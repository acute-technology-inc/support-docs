# Quick start

Follow these steps to set up and use MIPI I3C Protocol Exerciser:

## Setup steps

### 1. Select bus

Activate the bus by clicking the left box in the topology dialog.

![Bus Select](../../images/protocol-exerciser/i3c/topo-mode-init.png)

See: [Bus Select](bus-select.md)

---

### 2. Configure PX pair parameters

Set up pull-up resistance, Vdd, threshold, and operating mode.

![PX Pair Controller](../../images/protocol-exerciser/i3c/px-pair-ctrl.png)

See: [PX Pair Settings](px-pair-settings.md)

---

### 3. Controller-specific settings

**Note:** These settings are only available in Controller mode, not in Target mode.

Configure:

- **[Address Table](controller.md#address-table)** - Define I3C and I2C device addresses
- **[Timing Settings](controller.md#timing-settings)** - Adjust I3C timing parameters

---

### 4. Configure decode settings

Set up [Decode Settings](controller.md#decode-settings) for Logic Analyzer waveform decoding.

This ensures captured I3C signals are properly interpreted.

---

### 5. (Optional) Add internal nodes

Create virtual I3C or I2C devices using [Internal Nodes](internal-node.md).

**Use cases:**

- Simulate multiple target devices
- Test with mixed I3C and legacy I2C devices
- Verify dynamic address assignment behavior

---

### 6. (Optional) Enable DC power supply

Turn on the [DC Power Supply](../index.md#power-supply) to power your device under test.

---

### 7. Run

Press [Run](controller.md#run) to activate the exerciser and upload the topology configuration.

**What happens:**

- Topology is validated
- Settings are uploaded to the device
- Exerciser becomes active on the bus
- Status indicators show progress

---

### 8. Send commands (Controller mode only)

Use the [MIPI I3C Wizard](wizard.md) to send:

- CCC (Common Command Codes)
- Private READ/WRITE transactions
- Legacy I2C transactions
- HDR mode transfers