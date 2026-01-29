# File operations

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 31-40 -->

Manage waveform files, import data, export to various formats, and configure system settings.

## Basic file operations

### Open file

Load a previously saved waveform file from disk.

Supported formats:

- TravelLogic Waveform Files (*.TLW)
- Logic Analyzer Waveform Files (*.LAW)

### Save file

Save the current capture to disk with the existing filename.

### Save as

Save with a new filename and optionally specify a storage range.

**Available formats:**

1. **TravelLogic files (*.TLW)** - Native format with all settings
2. **Transitional text file (*.txt)** - Transition-only data
3. **Text file (*.txt)** - Full data export
4. **MATLAB array file (*.m)** - For MATLAB analysis
5. **Binary data file (*.bin)** - Raw binary format
6. **TravelLogic files + Report file (*.TLW + *.TXT)** - Waveform and decoded report
7. **Value Change Dump (*.vcd)** - Standard VCD format for simulation tools
8. **Timestamp binary file (*.bin)** - Time-stamped binary data with options:
   - 64-bit time + 16-bit data
   - 64-bit time + 32-bit data
   - 64-bit time + 64-bit data
   - 64-bit time + 128-bit data

**Timestamp binary format:**

The first 64 bits represent time, and the remaining bits represent data. Data direction is from LSB to MSB (left to right).

**Note:** If you choose a data bit format with fewer bits than the number of channels, extra bits will be discarded.

### Save all

Save all open Logic Analyzer and Protocol Analyzer windows to files at once.

---

## Export to pattern generator

### Save as DGW / PGV file

Convert captured waveforms to DGW/PGV format for Acute Digital Data Generators (PKPG, PG2000, DG Series, TD Series). The exported waveform can be used to regenerate digital signals.

**Configuration options:**

1. **Select PG model:** The software checks maximum working frequency and memory depth based on the selected model
2. **File name and location:** Specify where to save the converted PGV file
3. **Save range:** 
   - Waveform within cursor range
   - Maximum available range (based on PG's maximum memory)
   - **Note:** Files larger than the PG's memory may not open in the PG software
4. **Repeat output:** Add a "Jump to start" command at the end for continuous playback
5. **Idle convert method:** Replace long idle periods with loop instructions to save memory
   - **Warning:** This makes the waveform more complex and harder to edit
6. **PG working frequency:** Specify the target pattern generator frequency
7. **Waveform convert method:** Choose how to handle frequency mismatches:
   - **Real-time sampling mode:** Uses PG's maximum frequency (may lose small signals)
   - **Slower waveform mode:** Converts high-speed waveform to slower speed (may affect setup/hold timing)

---

## Import data

### Import CSV

Convert digital or analog data stored in text format to TLW format for viewing and analysis.

**Location:** Toolbar → File → Import CSV

**Requirements:** Hardware device must be connected.

**Supported formats:**

#### 1. Agilent LA Module CSV text file

Export from Agilent LA software using Module CSV text file format.

**To export from Agilent software:**

- Open .Ala file
- Toolbar → File → Export...
- Select Module CSV Text File format

#### 2. Tektronix TLA Data Exchange Format

Export from TLA software using Data Exchange Format.

**To export from TLA software:**

- Click File → Export Data...
- Select TLA Data Exchange Format

#### 3. LA Text File

Import generic text files with customizable format settings.

**Configuration required:**

- Separator characters
- Data start line (used as channel label names)
- Time field format

#### 4. DSO Text File

Import oscilloscope waveform data from supported devices.

**Supported devices:**

- BF6264B, BF7000 series, BF7264 Pro
- LA3068B, LA3134B, LA4068B, LA4136B
- TL3134B, TL3234B+, TL4131B, TL4234B

**Features:**

- Select multiple files for import
- Set individual data processing modes
- Auto-detect sample rate/interval and trigger position from first 10 lines

**Unit specification:**

You must specify the basic unit for voltage measurements:

**Example with mV (default):**

- Data value: 1357
- Interpreted as: 1.357V

**Example with μV:**

- Data value: 135790
- Interpreted as: 0.13579V

**Differential signal mode:**

- Positive and negative channel settings must match
- Number of positive and negative channels must be equal

#### 5. Custom format

Import waveforms from other logic analyzers by arranging data according to the required format.

---

## Batch operations

### Batch report save

Generate decode reports from multiple captured waveform files in one operation.

**Configuration:**

1. **Source files:** Select .TLW or .LAW waveform files
2. **Output directory:** Choose where to save converted reports
3. **File extension:** Select .CSV or .TXT format
4. **Decode settings:**
   - Use decode settings from each individual file
   - Use decode settings from a specified file for all conversions
5. **Report format:**
   - Save reports in separated files
   - Combine all reports into one file with separation text
6. **Include options:**
   - Timestamp column information
   - Header column information

---

## Window management

### Add analyzer windows

- **Add Protocol Analyzer:** Open a new Protocol Analyzer window
- **Add Logic Analyzer:** Open a new Logic Analyzer window

### Language

Change the display language:

- English
- Traditional Chinese (繁體中文)
- Simplified Chinese (简体中文)

---

## System environment settings

Configure application-wide preferences and display options.

### Display settings

1. **Default label height:** Modify the channel height in the waveform area
2. **Working directory:** Location for temporary files and waveforms during operation
3. **Waveform display type:** Choose what to display between waveform edges:
   - Time value
   - Logic value
   - No display
4. **Expanded waveform color:** Enable different colors for each channel

### Startup and save behavior

5. **Load last environment on software start:** Restore previous settings (not waveforms) when launching
6. **Save waveform after each acquisition:** Automatically save to working directory after capture
7. **Repeat acquisition behavior:** Configure waveform decoding display during repeat captures (1/2/5 second intervals)

### Report options

8. **Display row number in LA decode report:** Show row numbers on the left side of the report area
9. **Report data display byte number:** Set the number of bytes to display per report field
10. **Detail report byte numbers:** Limit the number of bytes displayed in each detail report

### Trigger and cursor

11. **Trigger out pulse width (μs):** Default length from trigger point to end of capture
12. **Show waveform value tooltip on cursor position:** Display channel numbers and bus decode names
13. **Show cursor position in decode/transition report:** Display cursor location in the report time field
14. **Show cursor separate time on cursor bar:** Show time intervals between cursors
15. **Cursor font size in report area:** Adjust font size for cursor positions in reports (item 13)
16. **Max. Logic Analyzer cursor measurement tab count:** Set number of cursor measurement groups (3-10)

### Device behavior

17. **Auto-reconnect device:** Automatically reconnect when device is re-plugged after offline

### Waveform display

18. **Show channel information in waveform display:** Display channel numbers in waveform area
19. **Show value information in waveform display:** Display 0/1 for digital channels, voltage for analog channels
20. **Show trigger information in waveform display:** Display trigger setting values
21. **Show channel activity in waveform display:** Summarize edge transitions for each channel
22. **Display waveform time scale dash line:** Add vertical lines to align waveform area with report area

### Processing

23. **Use multicore processing:** Enable multi-core CPU usage to speed up data processing
24. **Display report timestamp information:** Choose timestamp format:
    - Timing info format
    - Timing info with date/time (trigger point at 0 s)
    - Sample count format

### Channel management

25. **Enable label combine by mouse dragging:** Drag one channel label onto another to combine channels

### Font settings

Configure the font type and size for text displayed in:

- Waveform area
- Notes
- Channel labels
