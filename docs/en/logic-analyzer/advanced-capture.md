# Advanced capture settings

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 56-58 -->

Configure advanced capture modes including asynchronous/synchronous operation and glitch filtering.

## Capture mode setting

Choose between timing-based and state-based capture modes.

---

### Asynchronous mode (Timing Analyzer)

Uses the device's internal clock as the sampling frequency.

**Sampling frequency guidelines:**

- **Recommended:** Set sampling frequency to about 10x the signal frequency
- **Minimum:** Not less than 5x the signal frequency
- **Warning:** Rates lower than 5x will cause signal distortion

**Sampling error:**

Asynchronous sampling introduces sampling error between actual capture and the signal. The error time equals the reciprocal of the sampling frequency.

**Qualifier mode:**

To increase signal capture frequency, add a qualifier:

1. Select CK0
2. Set a channel condition (0 or 1)

**Example:** When Chip Select is 0 to capture the signal:

- Select asynchronous mode (recorded when CK0 = 0)
- The qualifier condition filters captures to only when CK0 meets the condition
- Device automatically enables transitional storage mode

---

### Synchronous mode (State Analyzer)

Uses an external input clock as the sampling frequency.

**Configuration:**

- The CK0 channel on the signal line is the external clock input
- When the external clock stops, signal capture also stops
- Creates synchronous operation between device and external clock

#### Easy setting

CK0 is used as the input clock when configured for edge detection:

- Rising edge
- Falling edge
- Either edge

#### Advanced setting

Configure multiple edge conditions to sample simultaneously.

**How it works:**

Each edge condition set has two qualifier sets. Sampling occurs immediately when any qualifier is met.

**Example conditions:**

- CK0 ↑ → Sampling occurs immediately
- CK0 ↑ + CK2 = 0 → Sampling occurs immediately

This allows complex sampling conditions based on multiple signal relationships.

---

## Glitch filter settings

Filter unwanted noise and eliminate false logic states caused by signal quality issues.

---

### Hardware glitch filter

Filter out unwanted glitches and logical misjudgments caused by slow transitions.

**Characteristics:**

- Acts as a low-pass filter
- Filters **before** hardware triggering occurs
- Reminds users that glitches may indicate poor data transmission quality

**Filter range:** 5ns to 35ns

**Use with Stack Oscilloscope:**

Combine Logic Analyzer and Oscilloscope Stack to:

- Determine signal integrity
- Identify unexpected glitches
- Analyze analog characteristics of digital signals

**Visual indicator:**

Channels using the hardware glitch filter are marked with a **red dot** on the channel label for easy identification.

---

### Software glitch filter

Filter signals after capture without affecting trigger or timing.

**Filter range:** 1ps to 1ms

**Characteristics:**

- Changes display and decode contents only
- Does **not** affect triggering
- Does **not** affect recordable time
- Disabling the filter restores original un-filtered waveform

**Use cases:**

- Remove noise for clearer display
- Filter out known glitches during analysis
- Test decode with and without noise

**Advantages over hardware filter:**

- Wider filter range (1ps to 1ms vs. 5ns to 35ns)
- Non-destructive - original data is preserved
- Can be toggled on/off to compare results

---

## Choosing the right mode

### Use Asynchronous mode when:

- Measuring signals without a common clock
- Signal frequency is well-defined and stable
- You need timing-accurate measurements
- Working with independent signal sources

### Use Synchronous mode when:

- Measuring state-based systems
- External clock defines data validity
- Working with bus protocols with clock lines
- State transitions are more important than timing

### Use Hardware glitch filter when:

- Pre-filtering is required before triggering
- Working with noisy signals that affect triggers
- Filter range of 5ns-35ns is sufficient
- Signal quality is critical to capture

### Use Software glitch filter when:

- Post-capture filtering is preferred
- Need to preserve original data
- Want to compare filtered vs. unfiltered results
- Need very short (1ps) or very long (1ms) filter times
