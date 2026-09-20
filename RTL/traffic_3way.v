module smart_traffic_3way (
    input clk,
    input rst,
    input ped_req,
    input emergency,

    output reg [2:0] A,
    output reg [2:0] B,
    output reg [2:0] C
);

    // Light Encoding
    // 001 = GREEN
    // 010 = YELLOW
    // 100 = RED

    localparam S0  = 4'd0;   // A Green
    localparam S1  = 4'd1;   // A Yellow
    localparam S2  = 4'd2;   // B Green
    localparam S3  = 4'd3;   // B Yellow
    localparam S4  = 4'd4;   // C Green
    localparam S5  = 4'd5;   // C Yellow
    localparam PED = 4'd6;   // Pedestrian Crossing
    localparam EMG = 4'd7;   // Emergency Mode

    localparam GREEN_TIME  = 20;
    localparam YELLOW_TIME = 5;
    localparam PED_TIME    = 10;

    reg [3:0] ps, ns;
    reg [5:0] count;

    //--------------------------------------------------
    // State Register
    //--------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst)
            ps <= S0;
        else
            ps <= ns;
    end

    //--------------------------------------------------
    // Counter
    //--------------------------------------------------
    always @(posedge clk or posedge rst) begin
        if (rst)
            count <= 0;
        else if (ps != ns)
            count <= 0;
        else
            count <= count + 1;
    end

    //--------------------------------------------------
    // Next State Logic
    //--------------------------------------------------
    always @(*) begin

        ns = ps;

        case(ps)

            S0:
                if(emergency)
                    ns = EMG;
                else if(count >= GREEN_TIME)
                    ns = S1;

            S1:
                if(emergency)
                    ns = EMG;
                else if(count >= YELLOW_TIME)
                    ns = (ped_req) ? PED : S2;

            S2:
                if(emergency)
                    ns = EMG;
                else if(count >= GREEN_TIME)
                    ns = S3;

            S3:
                if(emergency)
                    ns = EMG;
                else if(count >= YELLOW_TIME)
                    ns = (ped_req) ? PED : S4;

            S4:
                if(emergency)
                    ns = EMG;
                else if(count >= GREEN_TIME)
                    ns = S5;

            S5:
                if(emergency)
                    ns = EMG;
                else if(count >= YELLOW_TIME)
                    ns = (ped_req) ? PED : S0;

            PED:
                if(emergency)
                    ns = EMG;
                else if(count >= PED_TIME)
                    ns = S0;

            EMG:
                if(!emergency)
                    ns = S0;

            default:
                ns = S0;

        endcase
    end

    //--------------------------------------------------
    // Output Logic
    //--------------------------------------------------
    always @(*) begin

        A = 3'b100;
        B = 3'b100;
        C = 3'b100;

        case(ps)

            S0: begin
                A = 3'b001;
                B = 3'b100;
                C = 3'b100;
            end

            S1: begin
                A = 3'b010;
                B = 3'b100;
                C = 3'b100;
            end

            S2: begin
                A = 3'b100;
                B = 3'b001;
                C = 3'b100;
            end

            S3: begin
                A = 3'b100;
                B = 3'b010;
                C = 3'b100;
            end

            S4: begin
                A = 3'b100;
                B = 3'b100;
                C = 3'b001;
            end

            S5: begin
                A = 3'b100;
                B = 3'b100;
                C = 3'b010;
            end

            // Pedestrian Crossing
            PED: begin
                A = 3'b100;
                B = 3'b100;
                C = 3'b100;
            end

            // Emergency Vehicle Priority
            // Road A gets Green
            EMG: begin
                A = 3'b001;
                B = 3'b100;
                C = 3'b100;
            end

        endcase
    end

endmodule
