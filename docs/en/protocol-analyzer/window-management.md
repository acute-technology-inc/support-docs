# Window management

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 24-25, Appendix 1 Pages 80-82 -->

Manage report views, bookmarks, and navigation tools for efficient analysis.

## Overview

Window management features help you navigate large protocol captures and organize data for analysis.

---

## Report lists

Select which report views to display.

### Available report lists

**Options:**

- **Report List:** Standard decode report
- **Show Both Report:** Display multiple report types simultaneously
- **Transition Report:** Show signal transition data (requires [Show Waveforms](show-waveforms.md))
- **Statistics:** Protocol-specific statistics
- **Custom views:** Protocol-dependent additional views

---

## Navigation controls

### Position controls

Use control buttons to navigate the report:

**Functions:**

- **First:** Jump to the first row
- **Previous:** Move to previous row
- **Next:** Move to next row
- **Last:** Jump to the last row
- **Go to row:** Input row number to jump directly to that position

**Keyboard alternatives:**

- **Home:** Jump to first row
- **End:** Jump to last row
- **Arrow keys:** Move up/down one row
- **Page Up/Down:** Scroll by page

---

### To bottom button

Move directly to the end of captured data.

**Static data:** Jumps to the last line

**During capture:** Displays the most up-to-date data in real-time

**Use cases:**

- Monitor live capture progress
- Check most recent protocol activity
- Verify capture is still running
- Jump to end of large capture

---

## Bookmark list

Mark important rows for quick reference.

### Adding bookmarks

**Methods:**

1. Select a row in the report
2. Click **Add to Bookmark List** button
3. The row is added to the bookmark list with its row number and key information

**Keyboard shortcut:** Check for available shortcut in your software version

### Using bookmarks

**Bookmark list displays:**

- Row number
- Key protocol information (address, data, status)
- Timestamp
- Any custom notes (if supported)

**Navigate to bookmarks:**

- Click on a bookmark entry
- Report jumps to that row
- Highlighted for easy identification

### Removing bookmarks

**Methods:**

1. Select bookmark in the bookmark list
2. Click **Remove from Bookmark List** button
3. Bookmark is deleted (captured data remains unchanged)

### Managing bookmarks

**Tips:**

- Add bookmarks as you analyze
- Use bookmarks to mark errors, interesting transactions, or key events
- Bookmarks persist when you save the file
- Review bookmark list to see overview of important events

---

## Report list advanced features

Detailed report list functionality for in-depth analysis.

### Display configuration

**Configure display:**

1. **Select display list:** Choose which report type to show
2. **Column selection:** Enable/disable specific columns
3. **Row filtering:** Show/hide specific transaction types
4. **Sorting:** Sort by column (if supported)

---

### Position tracking

**Row number display:**

Enable "Display row number in LA Decode Report" in system environment settings to show row numbers on the left side of the report area.

**Benefits:**

- Easy reference to specific transactions
- Better communication when discussing results ("see row 1523")
- Simpler bookmark management
- Easier navigation in large captures

---

### Search integration

The report list integrates with [Search](search.md) functionality:

**Workflow:**

1. Perform search
2. Search highlights matches in report list
3. Use search navigation to move between matches
4. Bookmark important search results for later reference
5. Clear search to return to normal view

---

## Statistics window integration

Access detailed statistics through the window management interface.

**Statistics features:**

- Protocol-specific traffic analysis
- Error rate calculation
- Transaction counts
- Timing statistics

**Click on statistic trace:**

- Summarizes all records of the selected trace
- Displays in statistic list window
- Allows detailed analysis of specific event types

See: [Detail & Statistics](detail-statistics.md)

---

## Multiple window workflow

### Working with multiple reports

**Common setup:**

1. **Main report:** Full decode report
2. **Bookmark list:** Important events
3. **Statistics window:** Traffic analysis
4. **Detail window:** Inspect specific transactions

**Layout tips:**

- Arrange windows for your workflow
- Use multiple monitors if available
- Save layout preferences (if supported)

---

### Cross-referencing

**Efficient analysis:**

1. Use statistics to identify issues
2. Bookmark interesting transactions
3. Navigate between bookmarks
4. Use search to find related transactions
5. Export relevant data for documentation

---

## Tips and best practices

### Bookmark strategy

**During capture analysis:**

- Bookmark first error
- Bookmark pattern changes
- Bookmark unexpected events
- Bookmark known-good transactions for comparison

**Review workflow:**

1. Scan statistics for anomalies
2. Bookmark anomalies
3. Use detail window to investigate
4. Search for related transactions
5. Document findings using notes or export

### Navigation efficiency

**For large captures:**

- Use "Go to row" for quick jumps
- Bookmarks for key positions
- Search for specific data
- To bottom for latest activity
- Statistics for overview before diving into detail

### Organization

**Keep captures organized:**

- Use meaningful bookmark names/notes
- Export bookmark lists with captures
- Document important row numbers in external notes
- Save captures with bookmarks for future reference
