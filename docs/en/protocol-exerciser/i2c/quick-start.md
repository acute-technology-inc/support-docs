# Quick start

Follow these steps to set up and use I2C Protocol Exerciser:

## Setup steps

1. **[Select bus](bus-select.md)** - Choose which bus to use for your I2C communication
2. **[Configure PX pair parameters](px-pair-settings.md)** - Set controller/target mode, voltage, and pull-up resistors
3. *(Optional)* **[Add internal nodes](add-internal-node.md)** - Create virtual I2C devices in your topology
4. *(Optional)* **[Configure DC output](../index.md#power-supply)** - Power your device under test
5. **[Configure decode settings](controller.md#decode-settings)** - Set Logic Analyzer parameters for I2C signal analysis
6. **[Assign topology](controller.md#assign)** - Upload configuration to the exerciser device

## Controller mode operations

In [Controller mode](controller.md), you can perform additional operations:

7. *(Optional)* **[Scan for devices](controller.md#scan-external-node)** - Scan all available addresses (0x08 ~ 0x77) to detect connected devices
8. **[Send commands](controller.md#send-packets)** - Use the I2C wizard to send READ/WRITE transactions