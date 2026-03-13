# MDDI (Mobile Display Digital Interface)

## What is MDDI?

### Overview

MDDI (Mobile Display Digital Interface) is a high-speed digital interface standard developed by Qualcomm in the early 2000s specifically for connecting application processors to display panels in mobile devices such as smartphones, PDAs, and portable media players. MDDI was designed to address the limitations of parallel RGB interfaces commonly used at the time, which required numerous signal lines (often 18-24 data lines plus control signals) and consumed significant power at the higher resolutions and refresh rates demanded by modern mobile displays. By using a packet-based serial architecture similar to networking protocols, MDDI reduced pin count dramatically while supporting higher bandwidth and enabling advanced features like bidirectional communication and display device identification.

The MDDI specification defines both Type 1 (higher speed, 150-400 Mbps) and Type 2 (lower speed, up to 100 Mbps) variants, using differential signaling pairs for data and strobe/clock signals. The protocol employs a host-client architecture where the host (application processor) controls one or more client devices (displays, cameras, or other peripherals) connected via a point-to-point or daisy-chained topology. Data is organized into packets with headers, CRC error checking, and flow control mechanisms, providing reliability comparable to wired Ethernet but optimized for low-latency display updates. MDDI supports link power management, allowing sections of the interface to enter low-power states during idle periods, which is crucial for battery-powered mobile devices.

While MDDI offered significant advantages in the mid-2000s and was adopted in many Qualcomm Snapdragon-based smartphones, it has largely been superseded by MIPI DSI (Display Serial Interface) in modern devices. MIPI DSI achieved broader industry adoption, supported by the MIPI Alliance which includes most major mobile SoC vendors. Nevertheless, MDDI remains relevant for legacy device maintenance, understanding mobile display evolution, and certain specialized applications. The protocol's architecture influenced subsequent display interface designs and demonstrated the viability of serial, packet-based approaches for real-time multimedia data transfer in mobile contexts.

### Key Features

- **High-Speed Serial**: Type 1 up to 400 Mbps, Type 2 up to 100 Mbps
- **Low Pin Count**: Differential pairs replace dozens of parallel signals
- **Bidirectional Communication**: Full-duplex capability for commands and data
- **Packet-Based Protocol**: Structured packets with headers and CRC
- **Multiple Clients**: Support for displays, cameras, and other peripherals
- **Power Management**: Link power states for battery efficiency
- **Error Detection**: CRC checksums on all packets
- **Hot Plug Support**: Dynamic device detection and configuration
- **Display Identification**: Query capabilities and parameters
- **Low Latency**: Optimized for real-time display updates

## Technical Specifications

### Physical Layer

**Signal Lines**
- **MDDI_Data0+ / MDDI_Data0-**: Differential data pair 0
- **MDDI_Stb+ / MDDI_Stb-**: Differential strobe/clock pair
- **MDDI_Data1+ / MDDI_Data1-**: Optional second differential data pair (Type 1 multi-lane)
- **MDDI_Pwr**: Power supply line (optional, for powering client)

**Electrical Characteristics**
- **Signal Type**: Low-Voltage Differential Signaling (LVDS-like)
- **Differential Voltage**: 200-600 mV typical
- **Common Mode Voltage**: 1.2V typical
- **Impedance**: 100Ω differential
- **Rise/Fall Time**: < 1 ns (Type 1)

**MDDI Types**

**Type 1** (High Performance)
- **Data Rate**: 150-400 Mbps per lane
- **Lanes**: 1 or 2 data lanes
- **Use Case**: High-resolution displays (WVGA, qHD, HD)
- **Maximum Bandwidth**: Up to 800 Mbps (2 lanes × 400 Mbps)

**Type 2** (Lower Cost)
- **Data Rate**: Up to 100 Mbps
- **Lanes**: 1 data lane
- **Use Case**: Lower-resolution displays (QVGA, HVGA)
- **Maximum Bandwidth**: 100 Mbps

### Protocol Architecture

**Packet Structure**

All MDDI communication is organized into packets:

**Packet Format**:
```
| Packet Length | Packet Type | Sub-packet(s) | CRC | ...
|   (2 bytes)   |  (2 bytes)  |   (variable)  |(2B) | ...
```

**Packet Types**
- **Video Stream Packet**: Carries pixel data for display
- **Audio Stream Packet**: Carries audio data (if supported)
- **Register Access Packet**: Read/write client registers
- **Reverse Link Encapsulation**: Data from client to host
- **Link Shutdown Packet**: Power management
- **Client Capability Packet**: Reports client features and parameters

### Data Encoding

**Strobe Encoding**
- MDDI uses a "strobe" signal instead of a traditional clock
- **Data transitions** aligned with strobe transitions
- **Edge-Based**: Both rising and falling edges of data and strobe convey timing
- Similar to source-synchronous signaling

**Bit Encoding**
- Data sent LSB first within bytes
- Multi-byte fields typically sent in little-endian order
- Transition encoding allows clock recovery at receiver

### Packet Details

**Video Stream Packet**
Contains display pixel data organized by region:
- **Pixel Data Format**: RGB565, RGB666, RGB888, or other formats
- **Region-Based**: Can update specific screen regions for efficiency
- **CRC Protected**: 16-bit CRC for error detection
- **Timestamp**: Optional frame timing information

**Register Access Packet**
For configuring display and reading status:
- **Read Request**: Host requests register value from client
- **Write Request**: Host writes value to client register
- **Read Response**: Client returns requested register data
- **Register Address**: 32-bit addressing

**Capability Packet**
Reports client device capabilities:
- **Display Parameters**: Resolution, color depth, refresh rate
- **Supported Formats**: RGB formats, compression support
- **Client ID**: Manufacturer and device identification
- **Features**: List of supported optional features

### Link States

**Active State**
- Full-speed data transmission
- All lanes active
- Normal packet traffic

**Sleep State**
- Low-power mode during idle periods
- Wake-up signaling available
- Reduced power consumption

**Hibernation State**
- Deep sleep, minimal power
- Longer wake-up latency
- Maximum power savings

### Bandwidth and Performance

**Example Calculations**

For QVGA display (320×240, RGB565, 60 Hz):
- Pixels per frame: 76,800
- Bits per pixel: 16
- Bits per frame: 1,228,800
- Frame rate: 60 Hz
- Required bandwidth: ~74 Mbps (fits in Type 2)

For WVGA display (800×480, RGB888, 60 Hz):
- Pixels per frame: 384,000
- Bits per pixel: 24
- Bits per frame: 9,216,000
- Frame rate: 60 Hz
- Required bandwidth: ~553 Mbps (requires Type 1 dual-lane or reduced refresh)

**Protocol Overhead**
- Packet headers, CRC, and link management consume additional bandwidth
- Typical overhead: 10-20% depending on packet sizes and update patterns

## Common Applications

**Mobile Phones** (Historical)
- Qualcomm Snapdragon-based smartphones (circa 2005-2012)
- Feature phones and early smartphones
- Connection between Snapdragon SoC and LCD display
- Touchscreen digitizer interface in some designs

**Portable Media Players**
- High-resolution display connections
- Multimedia playback devices
- Portable gaming devices
- Digital photo frames

**PDAs and Handheld Devices**
- Personal Digital Assistants
- Handheld POS terminals
- Industrial handhelds
- Medical portable devices

**Embedded Displays**
- Automotive infotainment displays (early systems)
- Industrial HMI panels
- Instrumentation with color displays
- Embedded multimedia applications

**Development and Prototyping**
- Qualcomm development boards
- Mobile platform reference designs
- Display testing and validation
- Interface analysis and debugging

## Decoder Configuration

When analyzing MDDI communication with a logic analyzer, configure the following parameters:

**Signal Connections**
- **Data0+ / Data0-**: Primary differential data pair
- **Stb+ / Stb-**: Differential strobe pair
- **Data1+ / Data1-**: Secondary data pair (if Type 1 dual-lane)
- **Ground**: Reference ground

**Hardware Requirements**
- **Differential Probing**: Use differential probes or analyzers with differential inputs
- **High Sample Rate**: Minimum 2 GS/s for Type 1 (400 Mbps)
- **Bandwidth**: Minimum 500 MHz analog bandwidth for Type 1
- **Channel Count**: 4 channels minimum (2 differential pairs)

**Sampling Requirements**
- **Type 1 (400 Mbps)**: Minimum 2 GS/s sample rate (5× oversampling)
- **Type 2 (100 Mbps)**: Minimum 500 MS/s sample rate
- Recommended: Higher rates for better signal integrity analysis

**Decoder Parameters**
- **MDDI Type**: Select Type 1 or Type 2
- **Data Rate**: Specify expected bit rate (150-400 Mbps for Type 1, up to 100 Mbps for Type 2)
- **Lane Configuration**: Single-lane or dual-lane (Type 1)
- **Strobe Decoding**: Enable strobe-based clock recovery
- **Packet Parsing**: Enable packet structure decoding

**Protocol Decoding**
- **Packet Length**: Extract and display packet length field
- **Packet Type**: Decode packet type (Video, Register, Capability, etc.)
- **CRC Validation**: Verify 16-bit CRC, flag errors
- **Sub-packet Analysis**: Parse sub-packet structures within packets
- **Register Access**: Decode register addresses and values

**Display Options**
- Show packet boundaries and types
- Display video pixel data (RGB values, frame regions)
- Show register read/write transactions with addresses and data
- Indicate CRC errors and protocol violations
- Display link state transitions (Active, Sleep, Hibernation)

**Trigger Settings**
- Trigger on packet start pattern
- Trigger on specific packet types (e.g., Register Access)
- Trigger on register address matches
- Trigger on CRC errors
- Trigger on link state change patterns

**Analysis Tips**
- Verify strobe and data alignment
- Check CRC on all packets for transmission errors
- Monitor packet types to understand traffic patterns
- Analyze video stream packets to verify frame rate and resolution
- Check register access sequences during initialization
- Verify capability packet exchange at link establishment
- Monitor link power state transitions
- Measure actual data rate and compare to specification

**Common Issues**
- **Synchronization Loss**: Strobe/data misalignment, signal integrity problems
- **CRC Errors**: Noise, crosstalk, impedance mismatch, signal integrity
- **Missing Packets**: Buffer overflows, protocol violations
- **Incorrect Data Rate**: Wrong decoder configuration or clock issues
- **Display Corruption**: Incorrect pixel format, video packet errors
- **No Communication**: Differential signal issues, probe loading, power problems

**Advanced Analysis**
- Measure differential voltage levels and common-mode voltage
- Analyze eye diagrams for signal quality assessment
- Calculate actual bandwidth utilization and overhead
- Identify frame boundaries and measure frame rate
- Analyze partial screen update regions for efficiency
- Monitor link utilization and idle periods
- Characterize power management behavior

**Signal Integrity Considerations**
- MDDI is sensitive to impedance discontinuities
- Differential pair routing critical for signal quality
- Common-mode noise can cause data errors
- Cable length and quality significantly impact Type 1 performance
- Probe capacitance can distort high-speed signals

## Reference

- [Qualcomm MDDI Specification](https://developer.qualcomm.com/): Official specification (access may require NDA)
- [MDDI Overview White Paper](https://www.qualcomm.com/media/documents/files/mobile-display-digital-interface-mddi-overview.pdf)
- [MIPI Display Interfaces](https://www.mipi.org/specifications/dsi): Successor technology (MIPI DSI)
- [Mobile Display Technology Evolution](https://en.wikipedia.org/wiki/Mobile_Display_Digital_Interface)
- Qualcomm Developer Network - Technical documentation for MDDI-equipped SoCs

---
**Last Updated**: 2026-02-02
