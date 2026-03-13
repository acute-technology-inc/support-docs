# HDLC (High-Level Data Link Control)

## What is HDLC?

### Overview

HDLC (High-Level Data Link Control) is a bit-oriented data link layer protocol developed by the International Organization for Standardization (ISO) for reliable point-to-point and multipoint communication. Standardized as ISO/IEC 13239:2002, HDLC provides a comprehensive framework for transmitting data frames between nodes in telecommunications and computer networks with built-in error detection, flow control, and frame synchronization mechanisms. Originally derived from IBM's SDLC (Synchronous Data Link Control) protocol, HDLC has become one of the foundational protocols in data communications, serving as the basis for numerous other protocols including PPP (Point-to-Point Protocol), Frame Relay, LAPB (Link Access Procedure Balanced), and ISDN's LAPD.

HDLC's bit-oriented nature means it operates independently of character codes or byte boundaries, using special bit patterns (flags) to delimit frames and a technique called bit stuffing to maintain data transparency—ensuring that payload data never accidentally mimics control sequences. This approach provides greater efficiency and flexibility compared to earlier character-oriented protocols, allowing arbitrary binary data transmission without restrictions.

### Key Characteristics

- **Bit-Oriented**: Frame boundaries defined by bit patterns, not character boundaries
- **Code-Transparent**: Any bit pattern can be transmitted in the data field
- **Comprehensive Error Detection**: Frame Check Sequence (FCS) using CRC
- **Flow Control**: Sliding window mechanism prevents buffer overflows
- **Multiple Operational Modes**: Supports various network topologies and configurations
- **International Standard**: ISO/IEC 13239:2002 (consolidated from earlier separate standards)

## Frame Structure

### Basic Frame Format

All HDLC frames share a common structure:

```
Flag | Address | Control | Information | FCS | Flag
0x7E |  8+ bits| 8/16 bit|  Variable  |16/32| 0x7E
```

**Flag Sequence (01111110)**:
- Marks beginning and end of each frame
- Value: 0x7E (binary 01111110)
- Consecutive frames can share a closing/opening flag
- Receiver synchronizes to flag boundaries

**Address Field (8 bits minimum, extensible)**:
- Identifies destination (secondary) station
- Can be extended beyond 8 bits using EA (Extension Address) bit
- First bit=1 indicates final address octet, 0 indicates continuation
- Broadcast address (all 1s) addresses all stations
- Group addresses can address subsets of stations

**Control Field (8 or 16 bits)**:
- Defines frame type (Information, Supervisory, or Unnumbered)
- Contains sequence numbers for flow control and error recovery
- Specifies command or response designation
- Carries modifiers for unnumbered frames

**Information Field (Variable length)**:
- Carries user data payload
- Length not specified in frame (receiver processes until FCS)
- Only present in Information frames and some Unnumbered frames
- Can contain any bit pattern due to bit stuffing

**Frame Check Sequence (16 or 32 bits)**:
- CRC-16 (X.25 standard): 16-bit CRC for error detection
- CRC-32: 32-bit CRC for enhanced error detection
- Calculated over Address, Control, and Information fields
- Excludes Flag and bit stuffing bits

## Frame Types

### Information Frames (I-frames)

**Purpose**: Carry user data with sequence numbers for reliable delivery

**Control Field Structure (16-bit extended format)**:
- Bit 0: Always 0 (identifies as I-frame)
- Bits 1-8: N(S): Send sequence number
- Bit 9: P/F (Poll/Final) bit
- Bits 10-16: N(R): Receive sequence number (piggybacked acknowledgment)

**Function**:
- Numbered frames for sequenced delivery
- Simultaneous data transfer and acknowledgment
- Enables full-duplex operation with efficient bandwidth use

### Supervisory Frames (S-frames)

**Purpose**: Flow control and error control without user data

**Types**:
- **RR (Receive Ready)**: Ready to receive, acknowledges frames up to N(R)-1
- **RNR (Receive Not Ready)**: Temporarily unable to receive (buffer full)
- **REJ (Reject)**: Requests retransmission starting from frame N(R)
- **SREJ (Selective Reject)**: Requests retransmission of specific frame N(R) only

**Control Field**:
- Bits 0-1: Type identifier (10)
- Bits 2-3: Supervisory function code (RR/RNR/REJ/SREJ)
- Bit 4: P/F bit
- Bits 5-11: N(R) acknowledgment number

### Unnumbered Frames (U-frames)

**Purpose**: Link control, mode setting, and connection management

**Common Commands**:
- **SABM/SABME**: Set Asynchronous Balanced Mode (Extended)
- **DISC**: Disconnect request
- **UA**: Unnumbered Acknowledgment (positive response)
- **DM**: Disconnected Mode (link not operational)
- **FRMR**: Frame Reject (protocol error detected)
- **XID**: Exchange Identification information
- **TEST**: Test link integrity

## Operational Modes

### Normal Response Mode (NRM)

**Configuration**: Unbalanced (primary/secondary stations)
- Primary initiates all data transfers
- Secondary only responds when polled
- Typical in multipoint lines with centralized control

### Asynchronous Response Mode (ARM)

**Configuration**: Unbalanced with secondary-initiated responses
- Secondary can transmit without polling
- Primary maintains control of link
- Reduces latency in some applications

### Asynchronous Balanced Mode (ABM)

**Configuration**: Balanced (combined stations, peer-to-peer)
- Both stations can initiate transmission
- No distinction between primary/secondary
- Most common in modern point-to-point links (e.g., PPP, LAPB)

## Bit Stuffing for Transparency

**Problem**: Payload data might contain the flag sequence (01111110), causing false frame boundaries.

**Solution**: Bit Stuffing
- Transmitter: After five consecutive 1s in data, automatically insert a 0
- Receiver: After receiving five consecutive 1s followed by 0, automatically remove the 0
- This ensures flag pattern (six consecutive 1s) only appears at frame boundaries

**Example**:
- Data: 0111 111 0
- Stuffed: 0111 110 10 (0 inserted after five 1s)
- Receiver removes stuffed bit, recovers original data

## Decoder Configuration

When configuring an HDLC decoder:

- **Signal Lines**: Specify data line and clock line (if synchronous)
- **Bit Rate**: Set expected bit rate for proper sampling
- **Frame Check Sequence**: Select 16-bit or 32-bit CRC
- **Address Display**: Configure address field length and format
- **Control Field**: Select 8-bit or 16-bit control field format
- **Frame Type Filter**: Choose to display I-frames, S-frames, U-frames, or all
- **Error Detection**: Enable FCS validation and report errors
- **Bit Stuffing**: Decoder automatically handles destuffing

## Common Applications

HDLC and HDLC-derived protocols are widespread:

**Wide Area Networks (WAN)**:
- X.25 packet switching (LAPB)
- Frame Relay
- PPP (Point-to-Point Protocol) for dial-up and DSL
- ISDN D-channel (LAPD)

**Telecommunications**:
- SS7 signaling (MTP Level 2)
- Cellular base station communication
- Microwave radio links
- Satellite communication links

**Industrial Networks**:
- PROFIBUS (field bus)
- IEC 60870-5 (power system monitoring and control)
- DNP3 (utility SCADA)

**Computer Networks**:
- Cisco HDLC (proprietary variant)
- Multi-link PPP for link aggregation

## Advantages

- **Efficiency**: Bit-oriented operation, no character overhead
- **Reliability**: Strong error detection with CRC
- **Transparency**: Any data pattern transmissible
- **Flow Control**: Sliding window prevents overruns
- **Flexibility**: Multiple modes suit various topologies
- **Standardized**: International standard ensures interoperability
- **Proven**: Decades of successful deployment

## Reference

- [ISO/IEC 13239:2002 - HDLC Procedures](https://www.iso.org/standard/37010.html)
- [ISO/IEC 13239:2002 Sample (PDF)](https://cdn.standards.iteh.ai/samples/37010/cd2f63d674744888baccaf42845e119a/ISO-IEC-13239-2002.pdf)
- [ISO/IEC 3309:1993 - Frame Structure](https://www.iso.org/standard/8561.html)
- [Wikipedia: High-Level Data Link Control](https://en.wikipedia.org/wiki/High-Level_Data_Link_Control)
