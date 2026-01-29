# Timing check

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 66-77 -->

Automate timing verification by importing CSV files with test parameters and measurement specifications.

## Overview

The timing check function imports CSV files containing parameters and measurement items. The Logic Analyzer automatically configures channels, triggers, and measurements according to the specifications.

**Use cases:**

- Automated production testing
- Design verification
- Compliance testing
- Repeated measurement sequences

---

## Time sequence

Import CSV files to set up automated timing analysis and power sequence measurements.

**CSV file requirements:**

- Field names at the beginning of each section
- Comma-separated values
- Semicolon (;) at the end of each section
- Comments after double slash (//) are ignored

**To obtain sample files:** Contact Acute Technology support.

---

## Feature select

When loading a configuration file, the software prompts you to select which functions to apply:

- Set trigger conditions according to the CSV file
- Hide unused channels
- Configure measurement ranges
- Apply timing specifications

---

## CSV column items

### [SampleRate]

Set the sample rate for capture.

**Format:** Single line input

**Units:** MHz, KHz, Hz

**Range:** 100KHz to maximum (varies by channel count and trigger type)

**Note:** This setting affects both analog and digital sample rates. Use `[AnalogSampleRate]` and `[DigitalSampleRate]` to set them separately.

**Example:**

```
[SampleRate]
200MHz
;
```

---

### [DigitalSampleRate]

Set the digital sample rate independently.

**Format:** Single line input

**Units:** MHz, KHz, Hz

**Range:** 100KHz to maximum (varies by channel count and trigger type)

**Example:**

```
[DigitalSampleRate]
25MHz
;
```

---

### [ChannelNumber]

Specify the number of channels to use.

**Format:** Single line input

**Units:** None (just the number)

**Available channels depend on:**

- Sample rate
- Transitional storage mode enabled/disabled

**Channel availability table:**

| Sample rate | LA Non-Transition | LA Transition |
|-------------|-------------------|---------------|
| 2GHz (TL3234B+ only) | 0:3 (4 channels) | 0:2 (3 channels) |
| 1GHz | 0:7 (8 channels) | 0:5 (6 channels) |
| 500MHz | 0:15 (16 channels) | 0:11 (12 channels) |
| 250MHz, 200MHz | 0:31 (32 channels) | 0:23 (24 channels) |

**Example:**

```
[ChannelNumber]
24
;
```

---

### [RecordLength]

Set the recording memory depth.

**Format:** Single line input

**Units:** MB, Mb

**Range:** Minimum 16Mb, maximum varies by model

**Example:**

```
[RecordLength]
100Mb
;
```

---

### [TransitionalMode]

Enable or disable transitional storage mode.

**Format:** Single line input

**Units:** None (0 or 1)

**Example:**

```
[TransitionalMode]
1 // Transitional storage mode ON
;
```

---

### [Threshold]

Configure voltage thresholds for logic level detection.

**Format:** Multiple line input (one per channel group)

**Units:** mV, V

**Range:** ±5V (TL series)

**Note:** When Schmitt circuit is enabled, channels 16-31 become secondary threshold voltages.

**Example:**

```
[Threshold]
1.6V // Ch 00-07
1.5V // Ch 08-15
1.2V // Ch 16-23 or secondary for Ch00-07
2.5V // Ch 24-31 or secondary for Ch08-15
;
```

---

### [UseSchmittCircuit]

Enable Schmitt circuit threshold mode (TL series).

**Format:** Single line input

**Value:** 1 to enable, 0 to disable

**Effect:** When enabled, maximum available channels drops to 16, and channels 16-31 become secondary threshold references.

**Example:**

```
[UseSchmittCircuit]
1 // Input 1 to enable Schmitt circuit
;
```

---

### [Channel]

Define channels and their properties.

**Format:** Multiple line input (one per channel)

**Fields (in order):**

1. **Channel selection:** CH0 (digital), CH(A)0 (analog)
2. **Label:** Up to 31 alphanumeric characters
3. **Mode (optional):** TimingCheck, HwStrap, or TimingCheck+HwStrap
4. **Max voltage (optional):** For analog channels
5. **Min voltage (optional):** For analog channels

**Check modes:**

| Mode | Description |
|------|-------------|
| HwStrap | Channel only for hardware strap, hidden in timing check |
| TimingCheck | Channel only for timing check, hidden in H/W strap |
| TimingCheck+HwStrap | Available in both modes |

**Example:**

```
[Channel]
CH20, MyData0, HwStrap
CH22, MyData1, TimingCheck
CH24, MyData2, TimingCheck+HwStrap
;
```

---

### [Trigger]

Configure trigger conditions.

**Format:** Single line input

**Fields (in order):**

1. **Trigger channel label:** Reference to label defined in [Channel]
2. **Trigger type:**
   - CHANNEL_LOW
   - CHANNEL_HIGH
   - CHANNEL_ANY
   - CHANNEL_RISING
   - CHANNEL_FALLING
   - CHANNEL_CHANGING
3. **Mode (optional):** TimingCheck, HwStrap, or TimingCheck+HwStrap
4. **Voltage (optional):** For analog channels (MSO series), units: mV, V

**Example:**

```
[Trigger]
// For H/W Strap, trigger when MyData1 (Ch22) rises
MyData1, CHANNEL_RISING, HwStrap
// For Timing Check, trigger when MyData2 (Ch24) rises
MyData2, CHANNEL_RISING, TimingCheck
;
```

---

### [TriggerPosition]

Set trigger point position in memory.

**Format:** Single line input

**Range:** 1% to 99%

**Example:**

```
[TriggerPosition]
20% // Set trigger position to 20%
;
```

---

### [RangeStart]

Set measurement start position using cursor reference.

**Format:** Single line input

**Values:** CursorA through CursorZ

**Example:**

```
[RangeStart]
CursorS // Measurement starts from Cursor S
;
```

---

### [RangeEnd]

Set measurement end position using cursor reference.

**Format:** Single line input

**Values:** CursorA through CursorZ

**Example:**

```
[RangeEnd]
CursorE // Measurement ends at Cursor E
;
```

---

### [TimingCheck]

Define timing measurements and specifications.

**Format:** Multiple line input (one per measurement)

**Fields (in order):**

1. **Spec name:** For display only
2. **Description:** For display only
3. **Target CH A:** Reference to channel label from [Channel]
4. **Target CH B:** Reference to channel label from [Channel]
5. **Timing check type:** See table below
6. **Min limit:** Minimum acceptable value (use X for don't care)
7. **Max limit:** Maximum acceptable value (use X for don't care)

**Units for limits:**

- Timing: ns, μs, ms, s
- Voltage: mV, V
- Slew rate: mV/μs, mV/ms, V/μs, V/ms (default: mV/μs or V/μs)

**Example:**

```
[TimingCheck]
Spec_00, Desc_00, MyData0, MyData1, CHA_RISE_TO_CHB_RISE, 1ns, 10ms
Spec_01, Desc_01, MyData1, MyData2, CHA_FALL_TO_CHB_RISE, X, 100ms
Spec_02, Desc_02, MyData2, MyData3, CHA_FALL_TO_CHB_FALL, 100us, X
;
```

---

## Timing check types

### Channel-to-channel edge measurements

- **CHA_RISE_TO_CHB_RISE:** Time from first CH A rising edge to first CH B rising edge
- **CHA_RISE_TO_CHB_FALL:** Time from first CH A rising edge to first CH B falling edge
- **CHA_FALL_TO_CHB_RISE:** Time from first CH A falling edge to first CH B rising edge
- **CHA_FALL_TO_CHB_FALL:** Time from first CH A falling edge to first CH B falling edge

### Next edge measurements

- **CHA_RISE_TO_NEXT_CHB_RISE:** Time from first CH A rising edge to next CH B rising edge
- **CHA_RISE_TO_NEXT_CHB_FALL:** Time from first CH A rising edge to next CH B falling edge
- **CHA_FALL_TO_NEXT_CHB_RISE:** Time from first CH A falling edge to next CH B rising edge
- **CHA_FALL_TO_NEXT_CHB_FALL:** Time from first CH A falling edge to next CH B falling edge

### Previous edge measurements

- **CHA_RISE_TO_PREV_CHB_RISE:** Time from first CH A rising edge to previous CH B rising edge
- **CHA_RISE_TO_PREV_CHB_FALL:** Time from first CH A rising edge to previous CH B falling edge
- **CHA_FALL_TO_PREV_CHB_RISE:** Time from first CH A falling edge to previous CH B rising edge
- **CHA_FALL_TO_PREV_CHB_FALL:** Time from first CH A falling edge to previous CH B falling edge

### Farthest edge measurements

- **CHA_RISE_TO_FAREST_CHB_RISE:** Time from first CH A rising edge to farthest CH B rising edge
- **CHA_RISE_TO_FAREST_CHB_FALL:** Time from first CH A rising edge to farthest CH B falling edge
- **CHA_FALL_TO_FAREST_CHB_RISE:** Time from first CH A falling edge to farthest CH B rising edge
- **CHA_FALL_TO_FAREST_CHB_FALL:** Time from first CH A falling edge to farthest CH B falling edge

### Single channel measurements

- **CHA_HIGH_TIME:** Duration of high pulses
- **CHA_LOW_TIME:** Duration of low pulses
- **CHA_HIGH_PULSE_COUNT:** Count of high pulses
- **CHA_LOW_PULSE_COUNT:** Count of low pulses
- **CHA_RISE_EDGE_COUNT:** Count of rising edges
- **CHA_FALL_EDGE_COUNT:** Count of falling edges
- **CHA_EDGE_COUNT:** Total edge count

### Analog measurements (MSO series only)

- **CHA_SLEW_RATE:** Slew rate (rise or fall determined by reference voltage)
- **CHA_V_MAX:** Maximum voltage
- **CHA_V_MIN:** Minimum voltage
- **CHA_V_PP:** Peak-to-peak voltage
- **CHA_V_HIGH:** High level voltage
- **CHA_V_LOW:** Low level voltage
- **CHA_V_AMPLITUDE:** Voltage amplitude
- **CHA_V_MEAN:** Mean voltage
- **CHA_RISE_TIME:** Rise time
- **CHA_FALL_TIME:** Fall time

---

## Timing check report

After capture completes, the software analyzes results and displays Pass/Fail status for each measurement.

**Report features:**

- Visual Pass/Fail indicators
- Measured values vs. specifications
- Double-click to position cursors at measurement location

---

## Power sequence testing

Measure power-on or power-off sequences using timing check features.

**Typical workflow:**

1. Define voltage thresholds for each power rail
2. Set trigger on first power rail
3. Measure time to subsequent power rails
4. Verify against specifications
