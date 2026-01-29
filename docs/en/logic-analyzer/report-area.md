# Report area

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Page 64 -->

View channel states, bus decode results, and waveform statistics in the report area.

## Overview

The report area displays analysis results below the waveform area, providing detailed information about captured signals.

---

## Display options

### 1. Channel status

Display the current state or transition history of channels.

**Information shown:**

- Logic levels (0/1) for each sample
- Transition timestamps
- Value changes over time

---

### 2. Bus decode results

Display decoded protocol information from configured bus decoders.

**Display modes:**

- Individual bus decode reports
- Customized reports combining multiple decode results

**How to configure:** See [Bus Decode Settings](bus-decode.md)

---

### 3. Waveform data statistics

Calculate and display measurement values for selected channels.

---

## Waveform statistics

Perform automated measurements on signal characteristics.

### Configuration

1. **Select channel:** Choose which channel to measure
2. **Select measurement type:** Pick from available statistics (see below)
3. **Set range (optional):** Use cursors to limit measurement to a specific range
   - Default: Entire waveform area

---

### Available measurement types

| Measurement type | Description |
|------------------|-------------|
| **Period** | Time between consecutive rising (or falling) edges |
| **Frequency** | Number of cycles per second |
| **Edge count** | Total number of transitions |
| **Cycle count** | Total number of complete cycles |
| **Positive cycle count** | Number of high pulses |
| **Negative cycle count** | Number of low pulses |
| **Positive pulse count** | Count of positive pulses |
| **Negative pulse count** | Count of negative pulses |
| **Positive pulse width** | Duration of high pulses |
| **Negative pulse width** | Duration of low pulses |
| **Channel-to-channel rising delay** | Time from channel A rising to channel B rising |
| **Channel-to-channel falling delay** | Time from channel A falling to channel B falling |
| **Channel rising to channel falling delay** | Time from channel A rising to channel B falling |
| **Channel falling to channel rising delay** | Time from channel A falling to channel B rising |
| **Phase delay** | Phase relationship between two signals |

---

### Copy measurements

**Copy to other channels:**

Click and drag measurement items to copy the same measurement type to other channels.

**Result:** Multiple channels will show the same measurement type, each with their own values.

**Copy to same channel:**

Click and drag on the channel name to add multiple different measurement types to one channel.

**Result:** One channel displays multiple types of measurements.

---

## Report storage

### 4. Save report contents

Export report contents as text files for documentation or further analysis.

**Supported formats:**

- .CSV (Comma-Separated Values)
- .TXT (Plain text)

**What's included:**

- Decode results
- Timestamps
- Channel states
- Customized report columns

**How to save:** Click the save button in the report window toolbar.

---

## Tips and best practices

### Measurement range selection

- Use **cursors** to define the measurement range for more accurate statistics
- Measure only the relevant portion of long captures to avoid averaging effects
- Clear cursor selection to measure the entire waveform

---

### Efficient measurement workflows

**Compare multiple channels:**

1. Set up measurement type on first channel
2. Drag to copy to all channels you want to compare
3. Review results in report area

**Analyze single signal thoroughly:**

1. Drag multiple measurement types onto one channel name
2. View comprehensive signal characteristics
3. Export results for documentation

---

### Report organization

- Customize report columns using [Customized Report Settings](bus-decode.md#customized-report-settings)
- Show row numbers for easier reference (enable in system environment settings)
- Include timestamp information for precise time correlation
