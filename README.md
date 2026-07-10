# Design and Verification of a 64-bit Timer IP with APB Interface

## Project Overview

This project presents the RTL design and functional verification of a configurable **64-bit Timer IP** featuring a standard **AMBA APB slave interface**. The timer supports multiple operating modes, including normal counting, programmable clock division, compare-match interrupt generation, and debug halt functionality.

The project follows a **design-first, verification-driven methodology**, covering RTL implementation, directed verification, verification planning, simulation, and coverage analysis using **Verilog** and **QuestaSim**.

### Project Scope

- RTL Design using **Verilog**
- APB Slave Interface Implementation
- Directed Functional Verification
- Verification Planning (VPlan)
- Simulation using **QuestaSim**
- Coverage-Driven Verification

---

# 1. Project Directory Structure

The project is organized into separate RTL, verification, simulation, and documentation directories.

```text
report/       Specification and documentation
rtl/          RTL source files
sim/          Simulation scripts
tb/           Testbench
testcases/    Directed testcases
```

---

# 2. RTL Architecture
<img width="1182" height="582" alt="image" src="https://github.com/user-attachments/assets/c201986c-619e-4053-9e1c-cbfc06ff22e7" />

The Timer IP is composed of three major functional blocks: the APB register interface, the counter control logic, and the interrupt generation logic. These blocks work together to provide configurable timer operation while maintaining full APB protocol compliance.

<p align="center">
  <img src="YOUR_RTL_ARCHITECTURE_IMAGE" width="900">
</p>

### Main Functional Blocks

- **APB Register Block**
  - APB read/write interface
  - Register file implementation
  - Byte-write support (PSTRB)
  - Illegal access detection

- **Counter Control Block**
  - 64-bit counter
  - Timer enable control
  - Clock divider
  - Prescaler logic

- **Interrupt Block**
  - Compare-match detection
  - Interrupt generation
  - Interrupt enable control
  - RW1C interrupt status handling

---

# 3. Register Specification

The Timer IP provides a memory-mapped register interface for timer configuration, counter monitoring, compare value programming, interrupt control, and debug halt management.

## Register Map

| Address | Register | Description |
|----------|----------|-------------|
| 0x00 | TCR | Timer Control Register |
| 0x04 | TDR0 | Counter[31:0] |
| 0x08 | TDR1 | Counter[63:32] |
| 0x0C | TCMP0 | Compare Value[31:0] |
| 0x10 | TCMP1 | Compare Value[63:32] |
| 0x14 | TIER | Interrupt Enable Register |
| 0x18 | TISR | Interrupt Status Register (RW1C) |
| 0x1C | THCSR | Halt Control and Status Register |

### Register Features

- Timer enable/disable control
- Programmable clock divider configuration
- 64-bit counter value access
- 64-bit compare value configuration
- Interrupt enable and status control
- Debug halt configuration

---

# 4. Timer Operation

The Timer IP supports multiple operating modes to satisfy different application requirements.

### Normal Mode

- Counter increments every system clock cycle.
- Counting begins when **TIM_EN** is asserted.
- Clearing **TIM_EN** resets the counter to zero.

### Divider Mode

- Counter increments according to the programmed divider value.
- Divider ratio is configurable from **/1 to /256**.
- Divider configuration is protected while the timer is running.

### Compare-Match Interrupt

- Interrupt is generated when:

```
Counter == Compare Value
```

- Interrupt generation is controlled through the interrupt enable register.
- Interrupt status is cleared using the RW1C mechanism.

### Debug Halt Mode

When both **DBG_MODE** and **HALT_REQ** are asserted:

- Counter stops counting
- Prescaler is frozen
- HALT_ACK is asserted
- Timer resumes normally after halt request is released

---

# 5. Verification Plan (VPlan)

A structured verification plan was developed to validate all functional requirements of the Timer IP. The verification scope covers register functionality, timer operation, interrupt behavior, divider mode, APB protocol compliance, and error handling.

<p align="center">

<img width="1788" height="748" alt="image" src="https://github.com/user-attachments/assets/3a8a1b38-e6dd-41fe-aa63-4598387fe807" />
<img width="1790" height="462" alt="image" src="https://github.com/user-attachments/assets/8a72a00d-533f-4607-9879-c6decf1ee90f" />
<img width="1787" height="720" alt="image" src="https://github.com/user-attachments/assets/e9f19099-aee0-4057-894b-1e95c550168c" />
<img width="1753" height="682" alt="image" src="https://github.com/user-attachments/assets/72a4b510-bf7c-4df8-afe6-1e0ecb3fe339" />
<img width="1792" height="616" alt="image" src="https://github.com/user-attachments/assets/1356f18c-9dd4-49d1-aa48-5c50ba81eb32" />



  
</p>

---


# 6. Result
<img width="1091" height="881" alt="image" src="https://github.com/user-attachments/assets/35d22982-91b0-456b-bb37-f47b9e0c5a87" />


# 7. Coverage after exclude

Coverage-driven verification was adopted to evaluate verification completeness and ensure all planned functional scenarios were exercised.
<img width="830" height="725" alt="image" src="https://github.com/user-attachments/assets/601b1355-54f4-46d7-9bf1-0996baf3d29c" />
<img width="826" height="426" alt="image" src="https://github.com/user-attachments/assets/1659eb63-3781-410f-a317-9d87d681e72e" />

---

# 8. How to Run

Move to the simulation directory:

```bash
cd sim/
```

Clean previous simulation files:

```bash
make clean
```

Compile the RTL and testbench:

```bash
make build
```

Run a specific testcase:

```bash
make TESTNAME=<testcase_name>
```

Open waveform:

```bash
make wave
```

Simulation generates:

- Log files
- Waveform files
- Coverage database

---

# 8. Applications

The Timer IP can be integrated into various SoC designs, including:

- Periodic Timer Events
- Timeout Detection
- Real-Time Counters
- Clock Division
- Debug and Halt Control
- Interrupt-Driven Scheduling

---
