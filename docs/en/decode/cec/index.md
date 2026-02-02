# CEC (Consumer Electronics Control)

## What is CEC?

### Overview

CEC (Consumer Electronics Control) is a feature of HDMI designed to allow users to command and control multiple HDMI-connected devices through a single remote control. Embedded within the HDMI cable, CEC uses a dedicated pin (pin 13 on Type A HDMI connectors) to carry control signals between devices, eliminating the need for separate control cables or multiple remote controls. When properly implemented, CEC enables seamless integration of home entertainment systems, allowing actions like powering on the TV to automatically power on connected devices, or using the TV remote to control Blu-ray player playback.

The protocol operates at a very low bitrate—effectively no more than 36 bytes per second—which is sufficient for its intended purpose of sending control commands rather than streaming data. CEC is based on the legacy AV.link protocol originally used with SCART connectors, modernized for the HDMI ecosystem. Despite its low speed, CEC provides powerful automation and convenience features that significantly enhance the user experience in consumer electronics environments.

### Standardization and Versions

CEC is defined within the HDMI specification:

- **CEC 1.4**: Specified in Supplements 1 (CEC) and 2 (HEAC - HDMI Ethernet and Audio Return Channel) of HDMI 1.4a
- **CEC 2.0**: Extended features defined in Chapter 11 of the HDMI 2.0 specification
- **Ongoing Evolution**: Each new HDMI version may introduce additional CEC capabilities

While CEC is an open standard defined in the HDMI specification, many manufacturers implement proprietary extensions or marketing names (such as Samsung's Anynet+, LG's SimpLink, Sony's BRAVIA Sync, Panasonic's VIERA Link) that add brand-specific features while maintaining core CEC compatibility.

## Protocol Architecture

### Logical Addressing

CEC uses logical addresses to identify devices based on their function rather than their physical connection point. The protocol supports 15 logical addresses (0-14), with address 15 reserved for broadcast messages:

- **Address 0**: Always assigned to the TV (the central hub)
- **Addresses 1-3**: Recording devices (DVRs, PVRs)
- **Addresses 4-6**: Playback devices (Blu-ray players, streaming devices)
- **Address 5**: Audio systems (A/V receivers, soundbars)
- **Addresses 8-10**: Tuner devices (satellite receivers, cable boxes)
- **Address 11**: Reserved for specific playback devices
- **Address 14**: Reserved for specific devices

When a device connects to the HDMI network, it requests a logical address corresponding to its device type. If multiple devices of the same type exist, they receive sequential addresses within their designated range.

### Physical Addressing

Physical addresses describe the actual connection topology through HDMI switches and repeaters. A physical address consists of four 4-bit fields (e.g., 1.2.3.4), where each field represents a port number at successive levels in the connection hierarchy:

- The TV is always at physical address 0.0.0.0
- A device connected directly to HDMI port 1 on the TV has address 1.0.0.0
- A device connected to port 3 of a switch that's on TV port 1 has address 1.3.0.0

Physical addresses enable CEC to understand the connection topology, which is crucial for features like automatic input switching and one-touch play.

## Message Types and Commands

### System Control Messages

**Power Management**:
- **Standby**: Command devices to enter standby mode
- **Image View On**: Wake devices and display image on the TV
- **Text View On**: Wake devices without forcing TV to display image

**One Touch Play**: Allows a source device to wake the TV and automatically switch to the correct HDMI input with a single button press.

**System Standby**: Enables powering down all connected devices simultaneously when the TV is turned off.

### Routing and Source Selection

**Active Source**: Declares which device should be displayed on the TV

**Routing Change/Information**: Manages switching between HDMI inputs, particularly useful when devices are connected through AV receivers or HDMI switches

**Set Stream Path**: Commands the system to switch to a specific physical address

### Device Information

**Give Device Information**: Query device type, vendor ID, CEC version, and capabilities

**Report Physical Address**: Devices announce their physical address and device type

**Device Vendor ID**: Identifies the manufacturer of the device

### Audio Control

**System Audio Control**: Enables AV receivers to control TV audio

**Give Audio Status**: Requests volume and mute status

**Report Audio Status**: Devices report current volume level and mute state

**Set System Audio Mode**: Toggles between TV speakers and external audio system

### OSD (On-Screen Display)

**Set OSD Name**: Devices can set their friendly names that appear on TV menus

**Set OSD String**: Display text messages on the TV screen

### Remote Control Passthrough

**User Control Pressed/Released**: Forward remote control button presses between devices, allowing the TV remote to control other equipment

**Vendor Remote Button Down/Up**: Support for manufacturer-specific remote buttons

## Implementation Considerations

### Bit Rate and Timing

CEC operates at approximately 36 bytes per second with strict timing requirements:

- Bit period: approximately 2.4ms
- Start bit: 3.7ms low, 0.8ms high
- Logic 0: 1.5ms low, 0.9ms high
- Logic 1: 0.6ms low, 1.8ms high

These slow timing characteristics make CEC relatively easy to implement in firmware but require careful attention to timing accuracy.

### Bus Arbitration

When multiple devices attempt to transmit simultaneously, CEC uses a priority-based arbitration mechanism. The logical address serves as the priority indicator, with lower addresses (TV = 0) having highest priority. Colliding transmitters detect the collision and the lower-priority device yields the bus.

### Kernel vs. Userspace Handling

In operating systems like Linux:

- Certain messages (especially HEAC protocol commands) require kernel-level handling for proper system integration
- Application-level CEC commands can be handled in userspace
- The Linux CEC framework provides a unified interface supporting various hardware implementations

## Decoder Configuration

When configuring a CEC decoder:

- **Channel Selection**: Specify the logic analyzer channel connected to the CEC signal line (HDMI pin 13)
- **Signal Detection**: Configure proper voltage threshold detection (typically 3.3V logic levels)
- **Timing Parameters**: Set appropriate bit timing for start bit and data bit detection
- **Message Interpretation**: Enable decoding of logical addresses, opcodes, and parameters
- **Filtering**: Optionally filter messages by device type or command category

## Common Applications

CEC is found in virtually all modern HDMI-equipped devices:

- **Consumer TVs**: Central hub for home entertainment control
- **Blu-ray/DVD Players**: One-touch play functionality
- **Streaming Devices**: Roku, Apple TV, Chromecast, Fire TV
- **Game Consoles**: PlayStation, Xbox, Nintendo Switch
- **AV Receivers**: Audio system integration
- **Soundbars**: Volume control via TV remote
- **Cable/Satellite Boxes**: Automatic input switching
- **Media Centers**: HTPC and set-top box integration
- **Professional A/V**: Simplified control in commercial installations

## Limitations and Challenges

Despite its convenience, CEC has some notable challenges:

- **Inconsistent Implementation**: Not all manufacturers implement CEC fully or correctly
- **Interoperability Issues**: Devices from different brands may not work together perfectly
- **Proprietary Extensions**: Brand-specific features may not work across different manufacturers
- **Debugging Complexity**: Slow bit rate and timing sensitivity make troubleshooting difficult
- **Firmware Dependencies**: CEC behavior often requires firmware updates to resolve issues

## Reference

- [HDMI CEC Specification in HDMI 1.3](https://engineering.purdue.edu/ece477/Archive/2012/Spring/S12-Grp10/Datasheets/CEC_HDMI_Specification.pdf)
- [HDMI Specification Version 1.4b](https://picture.iczhiku.com/resource/eetop/WykdeTTrpaEticnM.pdf)
- [Linux Kernel CEC Documentation](https://docs.kernel.org/userspace-api/media/cec/cec-intro.html)
- [RDK Documentation: HDMI CEC](https://developer.rdkcentral.com/documentation/documentation/rdk_video_documentation/components/hdmi_cec/)
