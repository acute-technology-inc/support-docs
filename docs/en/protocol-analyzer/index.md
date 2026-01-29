# Overview

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 11-29 -->

The Protocol Analyzer mode captures and decodes bus protocol traffic in real-time, providing immediate visibility into protocol-level communication.

Protocol Analyzer mode focuses on protocol-level analysis rather than signal-level timing. It decodes bus transactions automatically and presents them in an easy-to-read report format.

**Key differences from Logic Analyzer:**

- Real-time protocol decoding during capture
- Report-focused view (optional waveform display)
- Three operating modes for different use cases
- Optimized for high-speed protocol capture

---

## Operating modes

### Protocol Analyzer

Real-time capture with immediate display. Data is sent back to the PC for real-time display as it's captured.

**Best for:** Quick protocol debugging and interactive analysis

Learn more: [Capture Modes](capture-modes.md#protocol-analyzer)

### Protocol Logger

Capture to disk without real-time processing. Data is saved as .LOG files and can be analyzed later.

**Best for:** Long captures and high-data-rate protocols

Learn more: [Capture Modes](capture-modes.md#protocol-logger)

### Protocol Monitor

Capture to device memory with trigger-based retrieval. Data stays in the device until triggered or manually stopped.

**Best for:** Monitoring for specific events over extended periods

Learn more: [Capture Modes](capture-modes.md#protocol-monitor)

---

## Quick start

1. [Select protocol and configure channels](protocol-settings.md)
2. [Choose operating mode](capture-modes.md)
3. Configure [memory settings](operating-modes.md)
4. Optional: Enable [Show Waveforms](show-waveforms.md) for signal-level view
5. Start capture (press Enter)
6. Use [Search](search.md) to find specific transactions

---

## Key features

### Protocol support

Supports dozens of protocols including:

- I2C, SPI, UART
- CAN, LIN, I3C
- USB PD, eSPI, eMMC
- And many more

See: [Specifications](../specifications.md)

### Analysis tools

- **Real-time decode:** See protocol data as it's captured
- **Search function:** Find specific addresses, data, or patterns
- **Statistics:** Analyze traffic patterns and error rates
- **Detail view:** Inspect complex protocol transactions
- **Export:** Save reports as .TXT or .CSV

### Integration

- **Convert to Logic Analyzer:** Switch modes for signal-level analysis
- **Stack Oscilloscope:** Combine protocol and analog analysis (requires waveforms enabled)

---

## Documentation sections

- [File Operations](file-operations.md) - Open, save, and export files
- [Keyboard Shortcuts](keyboard-shortcuts.md) - Quick key reference
- [Capture Modes](capture-modes.md) - Analyzer, Logger, and Monitor modes
- [Protocol Settings](protocol-settings.md) - Configure protocol parameters
- [Operating Modes](operating-modes.md) - Memory and stop conditions
- [Show Waveforms](show-waveforms.md) - Enable waveform display
- [Search](search.md) - Find specific protocol data
- [Window Management](window-management.md) - Reports and navigation
- [Detail & Statistics](detail-statistics.md) - Inspect and analyze data
- [Cursor](cursor.md) - Cursor operations (requires waveforms)

---

## When to use Protocol Analyzer

**Choose Protocol Analyzer mode when:**

- You need to see protocol transactions, not raw signal timing
- Real-time decode is important
- Working with complex multi-byte protocols
- Debugging protocol-level issues (addressing, data errors, etc.)
- Capturing high-speed protocol traffic

**Choose Logic Analyzer mode when:**

- You need precise timing measurements
- Signal integrity is a concern
- Working with non-standard or custom protocols
- Debugging electrical issues
- Need advanced triggering on signal patterns
