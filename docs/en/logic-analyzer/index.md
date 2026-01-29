# Overview

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 30-77 -->

The Logic Analyzer mode allows you to capture and analyze digital signals with advanced triggering, timing analysis, and bus decoding capabilities.

## Main window components

The Logic Analyzer interface consists of several key areas:

1. **Toolbar:** Configure trigger, sampling rate, threshold, and other capture parameters
2. **Channel labels:** Add and delete channels using the icons. Press the left mouse button on a channel label to change settings. Click the gear button on the top-right corner of a bus channel for advanced parameters. Select and drag a channel label to another to combine channels
3. **Report window toolbar:** Display channel data or decode results, view waveform statistics, and export reports as .CSV or .TXT files
4. **Status bar:** Shows device connection status
5. **Info panel:** Displays channel, value, and trigger information. Toggle visibility in environment settings
6. **Waveform area:** Use the mouse wheel to zoom in/out the waveform scale. Press Shift + Key to place cursors for calculating time intervals or frequency

---

## Quick start

1. Configure channels using [Quick Setting](capture-settings.md#quick-setting)
2. Set up [trigger conditions](capture-settings.md#trigger-parameter-setting)
3. Adjust [sampling rate and memory](capture-settings.md#device-memory-usage)
4. Configure [threshold levels](capture-settings.md#threshold)
5. Start capture (press Enter or click **Start**)

---

## Key features

### Capture modes

- **Asynchronous (Timing) mode:** Uses internal clock for sampling
- **Synchronous (State) mode:** Uses external clock for sampling
- **Transitional storage:** Captures only signal transitions to maximize memory

Learn more: [Advanced Capture Settings](advanced-capture.md)

### Trigger options

- Manual trigger
- Single level trigger
- Multi-level trigger (up to 16 states)
- Width trigger
- Timeout trigger
- External trigger

Learn more: [Capture Settings](capture-settings.md)

### Analysis tools

- **Bus decoding:** Decode I2C, SPI, UART, I3C, and many other protocols
- **Timing check:** Import CSV files to automate parameter verification
- **Waveform statistics:** Measure period, frequency, pulse width, delays, and more
- **Cursor measurements:** Place up to 25 cursors for precise timing analysis

Learn more: [Bus Decode](bus-decode.md), [Timing Check](timing-check.md), [Cursor](cursor.md)

### Integration

- **Stack Oscilloscope:** Combine logic and analog analysis by connecting to supported oscilloscopes
- **Export options:** Save as TLW, VCD, binary, MATLAB, or DGW/PGV formats

Learn more: [Stack Oscilloscope](stack-oscilloscope.md), [File Operations](file-operations.md)

---

## Documentation sections

- [File Operations](file-operations.md) - Open, save, import, and export files
- [Keyboard Shortcuts](keyboard-shortcuts.md) - Quick key reference
- [Capture Settings](capture-settings.md) - Configure triggers, memory, and thresholds
- [Advanced Capture](advanced-capture.md) - Async/sync modes and glitch filters
- [Cursor](cursor.md) - Cursor operations and waveform search
- [Waveform Area](waveform-area.md) - Waveform display and annotations
- [Report Area](report-area.md) - Channel status and statistics
- [Bus Decode](bus-decode.md) - Protocol decoding settings
- [Timing Check](timing-check.md) - Automated timing verification
- [Stack Oscilloscope](stack-oscilloscope.md) - Mixed-signal analysis
