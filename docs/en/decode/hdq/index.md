# HDQ (High-Speed Data Queue)

## What is HDQ?

### Overview

HDQ (also known as HDQ8) is a proprietary single-wire, asynchronous communication protocol developed by Texas Instruments for battery monitoring, fuel gauge ICs, and low-speed sensor applications. Operating at up to 5 kbit/s, HDQ provides a minimalist interface requiring only one data line plus ground, making it ideal for space-constrained applications like smartphone batteries, tablets, cameras, and portable electronics where pin count and board space are critical concerns. The protocol enables host processors to read battery capacity, voltage, temperature, charge status, and authentication data from intelligent battery packs.

HDQ represents TI's proprietary alternative to other single-wire protocols. Where protocols like 1-Wire (Dallas/Maxim) serve similar purposes, HDQ is specifically optimized for TI's battery management ecosystem, with timing and command structures tailored to battery fuel gauge requirements. The protocol uses a passive pull-up resistor on the single data line, with both master (host) and slave (battery monitor IC) using open-drain outputs to drive the line low—a simple hardware interface enabling cost-effective integration.

### Key Characteristics

- **Single-Wire**: One bidirectional data line plus ground
- **Open-Drain**: Passive pull-up, active pull-down
- **Asynchronous**: No separate clock signal required
- **Return-to-One**: Line idles high between transactions
- **Low Speed**: Maximum 5 kbit/s data rate
- **Command-Based**: 8-bit command structure with register addressing
- **LSB First**: Least significant bit transmitted first

## Protocol Specifications

### Electrical Interface

**Signal Characteristics:**
- **Voltage**: Referenced to Vss (ground)
- **Pull-Up**: Passive resistor (typically 10kΩ to 100kΩ) pulls line to Vdd when not driven
- **Driver**: Open-drain outputs from both host and battery IC
- **Logic Levels**: High = pulled up by resistor, Low = actively driven to ground

### Timing Specifications

**Bit Timing:**
- **Maximum Bit Rate**: 5 kbit/s (200 μs per bit minimum)
- **Break Time**: Hold HDQ line low for minimum 190 μs to reset communication engine
- **Break Recovery**: Minimum 40 μs idle time after break before next command
- **Bit Period**: ~200 μs at maximum rate

**UART Alternative:**
HDQ timing can be approximated using standard UART at 57,600 baud with 2 stop bits:
- Each bit period: ~190 μs
- Enables HDQ emulation using standard UART hardware
- Simplifies host implementation without dedicated HDQ controller

### Command Structure

**8-Bit Command Byte:**
- **Bits [6:0]**: Register address (0-127)
- **Bit [7]**: Read/Write bit
  - R/W = 0: Write operation
  - R/W = 1: Read operation

**Transaction Flow:**

**Write Transaction:**
1. Host sends Break (190 μs low)
2. Break recovery (40 μs high)
3. Host sends 8-bit command (write, address)
4. Host sends 8-bit data byte
5. Device stores data in specified register

**Read Transaction:**
1. Host sends Break (190 μs low)
2. Break recovery (40 μs high)
3. Host sends 8-bit command (read, address)
4. Device responds with 8-bit data from register

**Bit Format:**
- LSB transmitted first
- Each bit: specific timing pattern distinguishing 0 from 1
- Self-synchronizing through timing measurements

## Common HDQ Devices

### Battery Fuel Gauge ICs

**bq27000 Family:**
- Single-cell Li-Ion fuel gauge
- Monitors voltage, current, temperature
- Estimates remaining capacity (mAh)
- State of charge (SOC) percentage
- Time to empty calculation

**bq27546-G1:**
- Multi-cell Li-Ion/Li-Poly fuel gauge
- Support for 2S to 4S battery packs
- Impedance Track™ algorithm
- Battery authentication
- Data logging capabilities

**bq27741-G1:**
- Low-power fuel gauge for wearables
- Ultra-low sleep current
- Optimized for small batteries
- Integrated LDO
- Temperature compensation

### Authentication ICs

**bq2018/bq2019:**
- SHA-1 based battery authentication
- Prevents counterfeit batteries
- Secure challenge-response
- Unique 64-bit ID
- EEPROM for user data storage

## Register Access

HDQ devices typically provide register-mapped access to:

**Status and Control:**
- Device status flags
- Operating modes
- Control registers
- Feature enables

**Measurement Data:**
- Battery voltage (mV)
- Current flow (mA)
- Temperature (°C or °F)
- Remaining capacity (mAh)
- State of charge (%)
- Time to empty/full (minutes)

**Calibration and Configuration:**
- Factory calibration data
- User configuration
- Chemistry profile selection
- Alert thresholds

**Security and Identification:**
- Unique device ID
- Authentication challenge/response
- Manufacturer data
- Part information

## Advantages

- **Minimal Pin Count**: Single data line saves precious connector pins
- **Simple Hardware**: No level shifters or complex interface circuits
- **Cost Effective**: Reduces BOM cost compared to multi-wire interfaces
- **Proven Reliability**: Widely deployed in millions of devices
- **Low Power**: Minimal current draw during communication
- **Adequate Speed**: 5 kbit/s sufficient for battery monitoring applications

## Decoder Configuration

When configuring an HDQ decoder:

- **Signal Line**: Specify logic analyzer channel connected to HDQ data line
- **Bit Rate**: Set to expected bit rate (typically near maximum 5 kbit/s)
- **Break Detection**: Configure minimum break time (190 μs)
- **Bit Polarity**: Active low with return-to-one idle
- **Data Format**: LSB first, 8 bits per byte
- **Command Interpretation**: Decode command byte into address and R/W fields
- **Register Mapping**: If known, display register names and decode values

## Common Applications

HDQ is prevalent in battery-powered devices:

**Mobile Devices:**
- Smartphones (iPhone, Android phones)
- Tablets (iPad, Android tablets)
- E-readers
- Portable gaming devices

**Portable Electronics:**
- Digital cameras
- Camcorders
- Portable media players
- Bluetooth speakers/headphones

**Wearables:**
- Smartwatches
- Fitness trackers
- Wireless earbuds
- Health monitoring devices

**Power Tools:**
- Cordless drills and drivers
- Battery pack identification
- Remaining runtime estimation

**Medical Devices:**
- Portable diagnostic equipment
- Patient monitors
- Infusion pumps with battery monitoring

## Comparison with Similar Protocols

**HDQ vs. 1-Wire:**
- HDQ: TI proprietary, battery focus, 5 kbit/s
- 1-Wire: Maxim/Dallas, broader applications, slower (15.4 kbit/s standard, 125 kbit/s overdrive)

**HDQ vs. SMBus:**
- HDQ: Single-wire, 5 kbit/s, simpler
- SMBus: Two-wire (SDA, SCL), 10-100 kbit/s, more complex

**HDQ vs. I2C:**
- HDQ: One data line, proprietary
- I2C: Two lines (SDA, SCL), industry standard, more flexible

## Reference

- [Texas Instruments: HDQ Communication Basics (SLVA101)](https://www.ti.com/lit/an/slva101/slva101.pdf)
- [TI Application Note: Interfacing to HDQ (SLUA408A)](https://www.ti.com/lit/an/slua408a/slua408a.pdf)
- [TI bq27546-G1 Fuel Gauge Datasheet](https://www.ti.com/lit/ds/symlink/bq27546-g1.pdf)
- [TI bq27741-G1 Fuel Gauge Product Page](https://www.ti.com/lit/gpn/BQ27741-G1)
- [TI bq27000 Battery Fuel Gauge](https://www.ti.com/lit/ds/symlink/bq27000.pdf)
