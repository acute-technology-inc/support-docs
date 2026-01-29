# Detail and statistics

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 25-26 -->

Inspect detailed protocol data and analyze traffic statistics.

## Detail window

View complete details of protocol transactions with large amounts of data.

### Overview

Many protocols contain extensive numerical data that isn't suitable for display in the main report window. The detail window provides expanded views of this data.

---

### Opening detail view

**Method:**

1. Click on a row in the main report window
2. Click on the **Data** column specifically
3. The complete data is displayed in the detail window

**What's displayed:**

- Full data payload
- Formatted display (hex, decimal, ASCII, etc.)
- Complete packet structure
- Multi-byte data properly formatted
- Any overflow data not shown in main report

---

### Use cases

**Large data transfers:**

- I2C EEPROM reads with 256+ bytes
- SPI flash page reads
- UART data streams
- CAN extended frames

**Complex protocol structures:**

- Nested protocol data
- Multi-level decode
- Sub-protocol details
- Payload interpretation

**Data verification:**

- Confirm complete data transmission
- Check for data corruption
- Verify checksums or CRC
- Compare against expected values

---

## Statistics window

Analyze protocol traffic patterns and characteristics.

### Overview

Statistics provide high-level analysis of protocol behavior across the entire capture. Different protocols offer different statistics based on their characteristics.

---

### Accessing statistics

**Method:**

1. Click on **Window** menu
2. Select **Statistics**
3. Statistics window displays protocol-specific analysis

---

### Common statistics

**Traffic analysis:**

- Total transaction count
- Transactions per second
- Read vs. write ratios
- Address distribution

**Error analysis:**

- NACK count
- Timeout occurrences
- CRC/checksum errors
- Protocol violations

**Timing statistics:**

- Average transaction duration
- Maximum/minimum times
- Idle time percentage
- Bus utilization

**Data analysis:**

- Data rate (bytes/second)
- Average payload size
- Data distribution patterns
- Protocol command frequencies

---

### Using statistics

#### Identify issues

**High-level problem identification:**

- Unusual error rates
- Performance bottlenecks
- Unexpected traffic patterns
- Protocol violations

**Example workflow:**

1. Open statistics window
2. Notice high NACK rate on specific address
3. Use search to find NACK transactions
4. Bookmark problematic transactions
5. Investigate with detail window

---

#### Trace selection

**Click on statistic trace:**

- Summarizes all records of the selected trace type
- Displays in statistic list window
- Shows detailed breakdown of that event type

**Example:**

- Click on "Address 0x50" statistic trace
- See all transactions to/from address 0x50
- Analyze pattern for that specific device

---

### Protocol-specific statistics

Different protocols provide relevant statistics:

**I2C:**

- Address usage distribution
- Clock stretching occurrences
- START/STOP condition count
- ACK/NACK ratios per address

**SPI:**

- Chip select assertion count
- Data transfer sizes
- Clock frequency distribution
- CS idle time

**UART:**

- Baud rate accuracy
- Parity errors
- Framing errors
- Break conditions

**CAN:**

- Message ID distribution
- Error frame count
- Bus load percentage
- Retransmission statistics

---

## Hide Data window

Filter the display to focus on relevant data.

### Overview

Use the Hide Data function to temporarily remove data items from view, making it easier to focus on specific protocol activity.

---

### Hiding data

**Method:**

1. Open Hide Data window
2. Select data items to hide
3. Apply filter
4. Report display updates to show only non-hidden items

**What can be hidden:**

- Specific addresses
- Transaction types
- Error conditions
- Specific protocols (in multi-protocol captures)

---

### Restoring data

**Method:**

1. Open Hide Data window
2. Click **Clear** button
3. All hidden data reappears in report

**Important:** Hide Data is a display filter only. Hidden data is still in the capture and can be unhidden at any time.

---

### Use cases

**Focus analysis:**

- Hide known-good traffic to see errors
- Hide initialization sequence to focus on operational phase
- Hide high-volume addresses to see low-traffic issues
- Hide specific command types to analyze others

**Example workflow:**

1. Capture shows heavy traffic from address 0x50
2. Hide address 0x50 transactions
3. Other addresses become visible
4. Analyze low-traffic devices without distraction
5. Clear hide filter to see complete picture again

---

## Saving reports

Export detailed reports for documentation and further analysis.

### Save as text file

Contents of the report, detail, and statistics windows can be saved.

**Supported formats:**

- **.TXT** - Plain text format
- **.CSV** - Comma-separated values (import to Excel/spreadsheet)

---

### Save options

1. **Save scope:**
   - Entire capture
   - Selected rows only
   - Specified row range

2. **Advanced reports:**
   - **Enabled:** Include detailed data from detail window
   - **Disabled:** Main report data only

3. **Timestamp options:**
   - **Combined:** Timestamp and duration in one column
   - **Split:** Separate timestamp and duration columns

4. **Byte limit:**
   - Maximum saving byte per column
   - Prevents excessive column width in exports

---

### Export workflow

**For documentation:**

1. Analyze capture, bookmark key events
2. Hide irrelevant data
3. Export visible data to CSV
4. Open in spreadsheet for formatting
5. Include in test report or documentation

**For sharing:**

1. Capture and analyze data
2. Export to CSV or TXT
3. Share file with team members
4. Recipients can import to their tools for analysis

---

## Tips and best practices

### Detail window

- Keep detail window open during analysis
- Use it to verify main report interpretations
- Compare detail view with expected protocol format
- Check for truncation in main report

### Statistics

- Review statistics first before diving into details
- Use statistics to guide where to look closer
- Export statistics for trend analysis across multiple captures
- Compare statistics between captures to spot changes

### Hide Data

- Use hide data liberally - it's non-destructive
- Try hiding different combinations to see patterns
- Always clear hide filter before final export
- Document what was hidden in analysis notes

### Saving reports

- Export regularly during long analysis sessions
- Save with meaningful filenames (include date, test ID)
- Consider CSV format for maximum flexibility
- Include both summary and detail reports in documentation
