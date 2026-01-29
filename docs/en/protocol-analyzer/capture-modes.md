# Capture modes

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 16-22 -->

Protocol Analyzer offers three distinct capture modes, each optimized for different analysis scenarios.

## Mode comparison

| Feature | Protocol Analyzer | Protocol Logger | Protocol Monitor |
|---------|------------------|-----------------|------------------|
| **Real-time display** | Yes | No | No |
| **Data processing** | During capture | After capture | After capture |
| **Memory limit** | RAM + Device | Hard disk | Device only |
| **Best for** | Interactive debug | Long captures | Event monitoring |
| **PC performance** | High | Medium-High | Low |

---

## Protocol Analyzer

Real-time capture with immediate protocol decode and display.

### Functional description

Captured data is sent back to the PC for real-time display. You can see the protocol data immediately as it's being captured.

### Advantages

1. **Immediate visibility:** Data appears in real-time
2. **Small captures:** No need to set memory limits for short tests
3. **Interactive:** See results while capture is running

### Considerations

- **Higher USB performance required:** Data transfer and processing happen simultaneously
- **Computer performance:** May slow down during capture if the PC can't keep up
- **Auto-stop on memory full:** If the computer can't process data fast enough, the device may automatically stop

### Rules for repetitive captures

**Repetitive times:**

- **Disabled:** Device stops after stop condition is matched
- **Enabled:** After stop condition, device saves data and repeats capture for the specified number of times
- **Set to 0:** Continuous repetitive capture

**Stop conditions:**

Two automatic stop conditions are available:

1. **Number of data lines:** Stop when the stored data line count matches the setting
   - Use when you need a specific number of protocol transactions
   - Avoids unnecessarily long captures
   - Default: OFF

2. **Maximum device memory limit:** Stop when device memory reaches the set limit
   - Prevents memory overflow
   - Adjustable memory usage percentage

### Best practices

- Use for quick protocol debugging
- Monitor burst traffic patterns
- Verify basic protocol functionality
- Check for immediate errors or unexpected behavior

---

## Protocol Logger

Capture to disk without real-time processing. Data is saved and analyzed later.

### Functional description

Data is sent back to the PC for saving without being processed or displayed. Only after you press Stop will the data begin to be processed and displayed.

### Advantages

1. **Large captures:** As long as the hard disk is big enough and fast enough, you can save vast amounts of data
2. **Deferred analysis:** Logger files (.LOG) can be opened for analysis later
   - No need to analyze immediately after capture
   - Save captures for future reference
   - Share captures with team members

### Considerations

- **High USB and disk performance required:** Continuous high-speed data streaming
- **Large data requirements:**
  - Significant hard disk space needed
  - Long analysis time after capture
  - Processing may take time proportional to capture length

### Run data process after capture

**Option:** Run data process after logger capture stopped

- **Checked:** Software analyzes data immediately after stopping
- **Unchecked:** Software only saves the logger data without analysis
  - Faster capture termination
  - Analyze later by reloading the .LOG file

**File format conversion:**

When you analyze the data (immediately or later), the filename converts from .LOG to .TLW format.

### Best practices

- Use for long-duration captures (hours/days)
- High-speed protocol analysis where real-time decode isn't possible
- Capturing intermittent issues that occur over time
- Production environment monitoring

**Hard disk recommendations:**

- SSD for best performance
- At least 10GB free space per hour of capture (varies by protocol speed)
- Fast, dedicated disk if possible

---

## Protocol Monitor

Capture to device memory with trigger-based or manual retrieval.

### Functional description

Data is kept in the device and overwrites old data without returning to the PC. Capture can be stopped manually or by trigger condition. Then the device fills its memory and returns data to the PC for display.

### Advantages

1. **Reduced PC load:** During capture, data doesn't return to the PC, minimizing performance requirements
2. **Fixed data size:** Total data equals device memory capacity
3. **Long-term monitoring:** Trigger conditions can monitor for extended periods
   - Memory only fills when trigger conditions are met
   - Efficient for rare events

### Considerations

**Manual stop required if:**

- Trigger is not set, OR
- Trigger is set but you want data before memory fills

Press **Stop** to send data back to the computer.

### Work options

#### Maximum device memory limit

- **Unchecked:** Uses maximum device memory
- **Checked:** Adjustable memory usage ratio
  - Less memory = shorter subsequent processing time
  - Useful when you don't need full memory capacity

#### Wait for stop

**Data capture will continue until "Stop" is pressed**

- Data capture continues
- When memory is full, new data replaces old data (circular buffer)
- Press Stop when ready
- Newest data is sent back to computer

**Use case:** Capturing the most recent activity before a known event

#### Wait for trigger

**Data capture will continue until the trigger condition is met**

**Without trigger condition:**

- No Pre/Post trigger relationship
- Shows "Capturing..." until device memory is full

**With trigger condition:**

Configure post-trigger behavior:

1. **Fill the device memory then stop:** Fill remaining memory according to trigger position, then stop
   - Respects pre/post-trigger ratio
   - Maximum data capture

2. **Stop immediately:** Stop capturing immediately when triggered
   - Fastest response
   - Remaining memory is not filled
   - Smaller data set

3. **Wait for seconds then stop:** Continue capturing for specified time after trigger
   - Configurable duration
   - Stops early if memory fills first
   - Balanced approach

**Trigger position:**

Data fills according to the set trigger position percentage. For example:

- 20% trigger position = 20% pre-trigger data, 80% post-trigger data
- 50% trigger position = 50% pre-trigger data, 50% post-trigger data

### Best practices

- Monitor systems for specific error conditions
- Capture around trigger events efficiently
- Reduce PC resource usage during long monitoring
- Debug intermittent issues with trigger conditions

**Typical workflow:**

1. Set up trigger for error condition or specific pattern
2. Start capture and let it run
3. Trigger occurs (or press Stop manually)
4. Analyze captured data around the event

---

## Choosing the right mode

### Use Protocol Analyzer when:

- Debugging interactively
- Need to see data in real-time
- Captures are relatively short
- PC performance is adequate
- Immediate feedback is important

### Use Protocol Logger when:

- Capturing for extended periods
- Protocol data rate exceeds real-time decode capability
- Need to save captures for later analysis
- Disk space is available
- Archiving captures for documentation

### Use Protocol Monitor when:

- Waiting for specific trigger conditions
- Monitoring over long periods with low PC load
- Only need data around specific events
- Device memory is sufficient for the event
- Pre/post-trigger capture is important
