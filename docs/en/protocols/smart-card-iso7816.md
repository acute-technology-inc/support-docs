# Smart Card (ISO 7816)

## What is Smart Card (ISO 7816)?

### Overview

ISO 7816 is an international standard that defines the physical characteristics, electrical interface, and communication protocols for integrated circuit cards (smart cards) with electrical contacts. Originally published in 1987 and continuously updated, ISO 7816 has become the foundation for secure smart card applications worldwide, including payment cards (EMV), SIM cards, identification documents, and access control systems. The standard encompasses multiple parts that specify everything from card dimensions to high-level application protocols.

The ISO 7816 protocol uses a half-duplex serial communication interface between the card and card reader (terminal). The card is powered and clocked by the reader through dedicated contact pads, eliminating the need for an onboard power source. Communication follows a master-slave architecture where the terminal initiates all transactions using a command-response paradigm known as Application Protocol Data Units (APDUs). This design ensures that the passive card can be extremely simple and cost-effective while still providing robust security features.

Smart cards following ISO 7816 can implement various security mechanisms including symmetric and asymmetric cryptography, secure key storage, and tamper-resistant hardware. Modern smart cards contain sophisticated microcontrollers capable of executing complex cryptographic algorithms on-chip, making them ideal for applications requiring high security. The standard supports both synchronous and asynchronous communication modes, with asynchronous being far more common in practice. ISO 7816 has evolved to support higher data rates and advanced features while maintaining backward compatibility with older card generations.

### Key Features

- **Standard Contact Layout**: 8-position contact pad arrangement (C1-C8) with defined functions
- **Half-Duplex Serial**: Single I/O line for bidirectional asynchronous communication
- **ATR (Answer to Reset)**: Card identification and capability negotiation sequence
- **APDU Protocol**: Structured command-response message format
- **Multiple Speeds**: From 9600 bps up to 3.57 MHz with various baud rate divisors
- **Error Detection**: Parity bit on each byte plus EDC (Error Detection Code)
- **Secure Element**: Tamper-resistant hardware with cryptographic capabilities
- **File System**: Hierarchical file structure for data organization
- **Multi-Application**: Support for multiple applications on a single card

## Technical Specifications

### Physical Characteristics (ISO 7816-1, 7816-2)

- **Card Dimensions**: 85.60 × 53.98 × 0.76 mm (ID-1 format, credit card size)
- **Contact Positions**: C1 (VCC), C2 (RST), C3 (CLK), C4 (RFU), C5 (GND), C6 (VPP), C7 (I/O), C8 (RFU)
- **Operating Voltage**: 5V, 3V, or 1.8V (class A, B, or C)
- **Contact Material**: Gold plating with minimum 0.5 µm thickness
- **Temperature Range**: -25°C to +70°C operating, -40°C to +85°C storage

### Electrical Interface (ISO 7816-3)

The asynchronous transmission protocol uses the following parameters:

- **Clock Frequency**: 1-5 MHz typical (can be adjusted via ATR)
- **Elementary Time Unit (ETU)**: Defines bit duration, typically F/D where F=372, D=1
- **Default Baud Rate**: ~9600 bps (3.57 MHz clock with F=372, D=1)
- **Character Format**: 1 start bit, 8 data bits, 1 parity bit (even), 1 or 2 guard times
- **I/O Voltage Levels**: High ≥ 0.7 × VCC, Low ≤ 0.3 × VCC
- **Reset Duration**: 400-40,000 clock cycles (typically ~40,000)

### Answer to Reset (ATR)

Upon receiving power and clock, the card responds with an ATR sequence:

1. **TS (Initial Character)**: Either 0x3B (direct convention) or 0x3F (inverse convention)
2. **T0 (Format Byte)**: Indicates presence of interface bytes and number of historical bytes
3. **Interface Bytes**: TA, TB, TC, TD bytes defining protocol parameters
4. **Historical Bytes**: Card manufacturer and type information
5. **TCK (Check Byte)**: Exclusive OR of all bytes from T0 to last historical byte (if protocol T=1)

### APDU Structure

**Command APDU** (sent by terminal):
```
CLA INS P1 P2 [Lc Data] [Le]
```
- **CLA**: Class byte (instruction category)
- **INS**: Instruction byte (specific command)
- **P1, P2**: Parameter bytes
- **Lc**: Length of command data (optional)
- **Data**: Command data (optional)
- **Le**: Expected response length (optional)

**Response APDU** (sent by card):
```
[Data] SW1 SW2
```
- **Data**: Response data (optional)
- **SW1, SW2**: Status words (0x90 0x00 = success)

### Protocol Types

- **T=0**: Byte-oriented protocol (most common for older cards)
- **T=1**: Block-oriented protocol with error detection and recovery
- **T=14**: Protocol for USB-CCID (Chip Card Interface Device)
- **T=15**: Protocol for contactless extensions

## Common Applications

**Financial Services**
- EMV chip credit and debit cards
- Electronic purse and prepaid cards
- ATM cards and banking tokens
- Secure payment terminals

**Telecommunications**
- SIM cards (Subscriber Identity Module)
- USIM cards for 3G/4G/5G networks
- Operator authentication
- Over-the-air (OTA) updates

**Identity and Access Control**
- National ID cards and e-passports
- Employee access badges
- Healthcare insurance cards
- Driver's licenses with chip

**Government and Security**
- Digital signatures and PKI
- Secure document signing
- Government service authentication
- Military and defense ID

**Transportation**
- Transit fare payment cards
- Contactless ticketing systems
- Toll road payment systems
- Loyalty and reward programs

**Digital TV and Content**
- Conditional access modules (CAM)
- Pay-TV subscriber cards
- Content decryption keys
- Viewer authentication

## Decoder Configuration

When analyzing ISO 7816 smart card communication with a logic analyzer, configure the following parameters:

**Signal Connections**
- **CLK**: Connect to card's C3 contact (clock input)
- **RST**: Connect to card's C2 contact (reset)
- **I/O**: Connect to card's C7 contact (data line): primary signal to decode
- **VCC/GND**: Optional monitoring of C1 (power) and C5 (ground)

**Decoder Parameters**
- **Initial Baud Rate**: Start with default (typically 9600 bps or specify ETU)
- **Clock Source**: Use CLK signal to derive timing (F/D divisor)
- **Convention**: Auto-detect from TS byte (direct=0x3B or inverse=0x3F)
- **Parity**: Even parity (standard for ISO 7816)
- **Protocol Mode**: T=0 or T=1 (often auto-detected from ATR)
- **ATR Decoding**: Enable to capture and parse Answer to Reset
- **APDU Parsing**: Enable command/response APDU interpretation

**Trigger Settings**
- Trigger on RST rising edge to capture full power-up and ATR sequence
- Alternatively, trigger on TS character (0x3B or 0x3F) on I/O line
- For command analysis, trigger on CLA byte patterns

**Analysis Tips**
- Record from power-up to capture complete ATR negotiation
- Monitor for timing violations (guard time, work waiting time)
- Check parity errors on each character
- Verify protocol parameters derived from ATR match actual communication
- Decode historical bytes for card identification
- Parse SW1/SW2 status codes for error conditions

**Common Issues**
- **No ATR**: Check RST, CLK, and VCC connections; verify card insertion
- **Parity Errors**: Signal integrity issues or incorrect ETU calculation
- **Timing Violations**: Incorrect F/D divisor or clock frequency
- **No Response**: Card in error state, check for proper reset sequence

## Reference

- [ISO/IEC 7816-3: Electronic signals and transmission protocols](https://www.iso.org/standard/38770.html)
- [EMVCo Specifications](https://www.emvco.com/emv-technologies/contact/)
- [PC/SC Workgroup](https://pcscworkgroup.com/): Standards for smart card readers
- [Smart Card Basics](https://www.smartcardbasics.com/): Educational resource
- [ISO 7816 Wikipedia](https://en.wikipedia.org/wiki/ISO/IEC_7816): Overview and history

---
**Last Updated**: 2026-02-02
