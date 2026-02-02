# Ethernet MAC-PHY Interfaces

## Overview

MII (Media Independent Interface), RMII (Reduced MII), RGMII (Reduced Gigabit MII), and GMII (Gigabit MII) are a family of standard interfaces used to connect Ethernet MAC (Media Access Control) controllers to PHY (Physical Layer) transceivers. Originally defined in IEEE 802.3, these interfaces provide a standardized way to separate the MAC logic (typically integrated in SoCs, microcontrollers, or FPGAs) from the PHY chip that handles the actual electrical signaling on the Ethernet cable. This separation allows flexible hardware design where different PHYs can be paired with various MAC implementations without custom integration.

Each variant represents a different trade-off between pin count, clock frequency, implementation complexity, and cost. The evolution of these interfaces reflects the increasing demands of Ethernet speeds and the ongoing need to reduce system cost and complexity:

- **[MII](mii.md)** - The original 10/100 Mbps interface (1995)
- **[RMII](rmii.md)** - Reduced pin count version of MII
- **[GMII](gmii.md)** - Gigabit extension of MII
- **[RGMII](rgmii.md)** - Reduced pin count Gigabit interface

## Key Features

- **Standardized Interface**: IEEE-defined specifications ensure broad compatibility
- **MAC-PHY Separation**: Clean architectural boundary for flexible design
- **Multiple Speed Support**: Auto-negotiation and speed adaptation (10/100/1000 Mbps)
- **Bidirectional Communication**: Separate TX and RX datapaths
- **Management Interface**: MDC/MDIO sideband for PHY configuration (IEEE 802.3 Clause 22/45)
- **Pin Count Options**: From 7 pins (RMII) to 24 pins (GMII) depending on variant
- **Clock Flexibility**: Various clocking modes (source from MAC or PHY)
- **Error Signaling**: Dedicated signals for RX/TX errors
- **Industry Standard**: Supported by all major Ethernet PHY and MAC vendors

## Variant Comparison

| Interface | Data Width | Clock Freq | Pin Count | Speed | Year |
|-----------|------------|------------|-----------|-------|------|
| MII | 4-bit | 2.5/25 MHz | 16 | 10/100 Mbps | 1995 |
| RMII | 2-bit | 50 MHz | 7 | 10/100 Mbps | 1998 |
| GMII | 8-bit | 2.5/25/125 MHz | 24 | 10/100/1000 Mbps | 1998 |
| RGMII | 4-bit DDR | 125 MHz | 12 | 10/100/1000 Mbps | 2000 |

## Common Applications

**Embedded Systems**
- Microcontroller-based Ethernet devices (RMII common)
- IoT gateways and edge computing devices
- Industrial control and automation systems
- Single-board computers (Raspberry Pi, BeagleBone)

**Network Infrastructure**
- Ethernet switches and routers
- Network interface cards (NICs)
- Media converters
- PoE (Power over Ethernet) devices

**Consumer Electronics**
- Smart TVs and set-top boxes
- Gaming consoles
- Home automation hubs
- Network-attached storage (NAS)

**Automotive**
- In-vehicle infotainment systems
- ADAS (Advanced Driver Assistance Systems)
- Automotive Ethernet gateways
- Telematics control units

**Industrial/Commercial**
- Factory automation equipment
- Building management systems
- Security and surveillance systems
- Point-of-sale terminals

**Test and Measurement**
- Network analyzers
- Traffic generators
- Protocol analyzers
- Embedded test equipment

## Choosing an Interface

**Use MII when:**
- Need 10/100 Mbps with simple design
- PCB space and pins are not critical
- Legacy compatibility required
- Separate TX/RX clocks beneficial

**Use RMII when:**
- Pin count is constrained
- 10/100 Mbps sufficient
- Embedded microcontroller application
- Shared clock simplifies design

**Use GMII when:**
- Need Gigabit Ethernet
- Pin count not constrained
- Simple SDR design preferred
- Internal FPGA/ASIC implementation

**Use RGMII when:**
- Need Gigabit with minimal pins
- PCB routing complexity acceptable
- DDR-capable MAC and PHY available
- Most common Gigabit interface choice

## Protocol Documentation

Click on the links below for detailed documentation on each variant:

- **[MII (Media Independent Interface)](mii.md)** - Original 10/100 Mbps standard
- **[RMII (Reduced MII)](rmii.md)** - Low pin count 10/100 Mbps
- **[GMII (Gigabit MII)](gmii.md)** - Gigabit Ethernet standard
- **[RGMII (Reduced Gigabit MII)](rgmii.md)** - Low pin count Gigabit

## Reference

- [IEEE 802.3 Standard](https://standards.ieee.org/standard/802_3-2018.html) - Ethernet standards
- [RMII Specification v1.2](http://ebook.pldworld.com/_eBook/-Telecommunications,Networks-/TCPIP/RMII/rmii_rev12.pdf) - RMII Consortium
- [RGMII Specification v2.0](http://www.hp.com/rnd/pdfs/RGMIIv2_0_final_hp.pdf) - HP/Marvell
- [MII Management Interface Guide](https://www.ieee802.org/3/tutorial/mar02/ge_phys_ser_1_0302.pdf) - MDC/MDIO
- [Microchip Ethernet PHY Guide](https://www.microchip.com/) - Application notes and timing diagrams

---
**Last Updated**: 2026-02-02
