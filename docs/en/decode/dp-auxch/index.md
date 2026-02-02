# DisplayPort AUX Channel

## What is DisplayPort AUX Channel?

### Overview

The DisplayPort AUX (Auxiliary) Channel is a bidirectional, low-speed communication channel embedded within the DisplayPort interface standard. While the main DisplayPort lanes carry high-bandwidth video and audio data at multi-gigabit speeds, the AUX channel operates at a much slower 1 Mbps to handle link management, device configuration, and control functions. This separate channel enables essential operations like reading display capabilities (EDID), negotiating optimal video parameters (link training), handling display power management, and supporting advanced features like Multi-Stream Transport (MST) for daisy-chaining multiple displays.

The AUX channel is fundamental to DisplayPort's Plug and Play functionality and advanced capabilities. When you connect a DisplayPort monitor, the AUX channel facilitates the automatic detection, identification, and optimal configuration of the display without manual intervention. Beyond basic connectivity, the AUX channel enables sophisticated features like adaptive sync (G-SYNC/FreeSync), HDR metadata exchange, display stream compression parameters, and remote display management—all while the main video data streams continuously at full bandwidth.

### Protocol Architecture

The AUX channel implements a master-slave communication model:

- **DP Source (GPU/Computer)**: Acts as AUX Channel Requester (master), initiating all Request Transactions
- **DP Sink (Monitor/Display)**: Acts as AUX Channel Replier (slave), responding to requests with Reply Transactions

This master-driven architecture ensures deterministic behavior and prevents bus contention, as the sink never initiates communication unprompted.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- **Data Rate**: 1 Mbps (megabit per second)
- **Encoding**: Manchester-II coding (also called differential Manchester encoding)
- **Topology**: Half-duplex bidirectional, point-to-point or point-to-multipoint (for MST)
- **Physical Medium**: Single differential pair within the DisplayPort cable
- **Connector Pins**: AUX+ and AUX- on DisplayPort connector

**Manchester-II Encoding:**
Manchester coding provides several benefits:
- **Self-Clocking**: Clock information embedded in the data signal, no separate clock line needed
- **DC Balance**: Equal number of high and low transitions, preventing DC drift
- **Error Detection**: Encoding violations indicate transmission errors
- **Noise Immunity**: Differential signaling rejects common-mode noise

### Transaction Types

**AUX Request Transaction:**
Initiated by the source (master) to:
- Read data from the sink
- Write data to the sink
- Send I²C transactions to devices on the display's I²C bus

**AUX Reply Transaction:**
The sink (slave) responds with:
- ACK (Acknowledge): Transaction successful, data follows (if read)
- NACK (Not Acknowledge): Transaction unsuccessful, device busy or address invalid
- DEFER: Device temporarily busy, retry later

## AUX Channel Functions

### AUX Link Services

**Link Capability Read:**
- Query sink's supported link rates (1.62, 2.7, 5.4, 8.1 Gbps per lane)
- Determine maximum number of lanes (1, 2, or 4)
- Identify enhanced framing support
- Check for other advanced capabilities

**Link Configuration and Training:**
- Negotiate optimal link rate and lane count
- Perform clock recovery and channel equalization
- Monitor link quality and symbol lock
- Dynamically adjust link parameters for reliability

**Link Status Monitoring:**
- Check for loss of symbol lock, clock recovery failures
- Monitor inter-lane skew
- Detect and recover from link degradation
- Trigger retraining if necessary

### AUX Device Services

**EDID Read:**
- Access E-EDID data structure from the display
- Retrieve supported resolutions, refresh rates, color spaces
- Read HDR capabilities, audio formats, and other display characteristics
- Enable Plug and Play functionality

**MCCS (Monitor Command and Control Set):**
- Adjust display settings (brightness, contrast, color temperature)
- Switch input sources
- Control power states
- Access OSD (On-Screen Display) functions

**Sink Event Notification:**
- Display connection/disconnection events
- Hot-plug detection
- Display parameter change notifications
- User interaction events (for interactive displays)

### Sideband Messaging (For MST)

**Multi-Stream Transport Management:**
- Discover topology of daisy-chained displays
- Allocate bandwidth to individual display streams
- Route video streams to specific displays
- Manage branch devices (MST hubs)

**Remote Node Communication:**
- Send messages to displays downstream in MST chain
- Query remote display capabilities
- Configure remote displays
- Report status changes and errors from remote nodes

## DPCD (DisplayPort Configuration Data)

The DPCD is a standardized register space accessed via AUX transactions:

**Key DPCD Registers:**

**Capabilities (Read-Only):**
- **DPCD_REV**: DisplayPort specification version supported
- **MAX_LINK_RATE**: Maximum link rate (0x06 = 1.62 Gbps, 0x0A = 2.7 Gbps, 0x14 = 5.4 Gbps, 0x1E = 8.1 Gbps)
- **MAX_LANE_COUNT**: Maximum number of lanes (1, 2, or 4)
- **TPS3/TPS4 Support**: Advanced training pattern support
- **Enhanced Frame**: Enhanced framing capability
- **Downspread**: Support for clock spread spectrum

**Configuration (Read-Write):**
- **Link Rate Set**: Requested link rate
- **Lane Count Set**: Requested number of lanes
- **Training Pattern**: Current training pattern during link training

**Status (Read-Only):**
- **Lane Status**: Symbol lock, clock recovery, channel equalization per lane
- **Interlane Align**: Alignment status across all lanes
- **Sink Count**: Number of sinks connected (for MST)

**Power and Control:**
- **Set Power State**: Control display power modes
- **Test Request**: Manufacturing test modes
- **Device Service IRQ**: Interrupt request indicators

## Decoder Configuration

When configuring a DisplayPort AUX channel decoder:

- **Signal Assignment**: Specify logic analyzer channels for AUX+ and AUX- differential pair
- **Data Rate**: Set to 1 Mbps
- **Manchester Decoding**: Enable Manchester-II decoding
- **Transaction Parsing**: Decode request/reply structure, command codes, addresses
- **DPCD Interpretation**: Translate register addresses and values to human-readable form
- **I²C Embedded Transactions**: Decode I²C-over-AUX transactions (for EDID reads)
- **Timing Analysis**: Measure transaction timing, inter-transaction gaps

## Common Operations Observed

**Display Connection Sequence:**
1. Hot-plug detect assertion
2. AUX channel establishment
3. DPCD capability read
4. EDID read via I²C-over-AUX
5. Link training initiation
6. Video stream start

**Link Training:**
1. Write training pattern request to DPCD
2. Read lane status registers
3. Adjust voltage swing and pre-emphasis
4. Iterate until all lanes achieve clock recovery and channel equalization
5. Complete training, begin normal video transmission

**MST Topology Discovery:**
1. Query branch device for downstream port count
2. Read GUID (globally unique identifier) from each port
3. Discover displays on each port recursively
4. Build topology map
5. Allocate payload bandwidth to each display

## Applications

The AUX channel is critical in:

- **Consumer Displays**: Desktop monitors, laptops, all-in-one computers
- **High-Performance Computing**: Workstations, gaming systems
- **Professional Graphics**: CAD, 3D modeling, video editing workstations
- **Digital Signage**: Commercial displays with MST daisy-chaining
- **Medical Imaging**: Diagnostic displays with precise calibration
- **Broadcasting**: Professional video monitors
- **VR/AR Headsets**: DisplayPort over USB Type-C for VR displays
- **Docking Stations**: Laptop docks with multiple DisplayPort outputs
- **Embedded Systems**: Industrial and automotive displays

## Reference

- [Unigraf: How to Monitor AUX Channel Communication](https://www.unigraf.fi/app/uploads/2020/04/How-to-monitor-AUX-Channel-Communication-of-Displayport-interfaces.pdf)
- [Wireshark Display Filter Reference: DisplayPort AUX-Channel](https://www.wireshark.org/docs/dfref/d/dpaux.html)
- [Intel: DisplayPort AUX Channel Documentation](https://www.intel.com/content/www/us/en/docs/programmable/683623/current/aux-channel.html)
- [HDCP on DisplayPort Specification](https://www.digital-cp.com/sites/default/files/specifications/HDCP%20on%20DisplayPort%20Specification%20Rev1_1.pdf)
