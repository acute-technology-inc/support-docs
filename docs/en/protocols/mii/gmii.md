# GMII (Gigabit MII)

## What is GMII?

### Overview

GMII (Gigabit Media Independent Interface) is the Gigabit Ethernet extension of the original MII interface, standardized in IEEE 802.3z in 1998. GMII extends the 4-bit MII datapath to 8 bits (one byte) and increases the maximum clock frequency to 125 MHz to support 1000 Mbps (Gigabit) Ethernet while maintaining backward compatibility with 10/100 Mbps operation. GMII maintains the same architectural philosophy as MII—separate MAC and PHY with clean interface boundaries—while scaling the throughput by 10×.

The interface uses separate transmit and receive datapaths, each 8 bits wide, with independent clocks for each direction. For Gigabit operation, the transmit clock (GTX_CLK) is provided by the MAC at 125 MHz, while the receive clock (RX_CLK) is recovered from the incoming data by the PHY. This asymmetry is necessary because the PHY must recover clock from the wire at Gigabit speeds. For 10/100 Mbps operation, GMII falls back to MII-compatible timing with 2.5/25 MHz clocks.

GMII is commonly used in internal connections within ASICs and FPGAs where pin count is not constrained and the simpler single data rate (SDR) timing is preferred over the double data rate (DDR) timing required by RGMII. While external chip-to-chip connections have largely migrated to RGMII to save pins, GMII remains the standard for internal MAC-PHY interfaces in integrated designs and for simulation/verification environments.

## Technical Specifications

### Data Interface

- **Data Width**: 8 bits (byte) per direction
- **Clock Frequency**: 125 MHz (1000 Mbps), 25 MHz (100 Mbps), 2.5 MHz (10 Mbps)
- **Pin Count**: 24 data/control signals (plus 2 management = 26 total)
- **Throughput**: 10/100/1000 Mbps
- **Clocking**: Separate GTX_CLK (TX), TX_CLK, and RX_CLK

### Signal Description

**TX Signals** (MAC to PHY - 11 signals)
- **TXD[7:0]**: Transmit data (8-bit bus)
- **TX_EN**: Transmit enable (active high during frame transmission)
- **TX_ER**: Transmit error (optional, indicates intentional error injection)
- **GTX_CLK**: Gigabit transmit clock (sourced by MAC at 125 MHz for 1000 Mbps)
- **TX_CLK**: Transmit clock (sourced by PHY for 10/100 Mbps mode, 2.5/25 MHz)

**RX Signals** (PHY to MAC - 11 signals)
- **RXD[7:0]**: Receive data (8-bit bus)
- **RX_DV**: Receive data valid (active high during valid frame reception)
- **RX_ER**: Receive error (indicates PHY detected error)
- **RX_CLK**: Receive clock (sourced by PHY, 125/25/2.5 MHz depending on speed)

**Control Signals** (2 signals)
- **COL**: Collision detect (for half-duplex operation, rare at Gigabit)
- **CRS**: Carrier sense (indicates activity on medium)

**Management Interface** (2 signals - same as MII)
- **MDC**: Management data clock (up to 2.5 MHz, sourced by MAC)
- **MDIO**: Management data I/O (bidirectional serial data)

### Clock Architecture

**Gigabit Mode (1000 Mbps)**
- **GTX_CLK**: MAC provides 125 MHz clock for TX path
- **RX_CLK**: PHY provides 125 MHz clock recovered from receive data
- **TX_CLK**: Not used in Gigabit mode (or driven by PHY at 125 MHz)
- **Data Rate**: 8 bits × 125 MHz = 1000 Mbps

**Fast Ethernet Mode (100 Mbps)**
- **TX_CLK**: PHY provides 25 MHz clock
- **RX_CLK**: PHY provides 25 MHz clock
- **GTX_CLK**: Not used (or MAC stops driving it)
- **Data Rate**: 8 bits × 25 MHz = 200 Mbps (but only lower 4 bits used, giving 4 × 25 MHz = 100 Mbps)

**Ethernet Mode (10 Mbps)**
- **TX_CLK**: PHY provides 2.5 MHz clock
- **RX_CLK**: PHY provides 2.5 MHz clock
- **GTX_CLK**: Not used
- **Data Rate**: 8 bits × 2.5 MHz = 20 Mbps (but only lower 4 bits used, giving 4 × 2.5 MHz = 10 Mbps)

**Note**: In 10/100 modes, some implementations use only the lower 4 bits of the 8-bit bus (nibble mode), while others use all 8 bits with data packed differently. Consult specific PHY datasheets.

### Timing Characteristics

**Gigabit Mode Timing**
- **GTX_CLK**: 125 MHz ±100 ppm
- **RX_CLK**: 125 MHz (recovered, may have jitter)
- **Setup Time**: 2 ns minimum (data to clock)
- **Hold Time**: 2 ns minimum (data after clock)
- **Clock-to-Output**: 6 ns maximum (PHY driving signals)

**10/100 Mode Timing**
- **Clock Frequency**: 2.5 MHz or 25 MHz ±100 ppm
- **Setup/Hold**: 10 ns typical (more relaxed than Gigabit)
- **Compatible with MII timing**

### Speed Negotiation

Speed is typically negotiated via auto-negotiation (IEEE 802.3 Clause 28):
1. PHY advertises capabilities via MDIO registers
2. Link partners exchange information
3. Highest common speed selected (1000/100/10 Mbps)
4. Interface adjusts clock frequencies accordingly
5. MAC configures for negotiated speed

## Decoder Configuration

When analyzing GMII with a logic analyzer, configure the following:

### Signal Connections

**Minimum Gigabit Configuration** (19 channels)
- TXD[7:0] - 8 channels
- TX_EN, GTX_CLK, TX_ER - 3 channels
- RXD[7:0] - 8 channels
- RX_DV, RX_CLK, RX_ER - 3 channels

**Full Configuration** (22 channels)
- Add COL and CRS - 2 channels
- Add TX_CLK - 1 channel (for 10/100 mode observation)

**With Management** (24 channels total)
- Add MDC and MDIO - 2 channels

### Sampling Requirements

**For Gigabit (125 MHz)**
- **Minimum Sample Rate**: 625 MS/s (5× the 125 MHz clock)
- **Recommended**: 1-2 GS/s for reliable capture
- **Critical**: High-speed probes necessary, watch for loading effects

**For 10/100 Mbps**
- **Minimum**: 125 MS/s
- **Recommended**: 250 MS/s

### Decoder Parameters

- **Interface Type**: GMII
- **Speed**: 1000/100/10 Mbps (auto-detect from clock frequency)
- **Clock Edge**: Rising edge
- **Frame Format**: Ethernet II (DIX) or IEEE 802.3
- **MDIO Decoding**: Enable for PHY configuration monitoring
- **Error Detection**: Enable TX_ER and RX_ER monitoring
- **FCS Validation**: Enable CRC-32 checking

### Display Options

- Show TX and RX data separately with timestamps
- Display Ethernet frame fields (DA, SA, Type/Length, Payload, FCS)
- Highlight TX_EN and RX_DV active periods
- Indicate errors via TX_ER, RX_ER, or CRC failures
- Show speed mode (1000/100/10 Mbps based on clock)
- Decode MDIO register reads/writes for auto-negotiation
- Display collision and carrier sense events

### Trigger Settings

- **Frame Start**: Trigger on TX_EN or RX_DV rising edge
- **Specific Address**: Trigger on MAC address patterns
- **Error Events**: Trigger on TX_ER or RX_ER assertion
- **Speed Transition**: Trigger on clock frequency change (if observable)
- **MDIO Activity**: Trigger on auto-negotiation sequences
- **Pre-trigger**: 10-20% to capture idle before frame

### Analysis Tips

1. **Verify Clock Frequencies**
   - Gigabit: GTX_CLK and RX_CLK at 125 MHz
   - Fast Ethernet: TX_CLK and RX_CLK at 25 MHz
   - Ethernet: TX_CLK and RX_CLK at 2.5 MHz
   - Measure actual frequencies, check for jitter

2. **Check Frame Structure**
   - Preamble: 7 bytes of 0x55
   - SFD: 0xD5
   - Destination MAC: 6 bytes
   - Source MAC: 6 bytes
   - Type/Length: 2 bytes
   - Payload: 46-1500 bytes (1518 with VLAN tag)
   - FCS: 4 bytes (CRC-32)

3. **Validate Timing**
   - Data setup/hold relative to clock edges
   - TX_EN timing around data (should bracket entire frame including preamble)
   - RX_DV timing around data
   - Inter-frame gap (IFG): 96 bit times (96 ns at Gigabit, 960 ns at 100 Mbps)

4. **Monitor Control Signals**
   - TX_EN high during frame transmission
   - RX_DV high from preamble through FCS
   - COL rare at Gigabit (half-duplex not common)
   - CRS indicates carrier present

5. **Auto-Negotiation Analysis**
   - Decode MDIO register 0 (Control) and 1 (Status)
   - Check register 4 (Advertisement) and 5 (Link Partner Ability)
   - Verify register 9 (1000BASE-T Control) for Gigabit advertisement
   - Confirm negotiated speed matches clock frequency

6. **Gigabit-Specific Checks**
   - GTX_CLK must be stable 125 MHz from MAC
   - RX_CLK may have more jitter (recovered clock)
   - All 8 data bits in use (not just lower 4)
   - Higher signal integrity requirements

## Common Issues

**Clock Issues**
- **Symptom**: No Gigabit link, fallback to 100 Mbps
- **Cause**: GTX_CLK not stable or wrong frequency, RX_CLK recovery failing
- **Solution**: Check GTX_CLK source, verify PHY PLL lock, check signal integrity

**Signal Integrity Problems**
- **Symptom**: CRC errors, intermittent link drops at Gigabit
- **Cause**: Reflections, crosstalk, insufficient bandwidth at 125 MHz
- **Solution**: Improve PCB routing, add termination, reduce trace length

**Speed Mismatch**
- **Symptom**: No link or frequent errors
- **Cause**: Auto-negotiation failed or disabled, fixed speed mismatch
- **Solution**: Enable auto-negotiation, verify MDIO configuration, check PHY registers

**Timing Violations**
- **Symptom**: Intermittent errors, especially at Gigabit
- **Cause**: Setup/hold violations, clock-to-output delays excessive
- **Solution**: Check signal integrity, reduce trace lengths, improve routing

**Half-Duplex at Gigabit**
- **Symptom**: Link fails or operates at reduced speed
- **Cause**: Gigabit Ethernet requires full-duplex (1000BASE-T)
- **Solution**: Configure both ends for full-duplex, disable half-duplex advertisement

**Probe Loading Effects**
- **Symptom**: Interface works without probes, fails with probes attached
- **Cause**: Logic analyzer probe capacitance loading 125 MHz signals
- **Solution**: Use high-impedance active probes, reduce probe loading, probe at low-bandwidth points

## Design Considerations

**When to Use GMII**

**Advantages:**
- Simple SDR (single data rate) timing, easier to implement
- No DDR timing complexity
- Standard interface for internal ASIC/FPGA connections
- Easier to debug with logic analyzer
- Well-understood and mature

**Disadvantages:**
- High pin count (24 signals)
- Not suitable for chip-to-chip on constrained boards
- Higher PCB routing complexity
- More I/O power consumption

**Typical Applications:**
- Internal MAC-PHY connections within SoC
- FPGA-based Ethernet designs
- Academic and reference designs
- Where pin count is not constrained
- Simulation and verification environments

**GMII vs RGMII:**
- GMII: 24 pins, SDR, 125 MHz, simpler timing
- RGMII: 12 pins, DDR, 125 MHz, complex timing but fewer pins
- Most external chip-to-chip connections use RGMII
- Most internal or pin-unconstrained designs use GMII

## Reference

- [IEEE 802.3-2018](https://standards.ieee.org/standard/802_3-2018.html): Clause 35 (GMII specification)
- [IEEE 802.3z](https://standards.ieee.org/standard/802_3z-1998.html): Gigabit Ethernet over fiber
- [IEEE 802.3ab](https://standards.ieee.org/standard/802_3ab-1999.html): 1000BASE-T (Gigabit over copper)
- [Marvell GMII/RGMII Guide](https://www.marvell.com/)
- [TI Gigabit Ethernet PHY Design Guide](https://www.ti.com/lit/an/snla269/snla269.pdf)

---
**Last Updated**: 2026-02-02
