# BiSS-C

## What is BiSS-C?

### Overview

BiSS-C (Bidirectional Synchronous Serial C-mode) is an open-source digital interface protocol developed by iC-Haus in 2002 for high-speed, real-time communication between controllers and sensors, encoders, or actuators. The "C" designation denotes "continuous mode," indicating that the protocol maintains permanent bidirectional communication without requiring mode switching. BiSS-C has become a widely adopted standard in industrial automation, with over 650 licensed device manufacturers including major industry leaders such as Balluff, Baumer, Schneider Electric, Yaskawa, and Renishaw.

The protocol was specifically designed for industrial applications requiring high data transfer rates, safety, flexibility, and minimal implementation effort. Unlike simpler unidirectional interfaces like SSI (Synchronous Serial Interface), BiSS-C enables bidirectional communication, allowing the controller to both read sensor data and write configuration parameters to the sensor—all while maintaining real-time performance. This capability makes it ideal for modern smart sensors and actuators that require dynamic configuration and advanced diagnostic feedback.

### Hardware Compatibility

BiSS-C maintains hardware compatibility with the industry-standard SSI interface, easing adoption for systems already using SSI sensors. The physical layer can utilize RS-422 transceivers for longer cable runs (up to 100 meters) at speeds up to 10 MHz, or LVDS (Low-Voltage Differential Signaling) for shorter distances with speeds up to 100 MHz. The differential signaling provides excellent noise immunity, essential for reliable operation in electrically harsh industrial environments.

## Protocol Characteristics

### Bidirectional Communication

BiSS-C's defining feature is its permanently bidirectional operation. Unlike protocols that must switch between read and write modes, BiSS-C maintains continuous bidirectional communication:

- **MA (Master Clock)**: The master generates a continuous clock signal that synchronizes all communication
- **SLO (Slave Output/Data)**: Bidirectional data line carrying both sensor data (from slave to master) and register access commands (from master to slave)

This continuous bidirectional capability enables several advantages:
- No mode-switching overhead or latency
- Simultaneous position data readout and register access
- Simplified state machine implementation
- Deterministic, predictable timing behavior

### Data Types and Modes

BiSS-C supports three primary data types:

**Single Cycle Data (SCD)**: The most common mode, where the sensor continuously provides position or measurement data. Each communication cycle delivers a complete data frame including:
- Start bit
- Position/sensor data (configurable length, typically 8-32 bits)
- Error and warning flags
- CRC (Cyclic Redundancy Check) for data integrity
- Timeout monitoring

**Register Data - CDM (Control Data from Master)**: Used for writing configuration data to sensor registers. The master sends register addresses and data values to configure sensor parameters such as:
- Resolution and scaling
- Operating modes
- Alarm thresholds
- Calibration parameters

**Register Data - CDS (Control Data from Slave)**: Used for reading configuration data or status information from sensor registers. The sensor returns register contents, diagnostic information, and identification data.

### Safety Features

BiSS-C incorporates multiple safety mechanisms for mission-critical applications:

**CRC Protection**: Up to 16-bit CRC on all transmitted data detects communication errors caused by electrical noise, signal integrity issues, or component failures.

**Error and Warning Flags**: Dedicated bits in each data frame indicate sensor-detected faults (e.g., position error, overspeed, temperature) and warnings (e.g., approaching limits, calibration needed).

**Line Delay Compensation**: Automatically compensates for signal propagation delays on long cables, ensuring accurate timing in extended installations.

**Timeout Monitoring**: Detects communication failures if expected data doesn't arrive within specified time windows.

## Topology Options

### Point-to-Point

The simplest configuration connects one master to one sensor. This provides the highest bandwidth per sensor and simplest timing, ideal for single-axis positioning systems or standalone sensor applications.

### Multi-Slave (Bus Capability)

BiSS-C supports multiple sensors on a shared bus, enabling synchronized data acquisition from several sensors:

- All slaves share the same MA (clock) signal, ensuring perfectly synchronized sampling
- SLO lines from multiple slaves can be logically combined (with proper arbitration)
- Useful for multi-axis systems requiring coordinated motion (e.g., CNC machines, robotic arms)
- Reduces wiring complexity in distributed sensor networks

## Decoder Configuration

When setting up a BiSS-C decoder:

- **MA/SLO Channels**: Specify logic analyzer channels for MA (Master Clock) and SLO (Slave Data/Output)
- **Data Type**: Select the communication mode:
  - Single Cycle Data: For continuous position/sensor readout
  - Register Data-CDM: For decoding master-to-slave register writes
  - Register Data-CDS: For decoding slave-to-master register reads
- **Serial Data Length**: Set the number of data bits in Single Cycle Data frames (typically 8-32 bits, must match sensor configuration)

## Common Applications

BiSS-C excels in applications requiring fast, accurate, and safe sensor communication:

- **Rotary and Linear Encoders**: Position feedback for servo motors and linear stages
- **Machine Tools**: CNC machines, lathes, milling machines requiring precise position control
- **Robotics**: Joint position sensors in industrial robots and cobots
- **Factory Automation**: Conveyor positioning, pick-and-place systems, automated assembly
- **Motion Control**: Closed-loop position control in drives and actuators
- **Smart Sensors**: Intelligent sensors with configurable parameters and diagnostic capabilities
- **Safety-Critical Systems**: Applications requiring certified safe communication (SIL 2/SIL 3)

## Performance Characteristics

- **Speed**: 10 MHz over long lines (RS-422), up to 100 MHz short distances (LVDS)
- **Cable Length**: Up to 100 meters with RS-422 differential signaling
- **Resolution**: Supports position data up to 32 bits or more
- **Update Rate**: Microsecond-level update cycles for real-time control
- **Latency**: Deterministic, minimal latency suitable for high-speed servo systems

## Reference

- [iC-Haus China: BiSS Interface](https://ichauschina.com/en/biss.htm)
- [iC-Haus Japan: BiSS Interface](https://ichaus.jp/?Lang=EN&Menu=BiSS)
- [BiSS Interface: Official Portal](https://biss-interface.com/news/manufacturer/ic-haus/)
- [BiSS-C Protocol Description (PDF)](https://biss-interface.com/download/biss-c-protocol-description-english)
- [BiSS-C Unidirectional Protocol Description](https://biss-interface.com/wp-content/uploads/2024/07/BiSS_C_unidirectional_protocol_A3en.pdf)
