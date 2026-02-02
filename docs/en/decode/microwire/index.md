# Microwire

## What is Microwire?

### Overview

Microwire is a simple three-wire synchronous serial communication protocol developed by National Semiconductor (now part of Texas Instruments) in the 1980s for interfacing with small serial EEPROMs, real-time clocks, and other peripheral devices. Microwire was designed as a low-cost alternative to other serial protocols, optimizing for minimal pin count while maintaining adequate performance for non-volatile memory applications. The protocol uses a master-slave architecture with separate clock (SK), data output (DO), and data input (DI) lines, plus a chip select (CS) for device selection. Microwire is closely related to SPI but predates the widespread adoption of that term and has some distinct characteristics.

The Microwire protocol is characterized by its simplicity and fixed 8-bit or 16-bit word structure, with the master always generating the clock and initiating all communication. Data is typically transferred MSB (Most Significant Bit) first, and the clock is active only during data transmission. Unlike more complex protocols, Microwire has no formal specification or standard body, but rather represents a common implementation pattern established by National Semiconductor's early EEPROM products like the NM93C series. This informal nature means that "Microwire" can refer to slight variations in timing, word size, and command structure across different manufacturers and device families.

Despite being an older protocol, Microwire remains in use today in legacy systems and cost-sensitive applications where its simplicity provides advantages. Many modern devices described as "Microwire-compatible" are actually using a subset of SPI with specific timing and format conventions. The term is most commonly encountered when working with serial EEPROMs, particularly those with capacities from 128 bits to 16 kilobits. Understanding Microwire is important for maintaining older equipment, interfacing with legacy peripherals, and working with certain serial memory products that explicitly support this protocol.

### Key Features

- **Three-Wire Interface**: Clock (SK), Data In (DI), Data Out (DO) plus Chip Select (CS)
- **Synchronous Communication**: Master-generated clock, no async timing requirements
- **Master-Slave Architecture**: Master controls all communication
- **MSB First**: Data transferred most significant bit first (typical)
- **Fixed Word Length**: Usually 8-bit or 16-bit operations
- **Simple Protocol**: Minimal overhead, easy to implement
- **EEPROM Optimized**: Command structure suited for memory operations
- **Ready/Busy Detection**: DO line indicates EEPROM ready state
- **Multiple Devices**: CS enables multiple devices on shared bus
- **Low Speed**: Typically 100 kHz to 2 MHz, suitable for memory devices

## Technical Specifications

### Electrical Characteristics

**Signal Levels**
- **Supply Voltage**: 2.5V to 5.5V (device dependent, commonly 5V)
- **Logic High (VIH)**: Typically 0.7 × VDD
- **Logic Low (VIL)**: Typically 0.3 × VDD
- **Output High (VOH)**: VDD - 0.5V typical
- **Output Low (VOL)**: 0.4V typical

**Pin Definitions**
- **SK (Serial Clock)**: Clock signal, driven by master
- **DI (Data In)**: Data input to slave device, driven by master
- **DO (Data Out)**: Data output from slave device, tri-state when CS inactive
- **CS (Chip Select)**: Active high chip select, enables communication

**Bus Configuration**
- **Master**: Generates SK, drives CS and DI, reads DO
- **Slave**: Responds when CS active, outputs data on DO
- **Multi-Drop**: Multiple slaves possible with individual CS lines
- **DO Tri-State**: DO goes high-impedance when CS inactive

### Timing Characteristics

**Clock Specifications**
- **Frequency Range**: DC to 2 MHz typical (device dependent)
- **Common Frequencies**: 100 kHz to 1 MHz for EEPROMs
- **Clock Idle State**: Typically low (CPOL=0)
- **Clock Phase**: Data captured on rising edge, shifted on falling (CPHA=0 typically)
- **Duty Cycle**: 50% nominal, but often not critical

**Timing Parameters** (typical values, device specific)
- **tCSS (CS Setup Time)**: 250 ns minimum - CS high before first SK rising edge
- **tSKH (SK High Time)**: 250 ns minimum - clock pulse width high
- **tSKL (SK Low Time)**: 250 ns minimum - clock pulse width low
- **tDIS (DI Setup Time)**: 100 ns minimum - data stable before SK rising edge
- **tDIH (DI Hold Time)**: 50 ns minimum - data stable after SK rising edge
- **tDOV (DO Valid Time)**: 200 ns maximum - delay from SK to DO valid
- **tCSH (CS Hold Time)**: 250 ns minimum - CS high after last SK edge
- **tCSW (CS Inactive Width)**: 500 ns minimum - time between operations

**Write Cycle Time**
- **Self-Timed Write**: After write command, EEPROM performs internal programming
- **Duration**: 1-10 ms typical (device dependent)
- **Ready Detection**: Monitor DO line (high when ready) or use timed delay

### Protocol Structure

**Basic Operation Sequence**

1. **CS Inactive**: CS low, all signals idle
2. **CS Assert**: Master raises CS high
3. **Send Start Bit**: Master sends '1' on DI (sometimes called SB - Start Bit)
4. **Send Opcode**: Master sends 2-bit operation code on DI
5. **Send Address**: Master sends address bits on DI (typically 6-10 bits)
6. **Data Transfer**: Read or write data bits
7. **CS Deassert**: Master lowers CS to end operation

**Microwire Frame Format** (for typical 93C-series EEPROM)

```
CS   _______________________________________________
    |                                               |___
    
SK   ___   ___   ___   ___   ___     ___   ___   ___
    |   |_|   |_|   |_|   |_|   |...|   |_|   |_|   |
    
DI   1   OP1  OP0  A7   A6   A5  ... A1   A0   (start+opcode+address)
```

**Opcodes** (for 93Cxx series EEPROMs)
- **READ (10)**: Read data from specified address
- **WRITE (01)**: Write data to specified address
- **ERASE (11)**: Erase data at specified address
- **EWEN (00, 11xxxx)**: Erase/Write Enable
- **EWDS (00, 00xxxx)**: Erase/Write Disable
- **ERAL (00, 10xxxx)**: Erase All
- **WRAL (00, 01xxxx)**: Write All

### Command Details

**READ Operation**
1. CS high
2. Start bit (1) on DI
3. Opcode (10) on DI
4. Address (6-10 bits) on DI
5. Dummy bit (0) output on DO
6. Data word (8 or 16 bits) output on DO by device
7. CS low

**WRITE Operation**
1. CS high
2. Start bit (1) on DI
3. Opcode (01) on DI
4. Address (6-10 bits) on DI
5. Data word (8 or 16 bits) on DI
6. CS low (write cycle begins, takes ~5 ms)
7. Wait for write completion (poll DO or delay)

**EWEN (Write Enable) - Required Before Write/Erase**
1. CS high
2. Start bit (1) on DI
3. Opcode (00) on DI
4. Special code (11xxxx, x=don't care) on DI
5. CS low

**Ready/Busy Detection**
- After write/erase, device busy for programming cycle
- **Method 1**: Wait fixed time (5-10 ms typical)
- **Method 2**: Monitor DO with CS high - goes high when ready

### Word Size and Addressing

**Common Device Types**
- **93C46**: 64 × 16-bit (or 128 × 8-bit), 6-bit or 7-bit address
- **93C56**: 128 × 16-bit (or 256 × 8-bit), 7-bit or 8-bit address
- **93C66**: 256 × 16-bit (or 512 × 8-bit), 8-bit or 9-bit address
- **93C86**: 1024 × 16-bit (or 2048 × 8-bit), 10-bit or 11-bit address

**Organization Modes**
- **×16 Mode**: 16-bit words, addresses refer to 16-bit locations
- **×8 Mode**: 8-bit words, addresses refer to 8-bit locations
- Configuration selected via ORG pin on device

## Common Applications

**Non-Volatile Memory**
- Serial EEPROM for configuration data storage
- System parameter retention
- Calibration data storage
- Serial number and ID storage

**Embedded Systems**
- Microcontroller-based designs needing NV storage
- Settings and preferences storage
- Logging and event recording
- Firmware version and build information

**Consumer Electronics**
- TV settings and channel memory
- Audio equipment presets
- Appliance configuration storage
- Remote control learning codes

**Automotive**
- ECU configuration data
- Odometer and trip meter data
- Radio presets and settings
- Diagnostic trouble code storage

**Industrial Equipment**
- Machine settings and parameters
- Runtime hours and maintenance logs
- Process control setpoints
- Sensor calibration tables

**Networking Equipment**
- MAC address storage
- Configuration parameters
- License keys and activation codes
- Boot parameters

## Decoder Configuration

When analyzing Microwire communication with a logic analyzer, configure the following parameters:

**Signal Connections**
- **CS (Chip Select)**: Connect to chip select line
- **SK (Serial Clock)**: Connect to clock line
- **DI (Data In)**: Connect to data input to slave (MOSI equivalent)
- **DO (Data Out)**: Connect to data output from slave (MISO equivalent)

**Sampling Requirements**
- **Minimum Sample Rate**: 10× the SK clock frequency
- For 1 MHz Microwire: Minimum 10 MHz sample rate
- Recommended: 20-50 MHz for clean decoding and timing analysis

**Decoder Parameters**
- **Clock Polarity (CPOL)**: Usually 0 (clock idle low)
- **Clock Phase (CPHA)**: Usually 0 (sample on leading/rising edge)
- **Bit Order**: MSB first (typical for Microwire)
- **Word Size**: 8-bit or 16-bit (device dependent)
- **CS Polarity**: Active high (standard Microwire)

**Protocol-Specific Settings**
- **Start Bit Detection**: Enable to detect leading '1' bit
- **Opcode Decoding**: Decode 2-bit opcode field (READ, WRITE, ERASE, special)
- **Address Field**: Specify address width (6-10 bits, device dependent)
- **Data Field**: Specify data width (8 or 16 bits)
- **Device Type**: Select target device (e.g., 93C46, 93C56) for automatic decoding

**Display Options**
- Show command interpretation (READ, WRITE, EWEN, EWDS, ERASE, etc.)
- Display address in hex format
- Show data in hex, binary, or ASCII
- Indicate write cycle timing and ready/busy state
- Mark start bit and opcode separately

**Trigger Settings**
- Trigger on CS rising edge (start of operation)
- Trigger on specific opcode patterns (e.g., WRITE commands)
- Trigger on specific address values
- Trigger on data patterns (e.g., specific configuration writes)

**Analysis Tips**
- Verify start bit is present (first bit after CS=1 should be '1')
- Check opcode is valid (00, 01, 10, 11)
- Verify address is within valid range for device capacity
- For writes, monitor CS low period and subsequent ready detection
- Check for EWEN command before write operations (required)
- Verify CS timing (setup and hold times)
- Check clock timing (frequency, duty cycle, setup/hold for data)

**Common Issues**
- **No Response**: CS not asserted, wrong device address, device not powered
- **Invalid Opcodes**: Incorrect bit order or timing
- **Write Failures**: EWEN not issued before write, insufficient write cycle time
- **Timing Violations**: Setup/hold violations, SK frequency too high
- **Data Corruption**: Noise on bus, signal integrity issues
- **Missing Start Bit**: Decoding synchronization issue

**Advanced Analysis**
- Measure write cycle time (CS low after write to DO ready)
- Analyze timing margins (setup/hold times)
- Verify clock frequency stability
- Check for clock stretching or irregularities
- Monitor DO tri-state behavior when CS inactive
- Analyze read/write patterns for efficiency

**Device Identification**
- Count address bits to identify device capacity
- Observe word size (8 or 16 bits) to determine organization
- Look for EWEN/EWDS sequences indicating writable EEPROM
- Check for repeated patterns indicating ERAL/WRAL operations

## Reference

- [National Semiconductor Microwire EEPROMs](https://www.ti.com/memory/serial-eeproms/overview.html) - Now Texas Instruments
- [93C46/56/66 Datasheet](https://www.onsemi.com/pdf/datasheet/cat93c46-d.pdf) - Common Microwire EEPROM
- [Microchip 93LC/93C Series](https://www.microchip.com/en-us/products/memory/serial-eeprom) - Microwire-compatible devices
- [Microwire vs SPI Comparison](https://www.analog.com/en/analog-dialogue/articles/introduction-to-spi-interface.html)
- [Serial EEPROM Design Guide](https://www.microchip.com/stellent/groups/SiteComm_sg/documents/DeviceDoc/en558123.pdf)

---
**Last Updated**: 2026-02-02
