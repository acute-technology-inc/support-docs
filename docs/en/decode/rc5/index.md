# RC-5 (Philips Remote Control Protocol)

## What is RC-5?

RC-5 is a widely adopted infrared remote control protocol developed by Philips in the early 1980s for consumer electronics equipment. Originally designed for Philips products, RC-5 quickly became a de facto standard adopted by numerous European and international manufacturers including Marantz, Bang & Olufsen, Grundig, and many others due to its robust design and effective noise immunity. The protocol uses bi-phase (Manchester) encoding modulated onto a 36 kHz carrier frequency, a distinctive choice that was specifically selected to avoid interference from television horizontal scan frequencies (15.625 kHz and harmonics). Unlike pulse distance protocols like NEC that encode data by varying spacing between pulses, RC-5 encodes data within the pulse transitions themselves, with each bit represented by a transition in the middle of the bit period, making timing recovery simpler and providing inherent clock synchronization.

The RC-5 protocol transmits 14 bits of data per frame consisting of 2 start bits (always logic 1), 1 toggle bit that inverts with each new button press to distinguish new presses from key-hold repeats, a 5-bit system address identifying the device type (32 possible device categories like TV, VCR, audio, satellite), and a 6-bit command code supporting up to 128 commands (extended to 128 in RC-5X variant). Each bit has a duration of 1.778 ms (64 cycles of the 36 kHz carrier), resulting in a complete 14-bit frame transmission time of approximately 24.9 ms. When a button is held down, the complete frame repeats every 113.778 ms (approximately 114 ms), with the toggle bit remaining constant throughout the hold period and inverting only when the button is released and pressed again, allowing receivers to implement auto-repeat logic while detecting new button press events.

RC-5's Manchester encoding provides several advantages: excellent noise immunity through guaranteed mid-bit transitions, self-clocking capability allowing receivers to recover timing without a separate clock signal, and DC balance preventing IR receiver baseline drift. The 36 kHz carrier frequency, while less common than 38 kHz used by NEC and other protocols, provides immunity from television interference that was critical in the 1980s when CRT televisions were ubiquitous. RC-5 remains relevant today in legacy audio/video equipment, high-end audio systems from European manufacturers, universal remote controls, and as a reference protocol in infrared communication education and hobbyist projects, with extensive documentation and library support in embedded development platforms.

## Technical Specifications

### Physical Layer

**Infrared Carrier:**
- **Carrier frequency**: 36 kHz (chosen to avoid TV scan line harmonics)
- **Wavelength**: 940 nm (standard infrared LED)
- **Duty cycle**: 25-33% (1/4 or 1/3 — carrier on 25-33% of time, off remainder)
- **Modulation**: Bi-phase (Manchester) encoding

**Communication Range:**
- **Typical range**: 5-10 meters (line of sight)
- **Beam angle**: 30-60° cone (depends on LED and receiver characteristics)

### Manchester Encoding (Bi-Phase Coding)

**Encoding Principle:**
- Each bit period contains exactly one transition at the bit midpoint
- **Logical '0'**: Carrier burst in first half + silence in second half (1 → 0 transition at midpoint)
- **Logical '1'**: Silence in first half + carrier burst in second half (0 → 1 transition at midpoint)

**Bit Duration:**
- **Bit time**: 1.778 ms (64 cycles of 36 kHz carrier)
- **Half-bit time**: 889 µs (32 cycles)

**Transition Guarantee:**
- Every bit guaranteed to have a transition at its midpoint
- Additional transitions may occur at bit boundaries when adjacent bits have same value
- Provides self-clocking for receiver timing recovery

### Message Frame Format

**14-Bit Frame Structure:**

1. **Start bit 1**: Always '1' (889 µs silence + 889 µs burst)
2. **Start bit 2**: Always '1' (889 µs silence + 889 µs burst)
3. **Toggle bit**: Inverts with each new button press (1 bit)
4. **Address bits**: 5-bit system address, MSB first (bits A4-A0)
5. **Command bits**: 6-bit command, MSB first (bits C5-C0)

**Total frame duration**: 14 bits × 1.778 ms = 24.889 ms (~25 ms)

**Bit Transmission Order:**
- Start bits, toggle bit, address (MSB first), command (MSB first)
- Example: [S1=1][S2=1][T][A4][A3][A2][A1][A0][C5][C4][C3][C2][C1][C0]

### Address Space (5-bit System Address)

The 5-bit address field supports 32 device types:

**Common System Addresses:**
- **0 (0x00)**: TV1
- **1 (0x01)**: TV2
- **5 (0x05)**: VCR1
- **6 (0x06)**: VCR2
- **16 (0x10)**: Preamp
- **17 (0x11)**: Tuner
- **18 (0x12)**: Cassette tape
- **19 (0x13)**: CD player
- **20 (0x14)**: Audio amplifier
- **21 (0x15)**: CD-R (writable)
- **26 (0x1A)**: Satellite receiver

Each manufacturer may use addresses differently, but general categories are standardized.

### Command Space (6-bit Command)

**64 standard commands** (6 bits = 0-63):

**Common Commands (Examples):**
- **0**: Digit 0
- **1-9**: Digits 1-9
- **12**: Standby/Power toggle
- **13**: Mute
- **16**: Volume up
- **17**: Volume down
- **32**: Channel/Program up
- **33**: Channel/Program down
- **48**: Fast forward
- **49**: Fast rewind
- **50**: Play
- **54**: Stop
- **53**: Pause

### RC-5X Extended Protocol

To support 128 commands, RC-5X uses:
- **Inverted second start bit** when command bit 6 (C6) = 1
- Effectively provides 7-bit command space (C6-C0)
- Maintains backward compatibility with original RC-5

### Toggle Bit Behavior

**Purpose**: Distinguish new button press from auto-repeat

**Operation:**
1. Button pressed: Toggle bit inverts (0→1 or 1→0)
2. Frame transmitted with new toggle state
3. Button held: Frames repeat every ~114 ms with **same** toggle bit value
4. Button released and pressed again: Toggle bit inverts

**Receiver Logic:**
- If toggle bit changes: Process as new button press
- If toggle bit same as previous: Either repeat or spurious transmission (implement auto-repeat)

### Frame Timing

**Single frame**: ~24.9 ms

**Repeat interval** (button held): 113.778 ms (approximately 114 ms)
- Equivalent to 64 × 1.778 ms = one complete frame period

**Minimum frame separation**: ~89 ms between frame end and next frame start

## Common Applications

RC-5 is widely used in consumer electronics, particularly European brands:

- **Philips televisions**: Original RC-5 application, power, channel, volume control
- **Marantz audio equipment**: High-end receivers, amplifiers, CD players
- **Bang & Olufsen systems**: Premium audio/video equipment
- **Grundig products**: TVs, audio systems (European market)
- **Loewe televisions**: German premium TV manufacturer
- **CD players**: Many 1980s-1990s CD players used RC-5
- **VCRs**: Video cassette recorders from multiple manufacturers
- **Satellite receivers**: European satellite TV set-top boxes
- **Audio amplifiers**: Home theater and stereo receivers
- **Universal remotes**: Programmable remotes with RC-5 support (Logitech Harmony, etc.)
- **DIY projects**: Arduino, Raspberry Pi IR remote control projects
- **Home automation**: Integration of legacy equipment with smart home systems
- **Industrial control**: Non-contact equipment operation in factories
- **Museum exhibits**: Interactive displays with IR remote input
- **Educational systems**: Teaching infrared communication and encoding concepts

## Decoder Configuration

When configuring a logic analyzer to decode RC-5 protocol:

### Signal Capture Method

**Option 1: IR Receiver Module Output (Recommended)**
- Capture demodulated output from 36 kHz IR receiver (e.g., TSOP2236, SFH506-36)
- Provides clean digital Manchester-encoded signal
- Carrier already removed

**Option 2: Raw IR Signal**
- Capture from photodiode to see 36 kHz carrier modulation
- Requires fast sampling and envelope detection
- Useful for carrier analysis

### Channel Assignment

**Essential Signal:**
- **IR_DATA**: Demodulated IR receiver output (digital)

**Optional:**
- **TRIGGER**: External timing reference

### Protocol Parameters

- **Protocol type**: RC-5 or RC-5X (extended)
- **Carrier frequency**: 36 kHz
- **Bit encoding**: Manchester (bi-phase)
- **Bit duration**: 1.778 ms
- **Frame size**: 14 bits
- **Address bits**: 5 bits (MSB first)
- **Command bits**: 6 bits (MSB first, 7 bits in RC-5X)

### Decoding Options

- **Frame decoding**: Parse 14-bit frames into start, toggle, address, command
- **Manchester decoding**: Extract data bits from bi-phase transitions
- **Toggle bit tracking**: Monitor toggle bit state changes
- **Address display**: Show system address (e.g., "TV1", "CD", "Tuner")
- **Command display**: Show command code and name (e.g., "Volume Up", "Channel Down")
- **Repeat detection**: Identify repeated frames (same toggle bit)
- **Timing measurement**: Verify 1.778 ms bit times and 114 ms repeat intervals
- **RC-5X detection**: Identify extended commands (inverted S2)

### Trigger Configuration

- **Start of frame**: Trigger on first start bit transition pattern
- **Toggle bit change**: Trigger when toggle bit inverts (new button press)
- **Specific address**: Trigger on specific device type (e.g., TV, CD player)
- **Specific command**: Trigger on specific command code (e.g., Power, Mute)
- **Repeat pattern**: Trigger on repeated frames with same toggle bit
- **Address + command combination**: Trigger on specific device and command pair

### Analysis Tips

When analyzing RC-5 signals:

1. **Verify Manchester encoding**: Each bit should have a transition at midpoint
2. **Check bit timing**: Each bit should be 1.778 ms (±tolerance)
3. **Validate start bits**: First two bits should always be '1'
4. **Monitor toggle bit**: Should remain constant during button hold, invert on new press
5. **Verify bit order**: Address and command transmitted MSB first (unlike NEC's LSB first)
6. **Measure repeat interval**: Should be ~114 ms between frame starts during holds
7. **Check for RC-5X**: If S2 is '0', command bit 6 is '1' (extended command 64-127)
8. **Look for DC balance**: Manchester encoding should have roughly equal mark/space time
9. **Observe self-clocking**: Receiver can sync from mid-bit transitions
10. **Compare with NEC**: RC-5 uses Manchester, NEC uses pulse distance

### Common Protocol Patterns

**Single Button Press:**
1. User presses button
2. 14-bit frame transmitted (~25 ms)
3. Toggle bit in one state (e.g., '1')
4. User releases immediately
5. No repeat frames

**Button Hold:**
1. User presses and holds button
2. First frame with toggle bit = '1' (example)
3. After ~114 ms, second frame with toggle bit still '1'
4. Subsequent frames every ~114 ms, toggle bit remains '1'
5. User releases button
6. Transmission stops

**Second Button Press:**
1. User presses same button again (after release)
2. Frame transmitted with toggle bit = '0' (inverted from previous '1')
3. Receiver detects toggle change, processes as new press
4. If held, repeats with toggle = '0'

**Manchester Encoding Example:**

Logical '1' bit:
```
      889µs        889µs
   ______________|¯¯¯¯¯¯¯¯
   (silence)     (burst)
                 ↑ midpoint transition (0→1)
```

Logical '0' bit:
```
      889µs        889µs
   ¯¯¯¯¯¯¯¯|______________
   (burst)      (silence)
                 ↑ midpoint transition (1→0)
```

## Reference

- [Wikipedia: RC-5 Protocol](https://en.wikipedia.org/wiki/RC-5)
- [SB-Projects: Philips RC-5 IR Protocol Guide](https://www.sbprojects.net/knowledge/ir/rc5.php)
- [Altium: Philips RC5 Infrared Transmission Protocol](https://techdocs.altium.com/display/FPGA/Philips+RC5+Infrared+Transmission+Protocol)
- [NXP Application Note AN10210: Using Philips Microcontroller as RC-5 Transmitter](https://nxp.com/docs/en/application-note/AN10210.pdf)
- [PIC Microcontroller: Infra Red Remote Control Tester for RC5](https://pic-microcontroller.com/infra-red-remote-control-tester-for-philips-rc5-protocol/)
