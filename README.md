# FSM-Based Verilog Vending Machine

A synchronous vending machine designed using **Verilog HDL** with an **FSM + Datapath architecture**. The design accepts ₹5, ₹10, and ₹25 coins, supports two products with different prices, calculates change, and detects insufficient funds.

The project was simulated using **Icarus Verilog**, analyzed using **GTKWave**, and synthesized using **Yosys** in a Linux/WSL environment.

---

## 📌 Project Overview

This project demonstrates the complete basic RTL design flow:

Verilog RTL
    │
    ▼
Icarus Verilog
    │
    ▼
Functional Simulation
    │
    ▼
GTKWave
    │
    ▼
Waveform Verification
    │
    ▼
Yosys
    │
    ▼
RTL Synthesis
    │
    ▼
Synthesized Netlist / Schematic


⚙️ Features
Accepts ₹5, ₹10 and ₹25 coins
Supports two products
Product A price: ₹15
Product B price: ₹40
Tracks accumulated funds
Detects sufficient and insufficient funds
Automatically calculates change
Provides separate dispense signals for each product
Asynchronous reset
FSM-based control logic
Datapath-based fund calculation
Functional simulation
GTKWave waveform analysis
Yosys RTL synthesis

input signals

| Signal       | Width | Description        |
| ------------ | ----- | ------------------ |
| `clk`        | 1 bit | System clock       |
| `reset`      | 1 bit | Asynchronous reset |
| `coin_5`     | 1 bit | ₹5 coin input      |
| `coin_10`    | 1 bit | ₹10 coin input     |
| `coin_25`    | 1 bit | ₹25 coin input     |
| `req_item_a` | 1 bit | Request Item A     |
| `req_item_b` | 1 bit | Request Item B     |

output signals

| Signal               | Width  | Description                  |
| -------------------- | ------ | ---------------------------- |
| `dispense_a`         | 1 bit  | Dispenses Item A             |
| `dispense_b`         | 1 bit  | Dispenses Item B             |
| `insufficient_funds` | 1 bit  | Indicates insufficient funds |
| `change_returned`    | 8 bits | Amount of change returned    |


🛠️ Tools Used
| Tool           | Purpose                 |
| -------------- | ----------------------- |
| Verilog HDL    | RTL design              |
| Icarus Verilog | Simulation              |
| GTKWave        | Waveform analysis       |
| Yosys          | RTL synthesis           |
| Graphviz       | Schematic visualization |
| Linux/WSL      | Development environment |
| Git/GitHub     | Version control         |

🎯 Learning Objectives

This project was developed to gain practical experience in:

RTL design
Finite State Machines
Datapath and control-unit architecture
Sequential and combinational logic
Verilog HDL
Testbench development
Functional verification
Waveform debugging
RTL synthesis
Hardware design flow
Linux-based EDA tools

📚 Project Status

Status: Completed basic RTL design, simulation, waveform verification, and synthesis flow.

The project is intended as a practical learning project in RTL design and VLSI verification.

👨‍💻 Author

Harish V

Engineering Student | VLSI & RTL Design | Verification
