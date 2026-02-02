# Serialized IRQ (SERIRQ)

## What is Serialized IRQ?

Serialized IRQ (SERIRQ) is an interrupt signaling protocol developed by Intel as part of the Low Pin Count (LPC) Interface Specification to replace the traditional parallel interrupt request (IRQ) lines used in ISA-based PC architectures. Formally documented in Intel's Low Pin Count Interface Specification Revision 1.1 (August 2002), SERIRQ serializes up to 32 interrupt requests over a single bidirectional wire, dramatically reducing the pin count required for interrupt handling in embedded systems and chipset designs. The protocol was developed to support the transition from legacy ISA expansion buses to more integrated, lower-pin-count architectures while maintaining backward compatibility with existing interrupt-driven software.

SERIRQ operates as a time-multiplexed frame-based protocol where each interrupt source (IRQ0-IRQ31) is assigned a specific time slot within a repeating frame structure. Devices drive the SERIRQ line low during their assigned time slot to assert an interrupt request, while the host samples each slot to determine which interrupts are active. The protocol supports two operational modes: Quiet Mode, where frames are initiated only when an interrupt occurs (reducing power consumption), and Continuous Mode, where frames are transmitted continuously to minimize latency. Frame timing is controlled by the LPC host, which initiates each frame with a START pulse and maintains the clock timing for all subsequent time slots.

The serialization of interrupt signals was essential for reducing chipset complexity and board routing congestion in PC architectures from the late 1990s onward. SERIRQ became ubiquitous in embedded x86 systems, Super I/O controllers, embedded controllers (ECs), and platform controller hubs (PCH) where legacy interrupt sources needed to be communicated to the CPU with minimal pin overhead. While modern systems increasingly use message-signaled interrupts (MSI/MSI-X) for PCI Express devices, SERIRQ remains relevant for legacy peripheral support, embedded systems, and industrial applications requiring ISA-compatible interrupt handling.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- Single bidirectional open-drain signal (SERIRQ)
- Pull-up resistor to 3.3V or 5V (typically 10kΩ)
- Active-low signaling (driven low to assert)
- Wired-OR topology (multiple devices can pull low)

**Timing:**
- Frame-based time-multiplexed protocol
- Each frame contains 32 time slots (IRQ0-IRQ31)
- Clock period: Typically 1 MHz (1 microsecond per clock)
- Each IRQ slot: 3-4 clock periods wide

### Protocol Structure

**Frame Structure:**

A complete SERIRQ frame consists of:

1. **START pulse** (2-3 clocks): Host drives line low to begin frame
2. **IRQ slots** (32 slots × 3-4 clocks each): One slot per IRQ line
3. **STOP pulse** (2-3 clocks): Host drives line low to end frame
4. **Recovery time**: Line returns to idle (high) between frames

**IRQ Slot Timing:**

Each IRQ slot consists of:
- **Sample phase** (1-2 clocks): Host samples the line state
- **Turn-around time** (1 clock): Bus ownership transition
- **Drive phase** (1 clock): Device drives line low if IRQ is active

**Operational Modes:**

- **Quiet Mode**: Frames are initiated only when a device requests service by pulling SERIRQ low. Reduces power consumption by eliminating idle frame traffic. Host responds to interrupt assertion by starting a frame to determine which IRQ is active.

- **Continuous Mode**: Frames are transmitted repeatedly at regular intervals (typically every 32-40 microseconds). Provides lower latency since IRQ state is continuously polled. Used when predictable interrupt latency is critical.

**Mode Transition:**

The host can switch between Quiet and Continuous modes by controlling the frame generation pattern. Devices automatically adapt to the mode based on START pulse timing.

### Interrupt Priority and Handling

- IRQ slots are ordered IRQ0 through IRQ31 within each frame
- Lower IRQ numbers (IRQ0, IRQ1) have earlier time slots and thus lower latency
- Multiple devices can share the same IRQ slot (wired-OR)
- Host interrupt controller determines priority and masking
- Legacy PC IRQ assignments typically followed (IRQ0=timer, IRQ1=keyboard, etc.)

## Common Applications

SERIRQ is widely implemented in x86-based embedded systems and legacy PC architectures:

**Chipsets and Platform Controllers:**
- Intel Platform Controller Hubs (PCH)
- AMD chipsets with LPC support
- Embedded x86 system-on-chip (SoC) designs
- Legacy bridge chips (PCI-to-ISA, LPC bridges)

**Super I/O Controllers:**
- Keyboard and mouse controller interfaces
- Serial and parallel port controllers (16550 UART, LPT)
- Floppy disk controllers
- GPIO and hardware monitoring interfaces

**Embedded Controllers (EC):**
- Laptop embedded controllers for power management
- Battery management and charging control
- Thermal monitoring and fan control
- Hotkey and special function handling

**Industrial and Embedded Systems:**
- POS (Point of Sale) terminals with legacy peripherals
- Industrial automation controllers
- Medical equipment with legacy interface requirements
- Embedded systems requiring ISA-compatible interrupt handling
- Thin clients and embedded x86 platforms

**Legacy Peripheral Support:**
- ISA bus expansion card emulation
- PS/2 keyboard and mouse interfaces
- Legacy timer and RTC (Real-Time Clock) interrupts
- Legacy DMA controller interrupt signaling
- Hardware monitoring (temperature, voltage, fan sensors)

**Development and Test Equipment:**
- Logic analyzers with LPC decode support
- PC architecture debugging tools
- Embedded system development boards
- ICE (In-Circuit Emulator) systems for x86 platforms

## Decoder Configuration

When configuring a logic analyzer to decode SERIRQ signals:

### Channel Assignment

**Minimum Configuration (1 channel):**
- **SERIRQ**: The serialized interrupt signal line

**Optional Channels (for context):**
- **LFRAME#**: LPC frame start signal (helps identify LPC bus activity)
- **LCLK**: LPC clock reference (if available, aids timing analysis)

### Protocol Parameters

**Timing Settings:**
- **Clock frequency**: Typically 1 MHz (1 µs period) or system-specific
- **Frame detection**: Identify START pulse (2-3 clocks low)
- **Slot timing**: 3-4 clock periods per IRQ slot
- **Sampling rate**: Minimum 10 MHz (10x oversampling for 1 MHz signal)

**Decoding Options:**
- **Mode detection**: Identify Quiet Mode vs. Continuous Mode operation
- **IRQ slot identification**: Display which IRQ slots are asserted (IRQ0-IRQ31)
- **Frame timing**: Show inter-frame spacing and frame duration
- **Active IRQs**: Highlight asserted interrupt slots

### Trigger Settings

**Common trigger configurations:**
- **START pulse**: Trigger on frame start (2-3 clock low pulse)
- **Specific IRQ assertion**: Trigger when specific IRQ slot is driven low
- **Any IRQ active**: Trigger on any interrupt assertion within frame
- **Mode transition**: Trigger on change between Quiet and Continuous modes
- **Pattern matching**: Trigger on specific IRQ combinations (e.g., IRQ1 + IRQ12)

### Display Options

**Visualization:**
- **Frame view**: Show complete frames with all 32 IRQ slots
- **IRQ labels**: Display IRQ numbers (IRQ0-IRQ31) for each slot
- **Active indicators**: Highlight asserted IRQs (low during sample phase)
- **Timing annotations**: Mark START, STOP, and slot boundaries
- **Mode indicator**: Display current operational mode (Quiet/Continuous)

### Analysis Tips

**Frame Synchronization:**
Begin capture by triggering on a START pulse to ensure proper frame alignment. Without correct synchronization, IRQ slot assignments will be misinterpreted.

**Mode Identification:**
Observe inter-frame timing to identify operational mode. In Continuous Mode, frames repeat at regular intervals (typically 30-40 µs). In Quiet Mode, frames occur only after interrupt assertion with variable spacing.

**IRQ Mapping:**
Document the IRQ-to-device mapping for the target system. Standard PC IRQ assignments (IRQ0=timer, IRQ1=keyboard, IRQ3=COM2, IRQ4=COM1, IRQ12=mouse, IRQ14/15=IDE) may apply, but embedded systems often use custom mappings.

**Latency Measurement:**
Measure time from IRQ assertion (device pulling SERIRQ low outside a frame) to the START of the next frame. This indicates interrupt latency, which varies between Quiet and Continuous modes.

**Shared IRQ Analysis:**
When multiple devices share an IRQ slot, all will drive the line low during that slot. Additional analysis of device-specific signals or software interrupt handler behavior is needed to determine the actual interrupt source.

**Signal Integrity:**
Check for clean LOW levels during IRQ assertions and proper HIGH levels during idle states. Marginal pull-up resistors or excessive line capacitance can cause slow rise times and unreliable detection.

## Reference

- [Low Pin Count (LPC) Interface Specification, Revision 1.1](https://www.intel.com/content/dam/www/program/design/us/en/documents/low-pin-count-interface-specification.pdf) - Intel (August 2002)
- [SERIRQ Interrupt Event - Intel Embedded Peripherals](https://intel.com/content/www/us/en/docs/programmable/683130/23-4/serirq-interrupt-event.html) - Intel Documentation
- [Wikipedia: Low Pin Count](https://en.wikipedia.org/wiki/Low_Pin_Count) - LPC Bus Overview
- [Intel 500 Series Chipset Family Datasheet](https://edc.intel.com/content/www/us/en/design/products/platforms/details/tiger-lake-mobile-y/) - Example chipset with SERIRQ support
