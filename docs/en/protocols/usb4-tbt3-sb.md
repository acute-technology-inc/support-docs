# USB4/Thunderbolt 3 Sideband

## What is USB4/Thunderbolt 3 Sideband?

USB4/Thunderbolt 3 Sideband is a low-speed auxiliary communication channel that operates independently from the high-speed differential lanes in USB4 and Thunderbolt 3 interfaces. Standardized in the USB4™ Thunderbolt3™ Compatibility Requirements Specification (Version 1.0, January 2021), this protocol was developed through collaboration between Apple, HP, Intel, Microsoft, Renesas, STMicroelectronics, and Texas Instruments to ensure interoperability between USB4 and Thunderbolt 3 devices. The sideband channel manages critical link initialization, configuration, and management functions that occur before and during high-speed data transmission.

The sideband protocol uses a bidirectional, half-duplex, two-wire serial bus operating at 1 Mbps with 10-bit start/stop encoding that requires no separate synchronization clock. It operates independently from the main high-speed differential pairs (lanes), providing a dedicated control channel for router discovery, capability negotiation, link configuration, and continuous link management. The protocol supports three transaction types: Link Type (LT) for basic link operations, Administrative Type (AT) for higher-level management, and Retimer Type (RT) for managing signal retimer devices in the communication path.

USB4 and Thunderbolt 3 combine to support Gen 2 (20 Gbps), Gen 3 (40 Gbps), and Gen 4 (80 Gbps symmetric or 120 Gbps asymmetric) link speeds. The sideband channel handles essential tasks such as lane bonding negotiation, transmitter equalization parameter exchange, sleep state management, and fault recovery—all occurring over this low-speed control channel while the high-speed lanes carry user data at multi-gigabit rates. The sideband's independence from the main data lanes allows it to remain operational even when high-speed links are down or in low-power states, making it essential for robust link management.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- Two-wire bidirectional serial interface
- Operates independently from high-speed differential lanes
- Half-duplex communication
- Open-drain or open-collector signaling with pull-up resistors

**Data Rate:**
- 1 Mbps (megabit per second)
- 10-bit start/stop encoding
- Self-clocked, no separate synchronization required

### Protocol Structure

**Transaction Types:**
- **Link Type (LT)**: Basic link initialization and control operations
- **Administrative Type (AT)**: Higher-level management and configuration
- **Retimer Type (RT)**: Management of signal retimer devices in the path

**Frame Structure:**
- 10-bit encoding per byte (start bit, 8 data bits, stop bit)
- Variable-length packets depending on transaction type
- CRC-protected for data integrity

### Key Functions

The sideband channel manages these critical operations:

**Lane Initialization:**
- Router detection and enumeration
- USB4 port characteristic exchange (bonding support, lane speeds)
- RS-FEC (Reed-Solomon Forward Error Correction) status negotiation
- Asymmetric link capability negotiation
- Transmitter equalization (TxFFE) parameter negotiation

**Link Management:**
- Sleep state entry and exit coordination
- Disconnect and reconnect handling
- Link recovery and error management
- Power state transitions

**High-Speed Coordination:**
- Broadcasting negotiated parameters to all lanes
- Synchronizing high-speed lane activation
- Initiating and managing multi-lane data transmission

### Supported Link Speeds

The protocol supports coordination for:
- **Gen 2**: 20 Gbps (10 Gbps per lane, 2 lanes)
- **Gen 3**: 40 Gbps (20 Gbps per lane, 2 lanes)
- **Gen 4**: 80 Gbps symmetric (40 Gbps per lane, 2 lanes) or 120 Gbps asymmetric

## Common Applications

USB4/Thunderbolt 3 Sideband is used in all USB4 and Thunderbolt 3 implementations:

**Computing Devices:**
- Laptop and desktop USB4/Thunderbolt 3 host controllers
- External GPU (eGPU) enclosures with Thunderbolt 3
- Docking stations with USB4/Thunderbolt connectivity
- USB4 hubs and daisy-chain devices

**High-Speed Peripherals:**
- External NVMe SSD enclosures (Thunderbolt 3/USB4)
- Professional video capture devices
- Audio/video production equipment
- High-speed network adapters (10/25/40 GbE over Thunderbolt)

**Display Connectivity:**
- DisplayPort Alt Mode tunneling over USB4
- External 4K/5K/8K displays via Thunderbolt 3/USB4
- Multi-display daisy-chaining configurations

**Cable and Connector Management:**
- Active USB4/Thunderbolt cables with retimers
- USB4 cable orientation detection
- Thunderbolt 3 certified cable identification

**Debugging and Development:**
- Protocol analyzer tools for USB4/Thunderbolt
- Compliance testing equipment
- Router and retimer development
- Interoperability validation between USB4 and Thunderbolt 3 devices

**Power Delivery Integration:**
- Coordination with USB Power Delivery (USB PD)
- Dynamic power allocation for multiple devices
- Charging capability negotiation

## Decoder Configuration

When configuring a logic analyzer to decode USB4/Thunderbolt 3 Sideband signals:

### Channel Assignment

**Minimum Configuration (2 channels):**
- **SB_TX**: Sideband transmit data line (host to device)
- **SB_RX**: Sideband receive data line (device to host)

**Optional (1 channel):**
- **Ground or reference**: For signal quality reference

### Protocol Parameters

**Timing Settings:**
- **Bit rate**: 1 Mbps (1 microsecond per bit)
- **Encoding**: 10-bit start/stop (1 start, 8 data, 1 stop)
- **Sampling rate**: Minimum 10 MHz (10x oversampling recommended)
- **Bit order**: LSB first (least significant bit first)

**Transaction Decoding:**
- **Packet types**: Identify LT (Link Type), AT (Administrative), RT (Retimer)
- **CRC validation**: Enable CRC checking for data integrity
- **Address decoding**: Display router addresses and port numbers
- **Command interpretation**: Decode common commands and responses

### Trigger Settings

**Common trigger conditions:**
- **Packet start**: Trigger on start bit detection
- **Transaction type**: Trigger on specific LT/AT/RT packet types
- **Error conditions**: Trigger on CRC errors or protocol violations
- **State transitions**: Trigger on link state changes (initialization, sleep entry, recovery)
- **Specific commands**: Trigger on lane configuration or capability negotiation packets

### Display Options

**Visualization settings:**
- Show decoded packet headers (type, length, addresses)
- Display command names and parameter values
- Annotate link state transitions
- Highlight CRC errors and protocol violations
- Show timing between related transactions
- Display lane configuration parameters (bonding, speeds, equalization)

### Analysis Tips

**Link Initialization Capture:**
Begin capture during device connection to observe the complete initialization sequence from router discovery through lane activation. This provides context for understanding subsequent management traffic.

**Transaction Correlation:**
Correlate sideband transactions with high-speed lane activity to understand how control plane operations affect data plane behavior. Look for sideband configuration messages immediately before lane speed changes or bonding reconfiguration.

**Error Analysis:**
When troubleshooting link issues, focus on CRC errors, missing acknowledgments, or repeated retry attempts on the sideband channel. These often indicate signal integrity problems, timing violations, or incompatible device implementations.

**Retimer Management:**
For active cables or systems with retimers, pay special attention to RT (Retimer Type) transactions, which manage signal conditioning and equalization parameters through the retimer devices.

**Power State Transitions:**
Monitor sideband activity during sleep entry/exit and device reconnection to understand low-power behavior and wake-up sequences. The sideband remains active even when high-speed lanes are powered down.

## Reference

- [USB4™ Specification](https://www.usb.org/document-library/usb4tm-specification): USB Implementers Forum
- [USB4™ Thunderbolt3™ Compatibility Requirements Specification](https://usb.org/document-library/usb4tm-thunderbolt3tm-compatibility-requirements-specification): USB-IF
- [Thunderbolt™ Technology](https://www.intel.com/content/www/us/en/architecture-and-technology/thunderbolt/thunderbolt-technology-general.html): Intel
- [USB4 Sideband Channel Is Not a Side Business](https://community.cadence.com/cadence_blogs_8/b/fv/posts/usb4-sideband-channel-is-not-a-side-business): Cadence Technical Blog
- [Wikipedia: USB4](https://en.wikipedia.org/wiki/USB4)
