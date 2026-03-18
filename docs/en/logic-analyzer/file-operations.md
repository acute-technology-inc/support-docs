# File Operations

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 31-40 -->

Open, save, and import waveform files from various sources.

## Basic File Operations

### Open File

Load a previously saved waveform file from disk.

Supported formats:

- TravelLogic Waveform Files (*.TLW)
- Logic Analyzer Waveform Files (*.LAW)

### Save File

Save the current capture to disk with the existing filename.

### Save As

Save with a new filename and optionally specify a storage range.

**Primary format:**

- **TravelLogic files (*.TLW)** - Native format with all settings preserved

**Additional formats:** For exporting to other formats, see [Export Data](export-data.md).

### Save All

Save all open Logic Analyzer and Protocol Analyzer windows to files at once.

**Use case:** Quickly save multiple captures from different windows in one operation.

---

## Import Data

### Import CSV

Convert digital or analog data stored in text format to TLW format for viewing and analysis.

**Location:** Toolbar → File → Import CSV

**Requirements:** Hardware device must be connected.

**Supported formats:**

#### 1. Agilent LA Module CSV Text File

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

#### 5. Custom Format

Import waveforms from other logic analyzers by arranging data according to the required format.

---

## File Format Reference

### Supported File Formats

**For opening:**

- *.TLW (TravelLogic Waveform): Native format with full settings
- *.LAW (Logic Analyzer Waveform): Legacy format

**For saving:**

- *.TLW (TravelLogic Waveform): Recommended format

**For importing:**

- Agilent LA Module CSV
- Tektronix TLA Data Exchange Format
- Generic LA Text Files
- DSO Text Files
- Custom formatted files

**For exporting:** See [Export Data](export-data.md) for VCD, MATLAB, binary, and other export formats.

---

## Tips And Best Practices

### Organizing Files

- Use descriptive filenames with dates (e.g., `i2c_sensor_2026-03-10.tlw`)
- Save reference waveforms for comparison
- Keep decode settings with waveforms using .TLW format

### Importing From Other Analyzers

- Check sample rate and time base compatibility
- Verify channel mapping before import
- Test with small files first to verify format
- Hardware device must be connected for CSV import

### File Compatibility

- .TLW files preserve all settings and decode configurations
- Use Save All to quickly backup multiple open windows
- Legacy .LAW files can be opened but should be saved as .TLW

---

## Related Topics

- [Export Data](export-data.md): Export waveforms and reports to various formats
- [Preferences](preferences.md): Configure working directory and auto-save behavior
- [Navigate the data](navigate-data.md): Save and recall channel label configurations
