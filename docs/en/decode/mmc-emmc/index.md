# MMC/eMMC

## What is MMC/eMMC?

MMC (MultiMediaCard) is a memory card standard developed by Siemens and SanDisk in 1997 for portable data storage, using a simple serial interface for communication between a host controller and flash memory. eMMC (embedded MultiMediaCard) evolved from the removable MMC card format into an embedded, soldered-down BGA package integrating both flash memory and a flash controller into a single component. Standardized by JEDEC committee JC-64, eMMC simplifies embedded system design by providing a complete managed flash storage solution with wear leveling, bad block management, and error correction handled internally by the eMMC controller.

The eMMC protocol uses a master-slave architecture where the host controller initiates all communications through commands sent on a dedicated CMD line, with data transferred on parallel DAT lines. The current specification, JESD84-B51A (eMMC 5.1) released in January 2019, defines interfaces supporting up to 400 MB/s data rates using HS400 mode with dual data rate signaling at 200 MHz clock frequency. The protocol supports multiple bus widths (1-bit, 4-bit, and 8-bit), various speed modes from legacy 26 MHz to high-speed HS400, and advanced features including multiple partitions (user data, boot, RPMB), secure erase, background operations, and power management through sleep and standby modes.

eMMC has become the dominant embedded storage solution for consumer electronics, particularly smartphones, tablets, automotive infotainment systems, and IoT devices. The managed NAND architecture abstracts away flash complexity from the host system, providing a simple command-based interface similar to SD cards while offering higher performance, better endurance management, and smaller physical footprint compared to raw NAND flash. eMMC's integration of controller and flash in a single package reduces board space, simplifies design, and provides predictable performance across different vendors' products that comply with the JEDEC standard.

## Technical Specifications

### Physical Interface

**Signal Lines:**
- **CLK**: Clock signal (host to device)
- **CMD**: Bidirectional command/response line
- **DAT0-DAT7**: Up to 8 bidirectional data lines
- **DS (Data Strobe)**: Data strobe signal for HS400 mode (device to host)
- **RST_n**: Optional hardware reset (active low)

**Bus Width Modes:**
- **1-bit mode**: DAT0 only (default after power-on)
- **4-bit mode**: DAT0-DAT3 (common in mobile devices)
- **8-bit mode**: DAT0-DAT7 (maximum bandwidth mode)

**Voltage Ranges:**
- **3.3V**: Legacy voltage level (2.7V-3.6V)
- **1.8V**: High-speed voltage level (1.7V-1.95V)
- **1.2V**: Ultra-high-speed voltage level (1.14V-1.26V)

### Speed Modes and Data Rates

**Legacy Modes:**
- **Default Speed**: 26 MHz clock, up to 26 MB/s (SDR)
- **High Speed (SDR)**: 52 MHz clock, up to 52 MB/s
- **High Speed (DDR)**: 52 MHz clock DDR, up to 104 MB/s (both clock edges)

**Advanced High-Speed Modes:**
- **HS200**: 200 MHz clock SDR, up to 200 MB/s, requires tuning (CMD21)
- **HS400**: 200 MHz clock DDR with Data Strobe, up to 400 MB/s, 8-bit only
- **HS400 Enhanced Strobe**: Improved HS400 with device-generated strobe

**Mode Characteristics:**

| Mode | Clock | Edges | Bus Width | Max Rate | Voltage | Tuning |
|------|-------|-------|-----------|----------|---------|--------|
| Default | 26 MHz | SDR | 1/4/8-bit | 26 MB/s | 3.3V | No |
| HS SDR | 52 MHz | SDR | 1/4/8-bit | 52 MB/s | 3.3V/1.8V | No |
| HS DDR | 52 MHz | DDR | 4/8-bit | 104 MB/s | 3.3V/1.8V | No |
| HS200 | 200 MHz | SDR | 4/8-bit | 200 MB/s | 1.8V/1.2V | Yes |
| HS400 | 200 MHz | DDR | 8-bit only | 400 MB/s | 1.8V/1.2V | Optional* |

*HS400 with Enhanced Strobe does not require tuning.

### Protocol Architecture

**Command Structure:**
Commands are 48 bits transmitted serially on CMD line:
- **Start bit** (1 bit): Always 0
- **Transmission bit** (1 bit): 1 = host to device
- **Command index** (6 bits): CMD0-CMD63
- **Argument** (32 bits): Command-specific parameter
- **CRC7** (7 bits): Cyclic redundancy check
- **End bit** (1 bit): Always 1

**Response Types:**
- **R1**: Normal response with card status (48 bits)
- **R2**: CID/CSD register response (136 bits)
- **R3**: OCR register response (48 bits)
- **R4**: Fast I/O response (48 bits)
- **R5**: Interrupt request response (48 bits)

### Common Commands

**Device Initialization:**
- **CMD0**: Go idle state (reset)
- **CMD1**: Send operation conditions (OCR)
- **CMD2**: Send CID (card identification)
- **CMD3**: Set relative address

**Device Configuration:**
- **CMD6**: Switch function (change speed mode, bus width)
- **CMD7**: Select/deselect card
- **CMD8**: Send extended CSD
- **CMD13**: Send status

**Data Transfer:**
- **CMD17**: Read single block
- **CMD18**: Read multiple blocks
- **CMD23**: Set block count for multiple block operations
- **CMD24**: Write single block
- **CMD25**: Write multiple blocks

**Special Operations:**
- **CMD21**: Send tuning block (HS200 tuning)
- **CMD38**: Erase
- **CMD35/36**: Erase group start/end
- **CMD5**: Sleep/awake

### Data Transfer Protocol

**Data Block Format:**
- Start bit (0)
- Data payload (512 bytes default, configurable up to 4 KB)
- CRC16 (16 bits per data line)
- End bit (1)

**Multi-block Transfer:**
Supports pre-defined block count (CMD23) or open-ended transfer with explicit stop command (CMD12).

### Partition Architecture

eMMC devices include multiple partitions:
- **User Data Area**: Primary storage for user data
- **Boot Partition 1 & 2**: Separate partitions for boot code (4 MB typical)
- **RPMB (Replay Protected Memory Block)**: Secure authenticated storage
- **General Purpose Partitions**: Optional additional partitions (GP1-GP4)

## Common Applications

eMMC is the primary embedded storage solution across numerous industries:

- **Smartphones**: Primary storage for operating system and user data
- **Tablets**: Application and media storage
- **Automotive infotainment**: Maps, media, and application storage
- **Set-top boxes**: Firmware and application storage
- **Smart TVs**: OS, apps, and cached content storage
- **Digital cameras**: Photo and video storage
- **Portable gaming devices**: Game and save data storage
- **IoT devices**: Firmware and data logging
- **Industrial controllers**: Configuration and logging storage
- **Point-of-sale terminals**: Application and transaction logging
- **Medical devices**: Firmware and patient data storage
- **Network equipment**: Router and switch configuration storage
- **Drones**: Flight data and video recording
- **Wearables**: OS and activity data storage
- **Single-board computers**: Raspberry Pi, BeagleBone storage
- **Automotive ECUs**: Calibration data and fault logging

## Decoder Configuration

When configuring a logic analyzer to decode eMMC signals:

### Channel Assignment

**Minimum Required Signals:**
- **CLK**: Clock (required)
- **CMD**: Command/response line (required)
- **DAT0**: Data line 0 (required)

**Extended Signals (for full analysis):**
- **DAT1-DAT3**: Additional data lines for 4-bit mode
- **DAT4-DAT7**: Additional data lines for 8-bit mode
- **DS**: Data Strobe (for HS400 mode analysis)
- **RST_n**: Reset signal (optional)

### Protocol Parameters

- **Bus width**: Select 1-bit, 4-bit, or 8-bit mode
- **Speed mode**: Configure for expected mode (Default, HS, DDR, HS200, HS400)
- **Clock frequency**: Set expected clock rate
- **Voltage level**: Set input threshold for 3.3V, 1.8V, or 1.2V signaling

### Decoding Options

- **Command decoding**: Display command index and arguments
- **Response parsing**: Show response types and status information
- **Data block display**: Show data payload in hex/ASCII
- **CRC verification**: Check and flag CRC errors on CMD and DAT lines
- **Status register**: Decode card status fields
- **EXT_CSD parsing**: Interpret extended CSD register values
- **Timing measurement**: Measure setup/hold times and response delays

### Trigger Configuration

- **Command trigger**: Trigger on specific command index (e.g., CMD17 for read)
- **Data transfer**: Trigger on data start bit or specific data pattern
- **Error conditions**: Trigger on CRC errors or timeout conditions
- **State transitions**: Trigger on mode switching (CMD6)
- **Power events**: Trigger on CMD5 (sleep/awake)

### Sampling Requirements

**Minimum Sampling Rates:**
- Default Speed (26 MHz): 104 MHz minimum (4× clock)
- HS SDR (52 MHz): 208 MHz minimum
- HS DDR (52 MHz): 208 MHz minimum
- HS200 (200 MHz): 800 MHz minimum
- HS400 (200 MHz DDR): 1.6 GHz minimum

**Recommended**: 10× clock frequency for clear waveform analysis and accurate timing measurements.

### Analysis Tips

When analyzing eMMC communications:

1. **Initialization sequence**: Capture from power-on to observe CMD0, CMD1, CMD2, CMD3, CMD9 (get CSD)
2. **Speed mode transitions**: Watch for CMD6 commands that switch bus width or speed mode
3. **Tuning procedure**: In HS200 mode, observe CMD21 with tuning block transfers
4. **Multi-block operations**: Look for CMD23 (set block count) before CMD18/CMD25
5. **Error recovery**: Monitor CMD13 (status) after failed operations
6. **Performance analysis**: Measure actual data throughput accounting for command overhead
7. **Data Strobe (HS400)**: In HS400 mode, verify DS signal toggles with data transfers

### Common Issues to Identify

- **CRC errors**: Indicate signal integrity problems or timing violations
- **Timeout**: Device not responding to commands (check card state)
- **Illegal command**: Command issued in wrong state
- **Voltage mismatch**: Attempting high-speed mode before voltage switch
- **Bus width mismatch**: Host and device configured for different widths
- **Clock violations**: Clock frequency exceeding device capability

## Reference

- [JEDEC JESD84-B51A: Embedded MultiMediaCard (eMMC) 5.1](https://www.jedec.org/standards-documents/docs/jesd84-b51)
- [JEDEC eMMC Standards](https://www.jedec.org/standards-documents/technology-focus-areas/flash-memory-ssds-ufs-emmc/e-mmc)
- [Arasan eMMC 5.1 Total Solution Datasheet](https://www.arasan.com/wp-content/uploads/2016/05/eMMC-5-1-Total-Solution_Rev-1-3.pdf)
- [JEDEC eMMC Mechanical Standards](https://www.jedec.org/standards-documents/docs/jesd-84-c43)
