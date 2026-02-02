# SSI (Synchronous Serial Interface)

## What is SSI?

### Overview

SSI (Synchronous Serial Interface) is a high-speed serial communication protocol commonly used for transferring data between Ethernet PHYs (Physical Layer transceivers), network processors, and switching/routing ASICs in telecommunications and networking equipment. While "SSI" is a general term that can refer to various synchronous serial interfaces, in the networking context it typically refers to source-synchronous serial interfaces that transfer data alongside a clock signal, enabling multi-gigabit data rates between chips on the same PCB. SSI interfaces are designed for short-distance, high-bandwidth chip-to-chip communication where parallel buses would consume too many pins and routing resources, making them essential for modern high-performance network infrastructure.

The SSI protocol family includes several variants with different data widths and speeds, ranging from 8-bit to 32-bit parallel data paths clocked at hundreds of MHz. Unlike fully serialized interfaces like SERDES which use complex clock recovery and equalization, SSI maintains a source-synchronous clocking scheme where the transmitter provides both data and clock signals, allowing the receiver to sample data with precise timing relationships. This approach offers a good balance between simplicity, pin count, and achievable data rates, making SSI suitable for board-level interconnects in routers, switches, and network processing systems where multi-gigabit aggregate bandwidth is required without the complexity of high-speed serialization.

SSI is widely deployed in telecommunications equipment including carrier-grade routers, enterprise switches, optical transport systems, and wireless base stations. The interface supports various traffic types including Ethernet packets, TDM (Time Division Multiplexing) voice channels, and backplane interconnects. Modern SSI implementations often operate at 2.5 Gbps to 12 Gbps aggregate bandwidth (depending on bus width and clock frequency), with features like embedded control signals, error detection, and flow control integrated into the data stream. Understanding SSI timing and signaling is essential for debugging network processor interfaces, validating PHY-to-MAC connectivity, and troubleshooting high-speed board-level interconnects.

### Key Features

- **Source-Synchronous**: Clock provided by transmitter with data
- **Parallel Data Path**: 8-bit, 16-bit, or 32-bit wide data buses
- **High Speed**: Clock rates from 125 MHz to 500+ MHz
- **Chip-to-Chip**: Short-distance PCB-level interconnect
- **Networking Focus**: Ethernet PHY, MAC, switch ASIC interfaces
- **Point-to-Point**: Direct connection between two devices
- **DDR Capable**: Some variants use Double Data Rate clocking
- **Embedded Control**: Control signals within data stream
- **Low Latency**: Minimal protocol overhead
- **Standard Variants**: Multiple industry implementations (vendor-specific)

## Technical Specifications

### Signal Description

**Basic SSI Signals** (varies by implementation)

- **TXD[n:0]**: Transmit data lines (8, 16, or 32 bits)
- **TXC / TXCLK**: Transmit clock (source-synchronous with TXD)
- **TXEN / TXCTL**: Transmit enable/control signal
- **RXD[n:0]**: Receive data lines (8, 16, or 32 bits)
- **RXC / RXCLK**: Receive clock (source-synchronous with RXD)
- **RXEN / RXCTL**: Receive enable/control signal

**Electrical Characteristics**
- **Voltage Levels**: LVDS (Low Voltage Differential Signaling) or CMOS (1.8V, 2.5V, 3.3V)
- **Signaling**: Single-ended or differential depending on variant
- **Impedance**: 50Ω or 100Ω differential (LVDS variants)
- **Topology**: Point-to-point only (no multi-drop)

### Clock and Data Timing

**Clock Frequencies**
- **125 MHz**: Common for Gigabit Ethernet applications (8-bit @ 1 Gbps)
- **156.25 MHz**: 10 Gigabit Ethernet XAUI-related (64-bit @ 10 Gbps)
- **312.5 MHz**: High-speed variants
- **DDR Operation**: Effective doubling of data rate (both clock edges)

**Timing Relationships**
- **Setup Time**: Data stable before clock edge (typically 100-500 ps)
- **Hold Time**: Data stable after clock edge (typically 100-500 ps)
- **Clock-to-Data Skew**: Minimal skew required (<±500 ps typical)
- **Data Valid Window**: Centered around clock edge

**Data Rates**
- 8-bit @ 125 MHz = 1 Gbps
- 16-bit @ 156.25 MHz = 2.5 Gbps
- 32-bit @ 312.5 MHz = 10 Gbps
- DDR variants achieve 2× these rates

### Data Frame Structure

**Typical Frame Format** (implementation-specific)

- **Start-of-Frame (SOF)**: Special control code or TXEN assertion
- **Data Payload**: Ethernet frames, TDM data, or raw packet data
- **End-of-Frame (EOF)**: Control code or TXEN deassertion
- **Idle**: Control codes or idle patterns between frames

**Control Encoding**

Many SSI variants use in-band control:
- **Data vs. Control**: Dedicated control bit or 8B/10B-like encoding
- **Frame Boundaries**: Start and end delimiters
- **Error Indication**: Parity, CRC, or error flags in-band
- **Flow Control**: Pause or throttle signaling

### SSI Variants and Standards

**Common Implementations**

1. **SSSMII (Source Synchronous Serial MII)**
   - 1-4 lanes (nibble-wide per lane)
   - Gigabit Ethernet focus
   - Clock and data per lane

2. **SPI-4.2 (System Packet Interface Level 4)**
   - Standardized by OIF (Optical Internetworking Forum)
   - 16-bit data bus (can be bonded for higher speeds)
   - Training sequences and DIP-4 encoding
   - Designed for 10 Gbps applications

3. **XAUI (10 Gigabit Attachment Unit Interface)**
   - 4 lanes × 3.125 Gbps = 10 Gbps aggregate
   - 8B/10B encoding per lane
   - Used for 10GbE PHY-to-MAC connections

4. **Vendor-Specific SSI**
   - Broadcom, Marvell, Intel, Qualcomm custom variants
   - Often proprietary timing and control signaling
   - Optimized for specific chip families

### Differential Signaling (LVDS Variants)

**LVDS SSI Characteristics**
- **Differential Voltage**: ±350 mV typical
- **Common Mode**: 1.2V nominal
- **Differential Impedance**: 100Ω
- **Termination**: 100Ω across differential pair at receiver
- **Advantages**: Better noise immunity, lower EMI, higher speeds

## Common Applications

**Networking Equipment**
- Ethernet switches (1G, 10G, 40G, 100G)
- Enterprise and data center routers
- Carrier-grade routing platforms
- Layer 2/Layer 3 switching systems
- Network interface cards (NICs)

**Telecommunications**
- Optical transport equipment (OTN)
- Wireless base stations (RAN)
- Mobile backhaul systems
- SONET/SDH transmission systems
- Packet transport networks

**PHY-to-MAC Interfaces**
- Ethernet PHY transceiver connections
- Copper and fiber PHY interfaces
- Multi-rate PHY (10/100/1000/10G)
- Optical module interfaces (SFP, SFP+, QSFP)

**Network Processors**
- NPU (Network Processing Unit) interfaces
- Traffic manager connections
- Fabric interface to line cards
- Search engine and classification ASICs
- Packet processors

**Industrial Networking**
- Industrial Ethernet switches
- Process control networks
- Factory automation systems
- Transportation and railway networks
- Power grid communication (IEC 61850)

**Test and Measurement**
- Network analyzers
- Protocol testers
- Bit error rate testers (BERT)
- Network emulation equipment

## Decoder Configuration

When analyzing SSI traffic with a logic analyzer, configure the following parameters:

### Signal Connections

**Minimum Configuration** (unidirectional)
- TXD[n:0] - All transmit data lines (8, 16, or 32 channels)
- TXCLK - Transmit clock (1 channel)
- TXEN/TXCTL - Transmit enable/control (1 channel)

**Bidirectional Configuration**
- Add RXD[n:0], RXCLK, RXEN/RXCTL for receive direction

**Differential Signaling** (if LVDS)
- Capture both P and N of each differential pair
- May require differential probes or input mode

### Sampling Requirements

- **Minimum Sample Rate**: 4× the clock frequency
- For 312.5 MHz clock: Minimum 1.25 GS/s
- For 156.25 MHz clock: Minimum 625 MS/s
- For 125 MHz clock: Minimum 500 MS/s
- **Recommended**: 10× clock frequency for timing analysis

### Decoder Parameters

- **Bus Width**: 8, 16, or 32 bits
- **Clock Frequency**: Specify or auto-detect
- **Clock Edge**: Rising, falling, or DDR (both edges)
- **Control Encoding**: Frame format (SOF/EOF markers)
- **Data Format**: Hex, binary, or protocol-specific (e.g., Ethernet frames)
- **Idle Pattern**: Expected idle code or pattern
- **Error Detection**: Enable CRC or parity checking if supported

### Display Options

- Show data bus as hex values per clock cycle
- Decode Ethernet frames if encapsulated
- Display frame boundaries (SOF/EOF)
- Annotate control vs. data periods
- Show idle periods
- Indicate errors (parity, CRC, framing errors)
- Calculate throughput and utilization

### Trigger Settings

- Trigger on TXEN/RXEN assertion (start of frame)
- Trigger on specific data patterns
- Trigger on SOF/EOF control codes
- Trigger on clock edge with specific data value
- Trigger on error conditions
- Pre-trigger to capture idle state before frame

### Analysis Tips

1. **Verify Clock Quality**
   - Measure clock frequency and stability
   - Check for jitter and phase noise
   - Ensure clock meets timing specifications

2. **Check Data-to-Clock Timing**
   - Measure setup and hold times
   - Verify data valid window centered on clock edge
   - Look for timing violations at high speeds

3. **Identify Frame Boundaries**
   - Decode SOF/EOF markers
   - Verify frame enable signals (TXEN/RXEN)
   - Check for proper frame sequencing

4. **Validate Data Integrity**
   - Check for bit errors or corruption
   - Verify CRC or parity (if implemented)
   - Look for unexpected data patterns

5. **Analyze Throughput**
   - Calculate effective data rate
   - Measure inter-frame gaps
   - Identify idle periods and utilization

6. **Monitor Control Signaling**
   - Observe in-band control codes
   - Check flow control behavior
   - Verify training sequences (if applicable)

7. **Differential Signal Quality** (LVDS variants)
   - Check differential voltage levels
   - Measure common-mode voltage
   - Look for skew between P and N signals

### Common Issues

**No Data / Idle Only**
- **Symptom**: Continuous idle patterns, no frames
- **Cause**: Link not active, PHY not initialized, no traffic
- **Solution**: Verify link establishment, check PHY configuration

**Timing Violations**
- **Symptom**: Corrupted data, intermittent errors
- **Cause**: Setup/hold time violations, clock-to-data skew
- **Solution**: Check PCB layout, add delay tuning, reduce clock speed

**Clock Missing or Unstable**
- **Symptom**: No clock signal or frequency drift
- **Cause**: Clock source disabled, PLL not locked
- **Solution**: Verify clock source, check PLL configuration

**Framing Errors**
- **Symptom**: SOF/EOF misalignment, frame length errors
- **Cause**: Protocol violation, software bug, PHY issue
- **Solution**: Verify frame generation logic, check protocol implementation

**Signal Integrity Issues**
- **Symptom**: Eye diagram closure, high BER
- **Cause**: Reflections, crosstalk, termination problems
- **Solution**: Check impedance matching, improve PCB routing, add termination

**Differential Imbalance** (LVDS)
- **Symptom**: Common-mode noise, EMI issues
- **Cause**: Skew between P and N, layout asymmetry
- **Solution**: Balance trace lengths, improve differential routing

### Advanced Analysis

**Eye Diagram Analysis**
- Overlay multiple data transitions
- Measure eye opening (width and height)
- Assess timing margins
- Identify jitter and noise

**Protocol Decoding**
- Decode encapsulated protocols (Ethernet, TDM)
- Parse frame headers and payloads
- Validate protocol compliance
- Analyze traffic patterns

**Performance Profiling**
- Measure packet rates and throughput
- Analyze latency and jitter
- Identify bottlenecks
- Optimize frame scheduling

**Compliance Testing**
- Verify timing parameters against specs
- Check signal integrity requirements
- Validate electrical characteristics
- Test interoperability with different devices

## Reference

- [SPI-4.2 System Packet Interface](https://www.oiforum.com/technical-work/hot-topics/spi-4-2/) - OIF Specification
- [XAUI Interface Specification](https://www.ieee802.org/3/ae/public/adhoc/serial_pmd/) - IEEE 802.3ae
- [Source Synchronous Interfaces](https://www.ti.com/lit/an/spra801/spra801.pdf) - Design Guide
- [High-Speed Digital Design](https://www.amazon.com/High-Speed-Digital-Design-Handbook/dp/0133957241) - Johnson & Graham
- [LVDS Owner's Manual](https://www.ti.com/lit/ml/snla187/snla187.pdf) - Texas Instruments

---
**Last Updated**: 2026-02-02
