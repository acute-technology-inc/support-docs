# Bus decode settings

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 65 -->

Configure bus protocol decoding and create customized decode reports.

## Bus decode settings

For detailed information about bus trigger and decoder configuration, please refer to the **Acute_DeTrig_en.PDF** manual.

This separate manual provides comprehensive documentation for:

- Protocol-specific decode parameters
- Trigger conditions for each bus type
- Advanced decode options
- Bus timing requirements

---

## Customized report settings

Create custom decode reports by combining columns from multiple bus decoders.

### Overview

All bus decoders enabled in the waveform area appear in the customized report settings window. Select columns from each decoder to combine them into a unified custom report.

---

### Configuration steps

1. **Enable bus decoders:** Add and configure the bus decode channels you need in the waveform area

2. **Open settings:** Access the customized report settings dialog

3. **Select columns:** Choose which columns to include from each bus decoder report
   - Address columns
   - Data columns
   - Control signal columns
   - Status information
   - Timing information

4. **Preview:** The preview window shows how many columns you've selected and displays the combined report structure

5. **Apply:** Create your customized report with the selected columns

---

### Requirements

**Important:** Bus decoders must be set up correctly to fetch the proper column names for the customized report.

**Setup checklist:**

- Configure protocol type correctly
- Assign correct channels to bus signals
- Set appropriate decode parameters
- Verify decode is working before creating custom report

---

## Report customization use cases

### Combine multiple protocols

**Example:** I2C + SPI combined report

- Show I2C address and data
- Show SPI chip select and data
- Correlate timing between buses

**Benefits:**

- Single view of multi-bus systems
- Easier correlation between protocols
- Simplified export for documentation

---

### Focus on specific data

**Example:** Filter to essential columns only

- Remove redundant status columns
- Keep only address and data
- Simplify report for specific analysis

**Benefits:**

- Cleaner, more focused reports
- Faster visual scanning
- Reduced exported file size

---

### Create standardized reports

**Example:** Team-standard report format

- Same columns across all test setups
- Consistent naming and order
- Easier comparison between tests

**Benefits:**

- Team consistency
- Easier review and collaboration
- Standardized documentation

---

## Report display options

### Show row numbers

Enable row numbers in the system environment settings to display line numbers on the left side of the report area.

**Benefits:**

- Easier reference to specific transactions
- Better communication when discussing results
- Simpler navigation in large reports

---

### Timestamp formats

Choose timestamp display format in system environment settings:

- **Timing info format:** Relative time from trigger
- **Timing info with date/time:** Absolute timestamp (trigger at 0s)
- **Sample count format:** Sample number instead of time

---

## Export custom reports

Save customized reports using standard export functions:

- Individual file export (current window)
- Batch report export (multiple files)
- CSV or TXT format

See: [File Operations - Report Storage](file-operations.md#batch-operations)
