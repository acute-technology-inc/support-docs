# ISELED RGB LED

## What is ISELED RGB LED?

ISELED (Integrated Smart Embedded LED) is a smart RGB LED technology and communication protocol developed by Inova Semiconductors specifically for automotive interior ambient lighting applications. Unlike traditional LED control methods that require individual current-limiting resistors and suffer from LED-to-LED brightness and color variations, ISELED integrates a microcontroller-based LED driver (the INLC10AQ controller IC) directly with RGB LEDs into intelligent modules that can be individually addressed, color-calibrated, and temperature-compensated. Each ISELED module communicates via a proprietary bidirectional, half-duplex, 2 Mbps CRC-protected serial bus, enabling daisy-chained configurations where hundreds of LEDs can be controlled from a single microcontroller with just two wires (data and power).

The ISELED protocol allows precise control of each LED's color (RGB values), brightness (PWM duty cycle), and compensation parameters, with all calibration data and temperature coefficients stored within each LED module at the time of manufacture. This eliminates the traditional need for LED binning (sorting LEDs by brightness and color characteristics) and simplifies system integration since color accuracy and uniformity are guaranteed by the module rather than requiring system-level calibration. The INLC10AQ driver IC features three independent constant current sinks controlled via high-frequency PWM, and the integrated intelligence enables features like color temperature adjustment, fade effects, and addressable animation patterns commonly used in automotive mood lighting, dashboard illumination, and decorative interior accents.

ISELED 2.0 evolved into the ILaS (ISELED Light and Sensor Network), expanding the protocol beyond just LEDs to support sensors and actuators over the same two-wire connection. ILaS provides segmented daisy-chain connectivity with fault tolerance, supports up to 4096 individual addresses for flexible multicast and unicast communication, and has been deployed in millions of vehicles since 2021. The protocol is optimized for automotive EMC (electromagnetic compatibility) requirements, operates from a simple 5V supply, and addresses the automotive industry's demands for high-quality, homogeneous, software-defined interior lighting without the complexity and cost of traditional analog LED control systems.

## Technical Specifications

### Physical Layer

**Signal Characteristics:**
- **Two-wire interface**: Data line + Ground (plus VCC power typically on separate wire)
- **Topology**: Daisy-chain (serial cascade) with bidirectional communication
- **Signaling**: Differential or single-ended (implementation-specific)
- **Supply voltage**: 5V automotive supply (7-18V input to LED modules with integrated regulator)

**Electrical Characteristics:**
- **Operating voltage**: 5V nominal for LED modules
- **Current drive**: Up to 60 mA per RGB channel (180 mA total per INLC10AQ)
- **EMC optimization**: Designed for automotive EMI/EMC compliance
- **Protection**: Short circuit, over-temperature, and fault detection

### Data Rate and Timing

**Communication Speed:**
- **Data rate**: 2 Mbps (megabits per second)
- **Protocol**: Proprietary serial protocol with CRC error detection
- **Frame structure**: Packets with address, command, color data, and CRC
- **Latency**: Low latency for real-time color changes and animations

**PWM Characteristics:**
- **PWM frequency**: High frequency (typically >1 kHz to avoid flicker)
- **Resolution**: 8-bit per color channel (256 levels per R, G, B)
- **Color depth**: 16.7 million colors (24-bit RGB)

### Protocol Structure

**Addressing:**
- **Individual addressing**: Each LED has unique address (up to 4096 in ILaS)
- **Multicast**: Groups of LEDs can be addressed simultaneously
- **Broadcast**: Commands can target all LEDs on bus
- **Segment support**: Bus can be divided into independent segments

**Data Packet Format:**
- **Header**: Packet start delimiter and type
- **Address**: Target LED address(es)
- **Command**: Operation (set color, brightness, read status, etc.)
- **Payload**: RGB values, brightness, timing parameters
- **CRC**: Cyclic redundancy check for error detection

**Communication Direction:**
- **Downstream**: Master to LEDs (color commands, configuration)
- **Upstream**: LEDs to master (status, temperature, fault reporting)
- **Half-duplex**: Bidirectional but not simultaneous

### Calibration and Temperature Compensation

**Factory Calibration:**
- Each module stores calibration data for color accuracy
- Eliminates LED binning requirements
- Ensures consistent color and brightness across all modules
- Stored in non-volatile memory within INLC10AQ

**Temperature Compensation:**
- Automatic temperature-dependent brightness and color correction
- Compensates for LED characteristics changes with temperature
- Maintains consistent appearance across temperature range (-40°C to +105°C automotive)

### ILaS Network Features (ISELED 2.0)

**Enhanced Capabilities:**
- Supports LEDs, sensors, and actuators on same bus
- Segmented daisy-chain with fault isolation
- 4K address space (up to 4096 devices)
- Improved fault tolerance and diagnostics
- Sensor data integration (temperature, light, proximity)

## Common Applications

ISELED is primarily used in automotive interior lighting:

**Automotive Ambient Lighting:**
- Door panel mood lighting and accents
- Dashboard and center console illumination
- Footwell and cabin floor lighting
- Dome lights and reading lights
- Cup holder and storage compartment lighting

**Automotive Decorative Lighting:**
- Interior trim accent lighting (door sills, center console)
- Contour lighting following interior design lines
- Dynamic welcome and goodbye lighting sequences
- Synchronized lighting effects (color sweeps, pulses, fades)
- User-customizable mood lighting with color selection

**Automotive Functional Lighting:**
- Instrument cluster backlighting
- Switch and button illumination
- Display border lighting
- Warning and notification indicators
- Adaptive lighting responding to driving mode or user preferences

**Premium Vehicle Features:**
- Multi-zone interior lighting control
- Synchronized lighting with audio system (music visualization)
- Personalized lighting profiles per driver
- Automotive interior branding and signature lighting

**Automotive Control Integration:**
- Integration with vehicle CAN bus for lighting control
- Climate control integration (color indicates temperature setting)
- ADAS integration (lighting alerts for safety features)
- User interface for lighting customization via touchscreen

**Beyond Automotive:**
- High-end architectural lighting installations
- Industrial equipment status indication
- Specialized RGB lighting requiring calibration
- Applications requiring consistent color accuracy

## Decoder Configuration

When configuring a logic analyzer to decode ISELED RGB LED signals:

### Channel Assignment

**Minimum Configuration (1 channel):**
- **DATA**: ISELED bidirectional data line

**Recommended Configuration (2-3 channels):**
- **DATA**: Bidirectional data line
- **VCC**: Power supply line (optional, for power event correlation)
- **GND**: Ground reference

### Protocol Parameters

**Timing Settings:**
- **Data rate**: 2 Mbps
- **Sampling rate**: Minimum 20 MHz (10x oversampling), 50+ MHz recommended
- **Bit encoding**: Check ISELED specification for encoding scheme
- **Frame detection**: Identify packet start delimiters

**Decoding Options:**
- **Address display**: Show target LED address(es)
- **Command interpretation**: Decode command types (set color, read status, etc.)
- **Color data**: Display RGB values in hex, decimal, or color swatch
- **CRC validation**: Check and display CRC status (pass/fail)
- **Direction indicator**: Show downstream (master→LED) vs. upstream (LED→master)

### Trigger Settings

**Common trigger conditions:**
- **Packet start**: Trigger on frame start delimiter
- **Specific address**: Trigger on commands to particular LED address
- **Color change**: Trigger when RGB values change
- **Broadcast command**: Trigger on broadcast packets targeting all LEDs
- **CRC error**: Trigger on CRC mismatch for error analysis
- **Read/status operations**: Trigger on upstream responses from LEDs

### Display Options

**Visualization:**
- **Packet view**: Show complete packets with all fields
- **Color representation**: Visual color swatch for RGB values
- **Address mapping**: Label LEDs by position (e.g., "Door Left", "Dashboard")
- **Timing diagram**: Show bit-level timing for signal integrity analysis
- **Protocol state**: Display communication state (idle, transmit, receive, error)

### Analysis Tips

**Initial Configuration Capture:**
Capture from system power-up to observe initialization sequence, address assignment, and initial color settings. This reveals the system's startup behavior and LED enumeration process.

**Color Command Sequences:**
When analyzing lighting effects, capture multiple packets to see how color changes are sequenced. Smooth fades and animations generate many rapid color update commands. Measure update rates and timing precision.

**Bidirectional Communication:**
ISELED is bidirectional—LEDs can respond with status and sensor data. Distinguish downstream commands (master to LED) from upstream responses (LED to master). Verify proper handshaking and response timing.

**CRC Error Analysis:**
Monitor CRC validation status. CRC errors indicate signal integrity problems, EMI interference, timing violations, or faulty LED modules. Track error rate and correlation with external events (motor starts, radio transmission, etc.).

**Temperature Compensation:**
If capturing over time, observe how RGB values change with temperature. ISELED modules adjust output to maintain consistent perceived color as temperature varies. Compare commanded vs. actual LED behavior.

**Fault Detection:**
ISELED modules report faults (open LED, short circuit, over-temperature). Capture fault reporting messages to diagnose LED failures or wiring issues. Check fault response time and recovery behavior.

**Daisy-Chain Propagation:**
In daisy-chain configurations, measure propagation delay from first to last LED in chain. Long chains may have noticeable delays. Verify signal integrity at end of chain—reflections and attenuation can cause errors.

**ILaS Sensor Integration:**
If using ILaS (ISELED 2.0) with sensors, decode sensor data packets (temperature, ambient light, proximity). Verify sensor data influences lighting behavior (e.g., dimming based on ambient light).

## Reference

- [ISELED Official Website](https://iseled.com/): Technology overview and specifications
- [Inova Semiconductors ISELED](https://inova-semiconductors.de/iseled.html): Developer resources and documentation
- [ISELED White Paper](https://inova-semiconductors.de/iseled.html?file=files%2Fdaten%2Fpdf%2FWhite+Paper%2FWhite+Paper+ISELED+-+Rev1.1.pdf): Technical white paper
- [ILaS Network](https://iseled.com/led-driver-controller.html): ISELED Light and Sensor Network
- [INLC10AQ Datasheet](https://inova-semiconductors.de/iseled/inlc10aq.html): LED driver/controller IC specifications
