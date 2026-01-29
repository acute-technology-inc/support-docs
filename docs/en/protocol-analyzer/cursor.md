# Cursor operations

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 29 -->

Use cursors for waveform measurements and searches in Protocol Analyzer mode.

## Overview

Cursor functions are available in Protocol Analyzer mode, but **only when the [Show Waveforms](show-waveforms.md) feature is enabled**.

---

## Requirements

**Critical:** The **Show Waveforms** function must be turned on before cursor operations become available.

**If Show Waveforms is disabled:**

- Cursor buttons appear gray and are disabled
- Waveform search is unavailable
- Time measurements cannot be performed
- Cursor keyboard shortcuts do not work

---

## Cursor functionality

When Show Waveforms is enabled, cursor operations work identically to Logic Analyzer mode:

### Cursor features

- **Place cursors:** Add measurement cursors at specific time positions
- **Measure time intervals:** Calculate time between cursors
- **Calculate frequency:** Determine signal frequency from period
- **Search waveforms:** Find edges, values, and patterns

### Special cursors

- **T cursor:** Trigger point marker (fixed position)
- **B cursor:** Search-specific cursor
- **A-Z cursors:** General-purpose measurement cursors (26 available)

---

## Cursor operations

### Adding cursors

**Method 1: Mouse**

Click the **Add Cursor** button and position cursor in waveform area.

**Method 2: Keyboard**

Press **Shift + [A-Z letter]** to add or move cursor to mouse position.

### Moving cursors

**Drag:**

- Click and drag cursor sign or line
- Reposition to desired time location

**Keyboard:**

- Press **A-Z** key to jump to that cursor's position
- Press **Shift + A-Z** to move cursor to mouse position

### Measurements

Cursor measurement bar shows:

- **Time interval:** Between selected cursors
- **Frequency:** 1 / interval
- **Sample count:** Number of samples between cursors

---

## Waveform search

Search for specific signal patterns using cursor positioning.

### Search modes

1. **By Edge:** Find rising/falling/either edges
2. **By Time:** Move cursor by specified time offset
3. **By Value Match:** Search for specific signal values
4. **Search Pulse Width:** Find pulses matching width criteria

### Search workflow

1. Position starting cursor
2. Configure search parameters
3. Execute search
4. Cursor moves to next match
5. Repeat to find subsequent matches

---

## Use cases in Protocol Analyzer

### Timing verification

**Measure protocol timing:**

1. Enable Show Waveforms
2. Capture protocol data
3. Place cursors at protocol events (START, STOP, ACK, etc.)
4. Verify timing meets specification

**Examples:**

- I2C setup and hold times
- SPI clock period
- UART bit timing
- CAN bit periods

---

### Signal quality check

**Inspect waveform quality:**

1. Enable Show Waveforms
2. Capture suspect protocol
3. Use cursors to measure:
   - Rise/fall times
   - Signal levels
   - Noise or glitches
   - Clock jitter

---

### Correlation

**Correlate protocol with waveform:**

1. Click on protocol transaction in report
2. Waveform view shows corresponding signals
3. Use cursors to measure exact timing
4. Verify signal integrity during transaction

---

## Transitioning to Logic Analyzer

If extensive cursor and waveform analysis is needed:

**Recommended workflow:**

1. Capture in Protocol Analyzer with Show Waveforms
2. Initial analysis using protocol report
3. Click **Convert to Logic Analyzer** in File menu
4. Continue with full Logic Analyzer cursor features

**Why convert?**

- Full cursor measurement capabilities
- Advanced waveform search
- Detailed timing analysis tools
- Signal-level triggering options
- Complete waveform annotation

See: [File Operations - Convert to Logic Analyzer](file-operations.md#convert-to-logic-analyzer)

---

## Limitations in Protocol Analyzer mode

**Compared to Logic Analyzer:**

- Fewer cursor analysis tools
- Basic search functionality only
- Limited waveform measurements
- No advanced statistics on waveform
- No cursor-based triggering

**Recommendation:** For extensive waveform analysis, convert to Logic Analyzer mode.

---

## Tips and best practices

### When to use cursors in Protocol Analyzer

**Use cursors here when:**

- Quick timing check needed
- Verifying protocol meets timing spec
- Simple signal quality inspection
- Don't need full Logic Analyzer features

**Convert to Logic Analyzer when:**

- Deep timing analysis required
- Multiple complex measurements needed
- Signal integrity is main concern
- Advanced triggering required

### Efficient workflow

1. **Start in Protocol Analyzer** (without Show Waveforms)
   - Pure protocol analysis
   - Maximum capture capacity

2. **If issues found, enable Show Waveforms and recapture**
   - Add signal visibility
   - Use cursors for basic timing checks

3. **If signal issues confirmed, convert to Logic Analyzer**
   - Full analysis capabilities
   - Complete timing measurements

---

## Keyboard shortcuts

When Show Waveforms is enabled:

| Function | Key |
|----------|-----|
| Move to cursor position | A-Z |
| Add/move cursor to mouse position | Shift + A-Z |
| Zoom in on waveform | Number Pad + |
| Zoom out on waveform | Number Pad - |

See: [Keyboard Shortcuts](keyboard-shortcuts.md)
