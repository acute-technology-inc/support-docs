# Cursor operations

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 59-61 -->

Place cursors for time measurements and search through waveforms efficiently.

## Overview

The cursor system allows precise time interval and frequency measurements, as well as sophisticated waveform searches.

**Special-purpose cursors:**

- **T cursor:** Marks the trigger point (cannot be repositioned)
- **B cursor:** Dedicated search cursor

---

## Move to

Quickly jump to specific positions in the waveform area.

**Available positions:**

- **Waveform start:** Move to the beginning of the captured waveform
- **First transition:** Move to the first waveform transition on any channel
- **First transition on selected label:** Move to the first transition of a specific channel
- **Waveform end:** Move to the end of the captured waveform
- **Last transition:** Move to the last waveform transition on any channel
- **Last transition on selected label:** Move to the last transition of a specific channel
- **Trigger position:** Move to the trigger point (T cursor)
- **Cursor A-Z:** Move to any named cursor position

---

## Waveform search

Find specific signal patterns using four search modes.

### 1. By edge

Move the cursor based on the number of edges on a specified channel.

**Configuration:**

- **Edge type:** Rising / Falling / Either
- **Edge count:** 1 to 4096 edges
- **Channel:** Select which channel to count edges on

**Search direction:** Forward or backward from current cursor position

---

### 2. By time

Move the cursor forward or backward by a specified time amount.

**Configuration:**

- **Time amount:** Enter time value with units (ns, μs, ms, s)
- **Direction:** Forward or backward

**Use cases:**

- Jump to a specific time offset from a known point
- Measure periodic signals by jumping in time increments

---

### 3. By value match

Search for specific data values on channels or buses.

**How it works:**

- **Protocol channels:** Uses text comparison for search
- **Bus/Channel data:** Uses numerical comparison for search

**Configuration:**

- Select target channel or bus
- Enter value to match
- Choose search direction

**Search direction:** Forward or backward from current cursor position

---

### 4. Search pulse width

Find pulses meeting specific width criteria on selected channels.

**Configuration:**

- **Channel:** Select which channel to analyze
- **Condition:** Minimum and/or maximum pulse width
- **Width range:** Specify time range with units

**Operation modes:**

- **Single-cursor movement:** Find next/previous matching pulse
- **Multiple-cursor movement:** Mark all matching pulses automatically

**Search starting point:** Current position of the selected cursor

---

## Cursor management

### Adding cursors

**Method 1: Click button**

Click the **Add Cursor** button in the toolbar to add a cursor at the current mouse position.

**Method 2: Keyboard shortcut**

Press **Shift + [A-Z letter]** to add a cursor at the mouse position.

**Automatic naming:** Cursors are automatically named A through Z in the order they're created.

---

### Deleting cursors

Click the **Delete Cursor** button in the toolbar to remove the selected cursor.

**Note:** Special cursors T (trigger) and B (search) cannot be deleted.

---

## Cursor movement methods

### 1. Mouse drag

Click and drag the cursor sign or cursor line at the top of the waveform window to reposition the cursor.

---

### 2. Keyboard navigation

Press **A-Z** keys to quickly jump to the corresponding cursor location.

**Example:**

- Press **A** to jump to cursor A
- Press **B** to jump to cursor B
- Press **T** to jump to the trigger point

---

### 3. Keyboard placement

Press **Shift + [A-Z letter]** to move an existing cursor to the mouse position, or create a new cursor if it doesn't exist.

**Advantage:** No dragging required - places cursor precisely at mouse location.

---

## Measurement display

The frequency/time display bar at the bottom right shows measurement values between cursors.

**Displayed information (left to right):**

1. **Interval time:** Time between the selected cursor and the reference cursor
2. **Frequency calculation:** 1 / interval time
3. **Sampling statistics:** Number of samples between cursors

**Cursor selection:**

Click the cursor name in the measurement display to switch between cursors.

**Multiple measurements:**

You can configure the maximum number of cursor measurement groups (3-10) in system environment settings.

---

## Tips and best practices

### Efficient cursor usage

- Use **Shift + letter** shortcuts to quickly place multiple cursors without clicking toolbar
- Name cursors strategically (e.g., A and B for pulse width, C and D for period)
- Use the B cursor for searches to preserve your other measurement cursors

### Measurement workflows

**Measure pulse width:**

1. Place cursor A on rising edge
2. Place cursor B on falling edge
3. Read interval time in measurement display

**Measure frequency:**

1. Place cursor A on first rising edge
2. Place cursor B on next rising edge
3. Read frequency calculation in measurement display

**Measure duty cycle:**

1. Measure pulse width (high time)
2. Measure period (full cycle)
3. Calculate: Duty cycle = (high time / period) × 100%
