# SWD (Serial Wire Debug)

## What is SWD?

SWD (Serial Wire Debug) is a two-wire debug protocol developed by ARM as a compact, pin-efficient alternative to the traditional JTAG (Joint Test Action Group) debug interface for accessing on-chip debug and trace capabilities in ARM Cortex-based microcontrollers and microprocessors. Part of the ARM Debug Interface v5 Architecture Specification and standardized within ARM's CoreSight debug and trace technology ecosystem, SWD was specifically designed to reduce the number of physical pins required for debugging from JTAG's minimum of four (TDI, TDO, TMS, TCK) plus optional reset to just two mandatory signals (SWDIO and SWCLK) plus optional trace output (SWO). This pin reduction is critical for space-constrained embedded devices, wearables, IoT modules, and cost-sensitive applications where minimizing pin count frees up valuable GPIO pins for application functionality while still providing full debug capabilities including breakpoints, watchpoints, register access, memory read/write, and Flash programming.

The SWD protocol uses a synchronous, bidirectional communication scheme where SWCLK (Serial Wire Clock) provides the timing reference and SWDIO (Serial Wire Data I/O) carries bidirectional data between the debug host (debugger, programmer, or development tool) and the target device. Unlike JTAG which uses separate data input and output lines, SWD multiplexes data transmission in both directions over the single SWDIO line with explicit turnaround periods to manage the change of direction. The protocol operates through request-acknowledge-data transaction sequences where the host sends a request packet, the target responds with an acknowledge, and then data is transferred in either direction depending on whether it's a read or write operation. SWD provides access to the Debug Access Port (DAP) which serves as a gateway to internal debug resources including CPU registers, memory, peripherals, Flash controllers, and trace components, enabling comprehensive development, debugging, and production programming workflows.

SWD has become the predominant debug interface for ARM Cortex-M microcontrollers (used in billions of IoT, industrial, consumer, and automotive devices) and is widely supported by development tools including SEGGER J-Link, ARM ULINK, ST-LINK, CMSIS-DAP compatible debuggers, and IDEs like Keil µVision, IAR Embedded Workbench, Eclipse-based toolchains, and modern platforms like VS Code with Cortex-Debug extensions. The protocol's combination of low pin count, high-speed operation (up to several MHz clock rates), robust operation, and comprehensive debug capabilities makes it the preferred debugging solution for modern embedded ARM development, with widespread adoption across microcontroller vendors including STMicroelectronics (STM32), NXP (Kinetis, LPC), Nordic Semiconductor (nRF series), Silicon Labs, Atmel/Microchip (SAM), Texas Instruments, and countless others in the ARM Cortex ecosystem.

## Technical Specifications

### Physical Interface

**Mandatory Signals:**
- **SWDIO (Serial Wire Data I/O)**: Bidirectional data line
- **SWCLK (Serial Wire Clock)**: Clock signal driven by debug host

**Optional Signals:**
- **SWO (Serial Wire Output)**: Unidirectional trace output from target (part of SWV - Serial Wire Viewer)
- **nRESET**: Target reset signal (often shared with application reset)

**Electrical Characteristics:**
- **Voltage levels**: Typically 3.3V or 1.8V CMOS logic levels (target I/O voltage)
- **Pull resistors**: SWDIO pulled HIGH on target (typically 10-100 kΩ), SWCLK pulled LOW on target
- **Drive strength**: Standard digital I/O drive capability

**Pin Count Advantage:**
- **JTAG**: 4 mandatory pins (TDI, TDO, TMS, TCK) + nTRST optional = 4-5 pins
- **SWD**: 2 mandatory pins (SWDIO, SWCLK) + SWO optional + nRESET shared = 2-4 pins
- **Savings**: Reduces debug connector pins, frees GPIO for application use

### Clock Frequency and Timing

**Clock Speed:**
- **Typical range**: 100 kHz to 10 MHz (device and debugger dependent)
- **Common speeds**: 1 MHz, 2 MHz, 4 MHz
- **Maximum**: Some implementations support up to 50 MHz

**Timing Parameters:**
- **SWCLK HIGH period**: 4 ns to 50 ms (minimum 4 ns)
- **SWCLK LOW period**: 4 ns to 50 ms
- **Output skew**: -1 ns to +1 ns
- **Setup time**: Minimum 4 ns (data valid before clock edge)
- **Hold time**: Minimum 1 ns (data stable after clock edge)

**Data Transitions:**
- **Host writes data**: On falling edge of SWCLK
- **Host reads data**: On rising edge of SWCLK
- **Target writes data**: On rising edge of SWCLK
- **Target reads data**: On rising edge of SWCLK

### Protocol Structure

**Transaction Phases:**

1. **Request Phase** (Host to Target)
   - 8-bit request packet transmitted by host
   - Contains: START bit, AP/DP select, Read/Write bit, address bits, parity, STOP bit, PARK bit
   - Host drives SWDIO

2. **Turnaround Phase**
   - 1 clock cycle for line turnaround (SWDIO changes direction)
   - Host releases SWDIO (pulled HIGH by target pull-up)
   - Target prepares to drive SWDIO

3. **Acknowledge Phase** (Target to Host)
   - 3-bit acknowledge response from target
   - **ACK codes**: OK (0b001), WAIT (0b010), FAULT (0b100)
   - Target drives SWDIO

4. **Turnaround Phase (for reads)**
   - 1 clock cycle for line turnaround (SWDIO changes direction)
   - For reads: Target continues driving SWDIO
   - For writes: Host prepares to drive SWDIO

5. **Data Phase**
   - 32-bit data + 1 parity bit (33 bits total)
   - **Write**: Host drives data onto SWDIO
   - **Read**: Target drives data onto SWDIO
   - Parity is even parity over 32 data bits

**Request Packet Format (8 bits):**
- **Bit 0**: START bit (always 1)
- **Bit 1**: AP/DP select (0 = DP access, 1 = AP access)
- **Bit 2**: Read/Write (0 = Write, 1 = Read)
- **Bits 3-4**: Address bits A[3:2] (selects DP/AP register)
- **Bit 5**: Parity bit (even parity over bits 1-4)
- **Bit 6**: STOP bit (always 0)
- **Bit 7**: PARK bit (always 1, ensures line idlesHIGH)

**Acknowledge Codes:**
- **OK (001)**: Transaction successful, data transfer proceeds
- **WAIT (010)**: Target not ready, host should retry
- **FAULT (100)**: Error condition, host should check sticky error flags

### Debug Access Port (DAP)

**DP (Debug Port) Registers:**
- **IDCODE**: Identification code for the debug port
- **ABORT**: Abort register for clearing error conditions
- **CTRL/STAT**: Control and status register (power control, error flags)
- **SELECT**: Selects which AP (Access Port) and register bank to access

**AP (Access Port):**
- **MEM-AP**: Memory Access Port for accessing system memory, peripherals, Flash
- **JTAG-AP**: JTAG Access Port (for systems with both SWD and JTAG)
- **APB-AP, AHB-AP, AXI-AP**: Bus-specific access ports

**Typical Access Sequence:**
1. Host reads DP IDCODE to identify target
2. Host writes DP CTRL/STAT to power up debug domain
3. Host writes DP SELECT to choose AP and register bank
4. Host reads/writes AP registers to access memory, CPU registers, peripherals

### SWO (Serial Wire Output): Trace Capability

**Purpose:**
- Provides instrumentation trace output from target without occupying SWDIO
- Supports ITM (Instrumentation Trace Macrocell), DWT (Data Watchpoint and Trace), ETM (Embedded Trace Macrocell) data

**Encoding Modes:**
- **UART/NRZ (Asynchronous)**: Standard UART-like serial data (common baud rates: 115200, 500000, 2000000 bps)
- **Manchester (Synchronous)**: Manchester-encoded data synchronized to SWCLK

**Use Cases:**
- `printf` debugging via ITM
- Real-time variable monitoring
- Execution profiling and PC sampling
- Data value tracing

## Common Applications

SWD is ubiquitous in ARM Cortex microcontroller development:

- **Microcontroller development**: STM32, nRF52/53, Kinetis, LPC, SAM, EFM32, CC13xx/CC26xx, and all ARM Cortex-M devices
- **Firmware debugging**: Breakpoints, watchpoints, single-stepping, register/memory inspection
- **Flash programming**: Production programming, firmware updates, bootloader installation
- **In-system programming (ISP)**: Field updates, calibration data programming
- **Application development**: Debugging embedded software in IDEs (Keil, IAR, Eclipse, VS Code)
- **RTOS debugging**: Thread-aware debugging with FreeRTOS, Zephyr, ThreadX, etc.
- **IoT device programming**: Nordic nRF BLE modules, ESP32 (via adapter), STM32 wireless MCUs
- **Wearable devices**: Smartwatches, fitness trackers, hearables
- **Industrial automation**: PLCs, motor controllers, sensors with ARM cores
- **Automotive ECUs**: Body control modules, infotainment, ADAS processors
- **Consumer electronics**: Smart home devices, appliances, gaming peripherals
- **Medical devices**: Portable diagnostic equipment, patient monitors
- **Drones and robotics**: Flight controllers, motor drivers, sensor fusion modules
- **Production testing**: Manufacturing test fixtures, automated programming stations
- **Security research**: Firmware extraction, reverse engineering, vulnerability analysis

## Decoder Configuration

When configuring a logic analyzer to decode SWD protocol:

### Channel Assignment

**Mandatory Signals:**
- **SWDIO**: Serial Wire Data I/O (required)
- **SWCLK**: Serial Wire Clock (required)

**Optional Signals:**
- **SWO**: Serial Wire Output (for trace decoding)
- **nRESET**: Reset signal (context for debug sessions)

### Protocol Parameters

- **Clock frequency**: Expected SWCLK rate (1-10 MHz typical)
- **Voltage level**: Target I/O voltage (1.8V, 3.3V, etc.)
- **Idle state**: SWDIO should idle HIGH, SWCLK should idle LOW

### Decoding Options

- **Request packet decoding**: Parse START, AP/DP, R/W, Address, Parity, STOP, PARK bits
- **Acknowledge decoding**: Identify OK, WAIT, FAULT responses
- **Data phase decoding**: Extract 32-bit data values and parity
- **Parity validation**: Check even parity on request and data
- **Register identification**: Annotate DP/AP register names (IDCODE, CTRL/STAT, etc.)
- **Transaction status**: Highlight successful transactions, retries (WAIT), errors (FAULT)
- **Turnaround visualization**: Show line direction changes
- **SWO trace decoding**: Decode ITM printf output, PC samples, DWT events (if SWO captured)

### Trigger Configuration

- **Request packet**: Trigger on specific request (e.g., memory read at address)
- **Acknowledge**: Trigger on FAULT responses (error conditions)
- **Data value**: Trigger when specific data written or read
- **Register access**: Trigger on access to specific DP or AP register
- **WAIT response**: Trigger on target busy conditions
- **Transaction start**: Trigger on START bit of request

### Analysis Tips

When analyzing SWD communications:

1. **Verify idle state**: SWDIO should be HIGH, SWCLK LOW when bus is idle
2. **Check request packets**: START=1, STOP=0, PARK=1 should always be present
3. **Validate parity**: Request parity and data parity should be correct (even parity)
4. **Monitor ACK responses**: Frequent WAIT responses indicate target busy or slow Flash/memory operations
5. **Identify transaction types**: Distinguish DP vs. AP accesses, reads vs. writes
6. **Track register accesses**: SELECT writes choose which AP and register bank is active
7. **Observe retry patterns**: Host should retry after WAIT responses
8. **Detect errors**: FAULT responses indicate sticky error flags need clearing via ABORT
9. **Measure timing**: Ensure setup/hold times meet specifications
10. **Correlate with debug operations**: Link SWD traffic to debugger commands (halt, step, run, read memory)

### Common Protocol Patterns

**Target Identification:**
1. Host sends READ request to DP IDCODE register (address 0x0)
2. Target responds OK
3. Target sends 32-bit IDCODE (identifies ARM CoreSight version, manufacturer, part number)

**Debug Domain Power-Up:**
1. Host sends READ to DP CTRL/STAT register
2. Target responds with current CTRL/STAT value
3. Host sends WRITE to DP CTRL/STAT with CDBGPWRUPREQ and CSYSPWRUPREQ bits set
4. Target powers up debug domain
5. Host polls CTRL/STAT until CDBGPWRUPACK and CSYSPWRUPACK bits set

**Memory Read:**
1. Host writes DP SELECT to choose MEM-AP
2. Host writes AP TAR (Transfer Address Register) with memory address
3. Host writes AP CSW (Control/Status Word) with transfer size and settings
4. Host reads AP DRW (Data Read/Write register)
5. Target returns 32-bit data from memory address

**Memory Write:**
1. Host writes AP TAR with destination address
2. Host writes AP DRW with 32-bit data to write
3. Target writes data to memory
4. Host reads AP CSW to verify transfer complete

**Flash Programming Session:**
1. Identify target (read IDCODE)
2. Power up debug domain
3. Halt CPU (write DHCSR register via MEM-AP)
4. Unlock Flash controller (write Flash keys)
5. Erase Flash sectors
6. Write Flash data (bulk writes to Flash addresses)
7. Verify Flash contents (read back)
8. Reset and release CPU

## Reference

- [ARM Developer: Serial Wire Debug Protocol Operation](https://developer.arm.com/documentation/ihi0031/a/The-Serial-Wire-Debug-Port--SW-DP-/Serial-Wire-Debug-protocol-operation)
- [ARM DSTREAM-ST: Serial Wire Debug Signals](https://developer.arm.com/documentation/100893/latest/Debug-and-trace-interface/Serial-Wire-Debug-signals)
- [Microchip: Serial Wire Debug Port Documentation](https://onlinedocs.microchip.com/oxy/GUID-04CBA5CC-E7FC-4091-8CDF-8925C26C8012-en-US-1/GUID-7AFC150F-2FBD-44C8-BCF6-F367E631D7C6.html)
- [Silicon Labs AN0062: Programming Internal Flash Over the Serial Wire Debug Interface](https://www.silabs.com/documents/public/application-notes/an0062.pdf)
- [ARM CoreSight Basics for Keil Tools](https://documentation-service.arm.com/static/61f93536fa8173727a1b72ab)
