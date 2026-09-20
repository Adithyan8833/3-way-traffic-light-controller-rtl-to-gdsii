# 3-Way Traffic Light Controller — RTL-to-GDSII ASIC Implementation

RTL-to-GDSII implementation of a 3-way traffic light controller using Verilog HDL and Cadence Genus and Innovus.

## 📌 Overview

This project implements a smart 3-way traffic light controller using a Finite State Machine (FSM). The design was developed in Verilog HDL and taken through a complete RTL-to-GDSII ASIC design flow.

The project covers:

- RTL design and simulation
- Logic synthesis using Cadence Genus
- Floorplanning
- Power planning
- Placement
- Clock Tree Synthesis (CTS)
- Routing
- Post-route timing analysis
- Power analysis
- Final GDSII-oriented physical implementation

## 🎯 Project Objective

The objective is to design a reliable three-way traffic light controller at RTL and implement it through the complete ASIC physical design flow, demonstrating the transition from Verilog RTL to a physically routed design.

## 🧩 Design Specification

The controller consists of three traffic directions:

- **Road A**
- **Road B**
- **Road C**

Each direction follows the sequence:

**Green → Yellow → Red**

The controller is implemented using a six-state FSM:

| State | Road A | Road B | Road C |
|-------|--------|--------|--------|
| S0    | Green  | Red    | Red    |
| S1    | Yellow | Red    | Red    |
| S2    | Red    | Green  | Red    |
| S3    | Red    | Yellow | Red    |
| S4    | Red    | Red    | Green  |
| S5    | Red    | Red    | Yellow |

### Timing

- Green duration: **10 clock cycles**
- Yellow duration: **3 clock cycles**

### Inputs

- `clk` — System clock
- `rst` — Reset

### Outputs

- Road A traffic light
- Road B traffic light
- Road C traffic light

## 💻 RTL Design and Simulation

The traffic light controller was designed using **Verilog HDL** and verified through RTL simulation using **Xilinx Vivado**.

### RTL Source Files

- 📄 [Traffic Light Controller RTL](RTL/traffic_3way.v)
- 🧪 [RTL Testbench](RTL/traffic_tb.v)

The RTL simulation was performed in **Vivado** to verify the FSM state transitions and the corresponding traffic light outputs for Roads A, B, and C.

### RTL Simulation Result

The waveform below shows the FSM transitions and corresponding traffic light outputs during simulation.

<img width="532" height="261" alt="image" src="https://github.com/user-attachments/assets/1103f53b-809b-42c0-b568-35b00cd58fd0" />


## 🔄 RTL-to-GDSII Flow

```text
Verilog RTL
    ↓
RTL Simulation
    ↓
Logic Synthesis
(Cadence Genus)
    ↓
Floorplanning
    ↓
Power Planning
    ↓
Placement
    ↓
Clock Tree Synthesis
    ↓
Routing
    ↓
Post-Route Analysis
    ↓
Final Physical Design

## 📊 Results

The final physical implementation achieved timing closure with no reported setup or hold violations.

| Parameter | Result |
|-----------|--------|
| Standard Cells | 60 |
| Synthesized Area | 389.047 µm² |
| Setup WNS | 7.643 ns |
| Setup TNS | 0 ns |
| Hold WNS | 0.339 ns |
| Hold TNS | 0 ns |
| Setup Violations | 0 |
| Hold Violations | 0 |
| DRC Violations | 0 |
| Routing Overflow | 0% |
| Total Vias | 342 |
| Total Power | 0.02729 mW |
| Supply Voltage | 0.9 V |

## ⚡ Power Analysis

The post-route power analysis reported a total power consumption of **0.02729 mW**.

| Power Component | Power |
|----------------|------:|
| Internal Power | 0.02197 mW |
| Switching Power | 0.00355 mW |
| Leakage Power | 0.00177 mW |
| **Total Power** | **0.02729 mW** |

## 🏁 Conclusion

The 3-way traffic light controller was successfully implemented from Verilog RTL through synthesis and physical design using Cadence Genus and Innovus.

The final implementation achieved timing closure with zero setup and hold violations, zero DRC violations, and zero routing overflow. This project demonstrates the complete ASIC RTL-to-GDSII flow for a digital control system.
