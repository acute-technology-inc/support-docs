# Export Data

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 31-40 -->

Export captured waveforms and decode reports to various formats for documentation, analysis, and signal regeneration.

## Export Waveform Files

### Save As Export Formats

Save captured waveforms in various formats for different purposes.

**Available formats:**

1. **TravelLogic files (*.TLW)** - Native format with all settings preserved
2. **Transitional text file (*.txt)** - Transition-only data (reduced file size)
3. **Text file (*.txt)** - Full data export
4. **MATLAB array file (*.m)** - For MATLAB analysis and processing
5. **Binary data file (*.bin)** - Raw binary format
6. **TravelLogic files + Report file (*.TLW + *.TXT)** - Waveform and decoded report together
7. **Value Change Dump (*.vcd)** - Standard VCD format for simulation tools and waveform viewers
8. **Timestamp binary file (*.bin)** - Time-stamped binary data with options:
   - 64-bit time + 16-bit data
   - 64-bit time + 32-bit data
   - 64-bit time + 64-bit data
   - 64-bit time + 128-bit data

**Timestamp binary format:**

The first 64 bits represent time, and the remaining bits represent data. Data direction is from LSB to MSB (left to right).

**Note:** If you choose a data bit format with fewer bits than the number of channels, extra bits will be discarded.

**Storage range options:**

When using Save As, you can optionally specify a storage range to export only a portion of the captured data:

- Full waveform
- Cursor range only
- Custom time range

---

## Export To Pattern Generator

### Save As DGW / PGV File

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

**Use cases:**

- Replaying captured signals for testing
- Creating test patterns from real-world signals
- Debugging with known-good waveforms
- Generating stimulus signals for verification

---

## Export Decode Reports

### Save Report Contents

Export bus decode results and statistics as text files for documentation or further analysis.

**How to export:**

1. Navigate to the report area below the waveform
2. Click the save button in the report window toolbar
3. Choose format and location

**Supported formats:**

- .CSV (Comma-Separated Values): For spreadsheet analysis
- .TXT (Plain text): For documentation

**What's included:**

- Decode results
- Timestamps
- Channel states
- Customized report columns
- Statistics (if configured)

See: [Bus Decode Settings](bus-decode.md#customized-report-settings) for customizing report columns before export.

---

## Batch Export Operations

### Batch Report Save

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

**Use cases:**

- Processing multiple test runs at once
- Generating reports for production logs
- Batch conversion for archival
- Creating standardized reports from multiple captures

---

## Export Best Practices

### Choosing The Right Format

**For analysis in other tools:**

- Use .VCD for waveform viewers (GTKWave, etc.)
- Use .CSV for spreadsheet analysis
- Use .MATLAB for signal processing

**For documentation:**

- Use .TXT for readable reports
- Use .TLW + .TXT for complete archives
- Include timestamps for traceability

**For signal regeneration:**

- Use .DGW/.PGV for Acute pattern generators
- Export cursor range to focus on specific events
- Consider idle optimization for long captures

### File Size Management

**Large captures:**

- Use transitional text format to reduce file size
- Export only cursor range when possible
- Use binary formats for efficient storage

**Batch operations:**

- Process files during off-hours for large batches
- Use consistent decode settings for easier comparison
- Combine reports when analyzing related captures

---

## Related Topics

- [File Operations](file-operations.md): Open and save waveform files
- [Report Area](navigate-report.md): Configure report display before export
- [Bus Decode](bus-decode.md): Set up decode before exporting reports
