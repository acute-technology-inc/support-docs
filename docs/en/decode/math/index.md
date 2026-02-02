# Math Functions (Waveform Mathematics)

## What are Math Functions?

Math functions in logic analyzers and oscilloscopes are computational tools that perform mathematical operations on captured waveforms to derive additional signals, measurements, and visualizations beyond the raw captured data. Rather than being a communication protocol, the "Math" function represents a suite of signal processing capabilities that transform, combine, and analyze digital and analog signals to reveal hidden characteristics, calculate derived parameters, and simplify complex signal relationships. These functions operate on time-series data—the voltage or logic level samples captured from input channels—applying algebraic operations (addition, subtraction, multiplication, division), logical operations (AND, OR, XOR, NOT), statistical calculations (average, RMS, standard deviation), frequency domain transforms (FFT), and advanced signal processing (filtering, integration, differentiation) to generate virtual channels that display computed results alongside original signals.

The fundamental purpose of waveform mathematics is to extract information that is implicit in captured signals but not directly visible. For example, subtracting two voltage signals reveals the differential voltage between them, essential for analyzing differential signaling like RS-485, USB, or LVDS. Integrating a current waveform over time calculates charge or energy transfer. Taking the FFT (Fast Fourier Transform) of a time-domain signal reveals its frequency spectrum, showing harmonic content, noise, and spectral characteristics. Logical operations on digital signals can reconstruct derived clocks (by XORing data edges), validate state machines (by comparing expected vs. actual states), or create custom protocol decodes. These mathematical transformations convert raw data into actionable insights without requiring external processing or recapture.

Modern logic analyzers implement math functions using dedicated DSP (Digital Signal Processing) hardware, FPGAs, or software post-processing, enabling real-time or near-real-time computation on high-speed captured data. Users configure math functions by selecting operands (input channels), choosing operations (add, subtract, FFT, etc.), setting parameters (filter cutoff frequencies, FFT window types), and assigning outputs to virtual channels that appear in the display alongside physical channels. The flexibility of math functions makes them indispensable for debugging power integrity (measuring ripple by subtracting DC component), signal integrity (analyzing eye diagrams from differential pairs), protocol analysis (decoding custom protocols with Boolean logic), and system characterization (frequency response, transfer functions). By eliminating the need for external computation or specialized equipment, waveform mathematics accelerates debug cycles and enables sophisticated analysis directly within the logic analyzer environment.

## Common Math Operations

### Arithmetic Operations

**Addition (A + B):**
- Combines two waveforms point-by-point
- **Applications**: Summing currents, combining noise sources, reconstructing signals
- **Example**: Sum currents from multiple power rails to calculate total supply current

**Subtraction (A - B):**
- Subtracts one waveform from another
- **Applications**: Differential signal extraction, noise cancellation, measuring voltage differences
- **Example**: Reconstruct differential signal (V+ minus V-) from two single-ended captures

**Multiplication (A × B):**
- Multiplies two waveforms sample-by-sample
- **Applications**: Power calculation (V × I), modulation analysis, convolution
- **Example**: Instantaneous power = voltage × current

**Division (A ÷ B):**
- Divides one waveform by another
- **Applications**: Calculating ratios, normalizing signals, transfer function estimation
- **Example**: Voltage gain = Vout ÷ Vin

**Scaling (k × A):**
- Multiplies waveform by constant
- **Applications**: Unit conversion, calibration, probe compensation
- **Example**: Convert ADC codes to voltage: Voltage = ADC_value × (Vref / 2^bits)

**Offset (A + k):**
- Adds constant to waveform
- **Applications**: DC bias adjustment, level shifting
- **Example**: Remove DC component: AC_signal = signal - DC_offset

### Logical Operations (Digital Signals)

**AND (A & B):**
- Logical AND of two digital signals
- **Applications**: Signal gating, enable logic verification
- **Example**: Verify chip select is active only when bus is idle

**OR (A | B):**
- Logical OR of two digital signals
- **Applications**: Combining interrupt sources, detecting activity on multiple lines
- **Example**: Trigger when any of several error flags assert

**XOR (A ⊕ B):**
- Exclusive OR of two signals
- **Applications**: Change detection, parity calculation, clock recovery
- **Example**: Generate transition clock: CLK_transitions = DATA XOR DATA_delayed

**NOT (!A):**
- Logical inversion
- **Applications**: Active-low to active-high conversion, complementing signals
- **Example**: Convert active-low enable to active-high: EN_high = !EN_low

**NAND, NOR, XNOR:**
- Complemented logical operations
- **Applications**: Logic verification, custom protocol decode

### Calculus Operations

**Derivative (dA/dt):**
- Calculates rate of change
- **Applications**: Finding edges (voltage transitions), slew rate measurement, detecting rapid changes
- **Example**: Edge detection: edges = d(signal)/dt

**Integral (∫A dt):**
- Calculates cumulative sum over time
- **Applications**: Charge calculation (∫I dt), energy calculation (∫P dt), area under curve
- **Example**: Battery capacity consumed: Charge = ∫ current × dt

**Running Average:**
- Computes moving average over time window
- **Applications**: Noise reduction, smoothing, extracting DC component
- **Example**: DC level = average(signal) over N samples

### Frequency Domain Operations

**FFT (Fast Fourier Transform):**
- Converts time-domain signal to frequency-domain spectrum
- **Applications**: Spectral analysis, harmonic identification, noise characterization, frequency response
- **Example**: Identify switching noise harmonics in power supply ripple

**Power Spectral Density (PSD):**
- FFT magnitude squared, showing power distribution vs. frequency
- **Applications**: Noise analysis, EMI investigation, jitter frequency analysis

**Inverse FFT (IFFT):**
- Converts frequency-domain back to time-domain
- **Applications**: Filter design verification, spectral editing

### Statistical Operations

**Average:**
- Mean value over specified time window or entire capture
- **Applications**: DC offset measurement, signal baseline

**RMS (Root Mean Square):**
- RMS = sqrt(mean(signal²))
- **Applications**: AC voltage/current measurement, noise power

**Standard Deviation:**
- Measure of signal variability around mean
- **Applications**: Quantifying noise, jitter, or signal stability

**Min, Max, Peak-to-Peak:**
- Extrema and range measurements
- **Applications**: Amplitude measurements, ripple voltage (Vmax - Vmin)

### Filtering Operations

**Low-Pass Filter:**
- Attenuates high frequencies, passes low frequencies
- **Applications**: Noise reduction, extracting DC or low-frequency components

**High-Pass Filter:**
- Attenuates low frequencies, passes high frequencies
- **Applications**: Removing DC offset, extracting AC components

**Band-Pass Filter:**
- Passes frequencies within a range, attenuates outside
- **Applications**: Isolating specific frequency components, narrowband analysis

**Band-Stop (Notch) Filter:**
- Attenuates frequencies within a range, passes outside
- **Applications**: Removing power-line interference (50/60 Hz), spurious tones

## Common Applications

Waveform mathematics is used across electronics debugging and analysis:

**Power Integrity Analysis:**
- Ripple voltage: High-pass filter on power rail or (Vmax - DC_average)
- Power consumption: Voltage × Current
- Energy: ∫ (Voltage × Current) dt
- Noise analysis: FFT of power rail to identify switching frequencies

**Signal Integrity:**
- Differential signal reconstruction: Signal_diff = A - B
- Eye diagram generation: Overlay many bit periods
- Jitter measurement: Standard deviation of edge timing
- Crosstalk analysis: Victim signal - baseline (aggressor quiet)

**Protocol Debugging:**
- Clock recovery: XOR data signal with delayed copy to extract transitions
- Custom decode: Boolean logic to implement proprietary protocols
- Parity/CRC check: XOR bits to verify error detection codes
- Signal conditioning: Filter noise before protocol decode

**Frequency Analysis:**
- Harmonic identification: FFT shows fundamental and harmonics
- Clock frequency measurement: FFT peak frequency
- Phase noise characterization: FFT of oscillator output
- Filter response: Output ÷ Input in frequency domain

**Analog Circuit Analysis:**
- Gain measurement: Vout ÷ Vin
- Phase shift: Cross-correlation or Lissajous analysis
- Transfer function: Output/Input across frequency sweep
- Distortion analysis: FFT to measure THD (Total Harmonic Distortion)

**Motor and Control Systems:**
- Motor current: Sum of phase currents
- Mechanical power: Torque × Speed (from sensor signals)
- Control loop error: Setpoint - Feedback
- PID controller analysis: P, I, and D terms from error signal

**Audio and Acoustics:**
- Stereo difference: Left - Right
- Mid-side encoding: Mid = (L+R)/2, Side = (L-R)/2
- Frequency spectrum: FFT for spectral content
- Distortion measurement: FFT-based THD+N

## Configuration

When configuring math functions in a logic analyzer:

### Function Selection

**Choose Operation Type:**
- Arithmetic: +, -, ×, ÷, scaling
- Logical: AND, OR, XOR, NOT
- Calculus: derivative, integral, average
- Frequency: FFT, PSD
- Statistical: mean, RMS, std dev
- Filtering: low-pass, high-pass, band-pass, notch

### Operand Selection

**Input Channels:**
- Select physical channels (Ch1, Ch2, etc.) or other math functions as operands
- Ensure channels are properly scaled and units match (if applicable)

**Constants:**
- Enter numerical constants for scaling, offsets, thresholds
- Specify units (V, A, Ω, etc.) for proper display

### Parameters

**Filter Settings:**
- Cutoff frequency for filters
- Filter order (number of poles)
- Filter type (Butterworth, Chebyshev, etc.)

**FFT Settings:**
- Window type (Hanning, Hamming, Blackman, rectangular)
- FFT size (number of points: 256, 1024, 4096, etc.)
- Frequency resolution = sample_rate / FFT_size
- Overlap percentage for spectral averaging

**Statistical Window:**
- Time window or sample count for running statistics
- Full capture or rolling window

### Display Settings

**Math Channel Configuration:**
- Assign math result to virtual channel (Math1, Math2, etc.)
- Set vertical scale and units
- Set color for easy identification

**Overlay or Separate:**
- Overlay math waveform with source signals for comparison
- Use separate grid for independent scaling

## Analysis Tips

**Verify Units and Scaling:**
Ensure all operands have compatible units and scaling. Adding a voltage (V) to a current (A) is physically meaningless—convert to power first (V×I). Check probe attenuation and scaling factors.

**Avoid Division by Zero:**
When dividing waveforms, ensure denominator never reaches zero. Use conditional math or add small offset to prevent divide-by-zero errors that cause display artifacts.

**Sampling and Nyquist Considerations:**
For FFT analysis, sample rate must be ≥2× highest frequency of interest (Nyquist theorem). Undersamp ling causes aliasing. Use anti-aliasing filters if necessary.

**Window Functions for FFT:**
Rectangular windows cause spectral leakage. Use Hanning, Hamming, or Blackman windows for better frequency resolution and reduced sidelobes in FFT analysis.

**Noise and Resolution:**
Math operations can amplify noise. Subtraction (A - B) of noisy signals produces noisier result. Use filtering or averaging to improve SNR before math operations.

**Computational Delay:**
Complex math (FFT, high-order filtering) may introduce processing latency. For real-time triggering, use simpler operations or hardware-accelerated functions.

**Cascading Math Functions:**
Create complex analyses by chaining math functions. Example: (Step 1) Differential = CH1 - CH2, (Step 2) AC_component = High-pass(Differential), (Step 3) FFT(AC_component) for spectral analysis.

**Save and Reuse Configurations:**
Save commonly-used math setups as templates for efficient reuse across debug sessions.

## Reference

- [Oscilloscope Math Functions Guide](https://www.keysight.com/) - Keysight application notes on waveform mathematics
- [FFT Basics and Applications](https://www.tek.com/) - Tektronix FFT tutorial
- [Signal Processing for Oscilloscopes](https://www.rohde-schwarz.com/) - R&S technical documentation
- [Wikipedia: Digital Signal Processing](https://en.wikipedia.org/wiki/Digital_signal_processing) - DSP fundamentals
- [Understanding FFT Windows](https://www.ni.com/en-us/innovations/white-papers/06/understanding-ffts-and-windowing.html) - National Instruments
