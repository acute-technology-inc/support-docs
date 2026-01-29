# Search

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 24 -->

Search for specific protocol data, addresses, or patterns in the report window.

## Overview

The search function helps you quickly locate specific protocol transactions in captured data. This is particularly useful when analyzing large captures or looking for specific events.

---

## Search interface

Access the search function using:

- **Menu:** Click Search in the toolbar
- **Keyboard:** Press **F3** or **Ctrl+F**

---

## Search operation

### 1. Enter search text

Type the text, value, or pattern you're looking for.

**Search supports:**

- Text strings (for ASCII decode)
- Hexadecimal values (0x prefix or without)
- Decimal values
- Binary patterns
- Protocol-specific fields

**Examples:**

- Search for address: `0x50` or `50`
- Search for ASCII text: `ERROR`
- Search for specific data: `FF` or `255`

---

### 2. Navigate results

Use navigation buttons to move through search results:

- **Next:** Find the next matching item
- **Previous:** Find the previous matching item

**Keyboard shortcuts:**

- **F3:** Find next
- **Shift + F3:** Find previous (in some implementations)

---

### 3. Field specification

Narrow your search to specific fields for faster results.

**Search scope options:**

- **All fields:** Search across all columns in the report
- **Target fields:** Search only specific columns

**Available target fields (protocol-dependent):**

- Address column
- Data column
- Command/Type column
- Status column
- Custom decode fields

**Why specify fields?**

- **Faster search:** Reduced search range
- **More precise:** Avoid false matches in irrelevant fields
- **Better performance:** Especially important for large captures

---

## Search results

### Visual feedback

**Match found:**

- Matching data shown with **green background** color
- Total number of packets found is displayed
- Current match is highlighted

**No match found:**

- Search result shown in **orange background** color
- "No results found" message
- Verify search term and try again

---

### Result navigation

**Current match indicator:**

- Shows which match you're viewing (e.g., "3 of 15")
- Updates as you navigate with Next/Previous
- Report automatically scrolls to show current match

---

## Advanced search techniques

### Partial matching

The search typically supports partial string matching.

**Examples:**

- Search `AB` finds `ABCD`, `CAB`, `FFAB00`
- Search `ERR` finds `ERROR`, `PERROR`, `ERR_CODE`

### Case sensitivity

Check search dialog for case-sensitive option if available.

- **Case-insensitive (default):** `error` matches `Error`, `ERROR`, `error`
- **Case-sensitive:** `error` matches only `error`

### Multiple criteria

For complex searches:

1. Perform first search
2. Note results
3. Refine search term
4. Search again

**Tip:** Export to CSV and use spreadsheet tools for complex multi-criteria searches.

---

## Search use cases

### Find specific addresses

**I2C address search:**

```
Search: 0x50
Field: Address
Result: All transactions to/from device 0x50
```

### Locate error conditions

```
Search: NACK
Field: Status
Result: All transactions with NACK (Not Acknowledged)
```

### Find data patterns

```
Search: FF
Field: Data
Result: All transactions containing 0xFF
```

### Debug specific commands

**SPI command search:**

```
Search: 0x03
Field: Command
Result: All READ operations (command 0x03)
```

### Trace register access

```
Search: 0x1A
Field: Address
Result: All accesses to register 0x1A
```

---

## Performance tips

### For large captures

**Speed up searches:**

1. **Use field specification:** Don't search all fields if you know which field contains your data
2. **Be specific:** More specific search terms = fewer false matches
3. **Close unused windows:** Reduce system load
4. **Consider filtering:** Use [Hide Data](detail-statistics.md#hide-data-window) to filter before searching

### For repeated searches

**Workflow:**

1. Perform common searches
2. Note the row numbers
3. Use bookmarks ([Window Management](window-management.md)) to mark important results
4. Return to bookmarks instead of re-searching

---

## Common search scenarios

### Troubleshooting communication failures

**Find failed transactions:**

1. Search for error indicators: `NACK`, `ERR`, `FAIL`
2. Check address field for problem device
3. Use Previous to find the last successful transaction before failure

### Verifying protocol compliance

**Check for specific sequences:**

1. Search for initialization commands
2. Verify proper ordering
3. Check response codes

### Data validation

**Find specific data values:**

1. Search for expected data pattern
2. Verify correct transmission
3. Check for corruption or errors

---

## Limitations

- Search operates on displayed/decoded data only
- Raw waveform data is not searchable (use Logic Analyzer search for signal-level search)
- Very large captures may take time to search
- Search is sequential (not indexed)
