# MIPI I3C Protocol Exerciser

*Supports MIPI I3C specification version 1.2 and below*

The MIPI I3C Protocol Exerciser allows you to generate and respond to I3C bus traffic, including legacy I2C compatibility.

## Overview

Use MIPI I3C Protocol Exerciser to:

- Act as an I3C controller with dynamic address assignment
- Simulate I3C target devices
- Test I3C Common Command Codes (CCC)
- Support legacy I2C devices on the same bus
- Create virtual internal nodes for multi-device testing

**Key features:**

- Dynamic address assignment (DAA)
- In-band interrupts (IBI)
- Hot-join capability
- HDR (High Data Rate) modes
- Backward compatible with I2C

---

## Specification support

**MIPI I3C version:** 1.2 and below

**Supported features:**

- SDR (Single Data Rate) mode
- HDR-DDR, HDR-TSP, HDR-TSL modes
- Dynamic address assignment (ENTDAA)
- Common Command Codes (CCC) - Broadcast and Direct
- Legacy I2C device support
- In-band interrupts (IBI)
- Hot-join

---

## Getting started

Follow the [Quick Start](quick-start.md) guide for step-by-step setup instructions.

---

## Documentation sections

- [Quick Start](quick-start.md) - Step-by-step setup guide
- [Bus Select](bus-select.md) - Choose bus configuration
- [Px Pair Settings](px-pair-settings.md) - Configure mode, voltage, and pull-up resistors
- [Controller Mode](controller.md) - Send I3C and CCC commands
- [Target Mode](target.md) - Respond to controller transactions
- [Internal Node](internal-node.md) - Create virtual I3C/I2C devices
- [Wizard](wizard.md) - Quick send and packet builder interface