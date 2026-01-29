# Protocol settings

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 16-17 -->

Configure protocol type, channels, and decode parameters for capture.

## Protocol configuration styles

Protocols use one of two configuration styles based on their complexity.

---

## Style 1: Easy setting protocols

For protocols with straightforward configuration.

### Configuration steps

1. **Select the protocol:** Choose from the protocol dropdown list
2. **Channel setting:** Assign device channels to protocol signals
3. **Waveform preview:** The software automatically detects signal waveform and frequency
4. **Options:** Set capture and decoding parameters specific to the protocol
5. **Threshold:** Set voltage levels according to the signal specifications

**Protocols using Style 1:**

- Simple protocols with automatic signal detection
- Protocols with minimal configuration options
- Self-clocked protocols

---

## Style 2: Advanced setting protocols

For protocols requiring more detailed configuration.

### Configuration steps

1. **Select the protocol:** Choose from the protocol dropdown list
2. **Set the sample rate:** Specify sampling frequency based on protocol speed
3. **Channel setting:** Assign device channels to protocol signals
4. **Trigger on:** Configure trigger conditions for protocol events
5. **Options:** Set capture and decoding parameters specific to the protocol
6. **Threshold:** Set voltage levels according to the signal specifications

**Protocols using Style 2:**

- High-speed protocols requiring precise sample rates
- Protocols with complex triggering requirements
- Protocols with multiple clock domains

---

## Channel setting

Assign physical channels to protocol signal lines.

### Common protocol signals

**For I2C:**

- SDA (Serial Data)
- SCL (Serial Clock)

**For SPI:**

- MOSI (Master Out Slave In)
- MISO (Master In Slave Out)
- SCK (Serial Clock)
- CS (Chip Select)

**For UART:**

- TX (Transmit)
- RX (Receive)

**For CAN:**

- CAN_H (CAN High)
- CAN_L (CAN Low)

### Channel assignment

1. Select the protocol signal from the dropdown
2. Choose the corresponding device channel
3. Repeat for all required signals
4. Optional signals can be left unassigned if not used

---

## Sample rate configuration

Set the sampling frequency appropriate for the protocol speed.

### Guidelines

**Minimum sampling rate:** 4× the protocol clock frequency

**Recommended sampling rate:** 10× the protocol clock frequency

**Examples:**

- I2C at 400 kHz → Use at least 4 MHz (recommended: 10 MHz)
- SPI at 10 MHz → Use at least 40 MHz (recommended: 100 MHz)
- UART at 115200 baud → Use at least 460 kHz (recommended: 1.15 MHz)

### Auto-configuration

For Style 1 protocols, the software automatically sets an appropriate sample rate based on the detected signal frequency.

---

## Waveform preview

Available in Style 1 protocols.

**Features:**

- Automatic signal detection
- Frequency measurement
- Signal quality indication
- Waveform visualization

**What it shows:**

- Detected clock frequency
- Signal levels
- Edge transitions
- Signal integrity indicators

---

## Options (Protocol-specific settings)

Each protocol has specific decode and capture options.

### Common options

**Decode parameters:**

- Address format (7-bit, 10-bit, etc.)
- Data format (hex, decimal, binary, ASCII)
- Endianness (big-endian, little-endian)
- Error detection (parity, CRC, etc.)

**Capture parameters:**

- Decode on-the-fly vs. post-capture
- Filter settings
- Packet size limits
- Buffer settings

**Display options:**

- Show/hide specific packet types
- Color coding
- Report format preferences

---

## Threshold settings

Configure voltage thresholds for logic level detection.

### Single threshold

Set one threshold voltage:

- Signal above threshold = Logic High (1)
- Signal below threshold = Logic Low (0)

**Recommendation:** Set threshold to half the signal voltage level.

**Examples:**

- 3.3V logic → Threshold: 1.65V
- 5V logic → Threshold: 2.5V
- 1.8V logic → Threshold: 0.9V

### Per-channel threshold

Different channels can have different thresholds if needed.

**Use cases:**

- Mixed voltage systems
- Level-shifted signals
- Different logic families on same bus

### Quick presets

Common threshold presets:

- TTL (5V): 2.5V
- CMOS 3.3V: 1.65V
- CMOS 2.5V: 1.25V
- CMOS 1.8V: 0.9V
- Custom: Manual entry

---

## Trigger configuration

Available in Style 2 protocols.

### Trigger options

**Trigger on protocol events:**

- Start condition
- Stop condition
- Specific address
- Data pattern
- Error conditions

**Trigger on signal events:**

- Edge transitions
- Pulse width
- Timeout
- External trigger

### Trigger position

Set the percentage of memory for pre-trigger vs. post-trigger data:

- 0%: All post-trigger data
- 50%: Equal pre and post-trigger
- 100%: All pre-trigger data

---

## Protocol-specific notes

### I2C

- Address format: 7-bit or 10-bit
- Speed modes: Standard (100 kHz), Fast (400 kHz), Fast-plus (1 MHz), High-speed (3.4 MHz)
- Watch for clock stretching

### SPI

- Clock polarity (CPOL): 0 or 1
- Clock phase (CPHA): 0 or 1
- Bit order: MSB-first or LSB-first
- Word size: 8, 16, 24, or 32 bits

### UART

- Baud rate: Common rates from 300 to 921600
- Data bits: 5, 6, 7, 8, or 9
- Parity: None, odd, even, mark, space
- Stop bits: 1, 1.5, or 2

### CAN

- Baud rate: Typical 125, 250, 500 kbps, 1 Mbps
- Frame format: Standard (11-bit ID) or Extended (29-bit ID)
- CAN FD support: If available

---

## Tips and best practices

### Getting good captures

1. **Choose appropriate sample rate:** Higher is better, but not excessive
2. **Set accurate thresholds:** Use multimeter to measure actual signal levels
3. **Test with known-good signals:** Verify configuration before debugging

### Troubleshooting decode errors

**If decode fails or shows errors:**

- Check channel assignments
- Verify threshold levels
- Increase sample rate
- Check signal quality with Logic Analyzer mode
- Verify protocol-specific settings (baud rate, clock polarity, etc.)
