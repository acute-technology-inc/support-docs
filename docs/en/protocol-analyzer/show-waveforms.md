# Show waveforms

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 23 -->

Enable waveform display alongside protocol decode for signal-level visibility.

## Overview

By default, Protocol Analyzer shows only the decoded protocol report. Enabling **Show Waveforms** adds a waveform view, allowing you to see the actual signal transitions alongside the protocol decode.

---

## Enabling Show Waveforms

Select the **Show Waveforms** option before starting capture.

**Memory impact:**

- Requires additional device memory to store waveform data
- Reduces the total number of protocol transactions that can be captured
- Memory is divided between decode data and waveform data

---

## Available features

When Show Waveforms is enabled, the waveform area provides additional functions:

### 1. Bus decode button

**Refresh bus decode**

Manually refresh or update the bus decode after capture completes.

**Use cases:**

- Reprocess decode with different parameters
- Update decode after changing settings
- Verify decode accuracy

### 2. Stop bus decode button

Stop the bus decode process immediately.

**Use cases:**

- Lengthy decode is taking too long
- Want to start analysis before decode completes
- Decode parameters need changing

### 3. Add user notes

Add annotations and comments directly in the waveform area.

**Features:**

- Text notes at specific time positions
- Visual markers for important events
- Documentation for later review

**Use cases:**

- Mark interesting protocol transactions
- Note signal anomalies
- Document test conditions

### 4. Waveform zoom

Scale waveforms in and out for detailed inspection.

**Methods:**

- **Toolbar button:** Click zoom in/out buttons
- **Mouse wheel (recommended):** Scroll to zoom smoothly
- **Keyboard:** Number Pad + / Number Pad -

**Tips:**

- Mouse wheel zoom is most convenient
- Zoom focuses on cursor or mouse position
- Combine zoom with panning for efficient navigation

---

## Integration with other modes

### Convert to Logic Analyzer

**Requirement:** Show Waveforms must be enabled

After capturing protocol data with waveforms:

1. Click **Convert to Logic Analyzer** in the File menu
2. Waveform data and settings transfer to Logic Analyzer window
3. Continue using full Logic Analyzer capabilities

**What transfers:**

- Captured waveform data
- Channel assignments
- Threshold settings
- Trigger position

**Benefits:**

- Seamless transition between protocol and signal analysis
- No need to recapture data
- Preserve existing decode results

See: [File Operations - Convert to Logic Analyzer](file-operations.md#convert-to-logic-analyzer)

---

### Stack Oscilloscope

**Requirements:**

- Show Waveforms must be enabled
- Capture protocol data with waveforms
- Supported oscilloscope connected

**Workflow:**

1. Enable Show Waveforms in Protocol Analyzer
2. Configure and start capture
3. After capture, click the DSO icon
4. System enters Logic Analyzer window
5. Configure oscilloscope stack connection
6. View protocol decode with analog waveforms

See: [File Operations - Stack Oscilloscope](file-operations.md#stack-oscilloscope)

---

## Cursor operations

**Requirement:** Show Waveforms must be enabled

When waveforms are displayed, cursor functions become available:

- **Place cursors:** Measure time intervals
- **Cursor navigation:** Jump between interesting points
- **Waveform search:** Find edges, values, or patterns

See: [Cursor](cursor.md)

---

## Waveform vs. Report view

### Protocol Report (default)

**Advantages:**

- Uses less memory
- Captures more protocol transactions
- Faster post-processing
- Focuses on protocol-level issues

**Best for:**

- Protocol-level debugging
- High-speed protocol capture
- Long-duration captures
- When timing isn't critical

### Waveforms enabled

**Advantages:**

- See signal quality and timing
- Measure precise timing relationships
- Detect signal integrity issues
- Convert to Logic Analyzer for detailed analysis

**Best for:**

- Signal integrity analysis
- Mixed protocol/signal debugging
- Understanding timing issues
- When you might need signal-level detail

---

## Performance considerations

### Memory usage

**With Show Waveforms:**

- ~50-70% reduction in protocol transaction capacity
- Depends on sample rate and channel count
- Higher sample rates use more memory

**Without Show Waveforms:**

- Maximum protocol transaction capacity
- Memory used only for decode data
- Optimal for pure protocol analysis

### Processing time

**With Show Waveforms:**

- Longer post-processing time
- Waveform rendering overhead
- Decode + waveform display

**Without Show Waveforms:**

- Faster post-processing
- Decode-only processing
- Faster display updates

---

## When to use Show Waveforms

### Enable Show Waveforms when:

- You might need signal-level detail
- Debugging both protocol and signal issues
- Want option to convert to Logic Analyzer
- Planning to use Stack Oscilloscope
- Signal timing is important
- Unknown issue - might need multiple analysis approaches

### Disable Show Waveforms when:

- Pure protocol analysis
- Need maximum transaction capture
- Long-duration captures
- High-speed protocols
- Memory is limited
- Faster processing is priority
- Signal quality is known good

---

## Tips and best practices

### Decision workflow

Ask yourself:

1. Do I need signal timing information? → **Enable**
2. Might I need to use Logic Analyzer features? → **Enable**
3. Do I need maximum protocol transaction capture? → **Disable**
4. Is this a quick protocol debug session? → **Disable**

### Hybrid approach

**First capture:** Disable Show Waveforms for quick protocol analysis

**If issues found:** Enable Show Waveforms and recapture to investigate signal-level details

This two-stage approach maximizes efficiency while maintaining flexibility.
