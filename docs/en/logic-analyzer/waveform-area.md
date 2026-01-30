# Waveform area

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 62-63 -->

Display, navigate, annotate, and manage channel labels in the waveform viewing area.

## Basic operations

### 1. Drag waveform

Use the left mouse button to drag and pan the waveform in the waveform display area.

**Usage:** Click and hold the left button, then move the mouse to scroll horizontally through the captured data.

---

### 2. Zoom waveforms

**Mouse wheel:**

- Scroll up to zoom in
- Scroll down to zoom out

**Toolbar button:**

Click the zoom in/out buttons on the screen for step-by-step magnification changes.

**Keyboard shortcut:**

- Press **Number Pad +** to zoom in
- Press **Number Pad -** to zoom out

---

### 3. Add text / graphic annotations

Add notes and visual markers directly in the waveform area to document important signals or conditions.

**Annotation types:**

- Text labels
- Graphic markers
- Notes at specific time positions

**Use cases:**

- Mark important events or anomalies
- Document test conditions
- Add reminders for later analysis

---

### 4. Quick calculation function

Right-click and drag in the waveform display area to select a region for quick analysis.

**Displayed information:**

- Number of signal transitions in the selected interval
- Length of time (duration)
- Average frequency

**Availability:** This function works in both Logic Analyzer and Protocol Analyzer modes.

---

## Label management

### 5. Add/Delete waveform labels

Manage channels, buses, and protocol decoders in the waveform area.

#### Add labels

Add individual channel labels to display specific signals.

**Operation:** Click the **Add Label** button to create a new channel display.

---

#### Add parallel bus

Group multiple channels into a parallel bus for easier viewing.

**Benefits:**

- View multiple signals as a single hex/binary value
- Reduce visual clutter
- Interpret multi-bit data more easily

---

#### Add protocol decode

Configure bus protocol decoding for supported protocols.

**Supported protocols include:**

- I2C, SPI, UART
- I3C, CAN, LIN
- And many more (see [Specifications](../specification/specifications.md))

**Configuration:** Click the gear icon on the protocol label to access advanced decode settings.

---

#### Label save/recall

Save and load channel configurations for reuse across captures.

**Save:** Store current channel settings, labels, buses, and decode configurations

**Recall:** Load previously saved channel configurations

**Benefits:**

- Quickly set up recurring test configurations
- Share configurations with team members
- Standardize test setups across projects

---

#### Import channel label from CSV file

Import channel names and numbers from a CSV file.

**CSV format example:**

```
CH0,Clock
CH1,Data
CH2,Enable
CH5,CS
```

**Note:** This feature can only import channel names and numbers. It cannot import parallel bus configurations or protocol decode settings.

---

## Channel label operations

### Combine labels

Select and drag one channel label onto another to combine two or more channels.

**Requirement:** Enable "Label Combine by Mouse Dragging" in system environment settings.

**Use cases:**

- Create parallel buses manually
- Group related signals
- Simplify complex signal displays

---

### Configure label settings

Click the left mouse button on a channel label to open parameter settings:

- Channel name
- Display format (binary, hex, decimal)
- Bus grouping
- Signal polarity

---

### Advanced protocol settings

For bus decode channels, click the gear button on the top-right corner of the label to access advanced parameter settings:

- Protocol-specific options
- Decode filtering
- Custom report columns

---

## Display optimization

### Adjust channel height

Change the height of individual channels or all channels:

- Drag the channel label border to resize
- Set default height in system environment settings
- Expand important signals for better visibility

---

### Color coding

**Expanded waveform color:**

Enable different colors for each channel in system environment settings for easier visual distinction.

---

### Information overlays

Enable/disable display overlays in system environment settings:

- **Channel information:** Show channel numbers
- **Value information:** Display 0/1 for digital, voltage for analog
- **Trigger information:** Show trigger setting values
- **Channel activity:** Display edge transition counts
