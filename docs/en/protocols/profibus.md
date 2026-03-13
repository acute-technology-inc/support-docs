# PROFIBUS

## What is PROFIBUS?

PROFIBUS (Process Field Bus) is an open, vendor-independent fieldbus communication protocol standardized as IEC 61158 Type 3 and IEC 61784, designed for high-speed, deterministic communication in factory automation and process control applications. Developed in Germany in the late 1980s and first standardized in 1991 as DIN 19245, PROFIBUS became one of the world's most widely deployed industrial networking technologies, with over 66 million devices installed globally. The protocol provides reliable, real-time communication between programmable logic controllers (PLCs), distributed I/O systems, sensors, actuators, drives, and other field devices in industrial environments.

PROFIBUS consists of two main variants optimized for different industrial applications: PROFIBUS DP (Decentralized Peripherals) for fast, cyclic data exchange in factory automation with deterministic response times typically under 10 milliseconds, and PROFIBUS PA (Process Automation) for connecting process instrumentation like pressure transmitters and valve positioners in hazardous areas using intrinsically safe, bus-powered transmission. PROFIBUS DP operates over RS-485 twisted pair cabling at speeds from 9.6 kbps to 12 Mbps, while PROFIBUS PA uses Manchester Bus Powered (MBP-IS) technology running at 31.25 kbps to provide both communication and power over the same two-wire cable. The protocol employs a hybrid master-slave and token-passing architecture where master devices exchange data cyclically with slaves and pass a token among themselves to coordinate bus access.

PROFIBUS supports sophisticated features including device diagnostics, parameter assignment, configuration management, and redundancy mechanisms. The protocol defines three functional variants: DPV0 (basic cyclic data exchange), DPV1 (acyclic data services for diagnostics and parameter setting), and DPV2 (isochronous operation for motion control). PROFIBUS continues to be maintained by PROFIBUS & PROFINET International (PI) and remains widely deployed in manufacturing, process industries, and building automation, though newer installations increasingly migrate to Industrial Ethernet protocols like PROFINET, which provides PROFIBUS compatibility through proxy devices.

## Technical Specifications

### Physical Layer Options

**PROFIBUS DP - RS-485:**
- **Medium**: Shielded twisted pair (STP) cable
- **Topology**: Bus topology with line termination at both ends
- **Connectors**: 9-pin D-sub connector (standard)
- **Maximum segment length**: Depends on baud rate:
  - 12 Mbps: 100 meters
  - 1.5 Mbps: 400 meters
  - 500 kbps: 1000 meters
  - 93.75 kbps: 1200 meters
- **Maximum stations per segment**: 32 without repeaters, 126 with repeaters
- **Maximum segments**: 9 (using repeaters)
- **Termination**: 390Ω active termination required at both ends

**PROFIBUS PA - MBP-IS:**
- **Medium**: Two-wire twisted pair (intrinsically safe)
- **Topology**: Bus, tree, or star topology
- **Data rate**: 31.25 kbps (fixed)
- **Maximum cable length**: 1900 meters (without repeaters)
- **Bus power**: Provides power to field devices (max 10mA per device)
- **Intrinsic safety**: Certified for hazardous area installation (Zone 0/1)
- **Encoding**: Manchester encoding with current signaling

### Data Rates and Timing

**Supported Baud Rates (PROFIBUS DP):**
- 9.6 kbps
- 19.2 kbps
- 45.45 kbps
- 93.75 kbps
- 187.5 kbps
- 500 kbps
- 1.5 Mbps
- 3 Mbps
- 6 Mbps
- 12 Mbps (maximum)

All devices on a PROFIBUS segment must operate at the same baud rate, configured during system setup.

**Cycle Times:**
- Typical DP cycle time: 1-10 milliseconds
- Minimum cycle time: <1 ms (with optimized configuration)
- Maximum cycle time: Configurable, typically <100 ms

### Protocol Architecture

**OSI Model Implementation:**
- **Layer 1 (Physical)**: RS-485 or MBP-IS
- **Layer 2 (Data Link)**: Fieldbus Data Link (FDL): hybrid token/master-slave
- **Layer 7 (Application)**: Fieldbus Application Layer (FAL) and user interface

**Device Types:**
- **Master (Class 1)**: Active stations that control bus communication (typically PLCs)
- **Master (Class 2)**: Programming/configuration devices (engineering stations)
- **Slave**: Passive devices responding only when polled (sensors, actuators, I/O)

**Token Passing:**
Masters pass a token in a logical ring, granting each master exclusive bus access during its token hold time. When a master holds the token, it polls its assigned slaves in a deterministic sequence.

### Frame Structure

**Telegram Types:**

**SD1 Frame (Short):**
- Start delimiter (SD1): 0x10
- Destination address (DA): 1 byte
- Source address (SA): 1 byte
- Function code (FC): 1 byte
- Frame Check Sequence (FCS): 1 byte
- End delimiter (ED): 0x16

**SD2 Frame (Variable length):**
- Start delimiter (SD2): 0x68
- Length (LE): 1 byte
- Length repeated (LEr): 1 byte
- Start delimiter repeated (SD2): 0x68
- Destination address (DA): 1 byte
- Source address (SA): 1 byte
- Function code (FC): 1 byte
- Data: Variable length (0-246 bytes)
- Frame Check Sequence (FCS): 1 byte
- End delimiter (ED): 0x16

**SD3 Frame (Fixed length):**
- Start delimiter (SD3): 0xA2
- Destination address (DA): 1 byte
- Source address (SA): 1 byte
- Function code (FC): 1 byte
- Data: 8 bytes
- Frame Check Sequence (FCS): 1 byte
- End delimiter (ED): 0x16

**SD4 Frame (Token):**
- Start delimiter (SD4): 0xDC
- Destination address (DA): 1 byte
- Source address (SA): 1 byte
- End delimiter (ED): 0x16

### Addressing

- **Station addresses**: 0-126 (0-122 for slaves, 1-126 for masters)
- **Address 127**: Reserved (broadcast)
- Each device requires unique address on network segment

## Common Applications

PROFIBUS is deployed across diverse industrial sectors:

- **Automotive manufacturing**: Assembly line automation, welding robots, paint systems
- **Chemical plants**: Process control, reactor monitoring, batch management
- **Oil and gas**: Pipeline monitoring, refinery automation, offshore platforms
- **Water treatment**: Pumping stations, filtration control, SCADA systems
- **Power generation**: Plant automation, turbine control, substation monitoring
- **Food and beverage**: Bottling lines, packaging equipment, batch processing
- **Pharmaceutical**: Clean room automation, batch reactors, filling systems
- **Mining**: Material handling, crushing systems, conveyor control
- **Paper mills**: Paper machines, quality control, material flow
- **Metalworking**: Rolling mills, forging presses, heat treatment
- **Building automation**: HVAC systems, lighting control, access systems
- **Material handling**: Conveyor systems, sorting equipment, AGVs
- **Machine tools**: CNC machines, cutting equipment, automated assembly
- **Printing**: High-speed printing presses, packaging printers
- **Textile industry**: Spinning machines, weaving looms, dyeing systems
- **Wastewater treatment**: Aeration control, sludge handling, chemical dosing

## Decoder Configuration

When configuring a logic analyzer to decode PROFIBUS signals:

### Channel Assignment - RS-485

**Differential Signals:**
- **A (Data+)**: Positive differential signal
- **B (Data-)**: Negative differential signal

If logic analyzer doesn't support differential input, capture both A and B signals for software differential reconstruction.

### Protocol Parameters

- **Baud rate**: Select configured network speed (9.6 kbps to 12 Mbps)
- **Encoding**: NRZ (Non-Return to Zero) for RS-485
- **Idle state**: A > B (idle/recessive state)
- **Active state**: A < B (dominant/active state)

### Decoding Options

- **Frame type identification**: Display SD1, SD2, SD3, SD4 telegram types
- **Address display**: Show source and destination addresses
- **Function code decoding**: Interpret FC field (request, response, token, etc.)
- **Data payload**: Display data field contents in hex/ASCII
- **FCS verification**: Check frame check sequence and flag errors
- **Token passing visualization**: Highlight token frames between masters
- **Master-slave transactions**: Show request-response pairs
- **Timing analysis**: Measure slot time, cycle time, response delays

### Trigger Configuration

- **Start delimiter**: Trigger on specific SD byte (0x68, 0x10, 0xA2, 0xDC)
- **Station address**: Trigger on frames to/from specific address
- **Token frame**: Trigger on token passing (SD4)
- **Specific slave**: Trigger when specific slave is polled
- **Error condition**: Trigger on FCS error or timeout
- **Data pattern**: Trigger on specific data content

### Sampling Requirements

**Minimum Sampling Rate:**
- At least 10× the baud rate
- Example: 12 Mbps requires 120 MHz minimum sampling

**Recommended Sampling Rate:**
- 20× baud rate for clear waveform capture
- Example: 12 Mbps requires 240 MHz sampling

**Buffer Depth:**
- For full cycle capture: Consider cycle time × baud rate
- Example: 10 ms cycle @ 1.5 Mbps = ~15,000 bits = adequate buffer for several cycles

### Analysis Tips

When analyzing PROFIBUS communications:

1. **Verify termination**: Check for proper 390Ω termination - poor termination causes reflections
2. **Identify masters**: Look for token passing (SD4 frames) to identify active masters
3. **Monitor slave polling**: Observe cyclic polling sequence from master to slaves
4. **Check cycle consistency**: Verify deterministic timing and consistent cycle times
5. **Diagnose errors**: Watch for retries, FCS errors, and timeout conditions
6. **Observe token rotation**: Ensure token circulates properly among masters
7. **Measure latency**: Time from master request to slave response
8. **Bus load analysis**: Calculate percentage of bus time used vs. idle

### Common Protocol Patterns

**Token Passing Between Masters:**
1. Master 1 holds token
2. Master 1 polls its slaves
3. Master 1 sends token to Master 2 (SD4 frame)
4. Master 2 receives token
5. Master 2 polls its slaves
6. Cycle repeats

**Master-Slave Cyclic Data Exchange:**
1. Master sends request (SD1 or SD2) to Slave address
2. Slave responds with data (SD1 or SD2)
3. Master verifies FCS
4. Master proceeds to next slave in poll list
5. Cycle completes and repeats

**Diagnostic Read (DPV1):**
1. Master sends diagnostic request to slave
2. Slave returns diagnostic data (extended information)
3. Master processes fault information
4. Master may reconfigure slave or alert operator

## Reference

- [PROFIBUS Standard DP Specification](https://www.profibus.com/download/profibus-standard-dp-specification/)
- [PROFIBUS & PROFINET International (PI)](https://www.profibus.com/)
- [PROFIBUS Technology Overview](https://us.profinet.com/technology/profibus/)
- [IEC 61158 Fieldbus Standard](https://webstore.iec.ch/publication/4682)
- [PROFIBUS Design Guideline](https://www.profibus.fr/wp-content/uploads/2021/04/PROFIBUS_Design_Guideline_8012_V127_Sep19.pdf)
