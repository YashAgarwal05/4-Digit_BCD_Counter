# 4-Digit BCD Counter (Verilog)

## Introduction

A **Binary Coded Decimal (BCD) Counter** is a digital counter that represents each decimal digit using a 4-bit binary value. Unlike binary counters, BCD counters count from **0 to 9** for each digit and then reset to zero while generating a carry to the next higher digit.

In this project, a **4-digit BCD counter** is implemented using **Verilog HDL**. The counter increments synchronously with the clock and supports a **synchronous active-high reset**. The design demonstrates multi-digit counting using enable (carry) signals between digits.

---

## BCD Counting Format and Timing

Each digit in the counter follows the BCD format:

- **0000** → Decimal 0  
- **0001** → Decimal 1  
- ...  
- **1001** → Decimal 9  

After reaching **9**, the digit resets to **0**, and a carry is generated to increment the next higher digit.

All digits are updated on the **positive edge of the clock**, ensuring synchronous operation.

---

## Counting Sequence

When the counter operates:

1. **Least Significant Digit (digit0)** increments on every clock pulse.
2. When `digit0` reaches **9**, it resets to **0** and enables the next digit.
3. **digit1** increments only when `digit0` overflows.
4. **digit2** increments only when both `digit0` and `digit1` overflow.
5. **digit3** increments only when `digit0`, `digit1`, and `digit2` overflow.
6. When all digits reach **9**, the counter rolls over to **0000**.

This cascading mechanism allows correct 4-digit decimal counting.

---

## Design Overview

The design is implemented as a single top-level module with internal logic for multi-digit counting.

Main components of the design include:

- **Four BCD digit registers** (`digit0` to `digit3`)
- **Enable (carry) generation logic**
- **Synchronous reset logic**
- **Concatenated output bus**

The complete 4-digit BCD count is available as a **16-bit output**.

---

## Enable (Carry) Logic

To propagate carry between digits, enable signals are generated:

- `ena[1]` is asserted when `digit0` reaches 9  
- `ena[2]` is asserted when `digit1` reaches 9 and `ena[1]` is high  
- `ena[3]` is asserted when `digit2` reaches 9 and `ena[2]` is high  

These enable signals ensure that higher-order digits increment only when required.

---

## BCD Counter Module

### Interface Signals

- **clk**  
  System clock input

- **reset**  
  Synchronous active-high reset

- **ena[3:1]**  
  Enable signals indicating carry to higher digits

- **digit0, digit1, digit2, digit3**  
  Individual 4-bit BCD digit outputs

- **q**  
  16-bit output representing the full 4-digit BCD value  
  (`{digit3, digit2, digit1, digit0}`)

---

## Counter Operation

- On every rising edge of the clock:
  - `digit0` increments by 1
  - If `digit0` reaches 9, it resets to 0 and enables `digit1`
- Higher digits increment only when their corresponding enable signals are active
- When reset is asserted:
  - All digits are synchronously reset to **0**

This guarantees correct and predictable decimal counting behavior.

---

## Testbench Overview

A Verilog testbench is used to verify the functionality of the BCD counter.

### Testbench Features

- Generates a periodic clock signal
- Applies a synchronous reset at the beginning of simulation
- Monitors the counter output (`q`) and enable signals (`ena`)
- Runs the simulation for a sufficient duration to observe multiple count cycles

The testbench confirms correct digit transitions, carry propagation, and reset behavior.

---

## Overall System Operation

1. Reset is asserted to initialize all digits to zero.
2. Reset is deasserted, allowing counting to begin.
3. The counter increments on each clock pulse.
4. Carry signals propagate correctly across digits.
5. The 16-bit output reflects the current 4-digit BCD count.

---

## Summary

This project demonstrates a **4-digit synchronous BCD counter** implemented in Verilog. The design correctly handles decimal counting, carry propagation, and synchronous reset operation.

The modular and structured logic makes the design easy to understand, simulate, and integrate into larger digital systems such as timers, clocks, and display controllers.

<img width="1569" height="811" alt="Screenshot 2025-12-17 175045" src="https://github.com/user-attachments/assets/74c10f2a-fa02-4ba2-83d1-30f12f437839" />
