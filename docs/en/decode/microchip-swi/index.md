# Microchip SWI (Single Wire Interface)

## What is Microchip SWI?

Microchip's Single Wire Interface (SWI) is a proprietary two-pin serial communication protocol designed for low-pin-count applications requiring minimal wiring complexity. Using only SI/O (Serial Input/Output) and Ground connections, SWI enables bidirectional communication with unpowered or parasitically-powered devices. The protocol was developed by Microchip Technology for applications such as printer cartridge identification, EEPROM data storage, sensor calibration, and battery authentication where minimizing connector pins and PCB routing is critical. SWI's most distinctive feature is its ability to harvest energy from the SI/O signal line to power the slave device, eliminating the need for a separate power connection in many applications.

The protocol uses an 8-bit data structure with MSB-first (Most Significant Bit first) transmission and supports up to eight devices on a common single-wire bus through software-based device addressing. Communication is half-duplex with the master controlling all transactions, similar in structure to I2C but with different trade-offs optimized for single-wire operation. Data transfers occur via bit frames where one data bit is transmitted per frame period (tBIT), and after each byte (8 bits), devices must respond with an Acknowledge (ACK) or No Acknowledge (NACK) during a ninth bit window. The master generates timing through controlled low pulses on the SI/O line, while a weak pull-up resistor maintains the idle high state.

SWI offers significant advantages in applications requiring longer communication distances (up to several meters) compared to I2C, reduced wiring complexity, and simplified board layouts with single-pin connections. However, it trades these benefits for lower data rates (typically 125 Kbps in High-Speed mode), increased susceptibility to noise and interference, and less widespread ecosystem support compared to ubiquitous protocols like I2C or SPI. Microchip's SWI is primarily used with their AT21CS series Serial EEPROM devices and similar single-wire communication products, making it particularly common in consumable authentication, calibration data storage, and cost-sensitive embedded applications.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- **SI/O (Serial Input/Output)**: Single bidirectional data line (open-drain)
- **GND**: Ground reference
- **VCC**: Optional external power (not required with parasitic power)
- **Pull-up resistor**: Weak pull-up to VCC (typically 10-100 kΩ depending on power mode)

**Electrical Characteristics:**
- **Logic High (Idle)**: Passive pull-up to VCC
- **Logic Low**: Master or slave drives line low
- **Supply voltage**: Typically 2.7V to 5.5V
- **Parasitic power**: Device harvests energy from SI/O line during high periods

### Timing and Data Rates

**Speed Modes:**
- **Standard Mode**: Lower data rate for longer distances and higher noise immunity
- **High-Speed Mode**: 125 Kbps for improved throughput
- **Bit frame period (tBIT)**: Varies by speed mode (typically 8-16 µs per bit)

**Timing Parameters:**
- **Master low time**: Pulse width determines bit value (1 vs. 0)
- **Discovery pulse**: Extended low pulse for device discovery
- **Presence detection**: Device response pulse indicating it is on the bus
- **Recovery time**: Idle high time between operations

### Protocol Structure

**Data Format:**
- **Bit order**: MSB first (Most Significant Bit transmitted first)
- **Byte structure**: 8 data bits + 1 ACK/NACK bit
- **Device addressing**: Software-based addressing (up to 8 devices per bus)

**Transaction Sequence:**

1. **Discovery/Reset**: Master sends extended low pulse
2. **Presence Detect**: Device(s) respond with presence pulse
3. **Command Byte**: Master sends operation command (Read, Write, etc.)
4. **Address Bytes**: Master sends memory address (if applicable)
5. **Data Bytes**: Master writes or device responds with data
6. **Acknowledge**: ACK (low) or NACK (high) after each byte

**Bit Encoding:**

Master controls timing by pulling SI/O low for specific durations:
- **Write '1'**: Short low pulse followed by long high period
- **Write '0'**: Long low pulse followed by short high period
- **Read bit**: Master initiates read slot; device drives line for bit value

**Acknowledge Mechanism:**

After 8 data bits, a 9th bit period is used for acknowledgment:
- **ACK**: Receiving device pulls line low during 9th bit
- **NACK**: Line remains high (no acknowledgment, indicates error or end)

### Device Addressing

**Software Addressing:**
- Up to 8 devices can share the same SI/O bus
- Devices are addressed via command structure or device-specific codes
- No hardware address pins required
- Master must know device addresses or use discovery process

### Parasitic Power Operation

**Energy Harvesting:**
- Device includes capacitor to store energy from SI/O line
- Charges during idle high periods
- Powers device operation during low periods
- Limits communication speed to allow sufficient charging time

## Common Applications

Microchip SWI is used in cost-sensitive and space-constrained applications:

**Consumable Authentication and Identification:**
- Printer ink and toner cartridge identification
- Battery pack authentication (power tools, medical devices)
- Replacement part verification and anti-counterfeiting
- Consumable usage tracking and metering

**Calibration Data Storage:**
- Sensor calibration parameters (temperature, pressure, flow)
- Display calibration data (color, brightness, gamma)
- Manufacturing test data and serial numbers
- Module-specific configuration data

**Embedded Systems:**
- Accessory identification for modular systems
- Board-to-board identification in stackable designs
- External sensor modules with calibration data
- Detachable component identification

**Industrial and Automation:**
- Replaceable sensor heads with stored calibration
- Smart cable identification and configuration
- Tool and fixture identification
- Maintenance tracking and cycle counting

**Medical Devices:**
- Disposable sensor authentication
- Single-use component identification
- Calibration data for replaceable modules
- Patient safety and counterfeit prevention

**Memory Applications:**
- Small EEPROM for configuration data (128 bits to 1 Kbit typical)
- Serial number storage
- Manufacturing date and origin tracking
- Warranty and support information

## Decoder Configuration

When configuring a logic analyzer to decode Microchip SWI signals:

### Channel Assignment

**Minimum Configuration (1 channel):**
- **SI/O**: Single bidirectional data line

**Optional Channels (2 channels recommended):**
- **SI/O**: Data line
- **VCC or GND**: Reference for signal level validation

### Sampling Requirements

**Sampling Rate:**
- **Minimum**: 1 MHz (for 125 Kbps High-Speed mode, provides ~8 samples per bit)
- **Recommended**: 5-10 MHz for reliable pulse width measurement and edge detection
- Higher sample rates improve timing accuracy and noise rejection

### Protocol Parameters

**Timing Configuration:**
- **Bit frame period (tBIT)**: 8-16 µs typical (device-specific)
- **Short pulse threshold**: ~2-4 µs (logic '1' write)
- **Long pulse threshold**: ~6-12 µs (logic '0' write)
- **Discovery pulse**: >20 µs (device detection)
- **Presence pulse**: ~8-10 µs (device response)

**Decoding Options:**
- **Bit order**: MSB first
- **Byte format**: 8 data bits + 1 ACK/NACK bit
- **Command decoding**: Identify Read, Write, Erase, and device-specific commands
- **Address display**: Show memory addresses for data operations
- **Data format**: Display as hex, binary, or ASCII

### Trigger Settings

**Common trigger conditions:**
- **Discovery pulse**: Trigger on extended low pulse (>20 µs)
- **Start of transaction**: Trigger on command byte
- **Specific command**: Trigger on Read or Write commands
- **ACK/NACK**: Trigger on acknowledge bit
- **Error conditions**: Trigger on NACK or timing violations

### Display Options

**Visualization:**
- **Transaction view**: Group related bytes (command, address, data)
- **Pulse width annotation**: Show pulse durations for timing analysis
- **ACK/NACK indicators**: Highlight acknowledge status
- **Device identification**: Label transactions by device address
- **Timing diagram**: Show bit-level timing with pulse widths

### Analysis Tips

**Discovery Phase:**
Capture from the beginning of a transaction to observe the discovery pulse and presence detection sequence. This confirms device communication is established before data transfer.

**Timing Verification:**
Measure actual pulse widths and compare to datasheet specifications. Timing violations can cause bit errors, especially in parasitic power mode where timing must allow adequate capacitor charging.

**ACK/NACK Monitoring:**
Monitor the 9th bit after each byte. Consistent NACK responses indicate communication errors, incorrect addressing, device not ready, or write protection.

**Parasitic Power Constraints:**
In parasitic power mode, observe longer idle high periods between bits and bytes to allow device capacitor recharging. Faster communication may cause device power failures and corrupt data.

**Multi-Device Bus:**
When multiple devices share the bus, use address bytes and presence detection to identify which device is responding. Simultaneous responses can cause bus contention and garbled data.

**Signal Integrity:**
Check for clean transitions and adequate voltage levels. Weak pull-up resistors, excessive capacitance, or long wires can cause slow rise times and unreliable communication.

**Noise Immunity:**
SWI is more susceptible to noise than differential protocols. Look for glitches during idle high periods that could be misinterpreted as valid pulses. Implement filtering or slower speeds in noisy environments.

## Reference

- [Microchip Single Wire Interface (SWI) Protocol](https://developerhelp.microchip.com/xwiki/bin/view/applications/swi/) - Official Microchip Documentation
- [AT21CS01/AT21CS11 Serial EEPROM Datasheet](https://ww1.microchip.com/downloads/en/DeviceDoc/doc8124.pdf) - Example SWI Device
- [Single-Wire Interface Application Note](https://ww1.microchip.com/downloads/en/appnotes/01199a.pdf) - Microchip AN1199
- [Microchip AT21CS Series](https://www.microchip.com/en-us/products/memory/serial-eeprom) - Product Family Overview
