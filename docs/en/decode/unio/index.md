# UNI/O

## What is UNI/O?

### Overview

UNI/O (Universal Input/Output) is a proprietary single-wire serial bus protocol developed by Microchip Technology specifically for interfacing with serial EEPROM (Electrically Erasable Programmable Read-Only Memory) devices. Introduced in the mid-2000s, UNI/O was designed to minimize pin count and simplify PCB design by requiring only one signal wire plus ground, compared to the two or three wires needed by I²C or SPI protocols. This makes UNI/O particularly attractive for space-constrained applications and devices where every pin counts, such as small form-factor electronics, battery-powered devices, and systems with limited I/O availability.

The UNI/O bus uses Manchester encoding (IEEE 802.3 style) to combine both clock and data into a single bidirectional signal line. The bus operates at a fixed bit rate of approximately 10 kHz to 100 kHz, with each bit cell divided into two halves. Manchester encoding ensures transitions occur within each bit period, allowing the slave device to extract clock information without requiring a separate clock line. Communication follows a command-based protocol where the master device sends commands to access memory locations, and the slave responds accordingly. UNI/O supports multiple devices on the same bus through device addressing, similar to I²C, though sharing is less common in practice.

UNI/O EEPROMs are primarily used for storing small amounts of non-volatile configuration data, calibration values, serial numbers, and other persistent information in embedded systems. The protocol's simplicity and minimal pin requirements make it ideal for applications like LCD modules, sensor modules, battery packs, and consumer electronics where data storage needs are modest (typically 1 Kb to 128 Kb). While not as widely adopted as I²C or SPI, UNI/O fills a specific niche where the single-wire interface provides tangible benefits in design simplicity and cost reduction.

### Key Features

- **Single-Wire Interface**: Only one signal line plus ground required
- **Manchester Encoding**: Self-clocking protocol embeds clock in data
- **Bidirectional Communication**: Master and slave share same signal line
- **Device Addressing**: Support for multiple devices on bus (up to 256 addresses)
- **Fixed Bit Rate**: Typically 10-100 kHz operation
- **Low Pin Count**: Minimal I/O requirements ideal for constrained designs
- **Standard Commands**: Read, write, and status operations
- **Built-in Timing**: Timing derived from Manchester transitions
- **Power Efficiency**: Low power consumption suitable for battery applications

## Technical Specifications

### Electrical Characteristics

**Signal Levels**
- **Operating Voltage**: 1.8V to 5.5V (device dependent)
- **Logic High (Voh)**: Typically Vcc - 0.4V minimum
- **Logic Low (Vol)**: Typically 0.4V maximum
- **Input High (Vih)**: Typically 0.7 × Vcc
- **Input Low (Vil)**: Typically 0.3 × Vcc

**Bus Configuration**
- **Pull-up Resistor**: Typically 10kΩ to 47kΩ (required)
- **Bus Capacitance**: Maximum 400 pF recommended
- **Cable Length**: Short traces recommended (< 30 cm typical)
- **Multiple Devices**: Supports multi-drop configuration with unique addresses

### Manchester Encoding

UNI/O uses Manchester encoding (IEEE 802.3 standard):

**Encoding Rules**
- **Logic '1'**: Low-to-high transition in middle of bit cell
- **Logic '0'**: High-to-low transition in middle of bit cell
- **Bit Cell**: Fixed duration typically 5-50 µs (depending on bit rate)
- **Edge Timing**: Mid-cell transition at 50% of bit period

**Timing Characteristics**
- **Bit Rate**: Typically 10 kHz to 100 kHz (100 µs to 10 µs per bit)
- **Common Speed**: ~10 kHz (100 µs per bit)
- **Quarter-Bit Time**: 25 µs at 10 kHz (used for timing reference)
- **Start Header**: Special pattern to indicate start of transmission

### Protocol Structure

**Bus States**
- **Standby**: Bus held high by pull-up resistor, no communication
- **Start Header (SAT)**: Fixed pattern to wake slave and establish timing
- **Data Transmission**: Manchester-encoded data bits
- **Master Acknowledge (MAK)**: Master indicates continue or stop
- **Slave Acknowledge (SAK)**: Slave confirms receipt

**Start Header (SAT)**
The Start Header establishes timing synchronization:
```
High for 4 × tBIT → Low for 1 × tBIT
```
- Duration: 5 bit periods total at bus frequency
- Alerts slave device to begin monitoring for commands
- Provides timing reference for Manchester decoding

**Device Address Byte**
Following the Start Header:
- **Format**: A7 A6 A5 A4 A3 A2 A1 A0
- **Default Address**: Often 0xA0 (1010 0000) for Microchip EEPROMs
- **Address Range**: 0x00 to 0xFF possible
- **Broadcast**: 0x00 can be used as no-device address

**Command Structure**

**Write Command Sequence**:
1. Master: Start Header (SAT)
2. Master: Device Address byte
3. Slave: Acknowledge (SAK)
4. Master: Command byte (e.g., 0x6C for write)
5. Slave: Acknowledge (SAK)
6. Master: Memory address (1 or 2 bytes)
7. Slave: Acknowledge (SAK) after each byte
8. Master: Data byte(s)
9. Slave: Acknowledge (SAK) after each data byte
10. Master: Master Acknowledge (MAK) set to NoMAK to end

**Read Command Sequence**:
1. Master: Start Header (SAT)
2. Master: Device Address byte
3. Slave: Acknowledge (SAK)
4. Master: Command byte (e.g., 0x6D for read)
5. Slave: Acknowledge (SAK)
6. Master: Memory address (1 or 2 bytes)
7. Slave: Acknowledge (SAK) after each byte
8. Slave: Data byte(s)
9. Master: Acknowledge (MAK after each byte, NoMAK to end)

**Common Commands**
- **0x6C**: Write command
- **0x6D**: Read command  
- **0x6E**: Read status register
- **0x6F**: Write status register

### Acknowledge Mechanism

**SAK (Slave Acknowledge)**
- **Acknowledge**: Logic '1' (low-to-high mid-cell transition)
- **No Acknowledge**: Logic '0' (high-to-low mid-cell transition)

**MAK (Master Acknowledge)**
- **MAK**: Logic '1' to continue reading
- **NoMAK**: Logic '0' to end read sequence

### Timing Parameters

Typical timing at 10 kHz bit rate:

- **tBIT**: 100 µs (bit cell period)
- **tHDR**: 400 µs high + 100 µs low (Start Header = 5 × tBIT)
- **tQTR**: 25 µs (quarter bit time, Manchester half-cell)
- **tSS**: Setup time for next start header (minimum 600 µs after last bit)
- **Write Cycle Time**: 5 ms typical (internal EEPROM programming time)

## Common Applications

**Embedded Systems**
- Configuration data storage in microcontroller systems
- Calibration data for sensors and modules
- Device-specific parameters and settings
- Boot configuration and firmware version info

**Consumer Electronics**
- LCD modules and displays (storing EDID-like data)
- Battery packs (storing capacity, chemistry, serial number)
- Camera modules (calibration data, lens parameters)
- Audio equipment (presets, equalization settings)

**Industrial**
- Sensor modules with identification and calibration data
- Smart transducers with configuration storage
- Measurement equipment calibration
- Replaceable module identification

**IoT and Wearables**
- Small form-factor devices with limited I/O
- Battery-powered devices requiring low power
- Wearable electronics with space constraints
- Smart accessories and peripherals

**Automotive**
- Module identification and configuration
- Infotainment system configuration storage
- Sensor calibration data
- Replacement part authentication

**Medical Devices**
- Patient data storage in disposable sensors
- Calibration data for measurement equipment
- Device configuration and usage tracking
- Service history and maintenance logs

## Decoder Configuration

When analyzing UNI/O communication with a logic analyzer, configure the following parameters:

**Signal Connection**
- **SCIO (Single Contact I/O)**: Connect to the single bidirectional data line
- **GND**: Connect ground reference
- **Pull-up**: Ensure proper pull-up resistor is present (10-47kΩ)

**Sampling Requirements**
- **Minimum Sample Rate**: At least 10× the bit rate
- For 10 kHz UNI/O (100 µs per bit): Minimum 100 kHz sample rate
- For 100 kHz UNI/O (10 µs per bit): Minimum 1 MHz sample rate
- Recommended: 500 kHz to 1 MHz for reliable Manchester decoding

**Decoder Parameters**
- **Encoding Type**: Manchester (IEEE 802.3 style)
  - Logic '1' = Low-to-High mid-cell transition
  - Logic '0' = High-to-Low mid-cell transition
- **Bit Rate**: Specify expected rate (typically 10 kHz) or auto-detect from Start Header
- **Start Header Detection**: Enable SAT (Standby to Active Transition) recognition
- **Device Address**: Specify expected address (e.g., 0xA0) or show all addresses

**Protocol Decoding**
- **Address Byte**: Display device address
- **Command Decoding**: Interpret command bytes (0x6C, 0x6D, 0x6E, 0x6F)
- **Memory Address**: Show target address (8-bit or 16-bit)
- **Data Bytes**: Display read/write data
- **Acknowledge Bits**: Show SAK (slave) and MAK (master) responses

**Display Options**
- Show Start Header (SAT) as separate event
- Indicate MAK/NoMAK and SAK/NoSAK
- Display data in hex, binary, or ASCII
- Show calculated memory addresses
- Annotate commands with human-readable names

**Trigger Settings**
- Trigger on Start Header pattern (high for 4×tBIT, then low for 1×tBIT)
- Trigger on specific device address byte
- Trigger on specific command bytes (e.g., write command 0x6C)
- Pre-trigger to capture bus idle state before transaction

**Analysis Tips**
- Verify Start Header duration matches expected bit rate
- Check acknowledge bits after each byte (SAK from slave, MAK from master)
- Monitor for NoMAK from master indicating end of read
- Verify write cycle time delays (typically 5 ms for EEPROM programming)
- Look for proper bus idle periods between transactions (minimum tSS)
- Check Manchester encoding for violations (missing mid-cell transitions)

**Common Issues**
- **No Start Header Detected**: Incorrect bit rate setting or signal level issues
- **Decoding Errors**: Insufficient sample rate for Manchester decoding
- **Missing Acknowledges**: Slave not present, wrong address, or bus contention
- **Data Corruption**: Signal integrity issues, cable too long, or excessive capacitance
- **Timing Violations**: Start Header not long enough or inter-transaction gap too short
- **Pull-up Problems**: Missing or incorrect pull-up resistor value

**Advanced Analysis**
- Measure actual bit rate from Start Header timing
- Analyze write cycle time to verify EEPROM write completion
- Check for bus contention (both master and slave driving at same time)
- Verify Manchester encoding compliance (50% duty cycle within each bit)
- Monitor for clock drift or timing variations
- Identify device type from address and command patterns

## Reference

- [Microchip UNI/O Bus Specification](https://ww1.microchip.com/downloads/en/DeviceDoc/22076B.pdf) - Official protocol specification
- [11AA010 UNI/O EEPROM Datasheet](https://www.microchip.com/wwwproducts/en/11AA010) - Example UNI/O device
- [Manchester Encoding Basics](https://en.wikipedia.org/wiki/Manchester_code) - Encoding scheme explanation
- [Microchip Serial EEPROM Selection Guide](https://www.microchip.com/design-centers/memory/serial-eeprom-serial-sram)
- [UNI/O Protocol Application Note AN1101](http://ww1.microchip.com/downloads/en/AppNotes/01101A.pdf)

---
**Last Updated**: 2026-02-02
