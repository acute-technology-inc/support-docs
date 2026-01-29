# Capture settings

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 42-55 -->

Configure capture parameters including quick settings, triggers, memory usage, and thresholds.

## Operating steps

Follow this sequence for configuring a capture:

**Quick Setting** → **Trigger** → **Sample Rate** → **Memory** → **Threshold**

---

## Quick setting

Immediately configure required channels and related settings. When configuring specific bus decode, the sampling rate and threshold are automatically set according to default conditions.

This feature provides preset configurations for common protocols, saving time on manual setup.

---

## Trigger parameter setting

### Manual trigger

After setup, click the **Stop** button to manually set the trigger point in the captured data.

---

### Single level trigger

Configure a simple trigger based on channel states.

**Configuration options:**

1. **Channel / Label:** Select trigger conditions for each channel:
   - **X** - Don't care
   - **↑** - Rising edge
   - **↓** - Falling edge
   - **0** - Low level
   - **1** - High level
   - **Either** - Any edge
   - **Specified value** - Exact binary pattern

2. **Pass count:** Number of matching trigger events to ignore before triggering. Default is 0 (trigger on first match).

---

### Multi-level trigger

Create complex trigger conditions using multiple stages (up to 16 states).

**Configuration:**

Each state is configured like a single-level trigger. States can be connected with:

- **Next IF** - Continuous trigger (signals must match on adjacent sample clocks)
- **Then IF** - Non-continuous trigger (signals can match with any number of samples between)

**State relationship diagram:**

The software displays the current trigger condition flow, showing which states are continuous and which are non-continuous.

**Continuous vs. non-continuous triggers:**

**Continuous trigger:**

- Signals captured by two adjacent sample clocks must meet the conditions
- Typically used with synchronous or state mode measurements
- Signals are in a continuous, predictable state

**Non-continuous trigger:**

- Triggers when both conditions are met, regardless of signals between them
- Suitable for asynchronous or timing mode
- Ideal when edge transitions must meet conditions but intermediate states don't matter

**Additional options:**

3. **Trigger condition area:** Set the trigger condition for each class
4. **OR IF:** Establish parallel trigger conditions. Any matching condition will trigger
5. **Sequence by:** Set incidental trigger conditions based on edge transitions

**Sequence by example:**

If signal data is valid only when the clock is rising, you can:

- Set Sequence by to **Custom Rising**
- Select the Clock pin as the valid condition
- Set conditions for other data lines using multi-level triggering

**Note:** Sequence by function is only supported when sampling frequency is ≤ 250 MHz.

**Limitation:** Multi-level triggering is not supported when sampling frequency is ≥ 2 GHz.

---

### Width trigger

Trigger when a channel meets the trigger condition and the pulse width matches the specified length.

---

### Timeout trigger

Trigger when a signal duration exceeds the set time value, without waiting for a complete pulse.

---

### External trigger

Use the device's **Trig-In** input pulse signal as the trigger condition.

---

## Device memory usage

Configure how much device memory to use for capture.

**Settings:**

1. **Device memory usage:** Set storage depth for capturing data. Capture stops when the limit is reached
2. **Recordable time:** Estimated length of actual capture waveform based on current settings
   - **Note:** Time estimation is disabled when using transitional storage mode
3. **Memory / Channel:** Device allocates available memory based on the number of channels selected
   - Fewer channels = more memory per channel
4. **Trigger position:** Set trigger point location in memory using percentage
   - **Example:** 50% means up to 50% of device memory stores pre-trigger data
5. **Capture stop condition:** Configure when the capture automatically stops

---

## Threshold

Configure voltage thresholds that determine logic levels for captured signals.

### Threshold settings

**Definition:**

- Signal voltage **above** threshold = Logic High (1)
- Signal voltage **below** threshold = Logic Low (0)

**Recommendation:** Set threshold to half of the signal voltage for optimal results.

**Quick setting:** Select commonly used voltage levels from preset options, then fine-tune as needed.

---

### Schmitt circuit threshold mode

Use two threshold levels to eliminate noise and signal jitter.

**Why use Schmitt circuit mode?**

When using a single threshold and the voltage is close to the threshold during signal transition, the device may capture ambiguous 0 or 1 states. This causes viewing difficulties.

**Hardware surge filter limitations:**

A hardware surge filter (low-pass filter) can filter noise but may also filter true signals or high-frequency components, making it unsuitable for this problem.

**Schmitt circuit solution:**

Uses two sets of thresholds to create hysteresis on the voltage signal, eliminating noise interference and solving signal jitter.

**Configuration:**

When using Schmitt circuit functions:

- Both channels must be used for measurements
- Each measurement point requires two test lines to form two threshold sets
- Either threshold can be Threshold-High or Threshold-Low

**Channel pairing:**

- First threshold set: A0-A15
- Second threshold set: A16-A31
- Pairing: A0↔A16, A1↔A17, A2↔A18, etc.

**Logic judgment rules:**

- Signal must **exceed Threshold-High** to become logic 1
- Signal must drop **below Threshold-Low** to become logic 0
- Signals between thresholds remain in the non-transposed area, maintaining last logical state

---

### Set individual threshold on each tip

Enable the checkbox to adjust the threshold of each probe tip individually. Click the value button to directly type the desired value.

This allows fine-tuning thresholds for signals with varying voltage levels across different channels.
