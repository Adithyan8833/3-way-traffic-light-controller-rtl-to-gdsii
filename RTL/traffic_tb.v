`timescale 1ns / 1ps
module tb_traffic_3way;
    reg clk;
    reg rst;
    wire [2:0] A;
    wire [2:0] B;
    wire [2:0] C;

    // Instantiate DUT
    traffic_3way uut (
        .clk(clk),
        .rst(rst),
        .A(A),
        .B(B),
        .C(C)
    );
    // Clock generation (10ns period)
    always #5 clk = ~clk;
    initial begin
        clk = 0;
        rst = 1;
        // Apply reset
        #10 rst = 0;
        // Run simulation
        #600;
        $stop;
    end
endmodule