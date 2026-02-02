# SENT (Single Edge Nibble Transmission)

## What is SENT?

SENT (Single Edge Nibble Transmission) is a unidirectional, point-to-point digital communication protocol standardized by SAE International in specification SAE J2716, specifically designed for transmitting high-resolution analog sensor data from automotive sensors to Electronic Control Units (ECUs). Introduced in 2008 and subsequently revised in 2010 and 2016, SENT was developed to address the automotive industry's need for a cost-effective, robust, and efficient method to communicate sensor measurements while replacing traditional analog voltage signals and reducing the complexity and cost compared to bidirectional serial protocols like LIN or CAN. The protocol uses a single wire for unidirectional data transmission from sensor to ECU, eliminating the need for complex transceivers, multiple signal lines, and reducing overall system cost while providing digital accuracy, diagnostic capabilities, and immunity to electrical noise inherent in automotive environments.

SENT encodes data using pulse-width modulation where information is represented by the time intervals between successive falling edges of the signal. Each data element (nibble, 4 bits) is transmitted as a pulse whose duration encodes the nibble value, with the protocol supporting 3 to 6 nibbles of sensor data per frame along with a synchronization/calibration pulse, status and communication nibble, and CRC checksum for error detection. The sensor continuously transmits data frames at regular intervals without requiring clock or enable signals from the ECU, with the ECU automatically synchronizing to the sensor's transmission rate using the calibration pulse at the start of each frame. This self-clocking design simplifies wiring harnesses and connector requirements—critical advantages in automotive applications where minimizing wire count reduces weight, cost, and failure points.

SENT has become widely adopted for critical automotive sensor applications including throttle position sensors, pedal position sensors, pressure sensors (manifold absolute pressure, fuel pressure), mass airflow sensors, temperature sensors, torque sensors, and various position and angle sensors used in engine management, transmission control, chassis systems, and advanced driver assistance systems (ADAS). The protocol's combination of digital accuracy (typically 12-bit resolution or better), built-in error detection via CRC, diagnostic status information, low cost (single wire, no complex transceiver ICs), and robust operation in electrically noisy automotive environments has made SENT the preferred sensor interface for modern vehicles, with deployment across millions of vehicles from major automotive OEMs worldwide.

## Technical Specifications

### Physical Interface

**Signal Line:**
- **Single wire**: Unidirectional data transmission from sensor to ECU
- **Ground reference**: Shared ground between sensor and ECU

**Electrical Characteristics:**
- **Voltage levels**: Typically 0V (low) and 5V (high), or 0V and 3.3V/12V depending on implementation
- **Signal type**: Digital pulse-width modulated signal
- **Drive type**: Push-pull output from sensor, pulled low or high

**Wiring:**
- **Minimal**: Sensor power (VDD), ground (GND), single SENT data signal
- **Typical 3-wire connection**: +5V supply, GND, SENT signal

### Timing and Encoding

**Tick Time Unit:**
- **Base timing unit**: 3 µs nominal (typical range 2-10 µs)
- **Configurable**: Sensors may use different tick times; ECU synchronizes automatically
- All pulse durations are multiples of the tick time

**Nibble Encoding (4-bit values):**
- **Nibble value 0**: 12 ticks (12 × 3 µs = 36 µs)
- **Nibble value 1**: 13 ticks (39 µs)
- **Nibble value 2**: 14 ticks (42 µs)
- **...continues...**
- **Nibble value 15**: 27 ticks (81 µs)
- **Formula**: Pulse duration = (12 + nibble_value) × tick_time

**Example**: 
- Nibble value 0x5 (decimal 5) = (12 + 5) × 3 µs = 51 µs pulse

### Frame Structure

**SENT Frame Format:**

1. **Synchronization/Calibration Pulse**
   - **Duration**: 56 tick times (56 × 3 µs = 168 µs typical)
   - **Purpose**: Allows ECU to measure and synchronize to sensor's tick time
   - **Always first pulse** in each frame

2. **Status and Communication Nibble**
   - **4 bits**: Sensor status information or optional serial message data
   - **Status codes**: Sensor health, diagnostics, operating mode indicators
   - **Duration**: 12-27 ticks depending on nibble value

3. **Data Nibbles (3 to 6 nibbles)**
   - **Sensor measurement data**: High-resolution ADC values, position, pressure, etc.
   - **Typical**: 6 nibbles = 24 bits of sensor data (12-bit resolution per channel for 2 channels, or single 24-bit value)
   - **Flexible**: 3 nibbles (12 bits) up to 6 nibbles (24 bits) per frame
   - **Duration per nibble**: 12-27 ticks

4. **CRC Checksum Nibble**
   - **4 bits**: CRC-4 (or enhanced CRC) for error detection
   - **Calculated over**: Status nibble and data nibbles
   - **Detects**: Transmission errors, single-bit errors

5. **Optional Pause Pulse**
   - **Variable length**: Can be used to extend frame period to specific interval
   - **Purpose**: Allows sensor to maintain constant frame rate regardless of data content
   - **Not present in all implementations**

**Total Frame Time:**
- **Typical**: 250 µs to several milliseconds depending on number of data nibbles and frame rate
- **Frame rate**: Commonly 200 Hz to 1 kHz (frames per second)

### Data Organization

**12-bit Sensor Value Example (using 3 nibbles):**
- Nibble 1: Bits 11-8 (most significant nibble)
- Nibble 2: Bits 7-4 (middle nibble)
- Nibble 3: Bits 3-0 (least significant nibble)

**24-bit Sensor Value Example (using 6 nibbles):**
- Often organized as two 12-bit channels, or single 24-bit high-resolution value
- Nibbles transmitted in order from most significant to least significant

**Status and Communication Nibble:**
- **Status mode**: 4-bit status code indicating sensor health, error conditions
- **Serial message mode**: Part of multi-frame serial data message (enhanced SENT)

### Enhanced SENT Features (SAE J2716-2010 and later)

**Serial Message Format:**
- **Multi-frame messages**: Up to 18 nibbles (72 bits) transmitted across multiple SENT frames
- **Message ID**: Identifies message type and content
- **Use cases**: Sensor ID, configuration parameters, extended diagnostics
- **Transmitted using status/communication nibble over multiple frames**

**Pause Pulse:**
- **Extends frame period** to ensure constant frame rate
- **Duration**: Variable, calculated to achieve desired frame time
- **Benefits**: Simplifies ECU timing, predictable sensor data arrival

### CRC Calculation

**CRC-4:**
- **Polynomial**: Recommended CRC-4 polynomial per SAE J2716
- **Computed over**: Status nibble and all data nibbles
- **Transmitted as**: Final nibble in frame
- **ECU validation**: ECU recalculates CRC and compares; flags error if mismatch

**Error Detection:**
- Detects single-bit errors, most multi-bit errors
- ECU can implement error handling (discard frame, use previous value, set fault code)

## Common Applications

SENT is deployed extensively in automotive sensor systems:

- **Throttle position sensors**: Electronic throttle control (drive-by-wire)
- **Accelerator pedal position sensors**: Pedal angle measurement for engine control
- **Brake pedal position sensors**: Brake-by-wire systems, regenerative braking
- **Manifold absolute pressure (MAP) sensors**: Engine intake pressure for fuel/air metering
- **Mass airflow (MAF) sensors**: Air mass measurement for combustion control
- **Fuel pressure sensors**: High-pressure fuel rail monitoring (gasoline direct injection)
- **Oil pressure sensors**: Engine lubrication system monitoring
- **Coolant temperature sensors**: Engine thermal management
- **Torque sensors**: Steering torque, drivetrain torque measurement
- **Transmission sensors**: Gear position, clutch position, shift force
- **Suspension sensors**: Ride height, damper position, load sensors
- **Steering angle sensors**: Electronic stability control, lane keeping assist
- **Accelerometers and gyroscopes**: Inertial measurement for vehicle dynamics control
- **Rain sensors**: Automatic wiper control
- **Tire pressure monitoring sensors (TPMS)**: Indirect TPMS via wheel speed sensors
- **ADAS sensors**: Object detection sensors, radar, lidar interfaces
- **Exhaust gas sensors**: NOx, particulate sensors for emissions control
- **Occupant detection sensors**: Seat occupancy, weight sensors for airbag deployment

## Decoder Configuration

When configuring a logic analyzer to decode SENT protocol:

### Channel Assignment

**Essential Signal:**
- **SENT_DATA**: Single SENT signal wire (required)

**Optional Signals:**
- **Sensor power (VDD)**: For correlation with power cycling events
- **Ground (GND)**: Reference signal

### Protocol Parameters

- **Tick time**: Expected tick time (3 µs typical, but verify from sensor datasheet or auto-detect)
- **Number of data nibbles**: 3, 4, 5, or 6 nibbles per frame
- **Frame rate**: Expected frames per second (e.g., 1000 Hz = 1 ms period)
- **CRC type**: CRC-4 or enhanced CRC per SAE J2716
- **Pause pulse**: Present or absent
- **Serial message support**: Enhanced SENT with serial messages (if applicable)

### Decoding Options

- **Frame decoding**: Parse sync pulse, status nibble, data nibbles, CRC nibble
- **Tick time measurement**: Measure tick duration from calibration pulse
- **Nibble value extraction**: Decode each nibble value (0-15)
- **Sensor data reconstruction**: Combine nibbles into 12-bit, 24-bit, or custom sensor values
- **Status nibble interpretation**: Decode sensor status codes
- **CRC validation**: Check CRC against calculated value, flag errors
- **Frame timing**: Measure frame period and frame rate
- **Serial message decoding**: Reconstruct multi-frame serial messages (enhanced SENT)
- **Pause pulse detection**: Identify and measure pause pulse duration

### Trigger Configuration

- **Synchronization pulse**: Trigger on 56-tick calibration pulse (frame start)
- **Specific nibble value**: Trigger when specific data nibble reaches threshold value
- **CRC error**: Trigger on CRC mismatch
- **Status code**: Trigger on specific status nibble value (e.g., fault condition)
- **Frame period**: Trigger when frame rate deviates from expected timing
- **Pause pulse**: Trigger on pause pulse detection

### Analysis Tips

When analyzing SENT signals:

1. **Measure tick time**: Use calibration pulse (56 ticks) to determine exact tick duration
2. **Validate frame structure**: Verify sync pulse, correct number of nibbles, CRC present
3. **Check CRC**: Ensure all frames have valid CRC; frequent CRC errors indicate noise or signal integrity issues
4. **Monitor frame rate**: Consistent frame rate indicates healthy sensor operation
5. **Decode nibbles**: Extract nibble values and reconstruct sensor measurements
6. **Observe status nibble**: Changes in status nibble indicate sensor mode changes or fault conditions
7. **Verify timing margins**: Pulses should fall within specified tolerance (typically ±10-20% of nominal)
8. **Look for serial messages**: In enhanced SENT, status nibble carries serial message data over multiple frames
9. **Correlate with sensor output**: Compare decoded digital values with expected sensor behavior (e.g., throttle angle vs. pedal position)
10. **Test signal integrity**: Ensure clean edges, no ringing or noise-induced glitches

### Common Protocol Patterns

**Normal Frame Transmission:**
1. Sensor transmits calibration pulse (56 ticks = 168 µs)
2. Status nibble (e.g., 0x0 = normal operation): 12 ticks = 36 µs
3. Data nibble 1 (e.g., 0xA = 10): 22 ticks = 66 µs
4. Data nibble 2 (e.g., 0x5 = 5): 17 ticks = 51 µs
5. Data nibble 3 (e.g., 0xF = 15): 27 ticks = 81 µs
6. Data nibble 4 (e.g., 0x3 = 3): 15 ticks = 45 µs
7. Data nibble 5 (e.g., 0x8 = 8): 20 ticks = 60 µs
8. Data nibble 6 (e.g., 0x1 = 1): 13 ticks = 39 µs
9. CRC nibble (calculated): X ticks
10. Optional pause pulse (extends to 1 ms total frame time)

**Reconstructed Sensor Data:**
- 24-bit value from nibbles: 0xA5F381
- Or two 12-bit channels: Channel 1 = 0xA5F, Channel 2 = 0x381

**Serial Message Transmission (Enhanced SENT):**
- Frame 1: Status nibble = message nibble 1
- Frame 2: Status nibble = message nibble 2
- Frame 3: Status nibble = message nibble 3
- ... continues for up to 18 nibbles ...
- Frame N: Status nibble = last message nibble
- Multi-frame pattern reconstructs full 18-nibble (72-bit) serial message

**Sensor Fault Indication:**
1. Sensor detects internal fault (e.g., over-temperature)
2. Sensor sets status nibble to fault code (e.g., 0x1 = sensor fault)
3. Frame transmitted with fault status
4. ECU receives frame, detects fault status nibble
5. ECU takes action (logs diagnostic trouble code, enters limp-home mode)

## Reference

- [SAE J2716_201604: SENT - Single Edge Nibble Transmission for Automotive Applications](https://www.sae.org/standards/content/j2716_201604/)
- [BSB Edge: SAE J2716_201604 Standard](https://www.bsbedge.com/standard/sent-single-edge-nibble-transmission-for-automotive-applications/SAEJ2716_201604)
- [SAE Technical Paper: J2716 SENT Updates and Status](https://sae.org/publications/technical-papers/content/2011-01-1034)
- [Microchip: dsPIC33/PIC24 SENT Module Documentation](https://www.microchip.com/DS70005145)
- [SAE J2716_200802: SENT Original Specification](https://www.sae.org/standards/content/j2716_200802/)
