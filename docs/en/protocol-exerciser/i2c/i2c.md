# I2C Protocol Exerciser

The I2C Protocol Exerciser allows you to generate and respond to I2C bus traffic, supporting controller and target modes with internal node simulation.

## Overview

Use I2C Protocol Exerciser to:

- Act as an I2C controller to test target devices
- Simulate I2C target devices
- Create virtual internal nodes for multi-device testing
- Test I2C communication without a full system

**Supported addressing modes:**

- 7-bit addressing
- 10-bit addressing (limited support)

---

## Getting started

Follow the [Quick Start](quick-start.md) guide for step-by-step setup instructions.

---

## Documentation sections

- [Quick Start](quick-start.md) - Step-by-step setup guide
- [Bus Select](bus-select.md) - Choose which bus to use
- [Px Pair Settings](px-pair-settings.md) - Configure mode, voltage, and pull-up resistors
- [Add Internal Node](add-internal-node.md) - Create virtual I2C devices
- [Controller Mode](controller.md) - Send I2C transactions
- [Target Mode](target.md) - Respond to I2C transactions
