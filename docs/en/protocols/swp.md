# SWP (Single Wire Protocol)

## What is SWP?

### Overview

SWP (Single Wire Protocol) is a half-duplex serial communication protocol standardized by ETSI (European Telecommunications Standards Institute) specifically for communication between a UICC (Universal Integrated Circuit Card, commonly known as a SIM card) and an NFC (Near Field Communication) controller in mobile devices. Developed to enable secure element functionality in smartphones, SWP allows the SIM card to act as a secure storage and execution environment for NFC applications such as mobile payments, access control, and transit cards. The protocol was designed to minimize the physical interface requirements while maintaining high reliability and security.

The SWP interface uses a single bidirectional signal line (plus ground) to establish communication between the UICC and the NFC chipset, typically operating at voltages around 1.8V. The protocol employs voltage modulation for signaling, where different voltage levels and load modulation techniques enable both the UICC and NFC controller to transmit data on the same wire. This single-wire approach is particularly advantageous in the space-constrained environment of SIM cards and mobile devices, eliminating the need for multiple pins while still achieving data rates sufficient for NFC transaction processing (typically around 1.7 Mbps).

SWP has become the dominant interface for connecting SIM-based secure elements to NFC controllers in mobile payments ecosystems, particularly for applications like Google Pay, Apple Pay (in some implementations), and transit payment systems. The protocol is defined in ETSI TS 102 613 and related specifications, with support from major mobile operators, handset manufacturers, and payment networks. While newer alternatives like NFC-WI (Wired Interface) exist, SWP remains widely deployed due to its maturity, standardization, and extensive ecosystem support.

### Key Features

- **Single Wire Interface**: Only one signal line plus ground required
- **Half-Duplex Communication**: Bidirectional on shared wire
- **Voltage Modulation**: Load modulation and voltage level signaling
- **High Data Rate**: Approximately 1.7 Mbps typical
- **Low Voltage**: 1.8V operation typical (compatible with modern UICC/SIM cards)
- **Secure Element Integration**: Designed for SE-to-NFC controller communication
- **ETSI Standardized**: Formal specification (ETSI TS 102 613)
- **HCI Protocol Support**: Typically carries HCI (Host Controller Interface) protocol
- **Activation Detection**: Automatic activation when NFC field detected
- **Power Management**: Low power consumption, suitable for mobile devices

## Technical Specifications

### Physical Layer

**Electrical Characteristics**
- **Operating Voltage**: Typically 1.8V (Class B UICC)
- **Signal Type**: Single-ended, bidirectional
- **Idle Voltage**: VDD (1.8V nominal)
- **Modulation**: Voltage level and load modulation
- **Impedance**: UICC presents variable load to CLF (Contactless Frontend/NFC controller)

**SWP Pin**
- **UICC Side**: Dedicated SWP contact (C6 in ISO 7816 pinout)
- **CLF Side**: SWP interface pin on NFC controller
- **Connection**: Direct single-wire connection between UICC and CLF

### Data Link Layer

**Data Rate**
- **Standard Speed**: 1.695 Mbps (±10%)
- **Bit Duration**: ~590 ns per bit
- **Encoding**: Modified Miller encoding (pulse width modulation)

**Frame Structure**

SWP uses a frame-based protocol:
- **Frame Header**: Indicates frame type and length
- **Payload**: Data bytes (typically HCI packets)
- **CRC**: Cyclic redundancy check for error detection
- **Frame Delimiter**: Special patterns to mark frame boundaries

### Signaling Mechanisms

**CLF-to-UICC Transmission**

The CLF (NFC controller) transmits by modulating the voltage on the SWP line:
- **Logic '0'**: Pull SWP line low (below threshold, ~0.4V)
- **Logic '1'**: Release line to high (VDD, ~1.8V via pull-up)
- **Encoding**: Modified Miller encoding with pulse width modulation

**UICC-to-CLF Transmission**

The UICC transmits using load modulation:
- **Modulation**: UICC varies its load impedance on SWP line
- **Detection**: CLF detects voltage variations caused by load changes
- **Logic '0'**: High load (low impedance to ground)
- **Logic '1'**: Low load (high impedance)
- **Encoding**: Same Modified Miller encoding

**Modified Miller Encoding**

SWP uses a variant of Miller encoding:
- **Logic '1'**: Transition at bit center
- **Logic '0'**: No transition at bit center (transition at boundary if followed by another '0')
- **Synchronization**: Edge transitions provide clock recovery

### Protocol Stack

**Typical Protocol Layers**

1. **Physical Layer**: SWP signaling (ETSI TS 102 613)
2. **Data Link Layer**: SWP framing and error detection
3. **HCI Protocol**: Host Controller Interface (ETSI TS 102 622)
4. **Application Layer**: NFC applications (payments, access control)

**HCI (Host Controller Interface)**

SWP typically carries HCI protocol:
- **Purpose**: Standardized communication between host (UICC) and NFC controller
- **Commands**: Configure NFC modes, route events, exchange data
- **Pipes**: Logical channels for different applications
- **Events**: Notifications of NFC field detection, card emulation activation

### Activation and States

**SWP States**

1. **Idle State**: No communication, SWP line at VDD
2. **Activation**: CLF sends activation sequence when NFC field detected
3. **Active State**: Bidirectional communication established
4. **Reset**: Return to idle, can be initiated by either side

**Activation Sequence**

When an NFC field is detected:
1. CLF sends SWP activation pattern
2. UICC responds with acknowledgment
3. HCI link established
4. Secure element applications notified
5. Card emulation or data exchange begins

### Error Detection and Recovery

- **CRC**: Frame-level CRC for data integrity
- **Parity**: Optional byte-level parity
- **ACK/NACK**: Acknowledgment protocol for reliable delivery
- **Timeout**: Detection of communication failures
- **Retry Mechanism**: Automatic retransmission on errors

## Common Applications

**Mobile Payments**
- Contactless payment cards (EMV) emulation
- Mobile wallet applications (Google Pay, Samsung Pay)
- Credit and debit card emulation
- QR code and NFC payment integration

**Transit and Ticketing**
- Public transportation fare cards
- Event ticketing (concerts, sports)
- Access passes and season tickets
- Multi-modal transit cards

**Access Control**
- Building access cards
- Hotel room keys (NFC-enabled)
- Corporate campus access
- Parking access systems

**Identity and Authentication**
- National ID cards with NFC
- Employee badges
- Student ID cards
- Two-factor authentication tokens

**Loyalty and Membership**
- Loyalty program cards
- Membership cards (gyms, clubs)
- Coupon and promotional systems
- Stored value cards

**Mobile Devices**
- Smartphones with NFC and embedded SIM
- Wearables with eSIM and NFC (smartwatches)
- Tablets with SIM and NFC capability
- IoT devices with secure element

## Decoder Configuration

When analyzing SWP communication with a logic analyzer, configure the following parameters:

**Signal Connection**
- **SWP**: Connect to the single bidirectional data line between UICC and CLF
- **GND**: Connect ground reference
- **VDD** (optional): Monitor supply voltage (1.8V typically)

**Sampling Requirements**
- **Minimum Sample Rate**: 20 MS/s (>10× the ~1.7 Mbps bit rate)
- **Recommended**: 50-100 MS/s for reliable Miller encoding capture
- **Voltage Range**: 0-2V or 0-3.3V
- **Resolution**: 8-bit or higher for detecting load modulation

**Decoder Parameters**
- **Data Rate**: 1.695 Mbps ±10% (auto-detect or specify)
- **Encoding**: Modified Miller encoding
- **Voltage Thresholds**: 
  - High level: >1.4V typical
  - Low level: <0.4V typical
  - Modulation depth: ~200-400 mV for load modulation
- **Frame Format**: Enable frame parsing (header, payload, CRC)
- **Protocol**: HCI protocol decoding (if supported)

**Display Options**
- Show transmission direction (CLF→UICC or UICC→CLF)
- Display frame types and lengths
- Decode HCI commands and events
- Show CRC validation results
- Indicate errors and retransmissions
- Display activation sequences

**Trigger Settings**
- Trigger on SWP activation pattern (field detection)
- Trigger on specific HCI command types
- Trigger on frame header patterns
- Trigger on voltage level transitions
- Pre-trigger to capture idle state before activation

**Analysis Tips**
- **Identify Direction**: CLF uses voltage modulation (larger swings), UICC uses load modulation (smaller variations)
- **Check Encoding**: Verify Modified Miller encoding rules (transitions at bit centers for '1')
- **Monitor Activation**: Capture the activation sequence when NFC field appears
- **HCI Decoding**: If decoder supports HCI, decode commands/events/responses
- **Error Analysis**: Look for CRC errors, timeouts, retransmissions
- **Voltage Levels**: Verify idle at VDD, proper low levels during transmission
- **Load Modulation**: UICC transmission may have smaller amplitude (100-400mV)

**Common Issues**
- **No Activation**: CLF not detecting NFC field, or SWP connection issue
- **Synchronization Loss**: Encoding errors, clock drift, noise
- **CRC Errors**: Signal integrity problems, impedance mismatch
- **Weak Load Modulation**: UICC load too weak, insufficient modulation depth
- **Voltage Issues**: Wrong VDD level, insufficient pull-up
- **Impedance Mismatch**: SWP line impedance not optimized

**Advanced Analysis**
- Measure actual bit rate and compare to specification
- Analyze Miller encoding compliance (transition timing)
- Measure modulation depth for UICC transmission
- Decode HCI pipe establishment and routing
- Monitor secure element application activation
- Analyze transaction timing (payment, access control)
- Verify error recovery and retry behavior

**HCI Protocol Analysis** (if decoder supports)
- **Administrative Commands**: Link establishment, pipe creation
- **Routing Commands**: Configure NFC event routing to secure element
- **Card Emulation Events**: Activation, data exchange, deactivation
- **Reader Mode Events**: Tag detection, data read/write
- **P2P Mode Events**: Peer-to-peer communication setup

## Reference

- [ETSI TS 102 613](https://www.etsi.org/deliver/etsi_ts/102600_102699/102613/): SWP Specification
- [ETSI TS 102 622](https://www.etsi.org/deliver/etsi_ts/102600_102699/102622/): HCI Protocol
- [ETSI TS 102 221](https://www.etsi.org/deliver/etsi_ts/102200_102299/102221/): UICC-Terminal Interface
- [GlobalPlatform SWP Specifications](https://globalplatform.org/): Secure element standards
- [NFC Forum](https://nfc-forum.org/): NFC technology specifications
- [EMVCo Contactless Specifications](https://www.emvco.com/): Payment card emulation

---
**Last Updated**: 2026-02-02
