# SDQ (Single Data Queue)

## What is SDQ?

### Overview

SDQ (Single Data Queue) is a proprietary single-wire bidirectional communication protocol developed by Texas Instruments for their battery fuel gauge and power management ICs, particularly the bq27xxx series gas gauge devices and battery authentication chips. The protocol enables communication between a host microcontroller and TI battery management ICs over a single data line (plus ground), making it ideal for space-constrained applications like smartphones, tablets, laptops, and portable electronics where minimizing connector pins and PCB routing complexity is critical. SDQ uses time-based encoding similar to 1-Wire protocol but with TI-specific timing requirements and command structures tailored for battery monitoring applications.

The SDQ interface operates through carefully timed signal transitions on the single bidirectional data line, with both the host and device pulling the line low to transmit bits, and a pull-up resistor returning the line to high when released. Communication uses a master-slave architecture where the host initiates all transactions by sending requests (read or write commands with addresses), and the device responds with data or acknowledgments. Bit encoding is achieved through pulse widths: short pulses represent logical '1' and longer pulses represent logical '0', with specific timing windows defining valid bit periods. The protocol includes CRC-based error detection to ensure data integrity in the electrically noisy environment of battery packs.

SDQ is specifically designed for battery management applications where low pin count, low power consumption, and simple implementation are priorities. It's commonly found in smartphone and laptop battery packs for reading state-of-charge (SOC), voltage, current, temperature, remaining capacity, cycle count, and authentication data. While proprietary to TI, SDQ has become widespread in portable electronics due to TI's dominant position in battery fuel gauge ICs. Understanding SDQ is essential for debugging battery communication issues, developing battery management systems, validating fuel gauge data, and implementing battery authentication in portable devices.

### Key Features

- **Single Wire Interface**: One data line plus ground
- **Bidirectional**: Host and device both transmit and receive
- **Time-Based Encoding**: Pulse width determines bit value
- **Master-Slave**: Host initiates all transactions
- **CRC Error Detection**: 8-bit CRC for data integrity
- **Battery Focus**: Optimized for fuel gauge and battery management
- **Low Pin Count**: Minimal connector requirements
- **Low Power**: Suitable for battery-powered applications
- **Simple Implementation**: Can be bit-banged on GPIO
- **TI Proprietary**: Specific to Texas Instruments battery ICs

## Technical Specifications

### Signal Description

**SDQ Signals** (2 wires)

- **SDQ**: Single bidirectional data line (open-drain)
- **GND**: Ground reference

**Electrical Characteristics**
- **Pull-up Resistor**: 1-10 kΩ (typically 4.7 kΩ) to VCC
- **VCC**: Typically 1.8V, 2.5V, or 3.3V (system voltage)
- **Logic Low**: <0.3 VCC (driven low by host or device)
- **Logic High**: >0.7 VCC (passive pull-up when released)
- **Drive**: Open-drain outputs from both host and device

### Timing Specifications

**Bit Timing** (typical values, device-specific)

- **Bit Period**: ~200 µs total
- **Logic '1' Low Time**: ~8-20 µs (short pulse)
- **Logic '0' Low Time**: ~80-120 µs (long pulse)
- **Recovery Time**: Remaining time in bit period (line high)
- **Sample Time**: Host/device samples line ~60-70 µs into bit period

**Transaction Timing**

- **Break**: Host pulls line low for >2 ms to initiate transaction
- **Presence Pulse**: Device responds with short low pulse
- **Command Byte**: Host sends 8-bit command
- **Address Byte(s)**: Host sends address (if applicable)
- **Data Byte(s)**: Host writes or device responds with data
- **CRC Byte**: Final byte for error detection

### Bit Encoding

**Write '1' (short pulse)**
```
SDQ: ‾‾|_|‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾‾  (~10 µs low, ~190 µs high)
     0  10    50   100  150  200 µs
```

**Write '0' (long pulse)**
```
SDQ: ‾‾|___________________|‾‾‾  (~100 µs low, ~100 µs high)
     0  10    50   100  150  200 µs
```

**Read Bit** (host initiates, device responds)
1. Host pulls line low briefly (~5 µs) to initiate read slot
2. Host releases line
3. Device pulls line low for short (1) or long (0) period
4. Host samples line around 60 µs mark
5. Bit period completes

### Protocol Structure

**Transaction Sequence**

1. **Initialization**: Host sends break (>2 ms low pulse)
2. **Presence**: Device responds with presence pulse
3. **Command**: Host sends command byte (read/write)
4. **Address**: Host sends register address byte(s)
5. **Data**: Host writes or device returns data byte(s)
6. **CRC**: CRC byte for error detection
7. **Completion**: Transaction ends, line returns to idle (high)

**Common Commands** (device-specific, bq27xxx example)

- **0x00**: Read data from specified address
- **0x01**: Write data to specified address
- **Control commands**: Device-specific configuration

**Data Format**

- **LSB First**: Least significant bit transmitted first
- **Byte Order**: Little-endian for multi-byte values
- **CRC-8**: Calculated over command, address, and data

## Common Applications

**Battery Management**
- Smartphone battery packs
- Tablet batteries
- Laptop battery packs
- Power tool batteries
- E-cigarette/vape batteries
- Portable medical devices

**Fuel Gauge Communication**
- Reading state-of-charge (SOC%)
- Battery voltage and current
- Remaining capacity (mAh)
- Full charge capacity
- Battery temperature
- Cycle count
- Time-to-empty/time-to-full

**Battery Authentication**
- Verifying genuine battery packs
- Reading battery serial numbers
- Authentication challenges
- Encrypted communication

**Power Management**
- Charge control parameters
- Safety thresholds (OVP, UVP, OCP, OTP)
- Calibration data
- Manufacturing data

**Embedded Systems**
- Portable instrumentation
- Handheld terminals
- Wearable devices
- IoT battery-powered nodes

## Decoder Configuration

When analyzing SDQ communication with a logic analyzer, configure the following parameters:

### Signal Connections

**Minimum Configuration** (2 channels recommended)
- SDQ - Data line (1 channel, required)
- VCC or GND - Reference (1 channel, optional but helpful for voltage reference)

### Sampling Requirements

- **Minimum Sample Rate**: 1 MS/s (10 samples per ~10 µs pulse)
- **Recommended**: 5-10 MS/s for reliable pulse width measurement

### Decoder Parameters

- **Logic '1' Threshold**: ~10-20 µs low pulse
- **Logic '0' Threshold**: ~80-120 µs low pulse
- **Bit Period**: ~200 µs typical
- **Break Detection**: >2 ms low pulse
- **CRC Polynomial**: Check device datasheet (typically CRC-8)

### Display Options

- Show decoded bytes (command, address, data)
- Display CRC and validation status
- Annotate break and presence pulses
- Show bit values and timing
- Decode common registers (SOC, voltage, etc.)

### Trigger Settings

- Trigger on break pulse (>2 ms low)
- Trigger on specific command bytes
- Trigger on CRC error
- Pre-trigger to capture transaction start

### Analysis Tips

1. **Identify Break Signal**
   - Look for long (>2 ms) low pulse from host
   - Indicates start of transaction

2. **Verify Presence Pulse**
   - Device should respond with short low pulse after break
   - Confirms device is present and communicating

3. **Decode Bit Timing**
   - Measure low pulse width
   - Short (~10 µs) = '1', Long (~100 µs) = '0'
   - Check consistency across transaction

4. **Validate CRC**
   - Last byte should match calculated CRC
   - CRC error indicates communication problem

5. **Monitor Register Accesses**
   - Identify which registers being read/written
   - Common: 0x00-0x7F for data registers

6. **Check for Timing Violations**
   - Bit periods should be consistent
   - Recovery time adequate between bits
   - No bus contention (both pulling low simultaneously)

### Common Issues

**No Presence Pulse**
- **Symptom**: Device doesn't respond to break
- **Cause**: Device not powered, wrong pull-up, disconnected
- **Solution**: Check power, verify pull-up resistor, check connections

**Timing Errors**
- **Symptom**: Inconsistent or wrong bit decoding
- **Cause**: Wrong timing parameters, clock drift
- **Solution**: Measure actual pulse widths, adjust decoder thresholds

**CRC Errors**
- **Symptom**: CRC mismatch on transactions
- **Cause**: Noise, timing violations, electrical interference
- **Solution**: Improve signal integrity, check pull-up value, reduce noise sources

**Bus Contention**
- **Symptom**: Line stuck low or garbled data
- **Cause**: Host and device both driving low simultaneously
- **Solution**: Verify software timing, check for protocol violations

**Weak Pull-up**
- **Symptom**: Slow rise times, unreliable communication
- **Cause**: Pull-up resistor too large or weak
- **Solution**: Use 4.7 kΩ or lower, ensure strong pull-up

## Reference

- [TI bq27xxx Fuel Gauge Family](https://www.ti.com/lit/ds/symlink/bq27421-g1.pdf) - Example SDQ device
- [TI Battery Fuel Gauge Overview](https://www.ti.com/power-management/battery-management/fuel-gauge-monitors/overview.html)
- [SDQ Protocol Application Note](https://www.ti.com/) - TI technical documentation
- [1-Wire vs. SDQ Comparison](https://www.analog.com/en/technical-articles/1wire-protocol.html) - Similar protocols

---
**Last Updated**: 2026-02-02
