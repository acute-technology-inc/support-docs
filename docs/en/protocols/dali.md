# DALI (Digital Addressable Lighting Interface)

## What is DALI?

### Overview

DALI (Digital Addressable Lighting Interface) is an international standard protocol for digital lighting control, specified in IEC 62386. Developed in the late 1990s and standardized by the International Electrotechnical Commission (IEC), DALI provides a two-way communication system for lighting applications, enabling intelligent control of individual luminaires or groups of lights in commercial, industrial, and architectural installations. Unlike traditional analog dimming systems (0-10V) that offer only basic intensity control, DALI supports bi-directional communication, allowing not only control commands but also status feedback, fault reporting, and configuration management.

DALI has become the de facto standard for professional lighting control systems, particularly in Europe and increasingly worldwide. The protocol enables sophisticated lighting scenarios including individual fixture addressing, scene recall, daylight harvesting integration, occupancy sensing, emergency lighting management, and energy monitoring. The DALI Alliance (Digital Illumination Interface Alliance, or DiiA) maintains the specifications and operates the DALI-2 certification program, ensuring interoperability between products from different manufacturers.

### Evolution to DALI-2

The current standard, DALI-2, represents significant enhancements over the original DALI protocol:

- Enhanced interoperability testing and certification
- Support for additional device types (LED drivers, sensors, input devices)
- Improved control device specifications
- Wireless and alternative wired system options (Part 104)
- Firmware update capabilities (Part 105)
- Extended device types for colored lighting, sensors, and IoT integration

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- **Voltage Levels**: Typically 16V (logic high) and 0V (logic low) with defined thresholds
- **Data Rate**: 1,200 baud (bits per second)
- **Encoding**: Manchester encoding for self-clocking and DC balance
- **Topology**: Bus topology with polarity-free two-wire connection
- **Cable Length**: Up to 300 meters without repeaters; longer with signal conditioning
- **Power Delivery**: DALI bus can deliver limited power (typically 250mA) for control devices

**Wiring:**
- Two-wire bus (non-polarity sensitive)
- No specific cable requirements beyond basic low-voltage wiring
- Can share conduit with mains power (depending on local electrical codes)
- Supports star, tree, line, and mixed topologies

### Addressing and Network

**Device Addressing:**
- **Short Addresses**: 0-63 individual device addresses
- **Group Addresses**: 0-15 group addresses for controlling multiple devices simultaneously
- **Broadcast**: Address all devices on the bus
- **Scenes**: 0-15 pre-programmed lighting scenes
- **Device Types**: Defined types for LED drivers, ballasts, sensors, switches, etc.

**Network Capacity:**
- Up to 64 individually addressable control gear per bus segment
- Up to 64 control devices (switches, sensors) per segment
- Groups and scenes enable flexible control architectures
- Multiple bus segments can be bridged for larger installations

## Command Structure

### Control Gear Commands

**Basic Commands:**
- **Direct Arc Power Control**: Set light level 0-254 (with fade time)
- **Off**: Turn light off
- **Up/Down**: Increment/decrement light level
- **Step Up/Down**: Larger steps for faster changes
- **Recall Max/Min Level**: Jump to configured maximum or minimum
- **Recall Scene**: Activate programmed scene 0-15

**Configuration Commands:**
- **Store Scene**: Save current light level as a scene
- **Set Fade Time**: Configure transition speed (0.0s to 90.5s)
- **Set Fade Rate**: Configure steps per second
- **Set Max/Min Level**: Define operating range limits
- **Reset**: Return device to factory defaults
- **Query Status**: Request device state and parameters

**Extended Commands:**
- **Device Type Specific**: Commands for colored tunable lighting, emergency functions, sensors
- **Color Control**: For RGBW, tunable white, or full-spectrum fixtures
- **Sensor Data**: Reading sensor values (occupancy, daylight level)

### Query Commands

DALI's bidirectional communication allows controllers to query devices:

- **Status Information**: Lamp failure, power on, ballast status
- **Actual Level**: Current light output level
- **Max/Min Levels**: Configured limits
- **Scene Levels**: Stored scene values
- **Device Type**: Identification of control gear type
- **Version Number**: Firmware version information
- **Serial Number**: Unique device identifier

## DALI-2 Standards Organization

The IEC 62386 standard is organized into multiple parts:

**General Requirements (Parts 101-105):**
- Part 101: System architecture and requirements
- Part 102: Control gear (LED drivers, ballasts)
- Part 103: Control devices (switches, sensors, gateways)
- Part 104: Wireless and alternative wired systems
- Part 105: Firmware update mechanisms

**Control Gear Types (Parts 201-209):**
- LED modules, fluorescent lamps, emergency lighting, discharge lamps
- Specific requirements for each control gear category

**Control Device Types (Parts 301+):**
- Input devices (push buttons, rotary controllers)
- Occupancy sensors, daylight sensors
- Gateways and system controllers

## Decoder Configuration

When configuring a DALI decoder:

- **Signal Assignment**: Specify the two logic analyzer channels connected to the DALI bus
- **Polarity**: DALI is polarity-insensitive, but proper detection improves reliability
- **Baud Rate**: Set to 1,200 baud
- **Manchester Decoding**: Enable Manchester encoding interpretation
- **Address Filtering**: Optionally filter by specific device addresses or device types
- **Command Interpretation**: Enable decoding of command opcodes and parameters
- **Timing Analysis**: Verify bit timing meets DALI specifications

## Common Applications

DALI is extensively used in:

- **Commercial Buildings**: Office lighting, retail stores, hotels
- **Industrial Facilities**: Warehouses, manufacturing plants
- **Healthcare**: Hospitals, clinics with specialized lighting requirements
- **Educational Institutions**: Schools, universities with classroom lighting control
- **Museums and Galleries**: Precise lighting control for exhibits
- **Theaters and Entertainment Venues**: Integrated with DMX systems
- **Smart Buildings**: Integration with BMS (Building Management Systems)
- **Emergency Lighting**: Mandatory testing and monitoring compliance
- **Outdoor Lighting**: Street lighting, parking lots with smart controls
- **Residential High-End**: Luxury homes with sophisticated lighting designs

## Advantages of DALI

- **Interoperability**: Certified devices from different manufacturers work together
- **Flexibility**: Reprogrammable without rewiring
- **Feedback**: Status monitoring and fault detection
- **Individual Control**: Each fixture addressable independently
- **Energy Efficiency**: Precise control enables optimal energy use
- **Integration**: Works with sensors, timers, and building automation systems
- **Future-Proof**: Upgradeable via firmware; expandable system architecture
- **Standards-Based**: Open specification ensures long-term support

## Reference

- [DALI Alliance: Standards and Specifications](https://www.dali-alliance.org/dali/standards.html)
- [IEC 62386 Standard](https://www.dali-alliance.org/standards/IEC62386.html)
- [DiiA Specifications Download](https://www.dali-alliance.org/specifications/download.html)
- [DALI Alliance Library & Resources](https://www.dali-alliance.org/downloads/)
