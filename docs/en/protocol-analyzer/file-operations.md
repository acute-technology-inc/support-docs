# File operations

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 11-14 -->

Manage protocol capture files, convert between analyzer modes, and configure system preferences.

## Basic file operations

### Open file

Load a previously saved protocol capture file from disk.

**Supported formats:**

- TravelLogic files (*.TLW)
- Logger files (*.LOG) - for Protocol Logger captures

### Save

Save the current window to a file with the existing filename.

### Save as

Save with a new filename and optionally specify a storage range.

**Range options:**

- Full capture
- Cursor range (if Show Waveforms is enabled)
- Custom row range

### Save all

Save all open Protocol Analyzer and Logic Analyzer windows to files at once.

---

## Mode conversion

### Add Protocol Analyzer

Open a new Protocol Analyzer window to capture a different protocol or bus simultaneously.

### Add Logic Analyzer

Open a new Logic Analyzer window for signal-level timing analysis.

### Convert to Logic Analyzer

Switch from Protocol Analyzer to Logic Analyzer mode while preserving captured data.

**Requirements:**

- [Show Waveforms](show-waveforms.md) must be enabled
- Data/waveforms must be captured before converting

**What's transferred:**

- Waveform data
- Channel settings
- Threshold configurations
- Trigger position

**After conversion:**

Continue using Logic Analyzer features:

- Signal-level timing measurements
- Advanced triggering
- Cursor-based analysis
- Additional bus decoding

---

## Integration features

### Stack Oscilloscope

Add oscilloscope measurements to Protocol Analyzer captures.

**Requirements:**

- **Show Waveforms** must be enabled
- Capture protocol data with waveforms before clicking the DSO icon
- Supported oscilloscope must be connected

**How it works:**

1. Enable Show Waveforms in Protocol Analyzer
2. Capture data
3. Click DSO icon to enter Logic Analyzer window
4. Configure oscilloscope stack connection
5. View protocol decode alongside analog waveforms

Learn more: [Logic Analyzer - Stack Oscilloscope](../logic-analyzer/stack-oscilloscope.md)

---

## Display preferences

### Language

Select the display language:

- English
- Traditional Chinese (繁體中文)
- Simplified Chinese (简体中文)

The language setting applies to all menus, dialogs, and reports.

---

## Options (System preferences)

Configure application-wide settings for Protocol Analyzer operation.

### Display settings

1. **Default label height:** Modify the channel height in the waveform area
2. **Working directory:** Location for temporary files and captured data
3. **Waveform display type:** Choose what to display between waveform edges:
   - Time value
   - Logic value
   - No display
4. **Expanded waveform color:** Enable different colors for each channel

### Startup and save behavior

5. **Load last environment on software start:** Restore previous settings (not waveforms) when launching
6. **Save waveform after each acquisition:** Automatically save to working directory
7. **Repeat acquisition behavior:** Configure waveform decoding display during repeat captures
   - Display intervals: 1/2/5 seconds

### Report options

8. **Display row number in LA decode report:** Show row numbers on the left side of the report area
9. **Report data display byte number:** Set the number of bytes to display per report field (Protocol Analyzer specific)
10. **Detail report byte numbers:** Limit the number of bytes displayed in detail view

### Trigger and cursor

11. **Trigger out pulse width (μs):** Default length from trigger point to end of capture
12. **Show waveform value tooltip on cursor position:** Display channel numbers and bus decode names
13. **Show cursor position in decode/transition report:** Display cursor location in report time field
14. **Show cursor separate time on cursor bar:** Show time intervals between cursors
15. **Cursor font size in report area:** Adjust font size for cursor position display

### Device behavior

16. **Auto-reconnect device:** Automatically reconnect when device is re-plugged after going offline

### Waveform display

17. **Show channel information in waveform display:** Display channel numbers
18. **Show value information in waveform display:** Display 0/1 for digital, voltage for analog
19. **Show trigger information in waveform display:** Display trigger setting values
20. **Show channel activity in waveform display:** Summarize edge transitions
21. **Display waveform time scale dash line:** Add vertical lines to align waveform with report

### Processing

22. **Use multicore processing:** Enable multi-core CPU usage for faster data processing
23. **Display report timestamp information:** Choose timestamp format:
    - Timing info format
    - Timing info with date/time (trigger at 0s)
    - Sample count format

### Channel management

24. **Enable label combine by mouse dragging:** Drag one channel label onto another to combine
25. **Max. Logic Analyzer cursor measurement tab count:** Number of cursor measurement groups (3-10)

### Font settings

Configure font type and size for:

- Waveform area text
- Notes
- Channel labels

---

## Export options

### Save report as text file

Export the protocol decode report to .TXT or .CSV format.

**Save options:**

1. **Save range:**
   - All data
   - Specified number of rows
2. **Advanced reports:** Include detailed data in export
3. **Split timestamp columns:** Separate timestamp into two columns:
   - Timestamp column
   - Duration column
4. **Maximum saving byte per column:** Limit byte count per field

Learn more: [Window Management](window-management.md)

---

## Tips and best practices

### Working directory

Choose a working directory with:

- Sufficient free space for large captures
- Fast read/write performance (SSD recommended for Logger mode)
- Regular backup if storing important captures

### Auto-save

Enable "Save Waveform After Each Acquisition" to:

- Prevent data loss from crashes
- Maintain capture history
- Quick recovery of previous captures

**Note:** Auto-saved files can accumulate quickly. Periodically clean the working directory.

### Mode conversion workflow

**Protocol analysis → Signal analysis:**

1. Start in Protocol Analyzer with Show Waveforms enabled
2. Capture interesting protocol traffic
3. Convert to Logic Analyzer when signal-level issues appear
4. Use Logic Analyzer tools for detailed timing analysis
