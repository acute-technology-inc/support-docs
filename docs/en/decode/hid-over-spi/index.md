# HID over SPI

## What is HID over SPI?

### Overview

HID over SPI extends the Human Interface Device (HID) protocol specification to operate over the Serial Peripheral Interface (SPI) bus, enabling touchscreens, touchpads, sensors, and other HID-class devices to communicate with host systems using SPI instead of USB or I²C. Similar in concept to HID over I²C, HID over SPI provides a standardized transport layer for HID reports and commands over the high-speed SPI interface, offering advantages in terms of throughput, deterministic timing, and simplicity of implementation in systems already utilizing SPI for other peripherals.

While less common than USB HID or HID over I²C, HID over SPI fills a specific niche for applications requiring higher data rates than I²C can provide (I²C: typically 400 kHz-1 MHz; SPI: 1-50+ MHz) while maintaining the standardized HID report descriptor model. This makes it particularly suitable for high-resolution multitouch displays, high-sample-rate sensors, active pen digitizers, and other input devices where the additional bandwidth of SPI justifies the increased pin count (typically 4 pins for SPI vs. 2 for I²C).

### Key Characteristics

- **Higher Bandwidth**: SPI speeds (1-50 MHz) significantly exceed I²C capabilities
- **Full-Duplex**: Simultaneous bidirectional communication
- **Deterministic Timing**: Synchronous protocol with predictable latency
- **HID Compatibility**: Uses standard HID report descriptors and report formats
- **Master-Slave**: Host (SPI master) controls all communication timing

## Protocol Architecture

### SPI Transport Layer

**Signal Lines:**
- **SCLK**: Serial Clock (master-generated)
- **MOSI**: Master Out, Slave In (host to device data)
- **MISO**: Master In, Slave Out (device to host data)
- **CS/SS**: Chip Select / Slave Select (active low)
- **INT** (optional): Interrupt line (GPIO) for event notification

**SPI Mode:**
- Typically SPI Mode 0 (CPOL=0, CPHA=0) or Mode 3 (CPOL=1, CPHA=1)
- Determined by device specification
- MSB-first or LSB-first (device-dependent)

**Clock Speeds:**
- Common: 1-10 MHz for general HID devices
- High-performance: 20-50 MHz for high-resolution touch controllers

### Communication Model

**Command-Response Structure:**
Similar to HID over I²C, devices expose a register-based interface:

**Descriptor Access:**
- Read HID Descriptor
- Read Report Descriptor
- Configuration registers

**Report Transfer:**
- Input Reports: Device to host (touch, keys, sensor data)
- Output Reports: Host to device (LEDs, haptics)
- Feature Reports: Configuration and status

**Power Management:**
- SET_POWER command
- Sleep/wake control
- Power state reporting

### Interrupt-Driven vs. Polled

**Interrupt-Driven** (Recommended):
1. Device asserts INT line when data ready
2. Host initiates SPI transaction to read input report
3. Efficient power usage, low latency

**Polled Mode**:
1. Host periodically initiates SPI reads
2. Device responds with current state or null report
3. Simpler but higher power consumption and latency

## Register Model

**Addressing:**
Commands often include address/command byte indicating register or operation:
- Read HID Descriptor: Command 0x01
- Read Report Descriptor: Command 0x02
- Read Input Report: Command 0x03
- Write Output Report: Command 0x04
- SET_POWER: Command 0x08

**Transaction Format:**
```
Master: [Command] [Address] [Length] [Data...]
Slave:  [Status]  [Data...] [Data...]  [Data...]
```

## Data Transfer

### Input Report Transaction

1. **Interrupt Assertion**: Device pulls INT low (if using interrupt mode)
2. **CS Assert**: Master asserts CS low
3. **Command**: Master sends "Read Input Report" command
4. **Response**: Device sends input report data
5. **CS Deassert**: Master deasserts CS high
6. **INT Clear**: Device clears INT

### Output Report Transaction

1. **CS Assert**: Master asserts CS low
2. **Command**: Master sends "Write Output Report" command
3. **Data**: Master sends output report data
4. **Acknowledgment**: Device responds with status
5. **CS Deassert**: Master deasserts CS high

## Supported Device Types

**High-Resolution Touch:**
- Multitouch displays (10+ touch points)
- Active pen digitizers with pressure sensitivity
- High-sample-rate touchpads

**Sensors:**
- IMU (Inertial Measurement Unit) with high update rates
- High-speed gesture sensors
- Time-of-flight sensors

**Input Devices:**
- Gaming controllers requiring low latency
- Keyboards with NKRO (N-Key Rollover)
- Precision mice with high polling rates

## Decoder Configuration

When configuring a HID over SPI decoder:

- **SPI Signals**: Assign SCLK, MOSI, MISO, CS, INT channels
- **SPI Mode**: Configure CPOL and CPHA
- **Clock Frequency**: Set expected SCLK frequency
- **Bit Order**: MSB-first or LSB-first
- **Command Set**: Define command codes and register map
- **Report Parsing**: If HID descriptor available, decode report contents
- **INT Correlation**: Associate INT assertions with subsequent SPI transactions

## Common Applications

HID over SPI is found in specific high-performance scenarios:

**High-End Tablets:**
- Capacitive touch controllers requiring high scan rates
- Active stylus/pen digitizers (Wacom, Apple Pencil support)

**Gaming Devices:**
- Low-latency controllers
- VR controller tracking
- High-precision gaming mice

**Embedded Systems:**
- Industrial touch panels with fast response
- Medical device touchscreens
- Automotive center console displays

**Development Platforms:**
- Prototyping and evaluation boards
- Custom embedded input devices

## Advantages

- **High Throughput**: 10-100× faster than I²C
- **Low Latency**: Synchronous protocol with minimal overhead
- **Full-Duplex**: Simultaneous send/receive
- **Simple Timing**: Clock-driven, no complex bit timing
- **Scalable Speed**: Adjust clock rate to match requirements
- **Widely Available**: SPI controllers standard in most microcontrollers

## Disadvantages

- **More Pins**: 4 signals vs. I²C's 2
- **More Complex Routing**: Additional traces on PCB
- **No Standard Addressing**: Requires CS for multi-device
- **Shorter Distance**: Typically <1 meter vs. I²C's few meters
- **Power Consumption**: Generally higher than I²C at equivalent data rates

## Reference

For detailed HID over SPI implementations, consult:
- Device-specific datasheets (touch controller manufacturers)
- Embedded system vendor application notes
- Custom protocol specifications from device manufacturers
- SPI and HID protocol specifications as foundational references
