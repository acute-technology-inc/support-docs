# Keyboard shortcuts

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 15 -->

Quick keyboard shortcuts for Protocol Analyzer operations.

## Available shortcuts

| Function | Key |
|----------|-----|
| Move to cursor position | A-Z |
| Add a cursor to the mouse position | Shift + A-Z |
| Start capture | Enter |
| Stop capture | ESC |
| Search | F3 or Ctrl+F |
| Zoom in on waveform area | Number Pad + |
| Zoom out on waveform area | Number Pad - |

**Note:** Cursor shortcuts only work when [Show Waveforms](show-waveforms.md) is enabled.

---

## Capture control

### Start capture

Press **Enter** to begin data capture with the current settings.

### Stop capture

Press **ESC** to stop an ongoing capture operation.

This is particularly useful in Protocol Logger and Protocol Monitor modes where captures may run for extended periods.

---

## Search

Press **F3** or **Ctrl+F** to open the search dialog.

The search function works in all Protocol Analyzer modes and allows you to:

- Find specific addresses
- Locate data values
- Search protocol fields
- Filter by packet type

Learn more: [Search operations](search.md)

---

## Cursor operations

**Requirements:** [Show Waveforms](show-waveforms.md) must be enabled for cursor operations.

### Navigation

Press any letter key (A-Z) to quickly jump to the corresponding cursor position in the waveform area.

### Adding cursors

Press Shift + any letter key (A-Z) to add a cursor at the current mouse position.

### Zoom operations

- **Zoom in:** Press **Number Pad +** to increase waveform magnification
- **Zoom out:** Press **Number Pad -** to decrease waveform magnification

Alternatively, use the mouse wheel:

- Scroll up to zoom in
- Scroll down to zoom out

---

## Tips

- The Enter/ESC keys work from anywhere in the application window
- Search (F3/Ctrl+F) is one of the most useful features for protocol analysis
- If cursor shortcuts don't work, verify that Show Waveforms is enabled
