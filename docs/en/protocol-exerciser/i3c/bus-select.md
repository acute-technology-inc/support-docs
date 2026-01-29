# Bus select

![Bus Select](/images/i3c/bus-select.png)

Choose the bus configuration for MIPI I3C operations.

## Available bus configurations

MIPI I3C supports two main bus configurations:

### 1. Multi-lane MIPI I3C

Uses multiple data lanes in addition to the standard clock and data signals, following MIPI Alliance specifications.

**Features:**

- Increased bandwidth
- Additional data lines beyond SCL and SDA
- Enhanced performance for high-speed applications

**Status:** Multi-lane function will be released in a future version[^1]

---

### 2. Traditional two-wire MIPI I3C

Standard I3C configuration using only SCL (clock) and SDA (data) lines.

**Features:**

- Compatible with I2C legacy devices
- Standard MIPI I3C operation
- Support for up to four buses

**Status:** Additional buses (beyond one) will be released in a future version[^1]

---

## Channel assignments

**Important:** Channel assignments for each bus are fixed and cannot be adjusted manually. The device automatically assigns channels based on your bus selection.

---

## Selecting a bus

1. Click on the desired bus in the topology diagram
2. The selected bus is highlighted
3. Configure the bus using [PX Pair Settings](px-pair-settings.md)
4. Add devices and set up topology

---

## Current limitations

- Only one bus is currently supported for operation
- Multi-lane configuration is not yet available
- Channel assignments are fixed per bus

---

[^1]: Multi-lane function and additional buses will be released in future software versions.