# LPC (Low Pin Count Bus)

## What is LPC?

### Overview

LPC (Low Pin Count) bus is a computer bus interface developed by Intel in 1997 as a replacement for the ISA (Industry Standard Architecture) bus on x86 PC motherboards. The LPC bus was designed to connect low-bandwidth peripheral devices such as Super I/O controllers, BIOS flash memory, keyboard controllers, and embedded controllers to the system chipset (typically the southbridge or PCH - Platform Controller Hub). By reducing the pin count from the 98 pins required by ISA to just 7 pins, LPC enabled cost-effective integration of legacy peripherals while maintaining backward compatibility with ISA I/O cycles and timing.

The LPC specification defines a synchronous serial bus that multiplexes address, data, and control information onto a 4-bit bidirectional bus (LAD[3:0]), clocked at 33 MHz. Despite being a serial interface, LPC maintains the ISA programming model, allowing existing ISA device drivers and BIOS code to work without modification. The protocol supports memory, I/O, DMA, and bus master cycles, making it suitable for a wide range of peripheral devices. LPC also includes power management features and supports firmware updates of system BIOS and BMC (Baseboard Management Controller) firmware.

While LPC was originally developed for desktop PCs, it has found widespread use in embedded systems, servers, and industrial computers where legacy peripheral support and BIOS access are required. The interface remains relevant in modern x86 platforms, though it's increasingly being supplemented or replaced by eSPI (Enhanced Serial Peripheral Interface) in newer designs. Understanding LPC is essential for motherboard debugging, BIOS development, embedded controller firmware, and security research related to firmware attacks.

### Key Features

- **Low Pin Count**: Only 7 pins vs. 98 for ISA bus
- **ISA Compatible**: Maintains ISA programming model and timing
- **33 MHz Clock**: Synchronous operation at system clock frequency
- **4-bit Multiplexed Bus**: Address, data, and control on LAD[3:0]
- **Multiple Cycle Types**: Memory, I/O, DMA, and bus mastering support
- **BIOS/Firmware Access**: Flash memory read/write via LPC
- **Embedded Controller Support**: Communication with system EC
- **Power Management**: Support for ACPI and power states
- **DMA Channels**: Legacy DMA support for compatible devices
- **TPM Interface**: Often used for Trusted Platform Module communication

## Technical Specifications

### Signal Description

**LPC Bus Signals** (7 pins minimum)

- **LAD[3:0]**: 4-bit bidirectional address/data bus (multiplexed)
- **LFRAME#**: Frame signal (active low) - indicates start of cycle
- **LCLK**: Clock signal (33 MHz typically, synchronized to PCI clock)
- **LRESET#**: Reset signal (active low)

**Optional Signals**

- **LDRQ#**: DMA request (for devices requiring DMA)
- **SERIRQ**: Serialized interrupt request
- **CLKRUN#**: Clock run control (for power management)
- **LPCPD#**: LPC power down
- **LSMI#**: System management interrupt

### Timing and Clocking

**Clock Specifications**
- **Frequency**: 33.33 MHz (typical, synchronized with PCI clock)
- **Can also be**: 25 MHz or 24 MHz in some systems
- **Duty Cycle**: 50% nominal
- **Synchronous**: All signals referenced to LCLK rising edge

**Cycle Timing**
- **Minimum Cycle**: 4 LCLK periods (start, address, data, TAR)
- **Typical I/O Cycle**: 6-8 LCLK periods
- **Turnaround (TAR)**: 1-2 LCLK periods for bus direction change
- **Wait States (SYNC)**: Variable, inserted as needed by peripherals

### LPC Cycle Types

**I/O Read/Write Cycle**
- Access I/O address space (0x0000-0xFFFF)
- Most common cycle type for peripheral registers
- Used by Super I/O, embedded controllers, TPM

**Memory Read/Write Cycle**
- Access memory address space
- Typically used for BIOS flash memory (0xFF000000-0xFFFFFFFF)
- Firmware Hub (FWH) protocol for BIOS access

**DMA Cycle**
- Legacy DMA channel support
- Used by floppy controllers, some legacy devices
- Becoming less common in modern systems

**Bus Master Cycle**
- Allows peripheral to initiate transactions
- Used by intelligent peripherals
- Requires additional arbitration logic

### LPC Cycle Structure

**Basic Cycle Phases**

1. **START Field** (1 cycle)
   - LFRAME# asserted (low)
   - LAD[3:0] contains start value (0000 = START)
   - Cycle type encoded in next field

2. **CYCTYPE+DIR Field** (1 cycle)
   - LAD[3:0] encodes cycle type and direction
   - Examples:
     - 0000: I/O Read
     - 0010: I/O Write
     - 0100: Memory Read
     - 0110: Memory Write
     - 1101: DMA Read
     - 1111: DMA Write

3. **ADDRESS Field** (2-8 cycles)
   - Address sent in 4-bit nibbles, MSB first
   - I/O address: 4 nibbles (16-bit address)
   - Memory address: 8 nibbles (32-bit address)

4. **SIZE Field** (Optional, for DMA)
   - Transfer size indicator

5. **TAR Field** (2 cycles)
   - Turnaround - bus direction change
   - LAD[3:0] driven to 1111 (high-impedance)
   - First cycle: host drives, second cycle: peripheral prepares

6. **SYNC Field** (1-N cycles)
   - Peripheral indicates readiness
   - 0000-0100: Ready with 0-4 wait states
   - 0101 (SYNC_READY): Ready this cycle
   - 0110 (SYNC_LWAIT): Long wait, more SYNC cycles coming
   - 1001-1010: Error conditions

7. **DATA Field** (2, 4, or 8 cycles)
   - Data transferred in 4-bit nibbles
   - Byte: 2 nibbles
   - Word: 4 nibbles
   - Dword: 8 nibbles

8. **TAR Field** (2 cycles)
   - Final turnaround before next cycle or idle

**Example I/O Read Cycle Timing**
```
LCLK:   __|‾|__|‾|__|‾|__|‾|__|‾|__|‾|__|‾|__|‾|__|‾|__
LFRAME: ‾‾|__|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾
LAD[3:0]: START|CT+DR|ADDR[15:12]|ADDR[11:8]|ADDR[7:4]|ADDR[3:0]|TAR|TAR|SYNC|DATA[3:0]|DATA[7:4]|TAR|TAR
Fields:   1     2      3            4          5          6        7   8   9     10         11        12  13
```

### SERIRQ (Serialized IRQ)

LPC typically uses SERIRQ for interrupt delivery:
- **Serial Protocol**: Interrupts serialized on single wire
- **IRQ Channels**: IRQ0-IRQ15 plus additional channels
- **Frame-Based**: Periodic frames with IRQ status bits
- **Quiet Mode**: Frame only sent when IRQs active
- **Continuous Mode**: Regular frame transmission

## Common Applications

**PC and Server Motherboards**
- Super I/O chip connection (keyboard, mouse, serial, parallel ports)
- BIOS flash memory interface (SPI flash via Firmware Hub)
- TPM (Trusted Platform Module) interface
- Embedded controller communication
- Hardware monitoring ICs

**BIOS and Firmware**
- System BIOS storage and boot code
- UEFI firmware storage
- Firmware update interface (BIOS flashing)
- CMOS/NVRAM configuration storage

**Embedded Controllers**
- Keyboard controller (8042 emulation)
- Battery management (laptops)
- Fan control and thermal management
- Power button and LED control
- Lid switch and hotkey handling

**Legacy Peripheral Support**
- Floppy disk controller (legacy)
- Parallel port (printer port)
- Serial ports (COM1, COM2)
- Game port (legacy)
- Legacy interrupt controller (PIC)

**Security Devices**
- TPM 1.2 and early TPM 2.0 modules
- Hardware security modules
- Cryptographic coprocessors
- Secure boot components

**Industrial and Embedded Systems**
- Watchdog timers
- GPIO expanders
- Legacy I/O emulation
- Industrial PC peripherals
- Embedded system debugging

## Decoder Configuration

When analyzing LPC bus traffic with a logic analyzer, configure the following parameters:

### Signal Connections

**Minimum Configuration** (7 channels)
- LAD[3:0] - 4 channels (bidirectional bus)
- LFRAME# - 1 channel (frame indicator)
- LCLK - 1 channel (clock)
- LRESET# - 1 channel (reset)

**With Interrupt** (8 channels)
- Add SERIRQ - 1 channel (serialized interrupts)

**Full Configuration** (up to 12 channels)
- Add LDRQ#, CLKRUN#, LPCPD#, LSMI# as available

### Sampling Requirements

- **Minimum Sample Rate**: 200 MS/s (6× the 33 MHz clock)
- **Recommended**: 500 MS/s to 1 GS/s for reliable capture
- **Synchronous Sampling**: Use LCLK as external clock if analyzer supports it

### Decoder Parameters

- **Clock Frequency**: 33.33 MHz (or actual system clock)
- **Cycle Types**: Enable decoding of I/O, Memory, DMA, Bus Master
- **Address Display**: Show I/O addresses (hex), memory addresses (hex)
- **Data Format**: Byte, word, or dword display
- **SERIRQ Decoding**: Enable if SERIRQ connected
- **Firmware Hub**: Enable FWH protocol for BIOS flash access

### Display Options

- Show cycle type (I/O Read, I/O Write, Memory Read, Memory Write)
- Display address being accessed
- Show data values read or written
- Indicate wait states (SYNC field values)
- Display TAR (turnaround) fields
- Show SERIRQ frame structure and active IRQs
- Annotate common addresses (0x80 POST codes, 0x60/0x64 keyboard, etc.)

### Trigger Settings

- Trigger on LFRAME# falling edge (start of cycle)
- Trigger on specific I/O address access (e.g., 0x80 for POST codes)
- Trigger on memory address range (BIOS region 0xFFxxxxxx)
- Trigger on specific data patterns
- Trigger on error conditions (error SYNC values)
- Trigger on SERIRQ frame start

### Analysis Tips

1. **Identify Cycle Types**
   - Watch for LFRAME# assertion
   - Decode CYCTYPE+DIR field in cycle 2
   - I/O cycles most common (Super I/O, EC, TPM access)

2. **Common I/O Addresses**
   - 0x0080: POST code port (diagnostic codes during boot)
   - 0x0060, 0x0064: Keyboard controller
   - 0x002E, 0x002F: Super I/O configuration
   - 0x004E, 0x004F: Alternate Super I/O configuration
   - 0x0070, 0x0071: CMOS/RTC access
   - 0x0CF8, 0x0CFC: PCI configuration space (may be bridged via LPC)

3. **BIOS Flash Access**
   - Memory cycles to 0xFF000000-0xFFFFFFFF range
   - Firmware Hub (FWH) protocol
   - Watch for block erase and programming cycles during BIOS update

4. **Embedded Controller Communication**
   - Often at 0x0062, 0x0066 or custom addresses
   - Command/data register access pattern
   - Status polling (watch for repeated reads)

5. **TPM Access**
   - TPM usually at 0xFED4xxxx (memory) or custom I/O
   - Command/response sequences
   - Locality-based access control

6. **Wait States and Timing**
   - Count SYNC cycles for performance analysis
   - Multiple wait states indicate slow peripheral
   - SYNC_LWAIT means extended wait

7. **SERIRQ Analysis**
   - Decode interrupt frame structure
   - Identify which IRQ lines are active
   - Check for spurious interrupts

### Common Issues

**No LPC Activity**
- **Symptom**: LFRAME# never asserts, bus idle
- **Cause**: System not powered, clock not running, or in reset
- **Solution**: Verify power, check LCLK present, verify LRESET# de-asserted

**Corrupted Cycles**
- **Symptom**: Invalid CYCTYPE, malformed addresses
- **Cause**: Signal integrity issues, sample rate too low
- **Solution**: Increase sample rate, check probe connections, verify LCLK quality

**Continuous Errors**
- **Symptom**: SYNC field shows error codes (1001, 1010)
- **Cause**: Peripheral not responding, wrong address, device failure
- **Solution**: Verify peripheral is present and configured, check address decoding

**Bus Contention**
- **Symptom**: LAD[3:0] showing conflicting values during TAR
- **Cause**: Turnaround timing violation, multiple drivers
- **Solution**: Check TAR field timing, verify only one device driving bus

**BIOS Update Failures**
- **Symptom**: Incomplete flash programming cycles
- **Cause**: Write protection, voltage issues, flash chip errors
- **Solution**: Check write enable signals, verify VPP voltage, ensure chip not locked

**Firmware Hub Issues**
- **Symptom**: BIOS memory reads return incorrect data
- **Cause**: FWH not enabled, incorrect addressing
- **Solution**: Verify FWH configuration, check address mapping

### Advanced Analysis

**Boot Sequence Analysis**
- Capture POST code sequence (writes to 0x80)
- Monitor BIOS initialization of Super I/O
- Track keyboard controller initialization
- Observe embedded controller startup

**Security Analysis**
- Monitor TPM command sequences
- Analyze secure boot measurements
- Capture BIOS update procedures
- Verify write protection mechanisms

**Performance Profiling**
- Measure wait state frequency
- Identify slow peripherals
- Analyze bus utilization
- Detect inefficient I/O patterns

**Debug Information**
- POST codes reveal boot progress
- Super I/O configuration shows peripheral setup
- EC commands reveal system state
- Flash access patterns show code execution flow

## Reference

- [Intel LPC Interface Specification](https://www.intel.com/content/www/us/en/support/articles/000007144/software.html) - Revision 1.1
- [Firmware Hub (FWH) Specification](https://www.intel.com/) - Intel document
- [SERIRQ Specification](https://www.intel.com/) - Serialized IRQ protocol
- [LPC Debug Card](https://en.wikipedia.org/wiki/POST_card) - POST code debugging
- [coreboot Documentation](https://doc.coreboot.org/) - Open source firmware using LPC

---
**Last Updated**: 2026-02-02
