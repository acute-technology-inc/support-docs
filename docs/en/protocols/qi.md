# Qi (Wireless Charging)

## What is Qi?

Qi (pronounced "chee," derived from the Chinese word for "energy flow") is an open, universal standard for wireless inductive power transfer, developed and maintained by the Wireless Power Consortium (WPC). First introduced in 2010 with version 1.0, Qi defines specifications for safely and efficiently charging mobile devices, wearables, and other consumer electronics by placing them on a charging pad or surface without physical connectors. The standard uses electromagnetic induction to generate a magnetic field between a transmitter coil (in the charging pad) and a receiver coil (in the device), transferring power across an air gap of several millimeters. Qi has become the dominant wireless charging standard globally, with over 7,500 certified charger types and support from major smartphone manufacturers including Apple, Samsung, Google, and others.

The Qi specification encompasses both the power transfer mechanism and a bidirectional communication protocol that enables the receiver (device being charged) and transmitter (charging pad) to exchange information about power requirements, charging status, and error conditions. Communication from receiver to transmitter uses Amplitude Shift Keying (ASK) modulation at 2 Kbps, implemented by the receiver varying its load impedance to modulate the power carrier signal. Communication from transmitter to receiver uses Frequency Shift Keying (FSK) at 200 Kbps. The power transfer carrier frequency operates at 100-205 kHz depending on the power class, with data modulated onto this carrier. The protocol defines packet structures including headers, payload data, and checksums to ensure reliable message exchange during the charging process phases: selection, ping, identification, configuration, and power transfer.

Qi has evolved through multiple specification versions, progressively increasing power delivery capabilities from 5W initially to 15W for smartphones in the Baseline Power Profile (BPP) and Extended Power Profile (EPP), and up to several kilowatts in specialized applications. The recent introduction of Qi2 (announced in 2023) incorporates Apple's MagSafe-style magnetic alignment system for improved positioning and efficiency. Qi wireless charging has expanded beyond smartphones to include wireless earbuds, smartwatches, electric toothbrushes, automotive applications, medical devices, and even power tools, making it one of the most widely adopted wireless power standards in consumer electronics.

## Technical Specifications

### Physical Layer - Inductive Coupling

**Power Transfer Frequency:**
- **Baseline Power Profile (BPP)**: 110-205 kHz (commonly 100-148 kHz)
- **Extended Power Profile (EPP)**: 110-205 kHz
- **Low Power**: 100-120 kHz (typical for <5W applications)
- **Medium Power**: 100-205 kHz (5W-15W smartphones)

**Coil Configuration:**
- **Transmitter coil**: Flat spiral or array of coils in charging pad
- **Receiver coil**: Compact spiral coil in receiving device
- **Coupling distance**: Typically 5-10mm maximum air gap
- **Alignment**: Qi2 introduces magnetic alignment (MagSafe compatible)

**Power Classes:**
- **Low Power (PC0)**: Up to 5W (USB power levels)
- **Medium Power (PC1)**: 5W-15W (standard smartphone charging)
- **High Power**: 15W+ (fast charging, automotive)
- **Qi2**: 15W with magnetic alignment

### Communication Protocol

**Receiver-to-Transmitter Communication (ASK Modulation):**
- **Modulation type**: Amplitude Shift Keying (ASK)
- **Data rate**: 2 Kbps (2000 bits per second)
- **Implementation**: Receiver modulates load by switching capacitors/resistors to ground
- **Detection**: Transmitter senses current changes in primary coil
- **Bit encoding**: Binary encoding with specific timing per WPC spec

**Transmitter-to-Receiver Communication (FSK Modulation):**
- **Modulation type**: Frequency Shift Keying (FSK)
- **Data rate**: 200 Kbps (200,000 bits per second)
- **Implementation**: Transmitter varies switching frequency slightly
- **Detection**: Receiver demodulates frequency shifts in induced voltage
- **Frequency deviation**: Typically ±1-2 kHz around carrier

**Packet Structure:**
- **Preamble**: Synchronization pattern (11 bits minimum)
- **Header**: Message identifier (8 bits)
- **Message data**: Payload (0-27 bytes depending on message type)
- **Checksum**: Error detection byte

### Charging Phases and Messages

**1. Selection Phase:**
- Transmitter periodically pings for objects (analog ping at 100% duty cycle)

**2. Ping Phase:**
- Transmitter detects presence via coil impedance change
- Sends Digital Ping to elicit response

**3. Identification & Configuration Phase:**
- **Signal Strength Packet**: Receiver reports induced voltage strength (0-255)
- **Identification Packet**: Receiver sends version, manufacturer info
- **Configuration Packet**: Receiver requests specific power level

**4. Power Transfer Phase:**
- **Control Error Packets**: Receiver sends error values to adjust power (every 250ms typical)
- **Received Power Packets**: Receiver reports actual power received
- **End Power Transfer**: Receiver signals charging complete or error

**5. Renegotiation:**
- Power level adjustments during charging as needed

**Message Types (Examples):**
- **0x01**: Signal Strength
- **0x02**: End Power Transfer
- **0x03**: Control Error (power adjustment request)
- **0x04**: Received Power Report
- **0x05**: Charge Status
- **0x06**: Power Holdoff
- **0x51**: Configuration (Baseline)
- **0x71**: Identification

### Control Error Packet

The receiver sends Control Error values to regulate power:
- **Positive values**: Request power increase
- **Negative values**: Request power decrease
- **Zero value**: Power is optimal
- **Range**: Typically -128 to +127

Transmitter adjusts operating frequency or duty cycle to change delivered power based on these error corrections.

## Common Applications

Qi wireless charging is ubiquitous in modern consumer electronics and expanding into numerous sectors:

- **Smartphones**: iPhone (8 and later), Samsung Galaxy, Google Pixel, and hundreds of other models
- **Wireless earbuds**: AirPods, Galaxy Buds, and many third-party earbuds with Qi cases
- **Smartwatches**: Apple Watch (with Qi2), Galaxy Watch, Pixel Watch
- **Tablets**: iPad models with MagSafe, Android tablets
- **Automotive charging**: Built-in Qi pads in center consoles and dashboards
- **Furniture integration**: Qi charging built into desks, nightstands, lamps
- **Public charging stations**: Airports, cafes, restaurants, hotels
- **Multi-device chargers**: Pads supporting simultaneous charging of phone, watch, earbuds
- **Portable power banks**: Qi-enabled wireless power banks
- **Medical devices**: Electric toothbrushes, hearing aids, medical monitors
- **Power tools**: Cordless tool battery chargers (DeWalt, Bosch)
- **Gaming peripherals**: Wireless mouse charging pads
- **Laptop charging**: Emerging Qi support for ultrabooks and convertibles
- **IoT sensors**: Wireless charging for battery-powered sensors
- **Retail and hospitality**: Customer device charging amenities
- **Wearables**: Fitness trackers, smart rings

## Decoder Configuration

When configuring a logic analyzer to decode Qi wireless charging signals:

### Signal Monitoring Approach

Qi uses inductive coupling and load modulation, making direct digital signal capture challenging. Typical approaches include:

**Option 1: Monitor Demodulated Digital Signals**
- Capture digital ASK/FSK output from controller's demodulation block
- Requires access to test points on transmitter or receiver PCB
- Provides clean packet data ready for protocol decoding

**Option 2: Monitor Power Coil Current/Voltage**
- Use current probe on transmitter coil to observe ASK modulation
- Capture receiver coil voltage with differential probe to see FSK modulation
- Requires analog channels or external demodulation

**Option 3: Controller Debug Interface**
- Some Qi controller ICs provide debug UART, SPI, or I²C outputs
- Captures communication messages without RF analysis

### Channel Assignment (Digital Demodulated Signals)

**For Receiver-to-Transmitter (ASK at 2 Kbps):**
- **ASK_DATA**: Demodulated ASK data signal from transmitter controller
- **ASK_CLK**: Optional recovered clock signal (if available)

**For Transmitter-to-Receiver (FSK at 200 Kbps):**
- **FSK_DATA**: Demodulated FSK data signal from receiver controller
- **FSK_CLK**: Optional recovered clock signal (if available)

**Supporting Signals:**
- **ENABLE**: Transmitter enable/power signal
- **ERROR**: Error indication signal
- **STATUS**: Charging status indicators

### Protocol Parameters

- **ASK bit rate**: 2000 bps
- **FSK bit rate**: 200,000 bps
- **Bit encoding**: Manchester encoding or differential encoding (per WPC spec version)
- **Packet format**: WPC Qi specification format
- **Byte order**: MSB first (typically)

### Decoding Options

- **Packet decoding**: Parse preamble, header, payload, checksum
- **Message type identification**: Decode message IDs (0x01, 0x02, 0x03, etc.)
- **Control Error visualization**: Plot power adjustment requests over time
- **Signal Strength mapping**: Track receiver position optimization
- **Power level tracking**: Monitor Received Power Reports
- **Phase identification**: Annotate Selection, Ping, Configuration, Power Transfer phases
- **Checksum validation**: Verify packet integrity
- **Timing analysis**: Measure packet intervals and response times

### Trigger Configuration

- **Packet trigger**: Trigger on specific message types (e.g., Identification, Control Error)
- **Phase transition**: Trigger on End Power Transfer or Start Power Transfer
- **Error condition**: Trigger on specific error codes
- **Signal strength**: Trigger on Signal Strength Packet with specific threshold
- **Power negotiation**: Trigger on Configuration Packet

### Analysis Tips

When analyzing Qi wireless charging communications:

1. **Identify charging phase**: Look for message sequence patterns (Identification → Configuration → Control Error loop)
2. **Monitor Control Error packets**: Frequency and magnitude indicate charging stability and efficiency
3. **Check Signal Strength**: Initial Signal Strength Packets indicate alignment quality
4. **Validate checksums**: Ensure packet integrity throughout charging session
5. **Observe timing**: Control Error packets should arrive approximately every 250ms during Power Transfer
6. **Track power negotiation**: Configuration Packet indicates maximum power contract
7. **Analyze failures**: End Power Transfer messages may include reason codes
8. **Foreign object detection**: Look for unexpected load changes or communication disruptions

### Common Protocol Patterns

**Successful Charging Start Sequence:**
1. Transmitter: Digital Ping (periodic)
2. Receiver: Signal Strength Packet (0x01) with value 0-255
3. Receiver: Identification Packet (0x71) with version/ID
4. Receiver: Configuration Packet (0x51) requesting power level
5. Transmitter: Acknowledges and begins power transfer
6. Receiver: Control Error Packets (0x03) every ~250ms
7. Receiver: Periodic Received Power Packets (0x04)

**Power Adjustment Pattern:**
1. Receiver measures voltage and compares to target
2. Receiver sends Control Error Packet with +/- value
3. Transmitter adjusts frequency or duty cycle
4. Cycle repeats until error converges to zero

**Charging Completion:**
1. Receiver battery reaches full charge
2. Receiver sends End Power Transfer (0x02) with completion code
3. Transmitter stops power transfer
4. Returns to Selection/Ping phase

**Foreign Object Detection:**
1. Receiver reports unexpected Received Power values
2. Comparison of transmitted vs. received power indicates losses
3. If threshold exceeded, transmitter sends End Power Transfer

## Reference

- [Wireless Power Consortium (WPC) Official Site](https://www.wirelesspowerconsortium.com/)
- [Qi Specification Documentation](https://www.wirelesspowerconsortium.com/knowledge-base/qi-specification/)
- [Wikipedia: Qi Wireless Charging Standard](https://en.wikipedia.org/wiki/Qi_(standard))
- [Renesas: Introduction to In-band Communication of Qi-based Wireless Power Designs](https://www.renesas.com/in/en/document/apn/introduction-band-communication-qi-based-wireless-power-designs)
- [NXP AN4701: Demodulating Communication Signals of Qi-Compliant Wireless Charger](https://nxp.com/docs/en/application-note/AN4701.pdf)
- [Granite River Labs: Evolution of Qi Wireless Charging Standard & Qi2](https://www.graniteriverlabs.com/en-us/technical-blog/qi2-wireless-charging-standards-evolution)
