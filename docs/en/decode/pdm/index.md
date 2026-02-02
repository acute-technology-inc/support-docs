# PDM (Pulse Density Modulation)

## What is PDM?

### Overview

PDM (Pulse Density Modulation) is a digital audio encoding technique where an analog audio signal is represented by the density of digital pulses in a high-frequency bit stream. Unlike PCM (Pulse Code Modulation), which encodes audio as discrete amplitude samples, PDM uses a single-bit data stream where the audio signal's amplitude is proportional to the density of '1' bits over time. PDM has gained widespread adoption in modern audio systems, particularly for MEMS (Micro-Electro-Mechanical Systems) microphones, due to its simplicity, noise immunity, and suitability for direct digital output from analog sensors.

The PDM interface typically consists of just two signals: a clock (CLK) and a data line (DATA). The clock runs at a frequency much higher than the audio sample rate (typically 64× to 128× the desired output sample rate), and the data line carries the pulse-density-encoded audio. For example, a PDM microphone operating with a 48 kHz output sample rate might use a 3.072 MHz clock (64× oversampling). Converting PDM to PCM requires a digital decimation filter that averages the pulse density over time windows and downsamples to the target sample rate. This conversion is typically performed in a microcontroller, DSP, or dedicated CODEC.

PDM's primary advantage over traditional analog microphones is its inherent immunity to electrical noise in mobile and consumer electronics. Since the signal is already digital at the microphone, it's not susceptible to analog noise pickup on PCB traces. Additionally, PDM microphones are extremely small, low-power, and cost-effective, making them ideal for space-constrained applications like smartphones, earbuds, smart speakers, and IoT devices. The simple 2-wire interface also reduces PCB routing complexity compared to multi-wire digital audio buses.

### Key Features

- **Single-Bit Data**: Audio encoded as pulse density, not multi-bit samples
- **Simple Interface**: Only 2 wires (CLK and DATA)
- **High Oversampling**: Typically 64× to 128× audio sample rate
- **Noise Immunity**: Digital signal resistant to analog interference
- **MEMS Microphone Standard**: De facto interface for digital microphones
- **Stereo Capable**: Two microphones can share clock, alternate on edges
- **No ADC Required**: Direct digital output from sensor
- **Decimation Filtering**: PDM-to-PCM conversion via DSP
- **Low Power**: Suitable for battery-powered devices
- **Small Form Factor**: Enables miniature microphone designs

## Technical Specifications

### Signal Description

**PDM Interface Signals** (2 wires)

- **CLK (Clock)**: High-frequency clock signal from host to microphone
- **DATA (Data Out)**: Single-bit PDM data stream from microphone to host

**Signal Characteristics**
- **Voltage Levels**: Typically 1.8V or 3.3V CMOS
- **CLK Frequency**: 1-4 MHz typical (768 kHz to 4.096 MHz common)
- **DATA Rate**: Equals CLK frequency (1 bit per clock)
- **Direction**: CLK is output from host, DATA is output from microphone

### PDM Encoding Principle

**Pulse Density Representation**

Audio amplitude is encoded by the density of '1' bits:
- **High Amplitude (positive)**: More consecutive '1' bits
- **Zero Amplitude**: Alternating '0' and '1' bits (~50% duty cycle)
- **Low Amplitude (negative)**: More consecutive '0' bits

**Example Bit Stream**
```
Loud positive:  1111111111111111111111111111 (high density of 1s)
Medium positive: 111111110111111101111111011 (75% 1s)
Silence:        101010101010101010101010101 (50% 1s)
Medium negative: 000000010000000100000001000 (25% 1s)
Loud negative:  0000000000000000000000000000 (high density of 0s)
```

**Sigma-Delta Modulation**

PDM is typically generated using sigma-delta (ΣΔ) modulation:
- Analog input is compared to feedback from 1-bit DAC
- Error signal is integrated (sigma)
- Quantized to 1-bit at high rate (delta)
- Quantization noise shaped to high frequencies
- Results in simple 1-bit stream with audio in baseband

### Clock Frequency and Sample Rate

**Common Configurations**

| Audio Sample Rate | Oversampling Ratio | PDM Clock Frequency |
|-------------------|-------------------|---------------------|
| 8 kHz | 64× | 512 kHz |
| 16 kHz | 64× | 1.024 MHz |
| 32 kHz | 64× | 2.048 MHz |
| 48 kHz | 64× | 3.072 MHz |
| 48 kHz | 128× | 6.144 MHz |
| 96 kHz | 64× | 6.144 MHz |

**Oversampling Benefits**
- **64×**: Adequate for most voice and audio applications
- **128×**: Better SNR, improved decimation filter performance
- **Higher OSR**: Pushes quantization noise further out of audio band

### Stereo PDM Configuration

**Dual Microphone Setup**

Two microphones can share a single clock:
- **Left Channel**: Outputs data on rising edge of CLK
- **Right Channel**: Outputs data on falling edge of CLK
- **Time Multiplexed**: Alternate bits from each microphone
- **Requires**: 2× CLK frequency (for same effective sample rate per channel)

**Timing for Stereo**
```
CLK:    ___|‾‾‾|___|‾‾‾|___|‾‾‾|___|‾‾‾|___
DATA:   L0  |  R0  |  L1  |  R1  |  L2  |  R2
        ↑        ↑        ↑        ↑
     Rising   Falling  Rising   Falling
```

**Alternative: Separate DATA Lines**
- Each microphone has its own DATA line
- Both share common CLK
- Simpler decoding, more pins
- More common in multi-microphone arrays

### PDM to PCM Conversion

**Decimation Filter**

Converting PDM to PCM requires:

1. **Low-Pass Filter**: Remove high-frequency quantization noise
2. **Downsampling**: Reduce data rate to target sample rate (e.g., 3.072 MHz → 48 kHz)
3. **Bit-Width Expansion**: Convert 1-bit stream to multi-bit samples (16/24-bit)

**Filter Stages**
- **CIC Filter (Cascaded Integrator-Comb)**: Efficient decimation, removes high-frequency content
- **FIR Filter**: Further filtering and final decimation
- **Output**: Standard PCM audio samples

**Processing Requirements**
- Typically performed in microcontroller or audio processor
- Some CODECs have built-in PDM decimation
- Can be implemented in software or dedicated hardware

### Timing Specifications

**Typical Parameters** (for MEMS PDM microphone)
- **CLK Frequency**: 1-4 MHz
- **Data Setup Time**: 10-20 ns before CLK edge
- **Data Hold Time**: 10-20 ns after CLK edge
- **Start-up Time**: 10-50 ms (microphone power-on to valid data)
- **SNR**: 60-65 dB typical for good MEMS microphone

## Common Applications

**Mobile Devices**
- Smartphone microphones (voice calls, recording)
- Tablet audio input
- Laptop and notebook microphones
- True wireless earbuds (TWS) - voice pickup
- Wearable devices (smartwatches, fitness trackers)

**Smart Speakers and Voice Assistants**
- Amazon Echo, Google Home microphone arrays
- Apple HomePod, Sonos speakers
- Voice-activated devices
- Far-field voice capture systems

**Automotive**
- Hands-free calling microphones
- In-cabin voice commands
- Active noise cancellation (ANC) systems
- Driver monitoring and voice recognition

**Consumer Electronics**
- Digital cameras (video recording audio)
- Drones (audio recording)
- Gaming headsets
- Action cameras (GoPro, etc.)
- VR/AR headsets

**IoT and Smart Home**
- Smart doorbells (Ring, Nest)
- Security cameras with audio
- Baby monitors
- Smart appliances with voice control
- Home automation systems

**Professional and Industrial**
- Conference room microphone systems
- Hearing aids and medical devices
- Industrial noise monitoring
- Acoustic sensors
- Measurement equipment

## Decoder Configuration

When analyzing PDM audio interfaces with a logic analyzer, configure the following parameters:

### Signal Connections

**Minimum Configuration** (2 channels)
- CLK - Clock signal (input to microphone)
- DATA - PDM data stream (output from microphone)

**Stereo Configuration** (2 or 3 channels)
- CLK - Shared clock
- DATA_L - Left channel data
- DATA_R - Right channel data (or multiplexed on same DATA with L)

**With Power** (3-4 channels for debug)
- Add VDD - Power supply monitoring
- Add GND - Ground reference

### Sampling Requirements

- **Minimum Sample Rate**: 10× CLK frequency
- For 3.072 MHz CLK (48 kHz × 64): Minimum 30.72 MS/s
- For 6.144 MHz CLK: Minimum 61.44 MS/s
- **Recommended**: 50-100 MS/s for typical PDM microphones

### Decoder Parameters

- **CLK Frequency**: Specify or auto-detect (1-4 MHz typical)
- **Oversampling Ratio**: 64× or 128× typical
- **Target Sample Rate**: Audio output sample rate (e.g., 48 kHz)
- **Clock Edge**: Rising, falling, or both (for stereo)
- **Decimation Filter**: Enable for PDM-to-PCM conversion (if supported)
- **Channel Configuration**: Mono, stereo (edge-multiplexed), or dual data lines

### Display Options

- Show raw PDM bit stream
- Display pulse density as percentage over time windows
- Convert to PCM and show audio waveform (if decoder supports decimation)
- Indicate bit density variations (audio amplitude proxy)
- Show left/right channel separation for stereo
- Calculate and display effective sample rate
- Annotate silence (50% density) and activity

### Trigger Settings

- Trigger on CLK edge (for timing analysis)
- Trigger on DATA pattern (e.g., start of high-amplitude audio)
- Trigger on density threshold (audio activity detection)
- Trigger on stereo left or right channel (specific edge)
- Pre-trigger to capture quiet period before audio event

### Analysis Tips

1. **Verify Clock Frequency**
   - Measure CLK frequency precisely
   - Common values: 1.024 MHz, 2.048 MHz, 3.072 MHz, 6.144 MHz
   - Calculate oversampling ratio: CLK / desired audio sample rate

2. **Check Pulse Density**
   - Silence should show ~50% density (alternating pattern)
   - Audio should modulate density above and below 50%
   - Continuous high or low density indicates problem

3. **Validate Data Timing**
   - DATA should change relative to CLK edges
   - Check setup/hold times
   - Verify data stable during clock high or low period

4. **Stereo Operation**
   - For edge-multiplexed stereo, verify data changes on both edges
   - Check left channel on rising edge, right on falling (typical)
   - Ensure both channels producing sensible data

5. **Power-Up Sequence**
   - Microphone typically needs 10-50 ms after power-up
   - Initial data may be invalid (all 0s, all 1s, or random)
   - Look for stabilization of pulse density pattern

6. **Audio Quality Indicators**
   - Healthy PDM shows rapid density variations tracking audio
   - Stuck at 0 or 1 for extended periods indicates failure
   - Very low density variation suggests weak/no audio signal
   - Proper silence: roughly alternating 0/1 pattern

7. **Decimation Analysis**
   - If decoder supports PDM-to-PCM, verify output makes sense
   - Check for aliasing or insufficient filtering
   - Compare decimated output to expected audio content

### Common Issues

**No Data / All Zeros**
- **Symptom**: DATA line stuck at 0
- **Cause**: Microphone not powered, CLK not present, or microphone in shutdown
- **Solution**: Verify VDD, check CLK running, ensure microphone enabled

**All Ones**
- **Symptom**: DATA line stuck at 1
- **Cause**: Microphone fault or incorrect configuration
- **Solution**: Check microphone part number, verify connections, try different mic

**No Density Variation**
- **Symptom**: Flat density, no audio modulation
- **Cause**: Microphone not picking up sound, defective mic, acoustic path blocked
- **Solution**: Check acoustic port clear, verify sound source present, test different mic

**Clock Issues**
- **Symptom**: Invalid data, noise, or intermittent operation
- **Cause**: CLK frequency wrong, unstable, or absent
- **Solution**: Verify CLK source, check frequency, ensure stable oscillator

**Stereo Channel Swap**
- **Symptom**: Left and right channels reversed
- **Cause**: Microphones connected to wrong CLK edges
- **Solution**: Verify L/R pin configuration, check which edge each mic uses

**Low SNR / Noisy Audio**
- **Symptom**: High noise floor in decimated PCM
- **Cause**: Insufficient oversampling, poor decimation filter, or electrical noise
- **Solution**: Increase OSR (use higher CLK), improve filter, check PDM signal integrity

**Timing Violations**
- **Symptom**: Intermittent data errors, glitches
- **Cause**: Setup/hold time violations, slow CLK edges
- **Solution**: Check CLK quality, verify PCB routing, reduce trace capacitance

### Advanced Analysis

**Spectral Analysis**
- FFT of raw PDM bit stream shows quantization noise shaping
- High-frequency noise should be well above audio band
- Audio signal should be clear in baseband (<20 kHz)

**Decimation Filter Design**
- Analyze filter response (CIC + FIR stages)
- Verify adequate stopband attenuation
- Check passband ripple
- Ensure proper decimation ratio

**Multi-Microphone Arrays**
- Analyze phase alignment between microphones
- Verify synchronous sampling across array
- Check for channel crosstalk
- Beam forming validation

**Power Consumption**
- Correlate CLK frequency with current draw
- Analyze power-down and wake-up behavior
- Measure duty-cycled operation (for low power)

**Signal Integrity**
- Check CLK edge rates and overshoot
- Verify DATA signal integrity at high clock rates
- Analyze ground bounce and power supply noise
- Check PCB routing for proper impedance

## Reference

- [AN4427 - PDM Microphone Interface](https://www.st.com/resource/en/application_note/dm00099986-pulse-density-modulation-pdm-microphones-and-the-stm32f4-stm32f7-families-stmicroelectronics.pdf) - ST Microelectronics
- [InvenSense PDM Microphone Guide](https://invensense.tdk.com/products/digital/ics-20600/) - TDK InvenSense
- [PDM to PCM Conversion](https://www.analog.com/en/analog-dialogue/articles/pdm-microphone-conversion.html) - Analog Devices
- [MEMS Microphone Overview](https://www.knowles.com/docs/default-source/default-document-library/understanding-pdm-digital-microphones.pdf) - Knowles Acoustics
- [CIC Filter Design](https://www.dsprelated.com/showarticle/1337.php) - Decimation filter explanation

---
**Last Updated**: 2026-02-02
