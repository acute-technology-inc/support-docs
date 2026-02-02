# PECI

## What is PECI?

PECI (Platform Environment Control Interface) is a proprietary single-wire communication interface developed by Intel for thermal and power management in computer platforms. The protocol enables bidirectional communication between Intel processors and external management controllers, primarily for reading processor temperature data and configuring thermal management parameters. PECI was introduced by Intel to replace older methods of thermal monitoring that relied on external substrate diodes, providing more accurate on-die temperature measurements through integrated Digital Thermal Sensors (DTS).

The PECI interface operates on a single self-clocked wire that carries both clock and data information through pulse-width encoding. The originator (typically a baseboard management controller or embedded controller) initiates transactions by sending command packets to the processor (responder), which replies with temperature readings, power consumption data, or configuration information. The protocol uses Manchester-style encoding where the duration of the high pulse determines whether a bit represents logic '0' or '1', eliminating the need for separate clock signals and reducing pin count.

PECI has become the standard interface for processor thermal management on Intel platforms, appearing in desktop, mobile, and server processors from Core 2 generation onwards. The interface supports data rates from 2 kbps to 2 Mbps and includes cyclic redundancy check (CRC) error detection to ensure reliable communication in electrically noisy environments. Modern implementations provide detailed thermal information including per-core temperatures, package power consumption, and thermal throttling status, enabling sophisticated thermal management algorithms for fan control, thermal throttling, and system protection.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- **Interface type**: Single-wire bidirectional communication
- **Encoding**: Self-clocked pulse-width encoding
- **Voltage reference**: Referenced to VTT (processor I/O buffer voltage)
- **Voltage range**: -0.15V to VTT + 0.15V
- **Idle state**: Near 0V (ground level)
- **Logic levels**: Determined by pulse width, not absolute voltage

**Electrical Specifications:**
- **Pull-down resistance**: Internal pull-down in processor maintains idle state
- **Rise time**: Fast rising edge driven at start of each bit
- **Timing**: Variable bit duration based on negotiated data rate

### Data Rate and Timing

PECI supports a wide range of data rates negotiated per transaction:
- **Minimum**: 2 kbps - for slow, low-power management controllers
- **Maximum**: 2 Mbps - for high-performance system management
- **Typical**: 100-1000 kbps - common in consumer platforms

The data rate is determined by the originator's bit timing and remains constant throughout a transaction. Each bit begins with a driven rising edge, followed by a high-duration that encodes the bit value:
- **Logic '0'**: Short high pulse (approximately 1/3 of bit time)
- **Logic '1'**: Long high pulse (approximately 2/3 of bit time)

### Protocol Structure

**Transaction Format:**
1. **Originator → Processor (Command):**
   - Start bit
   - Target address (8 bits)
   - Write length (4 bits)
   - Read length (4 bits)
   - Command code (8 bits)
   - Write data (optional, variable length)
   - Frame Check Sequence (FCS/CRC, 8 bits)

2. **Processor → Originator (Response):**
   - Frame Check Sequence (8 bits)
   - Read data (variable length based on command)

**Error Detection:**
- 8-bit CRC (Cyclic Redundancy Check) for both command and response
- Polynomial: x^8 + x^2 + x^1 + 1
- Detects single-bit and most multi-bit errors

### Common Commands

PECI defines several standard commands:
- **Ping**: Verify processor presence and PECI interface functionality
- **GetTemp**: Read Digital Thermal Sensor (DTS) temperature
- **RdPkgConfig**: Read package configuration data
- **WrPkgConfig**: Write package configuration parameters
- **RdIAMSR**: Read processor Model-Specific Register (MSR)
- **WrIAMSR**: Write processor Model-Specific Register
- **RdPCIConfig**: Read PCI configuration space
- **WrPCIConfig**: Write PCI configuration space
- **GetDIB**: Get Device Info Block (processor identification)

## Common Applications

PECI is implemented in various computing platforms for thermal and power management:

- **Desktop motherboards**: Fan speed control based on CPU temperature
- **Laptop embedded controllers**: Dynamic thermal management and power throttling
- **Server baseboard management controllers (BMC)**: Data center thermal monitoring
- **Workstation platforms**: High-precision thermal management for sustained workloads
- **All-in-one PCs**: Compact system thermal optimization
- **Thin clients**: Minimal-fan or fanless thermal management
- **Industrial PCs**: Temperature monitoring in harsh environments
- **Network appliances**: Server-grade processor thermal management
- **Storage systems**: NAS and SAN thermal monitoring
- **Blade servers**: Dense compute thermal management
- **Embedded systems**: Intel processor-based embedded platforms
- **Test equipment**: Processor development and validation tools
- **Thermal analysis**: Performance testing and thermal profiling
- **Data center management**: Large-scale thermal monitoring infrastructure
- **Overclocking systems**: Precision temperature monitoring for enthusiast platforms

## Decoder Configuration

When configuring a logic analyzer to decode PECI signals:

### Channel Assignment

- **PECI**: Assign to the single PECI signal line

Connect the logic analyzer probe to the PECI pin on the processor or at the management controller PECI connection point. Ensure proper grounding by connecting the logic analyzer ground to the system ground near the PECI signal.

### Protocol Parameters

- **Data rate**: Set to expected bit rate (typically 100-1000 kbps, auto-detect if supported)
- **Voltage reference**: Configure input threshold to approximately 40-50% of VTT
- **Trigger level**: Set to detect rising edge transitions from idle state

### Decoding Options

- **Command type display**: Show command codes (GetTemp, Ping, RdPkgConfig, etc.)
- **Address display**: Show processor target address
- **Data payload**: Display temperature readings, register values, configuration data
- **CRC verification**: Check Frame Check Sequence and flag errors
- **Temperature conversion**: Decode GetTemp responses to Celsius temperatures
- **MSR decoding**: Interpret Model-Specific Register addresses and values

### Trigger Configuration

- **Start of transaction**: Trigger on PECI frame start pattern
- **Specific command**: Trigger on GetTemp or other specific command codes
- **Address match**: Trigger when specific processor address is accessed
- **Temperature threshold**: Trigger when temperature reading exceeds specified value
- **CRC error**: Trigger on FCS error detection

### Sampling Requirements

For reliable PECI decoding:
- **Minimum sampling rate**: 10x the expected data rate (e.g., 10 MHz for 1 Mbps PECI)
- **Recommended sampling rate**: 20x or higher for accurate pulse width measurement
- **Buffer depth**: Sufficient to capture multiple transactions (at least 10-100 ms at expected data rate)

### Signal Quality Considerations

PECI signals are susceptible to noise due to single-wire operation:
- Use short ground leads on logic analyzer probes
- Minimize probe inductance and capacitance
- Consider differential probing if available
- Watch for signal reflections on long traces
- Filter out glitches shorter than minimum pulse width

### Analysis Tips

When analyzing PECI traffic:
1. Begin capture before system power-on to observe initial processor discovery
2. Look for periodic GetTemp commands (typically every 100-1000 ms for fan control)
3. Verify CRC on all transactions - repeated CRC errors indicate signal integrity issues
4. Monitor temperature values to correlate with system thermal events
5. Observe WrPkgConfig commands during system initialization for power management setup
6. Check for proper idle state between transactions (signal at ground level)

The PECI bus is normally quiet between transactions. Frequent retries or NAK responses may indicate electrical issues, incorrect data rate, or processor thermal management problems.

## Reference

- [Intel PECI Specification (Eagle Stream Platform)](https://edc.intel.com/content/www/us/en/design/products-and-solutions/processors-and-chipsets/eagle-stream/platform-electrical-data-sheet/platform-environmental-control-interface-peci/)
- [Linux Kernel PECI Subsystem Documentation](https://www.kernel.org/doc/Documentation/peci/peci.rst)
- [Intel 12th Generation Core Processors PECI DC Characteristics](https://edc.intel.com/content/www/us/en/design/ipla/software-development-platforms/client/platforms/alder-lake-desktop/12th-generation-intel-core-processors-datasheet-volume-1-of-2/peci-dc-characteristics)
- [Embedded.com: Thermal Management Standards with PECI](https://www.embedded.com/design-next-generation-platforms-while-adhering-to-thermal-management-standards/)
