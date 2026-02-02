# MII (Media Independent Interface)

## What is MII?

### Overview

MII (Media Independent Interface) is the original standardized interface defined in IEEE 802.3 for connecting Ethernet MAC controllers to PHY transceivers. Introduced in 1995 alongside Fast Ethernet (100BASE-TX), MII provides a clean separation between the MAC and PHY layers, enabling flexible hardware architectures. The interface uses a 4-bit wide datapath in each direction (TX and RX) with separate clocks, supporting both 10 Mbps and 100 Mbps operation. MII became the foundation upon which subsequent MAC-PHY interfaces (RMII, GMII, RGMII) were built.

The MII specification defines not only the data interface but also the management interface (MDC/MDIO) used to configure and monitor the PHY. This management interface, defined in IEEE 802.3 Clause 22, has become a universal standard across all Ethernet PHY variants. MII's parallel architecture makes it straightforward to implement and easy to debug, though it requires more pins than later reduced-pin variants.

While MII has been partially superseded by RMII for 10/100 applications due to pin count advantages, MII remains relevant in FPGA/ASIC implementations where internal routing is not constrained and the simpler non-DDR timing is preferred. The interface is also commonly used in educational settings and reference designs due to its straightforward operation.

## Technical Specifications

### Data Interface

- **Data Width**: 4 bits (nibble) per direction
- **Clock Frequency**: 25 MHz for 100 Mbps, 2.5 MHz for 10 Mbps
- **Pin Count**: 16 data/control signals (plus 2 for management)
- **Throughput**: 10/100 Mbps
- **Clocking**: Separate TX_CLK and RX_CLK

### Signal Description

**TX Signals** (MAC to PHY - 7 signals)
- **TXD[3:0]**: Transmit data (4-bit bus)
- **TX_EN**: Transmit enable (active high during frame transmission)
- **TX_CLK**: Transmit clock (sourced by PHY, 25 MHz or 2.5 MHz)
- **TX_ER**: Transmit error (optional, indicates intentional error injection)

**RX Signals** (PHY to MAC - 9 signals)
- **RXD[3:0]**: Receive data (4-bit bus)
- **RX_DV**: Receive data valid (active high during valid frame reception)
- **RX_CLK**: Receive clock (sourced by PHY, 25 MHz or 2.5 MHz)
- **RX_ER**: Receive error (indicates PHY detected error)
- **COL**: Collision detect (for half-duplex operation)
- **CRS**: Carrier sense (indicates activity on medium)

**Management Interface** (2 signals - shared across all variants)
- **MDC**: Management data clock (up to 2.5 MHz, sourced by MAC)
- **MDIO**: Management data I/O (bidirectional serial data)

### Timing Characteristics

**Clock Specifications**
- **100 Mbps Mode**: TX_CLK and RX_CLK at 25 MHz
- **10 Mbps Mode**: TX_CLK and RX_CLK at 2.5 MHz
- **Duty Cycle**: 40-60% typical
- **Jitter**: ±5% maximum

**Data Timing** (typical values)
- **Setup Time**: 10 ns minimum (data to clock)
- **Hold Time**: 10 ns minimum (data after clock)
- **Clock-to-Output**: 5-25 ns typical (PHY driving signals)
- **Propagation Delay**: TX_CLK to RX_CLK matched within 10 ns on same device

**Signal Transitions**
- Data valid on rising edge of respective clock
- TX_EN controls frame transmission boundaries
- RX_DV indicates valid received data
- All signals are synchronous to their respective clocks

## Decoder Configuration

When analyzing MII with a logic analyzer, configure the following:

### Signal Connections

**Minimum Configuration** (data only - 14 channels)
- TXD[3:0] - 4 channels
- TX_EN, TX_CLK, TX_ER - 3 channels
- RXD[3:0] - 4 channels
- RX_DV, RX_CLK, RX_ER - 3 channels

**Full Configuration** (with collision/carrier - 16 channels)
- Add COL and CRS - 2 channels

**With Management** (18 channels total)
- Add MDC and MDIO - 2 channels

### Sampling Requirements

- **Minimum Sample Rate**: 100 MS/s (4× the 25 MHz clock)
- **Recommended**: 200-250 MS/s for clean captures
- **For 10 Mbps**: 25 MS/s minimum, 50 MS/s recommended

### Decoder Parameters

- **Interface Type**: MII
- **Speed**: 10 Mbps or 100 Mbps (usually auto-detect from clock frequency)
- **Clock Edge**: Rising edge (standard for MII)
- **Frame Format**: Ethernet II (DIX) or IEEE 802.3
- **MDIO Decoding**: Enable if management signals connected
- **Error Detection**: Enable TX_ER and RX_ER monitoring
- **FCS Validation**: Enable CRC checking

### Display Options

- Show TX and RX data separately with timestamps
- Display Ethernet frame fields (preamble, addresses, type/length, payload, FCS)
- Highlight TX_EN and RX_DV active periods
- Indicate errors via TX_ER, RX_ER, or CRC failures
- Show COL and CRS events for half-duplex analysis
- Decode MDIO register reads/writes

### Trigger Settings

- **Frame Start**: Trigger on TX_EN or RX_DV rising edge
- **Specific Address**: Trigger on MAC address pattern in TXD or RXD
- **Error Events**: Trigger on TX_ER or RX_ER assertion
- **Collision**: Trigger on COL assertion (half-duplex debug)
- **MDIO Activity**: Trigger on MDC/MDIO start condition
- **Pre-trigger**: Capture 10-20% before trigger to see idle state

### Analysis Tips

1. **Verify Clock Frequency**
   - 25 MHz for 100 Mbps mode
   - 2.5 MHz for 10 Mbps mode
   - Check for clock stability and jitter

2. **Check Frame Structure**
   - Preamble: 7 bytes of 0x55
   - SFD (Start Frame Delimiter): 0xD5
   - Destination MAC: 6 bytes
   - Source MAC: 6 bytes
   - Type/Length: 2 bytes
   - Payload: 46-1500 bytes
   - FCS (CRC-32): 4 bytes

3. **Validate Timing**
   - Data setup/hold relative to clock edges
   - TX_EN timing around data
   - RX_DV timing around data
   - Inter-frame gap (IFG): minimum 96 bit times (9.6 µs at 100 Mbps)

4. **Monitor Control Signals**
   - TX_EN should be high during entire frame
   - RX_DV should be high for preamble through FCS
   - COL indicates collision in half-duplex
   - CRS indicates carrier present

5. **MDIO Transactions**
   - Monitor PHY register configuration
   - Check auto-negotiation results
   - Verify link status
   - Read PHY capabilities

## Common Issues

**Clock Problems**
- **Symptom**: No communication or garbled data
- **Cause**: Missing TX_CLK or RX_CLK, wrong frequency
- **Solution**: Verify PHY is powered and configured, check crystal/oscillator

**Timing Violations**
- **Symptom**: Intermittent errors, CRC failures
- **Cause**: Setup/hold violations, excessive trace length
- **Solution**: Improve PCB routing, reduce trace length, check signal integrity

**Frame Errors**
- **Symptom**: RX_ER asserted, FCS errors
- **Cause**: PHY detected coding errors, signal quality issues
- **Solution**: Check cable, connectors, and PHY configuration

**Half-Duplex Collisions**
- **Symptom**: COL frequently asserted
- **Cause**: Multiple devices transmitting simultaneously
- **Solution**: Verify duplex settings match, consider full-duplex

**No Link**
- **Symptom**: CRS never asserted, no RX data
- **Cause**: PHY not detecting carrier, cable issue, duplex mismatch
- **Solution**: Check cable, verify PHY link status via MDIO, check auto-negotiation

**MDIO Communication Failures**
- **Symptom**: PHY not responding to reads/writes
- **Cause**: Wrong PHY address, MDC frequency too high
- **Solution**: Verify PHY address strapping, reduce MDC frequency

## Reference

- [IEEE 802.3-2018](https://standards.ieee.org/standard/802_3-2018.html) - Clause 22 (MII specification)
- [Fast Ethernet MII Tutorial](https://www.ieee802.org/3/tutorial/mar02/ge_phys_ser_1_0302.pdf)
- [TI Ethernet PHY Design Guide](https://www.ti.com/lit/an/snla207/snla207.pdf)
- [MII Timing Diagrams](https://www.analog.com/en/technical-articles/mii-rmii-interface-for-ethernet.html)

---
**Last Updated**: 2026-02-02
