# PCM (Pulse Code Modulation Audio Interface)

## What is PCM?

### Overview

PCM (Pulse Code Modulation) in the context of digital audio interfaces refers to a family of synchronous serial protocols used to transmit uncompressed digital audio data between audio components. While PCM fundamentally describes the digital representation of analog audio signals (sampling and quantization), in hardware interfaces it commonly refers to protocols similar to I2S but with variations in timing, framing, and data formatting. PCM audio interfaces are widely used in telecommunications equipment, professional audio gear, consumer electronics, and embedded systems for transmitting stereo or multi-channel audio with low latency and high fidelity.

The PCM interface typically consists of three or four signals: a bit clock (BCLK), a frame sync or word select signal (FS/LRCLK), serial data (SDATA), and optionally a master clock (MCLK). Audio samples are transmitted as serial bit streams synchronized to the bit clock, with the frame sync indicating channel boundaries (left/right for stereo). Different PCM variants exist, including standard PCM, DSP/TDM modes, and left/right justified formats, each with specific timing relationships between the frame sync and data bits. These variations allow flexibility in interfacing different audio components from various manufacturers.

PCM audio interfaces have become ubiquitous in digital audio systems due to their simplicity, reliability, and ability to maintain audio quality without compression. The interface is used in DACs (Digital-to-Analog Converters), ADCs (Analog-to-Digital Converters), audio CODECs, DSPs, and microcontrollers with audio capabilities. Understanding PCM timing and formats is essential for debugging audio issues, verifying audio data integrity, and developing audio processing systems. While I2S is perhaps the most common PCM variant, many audio components support multiple PCM modes to ensure compatibility.

### Key Features

- **Synchronous Serial**: Clock-driven data transmission
- **Uncompressed Audio**: Full-fidelity digital audio samples
- **Multiple Formats**: I2S, Left-Justified, Right-Justified, DSP/TDM modes
- **Stereo and Multi-channel**: 2-channel typical, up to 8+ channels in TDM
- **Variable Bit Depth**: 16, 20, 24, 32-bit samples supported
- **Scalable Sample Rates**: 8 kHz to 192 kHz and beyond
- **Simple Protocol**: Minimal pins (3-4 signals)
- **Master/Slave Configuration**: One device generates clocks
- **Low Latency**: Minimal processing delay
- **Wide Adoption**: Industry-standard audio interface

## Technical Specifications

### Signal Description

**Common Signals**

- **BCLK (Bit Clock)**: Serial bit clock, toggles for each audio bit
- **FS/LRCLK/SYNC (Frame Sync)**: Indicates channel boundaries (left/right)
- **SDATA/SDIN/SDOUT (Serial Data)**: Audio data stream
- **MCLK (Master Clock)**: Optional, system master clock (typically 256× or 512× FS)

**Signal Naming Variations**

Different manufacturers use different names:
- Bit Clock: BCLK, SCK, SCLK, BCK
- Frame Sync: FS, LRCLK, WS (Word Select), SYNC
- Serial Data: SDATA, SD, SDIN (input), SDOUT (output), DIN, DOUT

### PCM Format Variants

#### 1. I2S (Inter-IC Sound)

**Most Common Format**

- **Frame Sync**: Toggles one BCLK cycle before MSB
- **LRCLK Low**: Left channel
- **LRCLK High**: Right channel
- **Data Alignment**: MSB first, 1 BCLK after FS transition
- **Clock Polarity**: Data typically captured on BCLK rising edge

**Timing**
```
LRCLK:  ‾‾‾‾‾‾‾‾‾|__________‾‾‾‾‾‾‾‾‾‾
BCLK:   _|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_
SDATA:  XX|  LEFT MSB  |  LEFT  ...  |  RIGHT MSB
```

#### 2. Left-Justified (LJ)

**Data Starts with Frame Sync**

- **Frame Sync**: Aligns with MSB of audio data
- **LRCLK Low**: Left channel
- **LRCLK High**: Right channel
- **Data Alignment**: MSB coincides with FS transition
- **No Delay**: Data starts immediately with frame sync

**Timing**
```
LRCLK:  ‾‾‾‾‾|_______________‾‾‾‾‾‾‾‾
BCLK:   _|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾
SDATA:  X|  LEFT MSB  |  LEFT  ...
```

#### 3. Right-Justified (RJ)

**LSB Aligns with End of Frame**

- **Frame Sync**: LSB aligns with FS transition
- **Data Alignment**: MSB appears earlier, LSB at end of frame
- **Padding**: Leading bits may be zero or don't-care
- **16/20/24-bit**: Different word sizes aligned to LSB

**Timing**
```
LRCLK:  _______________‾‾‾‾‾‾‾‾‾‾‾‾
BCLK:   |‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_
SDATA:  ...|  DATA  |  LSB  |XX
```

#### 4. DSP/TDM Mode

**Time Division Multiplexing**

- **Frame Sync**: Short pulse (1 BCLK) at start of frame
- **Multiple Channels**: Sequential channel data after FS pulse
- **Frame Period**: Contains all channels (2 to 16+)
- **Continuous Data**: Back-to-back channel slots
- **No Idle**: BCLK runs continuously

**Timing (4 channels example)**
```
FS:     _|‾|_______________________________
BCLK:   _|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_|‾|_
SDATA:  X|CH0 DATA|CH1 DATA|CH2 DATA|CH3 DATA
```

### Clock Relationships

**Sample Rate (Fs)**
- Audio sample rate: 8 kHz, 16 kHz, 32 kHz, 44.1 kHz, 48 kHz, 96 kHz, 192 kHz

**Bit Clock (BCLK)**
- BCLK = Fs × Channels × Bits per Channel
- Stereo 16-bit at 48 kHz: BCLK = 48,000 × 2 × 16 = 1.536 MHz
- Stereo 24-bit at 48 kHz: BCLK = 48,000 × 2 × 24 = 2.304 MHz
- TDM 8-channel 32-bit at 48 kHz: BCLK = 48,000 × 8 × 32 = 12.288 MHz

**Master Clock (MCLK)**
- Typically 256× or 512× Fs
- 48 kHz: MCLK = 12.288 MHz (256×) or 24.576 MHz (512×)
- 44.1 kHz: MCLK = 11.2896 MHz (256×) or 22.5792 MHz (512×)
- Used for internal oversampling, PLL reference

### Bit Depth and Data Format

**Common Bit Depths**
- **16-bit**: CD quality, most common
- **20-bit**: High-quality audio
- **24-bit**: Professional audio, studio quality
- **32-bit**: Extended precision, floating point

**Data Packing**
- **MSB First**: Standard for PCM
- **Left Aligned**: Padding in LSBs for shorter words
- **Right Aligned**: Padding in MSBs
- **Sign Extension**: 2's complement signed samples

## Common Applications

**Consumer Audio**
- CD players and digital audio players
- Bluetooth audio receivers (aptX, AAC decoders)
- Soundbars and home theater systems
- Smart speakers and voice assistants
- Headphone amplifiers and DACs

**Mobile Devices**
- Smartphone audio CODECs
- Tablet audio processing
- Wearable audio (smartwatches, earbuds)
- Mobile gaming audio

**Automotive**
- Car audio head units
- Amplifier interfaces
- Hands-free calling systems
- Digital radio receivers

**Professional Audio**
- Audio mixing consoles
- Studio recording equipment
- Digital audio workstations (DAW interfaces)
- Stage monitors and PA systems

**Telecommunications**
- VoIP phones and gateways
- Telephony systems
- Conferencing equipment
- Call recording systems

**Embedded Systems**
- Microcontroller audio peripherals
- DSP audio processors
- Voice recognition systems
- Audio effects processors
- IoT devices with audio (doorbells, security cameras)

## Decoder Configuration

When analyzing PCM audio interfaces with a logic analyzer, configure the following parameters:

### Signal Connections

**Minimum Configuration** (3 channels)
- BCLK - Bit clock
- FS/LRCLK - Frame sync / word select
- SDATA - Serial data

**With Master Clock** (4 channels)
- Add MCLK - Master clock (for clock relationship analysis)

**For Bidirectional Systems** (4-5 channels)
- SDIN - Serial data input (to CODEC)
- SDOUT - Serial data output (from CODEC)

### Sampling Requirements

- **Minimum Sample Rate**: 10× BCLK frequency
- For 1.536 MHz BCLK (48 kHz stereo 16-bit): Minimum 15.36 MS/s
- For 12.288 MHz BCLK (48 kHz TDM 8ch 32-bit): Minimum 122.88 MS/s
- **Recommended**: 50-100 MS/s for typical audio rates

### Decoder Parameters

- **Format**: Select I2S, Left-Justified, Right-Justified, or DSP/TDM
- **Bit Depth**: 16, 20, 24, or 32 bits per sample
- **Channels**: 2 (stereo) or specify number for TDM
- **Clock Edge**: Specify rising or falling edge for data capture
- **Frame Sync Polarity**: Active high or active low for channel indication
- **Bit Order**: MSB first (standard)
- **Sample Rate**: Auto-calculate or specify (for display purposes)

### Display Options

- Show left and right channel data separately
- Display sample values in hex, signed decimal, or as audio waveform
- Indicate channel transitions (L/R boundaries)
- Show calculated sample rate
- Display data in engineering units (dBFS if calibrated)
- Annotate silence detection (zero samples)
- Highlight clipping (max/min values)

### Trigger Settings

- Trigger on frame sync edge (start of left or right channel)
- Trigger on specific sample values (e.g., start of signal, clipping)
- Trigger on silence-to-audio transition
- Trigger on pattern in data stream
- Pre-trigger to capture context before event

### Analysis Tips

1. **Verify Format**
   - Check timing relationship between FS and data
   - I2S: Data delayed 1 BCLK from FS
   - Left-Justified: Data aligned with FS
   - Right-Justified: LSB aligned with FS
   - DSP/TDM: FS is short pulse

2. **Check Clock Frequencies**
   - Measure BCLK frequency
   - Calculate sample rate: Fs = BCLK / (Channels × Bits)
   - Verify MCLK ratio (256× or 512× Fs)

3. **Validate Data**
   - Look for expected patterns (sine wave, test tones)
   - Check for clipping (samples at min/max values)
   - Verify silence is true zero (not noise)
   - Monitor for channel swapping

4. **Timing Analysis**
   - Verify setup/hold times relative to BCLK
   - Check FS timing (should be stable during data)
   - Measure jitter on BCLK
   - Verify consistent sample periods

5. **Audio Quality Checks**
   - Look for DC offset (non-zero average)
   - Check for stuck bits (constant bit in stream)
   - Identify distortion (unexpected high-frequency content)
   - Verify channel balance

6. **Multi-channel TDM**
   - Count BCLK cycles per frame
   - Identify each channel slot
   - Verify all channels active or identify which are used
   - Check for cross-channel bleed

### Common Issues

**No Audio / Silence**
- **Symptom**: All zeros or no SDATA activity
- **Cause**: Source muted, wrong input selected, CODEC in reset
- **Solution**: Check CODEC configuration registers, verify audio source active

**Distorted Audio**
- **Symptom**: Unexpected data patterns, clipping, noise
- **Cause**: Wrong format, bit depth mismatch, clock issues
- **Solution**: Verify format matches both ends, check BCLK stability

**Channel Swap**
- **Symptom**: Left and right channels reversed
- **Cause**: FS polarity inverted
- **Solution**: Configure FS polarity correctly in both devices

**Clock Mismatch**
- **Symptom**: Intermittent dropouts, chirping sounds
- **Cause**: Sample rate mismatch, BCLK not synchronized to source
- **Solution**: Verify both ends configured for same sample rate, check PLL lock

**Bit Depth Errors**
- **Symptom**: Very quiet or very loud audio, distortion
- **Cause**: Transmitter and receiver using different bit depths
- **Solution**: Configure matching bit depths, check for left-alignment

**TDM Channel Confusion**
- **Symptom**: Wrong channel audio or mixed channels
- **Cause**: Incorrect channel slot assignment
- **Solution**: Verify TDM frame size matches channel count, check slot mapping

**MCLK Issues**
- **Symptom**: No audio, CODEC not functioning
- **Cause**: MCLK absent or wrong frequency
- **Solution**: Verify MCLK present, check frequency ratio to sample rate

### Advanced Analysis

**Audio Content Analysis**
- Decode audio samples to waveform display
- FFT analysis for frequency content
- THD (Total Harmonic Distortion) measurement
- SNR (Signal-to-Noise Ratio) estimation

**Clock Quality**
- BCLK jitter measurement
- MCLK stability analysis
- Phase relationship between MCLK and BCLK
- FS timing accuracy

**Synchronization Issues**
- Multi-device clock alignment
- Channel synchronization in TDM
- Sample-accurate triggering analysis
- Buffer underrun/overrun detection

**Format Identification**
- Auto-detect I2S vs LJ vs RJ
- Determine bit depth from data patterns
- Calculate sample rate from timing
- Identify TDM channel count

## Reference

- [I2S Specification](https://www.sparkfun.com/datasheets/BreakoutBoards/I2SBUS.pdf): Philips I2S Bus Specification
- [TI PCM Interface Application Note](https://www.ti.com/lit/an/slaa449a/slaa449a.pdf)
- [Audio Data Format Guide](https://www.cypress.com/file/133896/download): PCM/I2S/TDM formats
- [Understanding I2S](https://www.nxp.com/docs/en/user-guide/UM10204.pdf): NXP I2C-bus specification
- [Digital Audio Interfaces](https://www.analog.com/media/en/technical-documentation/application-notes/AN-282.pdf): Analog Devices

---
**Last Updated**: 2026-02-02
