# Operating modes

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 16-22 -->

Configure memory usage, stop conditions, and repetitive capture behavior.

## Memory settings

Control how much memory is used for capturing protocol data.

### Device memory usage

**Maximum device memory limit:**

- **Unchecked:** Uses the maximum available device memory
- **Checked:** Adjustable memory usage ratio
  - Allows limiting memory to speed up post-processing
  - Useful when full memory isn't needed

**Considerations:**

- More memory = longer captures
- More memory = longer processing time after capture
- Less memory = faster to process and display

---

### Trigger position

Set the percentage of memory used for pre-trigger vs. post-trigger data.

**Examples:**

- **0%:** All memory for post-trigger data (no pre-trigger)
- **20%:** 20% pre-trigger, 80% post-trigger
- **50%:** Equal pre and post-trigger data
- **80%:** 80% pre-trigger, 20% post-trigger
- **100%:** All memory for pre-trigger data (trigger at end)

**Use cases:**

- **0-20%:** Capturing what happens after a trigger event
- **50%:** Balanced view of activity before and after trigger
- **80-100%:** Capturing what led up to a trigger event

---

## Stop conditions

Configure when the capture automatically stops.

### Number of data lines

Stop capture when the stored data line count reaches the specified number.

**Configuration:**

- **Enabled:** Set target number of protocol transactions/packets
- **Disabled:** (Default) Capture until memory full or manual stop

**Use cases:**

- Need specific number of transactions (e.g., 1000 I2C packets)
- Avoid unnecessarily long captures
- Consistent test data size across multiple runs
- Automated testing with fixed packet counts

**Benefits:**

- Faster captures when you know how much data you need
- Prevents wasting time capturing more than necessary
- Simplifies post-processing when data size is predictable

---

### Maximum device memory limit

Stop capture when device memory fills to the specified limit.

**Default behavior:** Enabled in all modes

**Effect by capture mode:**

- **Protocol Analyzer:** Device stops when memory is full
- **Protocol Logger:** Stops when disk space limit is reached
- **Protocol Monitor:** Stops when device memory is full (or trigger condition met)

---

## Repetitive capture

Automatically repeat captures multiple times.

### Repetitive times setting

**Disabled (default):**

- Device stops after stop condition is met once
- Single capture per Start command

**Enabled:**

1. Device captures until stop condition is met
2. Saves captured data
3. Automatically starts next capture
4. Repeats for the specified number of times

**Set to 0:** Continuous repetitive capture (infinite loop)

- Captures continuously until manually stopped
- Each capture is saved separately
- Useful for long-term monitoring

---

### Repeat acquisition behavior

Control waveform decoding during repetitive captures.

**Options:**

1. **Don't display decoding:** Faster acquisition, analyze later
2. **Display with intervals:** Choose display time
   - 1 second
   - 2 seconds
   - 5 seconds

**Trade-off:**

- No display = Fastest capture rate
- Display = Slower but provides real-time feedback

---

## Mode-specific settings

### Protocol Analyzer mode

**Memory considerations:**

- Limited by RAM and device memory
- Real-time processing uses more resources
- Computer performance affects capture reliability

**Stop behavior:**

- May auto-stop if computer can't keep up with data rate
- Monitor memory usage during capture
- Reduce sample rate if auto-stopping occurs

---

### Protocol Logger mode

**Memory considerations:**

- Limited by hard disk space
- Can capture for very long durations
- Processing time proportional to capture size

**Additional option:**

**Run data process after capture stopped:**

- **Checked:** Automatically process .LOG file after stopping
  - Immediate analysis
  - Longer stop time

- **Unchecked:** Save .LOG file only
  - Faster stop
  - Analyze later by manually opening the .LOG file
  - Better for very large captures

---

### Protocol Monitor mode

**Memory considerations:**

- Limited to device memory only
- Circular buffer in some configurations
- Fixed maximum data size

**Wait modes:**

#### Wait for stop

**Data capture continues until "Stop" is pressed**

- Memory fills with latest data
- When memory is full, old data is overwritten (circular buffer)
- Press Stop when ready to retrieve data
- Always get the most recent activity

**Use case:** Capturing the moments before a system failure or user action

#### Wait for trigger

**Data capture continues until trigger condition is met**

**Without trigger condition set:**

- No Pre/Post trigger relationship
- Captures until memory is full
- Essentially same as "Wait for stop" without circular buffer

**With trigger condition set:**

Three post-trigger options:

1. **Fill the device memory then stop**
   - Respects trigger position percentage
   - Maximizes data capture
   - Fills all available memory

2. **Stop immediately**
   - Stops as soon as trigger occurs
   - Fastest response
   - Smaller data set
   - Useful when you only care about pre-trigger data

3. **Wait for seconds then stop**
   - Configurable time duration after trigger
   - Balance between immediacy and data completeness
   - Stops early if memory fills first

---

## Tips and best practices

### Choosing memory settings

**Use full memory when:**

- You don't know how much data you need
- Capturing intermittent issues
- Maximum data is desired

**Limit memory when:**

- You know exactly how much data is needed
- Fast post-processing is important
- Multiple repetitive captures are planned

### Repetitive capture strategies

**Use repetitive capture for:**

- Stress testing (capture same scenario multiple times)
- Detecting intermittent issues (capture until problem appears)
- Statistical analysis (collect multiple samples for averaging)
- Long-term monitoring (continuous overnight captures)

**Workflow example:**

1. Set repetitive times to 100
2. Set stop condition to 1000 packets
3. Start capture
4. System automatically captures 100 × 1000 packet sets
5. Analyze all captures for anomalies

### Stop condition combinations

**Fast known-size captures:**

- Enable "Number of data lines"
- Set to required packet count
- Disable memory limit (or set high)
- Result: Captures exactly what you need, stops quickly

**Long monitoring:**

- Disable "Number of data lines"
- Use Protocol Monitor "Wait for trigger"
- Set appropriate trigger condition
- Result: Efficient long-term monitoring with triggered capture
