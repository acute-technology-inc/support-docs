# SWIM (Single Wire Interface Module)

## What is SWIM?

### Overview

SWIM (Single Wire Interface Module) is a proprietary debug and programming interface developed by STMicroelectronics specifically for their STM8 family of 8-bit microcontrollers. Introduced with the STM8 architecture, SWIM provides a low-cost, single-wire alternative to traditional multi-wire debug interfaces like JTAG or SWD, making it particularly suitable for space-constrained and cost-sensitive embedded applications. The protocol enables comprehensive debugging capabilities including memory access, breakpoint setting, single-stepping, and flash programming through just one bidirectional communication pin plus ground.

The SWIM interface operates on a single wire that is shared between the host (programmer/debugger) and the target STM8 device, using specific voltage levels and timing sequences to establish communication. The protocol uses a synchronous communication scheme where the host generates the clock by driving specific pulse patterns, and both host and target share the same line for data transfer. Communication begins with an entry sequence that puts the STM8 into SWIM mode, after which the host can perform various operations including reading and writing memory, controlling execution, and programming flash memory. The SWIM pin is typically shared with the NRST (reset) pin on the STM8, requiring careful signal management during entry.

SWIM has become the standard debug interface for all STM8 microcontrollers, from the low-end STM8S series to the more advanced STM8L low-power variants. The simplicity of the single-wire interface reduces PCB complexity and BOM cost compared to multi-wire alternatives, while still providing professional-grade debugging capabilities. STMicroelectronics provides SWIM-compatible programmers and debuggers (such as ST-LINK), and the protocol is supported by major development tools including IAR Embedded Workbench, Cosmic, and STVD (ST Visual Develop). This combination of low cost, simplicity, and full-featured debugging makes SWIM ideal for high-volume consumer and industrial STM8-based products.

### Key Features

- **Single-Wire Interface**: Only one signal pin plus ground required
- **Bidirectional Communication**: Half-duplex on shared wire
- **Synchronous Protocol**: Host generates clock through pulse timing
- **Full Debug Capabilities**: Memory read/write, breakpoints, single-step
- **Flash Programming**: In-system and in-application programming
- **Reset Control**: Integrated with STM8 reset functionality
- **Low Pin Count**: Minimal I/O requirements ideal for small packages
- **Standard Interface**: Used across all STM8 microcontroller families
- **Tool Support**: Widely supported by programmers and IDEs

## Technical Specifications

### Electrical Characteristics

**Signal Levels**
- **Operating Voltage**: Matches STM8 VDD (typically 2.95V to 5.5V for STM8S, 1.65V to 3.6V for STM8L)
- **Input High (VIH)**: Typically 0.7 × VDD minimum
- **Input Low (VIL)**: Typically 0.3 × VDD maximum
- **Output High (VOH)**: VDD - 0.3V typical
- **Output Low (VOL)**: 0.3V typical

**Pin Configuration**
- **SWIM Pin**: Single bidirectional communication pin (often shared with NRST)
- **External Pull-up**: Required 10kΩ resistor to VDD
- **Pin Protection**: Series resistor (1kΩ) recommended on host side

### Protocol Timing

**Bit Timing**
- **Base Unit**: Defined by host, typically 1-2 µs per bit
- **HSI Frequency**: Synchronization to STM8's internal HSI oscillator (typically 8 MHz)
- **SWIM Frequency**: Communication typically 375 kHz to 8 MHz (depending on HSI)

**Standard Bit Rates**
- **Low Speed**: ~8 kHz (for entry sequence)
- **Normal Speed**: ~375 kHz (typical operational speed)
- **High Speed**: Up to 8 MHz (with fast HSI)

**Timing Parameters**
- **SWIM Entry Sequence**: ~16 low pulses at low frequency (~8 kHz)
- **Bit Cell**: Variable, determined by host
- **Turnaround Time**: Time for bus direction change

### SWIM Entry Sequence

To activate SWIM mode on the STM8:

1. **Reset Pulse**: Pull NRST/SWIM low for >1 µs, then release
2. **Synchronization Sequence**: Send exactly 4 pulses at low frequency
   - Low for ~128 µs, High for ~128 µs (repeated 4 times)
3. **SWIM Activation**: STM8 enters SWIM mode, SWIM pin decoupled from NRST
4. **Normal Communication**: Proceed with SWIM protocol at normal speed

**Entry Sequence Waveform**:
```
     ___     ___     ___     ___
____|   |___|   |___|   |___|   |___  (4 pulses, ~128µs each half)
    
After this, SWIM is active and ready for commands
```

### Protocol Structure

SWIM uses a synchronous bit-serial protocol:

**Bit Encoding**
- **Logic '0'**: Short low pulse followed by long high period
- **Logic '1'**: Long low pulse followed by short high period
- **Host Drives**: During command and write operations
- **Target Drives**: During read operations and acknowledge

**Frame Structure**

**Command Frame** (Host to Target):
1. **Start**: Host pulls line low
2. **Command Bits**: 3-bit command code
3. **Address/Data**: Variable length depending on command
4. **Parity**: Optional parity bit
5. **Acknowledge**: Target responds (pulls low for ACK)

**Response Frame** (Target to Host):
1. **Data Bits**: Requested data from target
2. **Parity**: Optional parity bit
3. **Acknowledge**: Host can signal continue/stop

**SWIM Commands**

- **SRST (0b000)**: System Reset - reset the STM8
- **ROTF (0b001)**: Read On-The-Fly - read byte while CPU runs
- **WOTF (0b010)**: Write On-The-Fly - write byte while CPU runs
- **ROTF_MSB**: Read On-The-Fly with MSB indication
- **WOTF_MSB**: Write On-The-Fly with MSB indication

### Communication Mechanism

**Host-Driven Clock**
- Host generates clock by controlling pulse widths on SWIM line
- Target synchronizes to host's timing
- No separate clock line needed

**Bus Arbitration**
- Host initiates all transactions
- Target can drive line during read data and acknowledge phases
- Pull-up resistor returns line to high when neither drives it

**Acknowledge Mechanism**
- Target pulls line low for specific duration to acknowledge command
- No acknowledge indicates error or target not ready

### Memory Access

SWIM provides direct access to STM8 memory spaces:

**Accessible Memory**
- **Flash Memory**: Program memory, read and write (for programming)
- **RAM**: Data memory, read and write
- **EEPROM**: Non-volatile data storage (if present)
- **Registers**: I/O peripheral registers
- **Option Bytes**: Configuration bytes

**Access Types**
- **Read**: Retrieve data from specified address
- **Write**: Store data to specified address
- **Block Operations**: Sequential read/write for efficiency

### Debug Features

**Debug Capabilities via SWIM**
- **Breakpoints**: Hardware breakpoints (quantity depends on STM8 variant)
- **Single-Step**: Execute one instruction at a time
- **Run/Halt Control**: Start and stop CPU execution
- **Memory Inspection**: Read variables and memory contents
- **Flash Programming**: Erase and program flash memory
- **Option Byte Programming**: Configure STM8 options

## Common Applications

**STM8 Development**
- Firmware development and debugging
- In-circuit debugging (ICD)
- Single-stepping through code
- Variable monitoring and memory inspection

**Production Programming**
- In-system programming (ISP) during manufacturing
- Flash programming of STM8 devices
- Verification and read-back
- Option byte configuration

**Field Updates**
- Firmware updates in deployed devices
- In-application programming (IAP) via bootloader
- Field configuration changes
- Remote debugging and diagnostics

**Educational/Prototyping**
- Learning embedded systems on STM8 platform
- Rapid prototyping with STM8
- University lab projects
- Maker/hobbyist STM8 projects

**Product Development**
- Consumer appliances (white goods, small appliances)
- Industrial controls using STM8
- Lighting control systems
- Motor control applications

**Quality Assurance**
- Production testing of STM8-based boards
- Flash content verification
- Functional testing during manufacturing
- Failure analysis and diagnostics

## Decoder Configuration

When analyzing SWIM communication with a logic analyzer, configure the following parameters:

**Signal Connection**
- **SWIM**: Connect to the SWIM pin on the STM8
- **GND**: Connect ground reference
- **VDD** (optional): Monitor supply voltage
- **Pull-up**: Verify 10kΩ pull-up to VDD is present

**Sampling Requirements**
- **Minimum Sample Rate**: At least 10× the SWIM bit rate
- For ~375 kHz SWIM: Minimum 3.75 MHz sample rate
- For high-speed SWIM (~8 MHz): Minimum 80 MHz sample rate
- Recommended: 50-100 MHz for reliable decoding across all speeds

**Decoder Parameters**
- **Bit Rate**: Auto-detect from entry sequence or specify expected rate
- **Entry Sequence Detection**: Enable to capture SWIM activation
- **Command Decoding**: Interpret SRST, ROTF, WOTF commands
- **Address Display**: Show target memory addresses
- **Data Format**: Display read/write data in hex or binary

**Protocol Decoding**
- **Entry Phase**: Detect and display SWIM entry sequence (4 pulses)
- **Command Phase**: Decode 3-bit command codes
- **Address Phase**: Show memory addresses being accessed
- **Data Phase**: Display data bytes transferred
- **Acknowledge**: Indicate ACK/NAK from target

**Display Options**
- Show SWIM commands with descriptive names (ROTF, WOTF, SRST)
- Display memory addresses in hex format
- Show data bytes with ASCII representation if printable
- Indicate direction (host→target or target→host)
- Mark acknowledge pulses clearly

**Trigger Settings**
- Trigger on SWIM entry sequence (start of 4-pulse pattern)
- Trigger on specific SWIM commands (e.g., SRST for reset)
- Trigger on specific memory address access
- Trigger on data patterns during memory operations

**Analysis Tips**
- Capture SWIM entry sequence to see initialization
- Verify pull-up resistor is functioning (idle state high)
- Monitor for timing violations or glitches
- Check acknowledge responses from target
- Verify memory addresses match expected access patterns
- Look for repeated operations indicating errors
- Measure actual bit rate from captured waveform

**Common Issues**
- **No Entry Sequence**: Check NRST/SWIM connection, pull-up resistor, VDD
- **Entry Fails**: Wrong pulse timing, noise on line, target not powered
- **No Acknowledgments**: Target not responding, timing too fast, target locked
- **Timing Errors**: Sample rate too low, signal integrity issues
- **Flash Programming Fails**: Insufficient hold time, option bytes misconfigured
- **Read/Write Errors**: Address out of range, protected memory area

**Advanced Analysis**
- Measure precise bit timing to calculate SWIM frequency
- Analyze flash programming sequences for optimization
- Monitor CPU run state changes (halt/run transitions)
- Decode option byte programming operations
- Identify inefficient memory access patterns
- Verify flash erase timing (can take several ms)

**Debugging SWIM Communication**
- Verify entry sequence has exactly 4 pulses at correct frequency
- Check that idle state returns to high (pull-up working)
- Look for proper acknowledge pulses from target
- Ensure no bus contention (host and target driving simultaneously)
- Verify reset pulse before entry sequence
- Check for electrical issues (ringing, overshoot, undershoot)

## Reference

- [STM8 SWIM Protocol Documentation](https://www.st.com/resource/en/user_manual/cd00173911.pdf) - UM0470 ST official spec
- [STM8 Family Reference Manuals](https://www.st.com/en/microcontrollers-microprocessors/stm8-8-bit-mcus.html) - STM8S, STM8L documentation
- [ST-LINK Programmer](https://www.st.com/en/development-tools/st-link-v2.html) - Official SWIM programmer
- [SWIM Protocol Analysis](https://wiki.st.com/) - STM community resources
- [STM8 Debugging Guide](https://www.st.com/resource/en/application_note/an3116-stm8s-and-stm8l-familiesflash-programming-using-swim-and-iapin-application-programming-stmicroelectronics.pdf) - AN3116

---
**Last Updated**: 2026-02-02
