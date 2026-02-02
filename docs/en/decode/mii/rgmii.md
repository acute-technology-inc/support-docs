# RGMII (Reduced Gigabit MII)

## What is RGMII?

### Overview

RGMII (Reduced Gigabit Media Independent Interface) is a pin-reduced variant of GMII developed by HP, Intel, Marvell, and other companies around 2000 to provide Gigabit Ethernet connectivity with fewer pins. RGMII reduces the pin count from 24 (GMII) to 12 by using Double Data Rate (DDR) signaling on a 4-bit wide datapath instead of Single Data Rate (SDR) on 8-bit. By sampling data on both rising and falling clock edges, RGMII achieves the same 1000 Mbps throughput as GMII while cutting the pin count in half, making it the de facto standard for external chip-to-chip Gigabit Ethernet connections.

The RGMII specification defines versions 1.3 and 2.0, with the main difference being timing delay handling. RGMII v1.3 requires a fixed 2 ns delay between clock and data to ensure proper setup and hold times at DDR rates. RGMII v2.0 made this delay optional and configurable, allowing the delay to be implemented in either the MAC, PHY, or both, or disabled entirely. This flexibility addresses different PCB layout scenarios and allows for better timing optimization. However, it also introduces configuration complexity as both MAC and PHY must be configured consistently.

RGMII has become the most widely used Gigabit Ethernet interface for embedded systems, appearing in everything from Raspberry Pi to automotive ECUs to enterprise networking equipment. The 50% pin reduction compared to GMII provides significant cost savings in package size and PCB routing complexity, though it comes at the cost of more complex DDR timing requirements and potential signal integrity challenges at 125 MHz.

## Technical Specifications

### Data Interface

- **Data Width**: 4 bits per direction (DDR signaling)
- **Clock Frequency**: 125 MHz for 1000 Mbps, 25 MHz for 100 Mbps, 2.5 MHz for 10 Mbps
- **Pin Count**: 12 data/control signals (plus 2 management = 14 total)
- **Throughput**: 10/100/1000 Mbps
- **Clocking**: Separate TX_CLK and RX_CLK (DDR clocks at 125 MHz for Gigabit)
- **Effective Data Rate**: 4 bits × 2 edges × 125 MHz = 1000 Mbps

### Signal Description

**TX Signals** (MAC to PHY - 6 signals)
- **TXD[3:0]**: Transmit data (4-bit bus, DDR)
- **TX_CTL**: Transmit control (DDR, multiplexes TX_EN and TX_ER)
- **TX_CLK**: Transmit clock (125 MHz for Gigabit, 25 MHz for Fast Ethernet, 2.5 MHz for Ethernet)

**RX Signals** (PHY to MAC - 6 signals)
- **RXD[3:0]**: Receive data (4-bit bus, DDR)
- **RX_CTL**: Receive control (DDR, multiplexes RX_DV and RX_ER)
- **RX_CLK**: Receive clock (125 MHz for Gigabit, 25 MHz for Fast Ethernet, 2.5 MHz for Ethernet)

**Management Interface** (2 signals - same as MII/GMII)
- **MDC**: Management data clock (up to 2.5 MHz, sourced by MAC)
- **MDIO**: Management data I/O (bidirectional serial data)

### DDR Signaling

**Double Data Rate Operation**

RGMII transfers data on both rising and falling edges of the clock:

**Rising Edge:**
- TXD[3:0] or RXD[3:0]: Lower nibble of byte
- TX_CTL or RX_CTL: TX_EN or RX_DV

**Falling Edge:**
- TXD[3:0] or RXD[3:0]: Upper nibble of byte
- TX_CTL or RX_CTL: TX_EN XOR TX_ER, or RX_DV XOR RX_ER

**Control Signal Encoding**

The TX_CTL and RX_CTL signals multiplex control information:

**TX_CTL:**
- Rising edge: TX_EN
- Falling edge: TX_EN XOR TX_ER
- To recover: TX_ER = TX_EN (rising) XOR TX_CTL (falling)

**RX_CTL:**
- Rising edge: RX_DV  
- Falling edge: RX_DV XOR RX_ER
- To recover: RX_ER = RX_DV (rising) XOR RX_CTL (falling)

This encoding allows error signaling without requiring an additional pin.

### Timing and Delays

**RGMII v1.3 (Fixed Delay)**
- **Required Delay**: 2.0 ns ±0.5 ns (clock to data)
- **Implementation**: Typically in PHY (delay added to RX_CLK, TX_CLK)
- **Purpose**: Ensures data is centered in clock window
- **Configuration**: Usually automatic/fixed in PHY

**RGMII v2.0 (Configurable Delay)**
- **Delay Options**: 0 ns, 2 ns, or custom
- **Location**: Can be in MAC, PHY, or both
- **Configuration**: Via MDIO registers or strapping pins
- **Flexibility**: Allows optimization for specific designs

**Delay Modes:**

1. **No Delay (Both Sides)**: Clock and data aligned at both MAC and PHY
   - Used when PCB traces naturally provide delay
   - Requires careful PCB design

2. **PHY Delay**: PHY adds ~2 ns delay to RX_CLK (and sometimes TX_CLK)
   - Most common configuration
   - Default for many PHYs
   - Simplifies MAC requirements

3. **MAC Delay**: MAC adds delay before transmitting
   - Less common
   - Requires MAC support

4. **Dual Delay**: Both MAC and PHY add delays
   - Rare, can cause too much delay

**Typical Timing Values (at 125 MHz):**
- **Clock Period**: 8 ns
- **Setup Time**: 1.0 ns minimum
- **Hold Time**: 1.0 ns minimum
- **Data Valid Window**: 2 ns (centered with proper delay)
- **Clock-to-Output**: 1.5 ns maximum

### Speed Modes

**1000 Mbps (Gigabit)**
- Clock: 125 MHz
- DDR: Both edges used
- Data rate: 4 bits × 2 edges × 125 MHz = 1000 Mbps

**100 Mbps (Fast Ethernet)**
- Clock: 25 MHz
- DDR: Both edges used
- Data rate: 4 bits × 2 edges × 25 MHz = 200 Mbps
- (But only half utilized to match 100 Mbps Ethernet)

**10 Mbps (Ethernet)**
- Clock: 2.5 MHz
- DDR: Both edges used
- Data rate: 4 bits × 2 edges × 2.5 MHz = 20 Mbps
- (But only half utilized to match 10 Mbps Ethernet)

## Decoder Configuration

When analyzing RGMII with a logic analyzer, configure the following:

### Signal Connections

**Minimum Configuration** (12 channels)
- TXD[3:0] - 4 channels
- TX_CTL, TX_CLK - 2 channels
- RXD[3:0] - 4 channels
- RX_CTL, RX_CLK - 2 channels

**With Management** (14 channels total)
- Add MDC and MDIO - 2 channels

### Sampling Requirements

**For Gigabit (125 MHz DDR)**
- **Minimum Sample Rate**: 2 GS/s (8× the 125 MHz clock, accounting for DDR)
- **Recommended**: 2.5-5 GS/s for reliable DDR capture
- **Critical**: Must handle 250 MHz effective data rate (125 MHz × 2 edges)
- **Probe Bandwidth**: Minimum 500 MHz, ideally 1 GHz

**For 10/100 Mbps**
- **Minimum**: 250 MS/s
- **Recommended**: 500 MS/s

### Decoder Parameters

- **Interface Type**: RGMII
- **DDR Mode**: Enable (critical for proper decoding)
- **Speed**: 1000/100/10 Mbps (auto-detect from clock frequency)
- **Clock Edges**: Both rising and falling
- **Delay Mode**: Specify if known (affects timing analysis)
- **Frame Format**: Ethernet II (DIX) or IEEE 802.3
- **Control Decoding**: Enable TX_CTL and RX_CTL demultiplexing
- **Error Detection**: Enable (recovered from CTL XOR encoding)
- **FCS Validation**: Enable CRC-32 checking

### Display Options

- Show TX and RX data with byte reconstruction from DDR nibbles
- Display Ethernet frame fields
- Highlight TX_CTL and RX_CTL with decoded TX_EN/TX_ER and RX_DV/RX_ER
- Show data sampled on both clock edges separately
- Indicate errors via recovered TX_ER/RX_ER or CRC failures
- Display speed mode (1000/100/10 Mbps)
- Show timing relationships (clock-to-data delays)
- Decode MDIO delay configuration

### Trigger Settings

- **Frame Start**: Trigger on TX_CTL or RX_CTL transition (TX_EN/RX_DV)
- **Specific Address**: Trigger on MAC address patterns (challenging with DDR)
- **Error Events**: Trigger on error indication in CTL signal
- **Clock Edge**: Can trigger on specific clock edge patterns
- **Pre-trigger**: Essential (20-30%) to capture idle state and clock alignment

### Analysis Tips

1. **Verify Clock Frequencies**
   - Gigabit: TX_CLK and RX_CLK at 125 MHz
   - Fast Ethernet: 25 MHz
   - Ethernet: 2.5 MHz
   - Check for jitter (should be <1 ns at Gigabit)

2. **DDR Data Reconstruction**
   - Rising edge: Lower nibble of each byte
   - Falling edge: Upper nibble of each byte
   - Reconstruct: Byte = (Falling << 4) | Rising
   - Example: Rising=0x5, Falling=0x5 → Byte=0x55 (preamble)

3. **Control Signal Decoding**
   - TX_EN = TX_CTL at rising edge
   - TX_ER = TX_CTL(rising) XOR TX_CTL(falling)
   - Same for RX_DV and RX_ER
   - Verify XOR logic for error detection

4. **Timing Analysis**
   - Measure clock-to-data delay (should be ~2 ns if v1.3 or configured delay)
   - Check setup and hold times (min 1 ns each)
   - Verify data is centered in clock window
   - Look for timing violations at Gigabit speed

5. **Signal Integrity**
   - Check for ringing, overshoot, undershoot
   - Verify rise/fall times (<1 ns typical at 125 MHz)
   - Look for crosstalk between data lines
   - Monitor clock quality (jitter, duty cycle)

6. **Frame Structure**
   - Preamble: 0x55 repeated (appears as 0x5, 0x5 in nibbles)
   - SFD: 0xD5 (appears as 0x5, 0xD)
   - Normal Ethernet frame follows
   - TX_CTL/RX_CTL high throughout preamble and frame

7. **Delay Configuration**
   - Check MDIO registers for delay settings
   - Verify consistent configuration between MAC and PHY
   - Common error: mismatched delay settings

## Common Issues

**Timing Violations**
- **Symptom**: Intermittent CRC errors, lost frames at Gigabit
- **Cause**: Setup/hold violations due to improper delay configuration
- **Solution**: Configure proper delay mode (usually PHY delay ~2 ns), verify with scope

**Delay Misconfiguration**
- **Symptom**: No link at Gigabit, works at 100 Mbps
- **Cause**: Both or neither side adding delay, or wrong delay amount
- **Solution**: Configure delay properly (typically enable PHY RX/TX delay), check datasheets

**Signal Integrity Issues**
- **Symptom**: Errors increase with cable length or at temperature extremes
- **Cause**: Reflections, crosstalk, insufficient bandwidth at 125 MHz DDR
- **Solution**: Improve PCB routing (impedance control, length matching, ground plane)

**DDR Sampling Errors**
- **Symptom**: Decoder shows garbage data
- **Cause**: Logic analyzer sample rate too low or not sampling both edges
- **Solution**: Increase sample rate to 2+ GS/s, enable DDR mode in decoder

**Clock Skew**
- **Symptom**: Intermittent errors, timing marginal
- **Cause**: Excessive skew between clock and data traces
- **Solution**: Match trace lengths within 0.5 inch, minimize vias, proper routing

**Probe Loading**
- **Symptom**: Interface works without probes, fails with probes
- **Cause**: Probe capacitance loading 125 MHz DDR signals
- **Solution**: Use high-impedance active probes (<1 pF), probe carefully

**Mode Confusion**
- **Symptom**: Link fails or limited to 100 Mbps
- **Cause**: PHY in MII/GMII mode instead of RGMII
- **Solution**: Check PHY mode selection pins or registers

## Design Guidelines

**PCB Layout Best Practices**

1. **Trace Routing**
   - Differential pairs for clock traces (TX_CLK, RX_CLK)
   - Match data trace lengths within ±0.5 inch
   - 50Ω impedance for single-ended signals
   - Minimize vias, stubs, and discontinuities

2. **Clock-to-Data Skew**
   - Keep clock trace slightly longer if no delay mode
   - Allow ~2 ns natural skew if not using PHY delay
   - Use PHY delay to compensate for layout

3. **Signal Integrity**
   - Solid ground plane reference
   - Avoid running RGMII near noise sources
   - Terminate properly per datasheet
   - Use controlled impedance

4. **Delay Configuration Strategy**
   - **Recommended**: Enable PHY RX and TX delay (v2.0 PHYs)
   - Simplifies MAC requirements
   - Provides ~2 ns delay for data centering
   - Check PHY datasheet for configuration method

## RGMII vs GMII Trade-offs

| Aspect | GMII | RGMII |
|--------|------|-------|
| Pins | 24 | 12 |
| Data Rate | SDR | DDR |
| Complexity | Simple | More complex |
| Timing | Relaxed | Tight (DDR) |
| PCB Routing | Complex (many pins) | Simpler (fewer pins) |
| Debug | Easier | Harder (DDR) |
| Cost | Higher (pins/pkg) | Lower |
| Use Case | Internal/FPGA | External chip-to-chip |

## Reference

- [RGMII Specification v2.0](http://www.hp.com/rnd/pdfs/RGMIIv2_0_final_hp.pdf) - HP/Marvell official spec
- [RGMII Specification v1.3](http://www.hp.com/rnd/pdfs/RGMIIv1_3.pdf) - Original specification
- [IEEE 802.3-2018](https://standards.ieee.org/standard/802_3-2018.html) - Ethernet standard
- [TI RGMII Design Guide](https://www.ti.com/lit/an/snla269/snla269.pdf)
- [Microchip RGMII Interface Guide](https://ww1.microchip.com/downloads/en/Appnotes/00002260A.pdf)

---
**Last Updated**: 2026-02-02
