# UART (RS-232)

## What is UART and RS-232?

### Overview

UART (Universal Asynchronous Receiver/Transmitter) is a hardware communication protocol that provides asynchronous serial communication between devices using two wires: one for transmitting (TX) and one for receiving (RX). Unlike synchronous protocols like SPI or I²C that require a shared clock signal, UART devices communicate asynchronously—each device has its own clock and synchronizes on a per-character basis using start and stop bits embedded in the data stream. This asynchronous nature makes UART ideal for situations where sending a shared clock signal is impractical, such as long-distance cables, optically-isolated communications, or simple point-to-point connections between devices.

RS-232 (Recommended Standard 232), formally TIA-232-F, is a specific electrical standard that defines voltage levels, connectors, and pin assignments for serial communication equipment. Introduced in 1960 and revised through 1997, RS-232 was historically the dominant standard for connecting computers to modems, terminals, printers, and other peripherals. While modern computers have largely transitioned to USB, RS-232 remains ubiquitous in industrial equipment, networking hardware, scientific instruments, and embedded systems due to its simplicity, reliability, and extensive legacy device support.

### UART vs. RS-232

**UART** refers to the protocol and hardware logic for async serial communication (start/stop bits, data format, timing). Modern UARTs use TTL or CMOS logic levels (0V/3.3V or 0V/5V).

**RS-232** specifies the physical layer—voltage levels (+/- 3-15V), connectors (DB-9, DB-25), and signal names (RTS, CTS, DTR, DSR). RS-232 uses higher voltages and inverted polarity compared to TTL UART.

Many modern embedded systems use "UART" to mean TTL-level serial (e.g., microcontroller TX/RX pins), while "RS-232" refers to the voltage-converted interface using MAX232 or similar chips.

## Technical Specifications

### Frame Structure

Each UART character frame consists of:

**Start Bit**:
- Always 0 (space)
- Signals beginning of character
- Allows receiver to synchronize

**Data Bits** (5-9 bits, typically 8):
- Actual payload data
- LSB transmitted first (usually)
- 8 bits = 1 byte, most common

**Parity Bit** (optional):
- **None**: No parity (most common)
- **Even**: Parity bit makes total 1s even
- **Odd**: Parity bit makes total 1s odd
- **Mark**: Parity bit always 1
- **Space**: Parity bit always 0

**Stop Bits** (1, 1.5, or 2 bits):
- Always 1 (mark)
- Marks end of character
- Provides inter-character spacing
- 1 stop bit most common; 2 for slower mechanical devices

**Common Formats**:
- **8N1**: 8 data bits, No parity, 1 stop bit (most common)
- **7E1**: 7 data bits, Even parity, 1 stop bit (legacy ASCII systems)
- **8N2**: 8 data bits, No parity, 2 stop bits

### Baud Rates

Baud rate is the bits-per-second transmission speed (including start/stop/parity bits):

**Common Rates**:
- 300, 1200, 2400, 4800, 9600, 19200, 38400, 57600, 115200 (standard)
- 230400, 460800, 921600, 1000000+ (high-speed, less universal)

**Standard Limitation**: RS-232 originally specified rates below 20 kbit/s, but modern implementations commonly exceed this.

**Calculation**:
- Actual data throughput = Baud rate / (1 start + data bits + parity + stop bits)
- Example: 115200 baud, 8N1 = 115200 / 10 = 11,520 bytes/second

### RS-232 Electrical Characteristics

**Voltage Levels** (RS-232):
- **Driver Output**: +5 to +15V = logic 0 (space), -5 to -15V = logic 1 (mark)
- **Receiver Input**: +3 to +15V = logic 0, -3 to -15V = logic 1
- **Noise Margin**: ±2V dead zone (-3V to +3V) for noise immunity

**TTL/CMOS UART Levels**:
- Logic 1 (mark): Vcc (typically 3.3V or 5V)
- Logic 0 (space): 0V (GND)

**Level Conversion**: MAX232, MAX3232, or similar chips convert between TTL and RS-232 voltage levels.

## RS-232 Control Signals

Beyond TX/RX, RS-232 defines handshaking signals:

**Hardware Flow Control**:
- **RTS** (Request To Send): Asserted by DTE when ready to receive
- **CTS** (Clear To Send): Asserted by DCE when ready to receive
- **RTS/CTS handshaking**: Prevents buffer overruns

**Modem Control**:
- **DTR** (Data Terminal Ready): DTE asserts when powered and operational
- **DSR** (Data Set Ready): DCE (modem) asserts when ready
- **DCD** (Data Carrier Detect): Modem asserts when carrier detected on phone line
- **RI** (Ring Indicator): Modem asserts when phone ringing

Modern non-modem applications often loop back or ignore these signals, using only TX/RX/GND.

## Connectors

**DB-9 (DE-9)**:
- 9-pin D-subminiature connector
- Most common RS-232 connector on modern equipment
- Pins: TX(3), RX(2), GND(5), RTS(7), CTS(8), DTR(4), DSR(6), DCD(1), RI(9)

**DB-25 (DB-25)**:
- 25-pin D-subminiature connector
- Original RS-232 standard connector
- Includes secondary channel and additional signals
- Rare on modern equipment

**DTE vs. DCE Pinout**:
- DTE (Data Terminal Equipment): Computer, terminal
- DCE (Data Communications Equipment): Modem
- TX/RX pins swapped between DTE and DCE
- Null modem cables swap pins to connect two DTE devices directly

## Common Configurations

**Minimal Three-Wire**:
- TX, RX, GND only
- No hardware flow control
- Most common modern configuration
- Software flow control (XON/XOFF) if needed

**Five-Wire with Handshaking**:
- TX, RX, GND, RTS, CTS
- Hardware flow control prevents data loss
- Recommended for high-speed or unreliable connections

**Full RS-232**:
- All signals per specification
- Required for true modem communication
- Rare in modern applications

## Decoder Configuration

When configuring a UART decoder:

- **TX/RX Channels**: Assign logic analyzer channels to transmit and receive lines
- **Baud Rate**: Set transmission speed (often auto-detectable)
- **Data Format**: Specify data bits (5-9), parity (N/E/O), stop bits (1/1.5/2)
- **Bit Order**: LSB first (typical) or MSB first
- **Idle State**: Usually high (mark)
- **Polarity**: Select normal or inverted (RS-232 inverted relative to TTL)
- **Display Format**: ASCII, HEX, decimal, binary
- **Flow Control**: Show RTS/CTS if analyzing hardware handshaking

## Common Applications

UART/RS-232 appears throughout electronics:

**Industrial**:
- PLCs and industrial controllers
- SCADA systems
- Measurement and test equipment
- Barcode scanners
- CNC machine tool communication

**Networking**:
- Router and switch console ports (Cisco, Juniper)
- Network management
- Out-of-band access

**Embedded Systems**:
- Debug console output
- Bootloader communication
- Firmware updates
- Sensor data readout

**Scientific**:
- Laboratory instruments
- Data loggers
- Weather stations
- Telescope controllers

**Consumer**:
- GPS receivers
- Point-of-sale terminals
- Legacy peripherals (mice, modems)

**IoT**:
- LoRa/LoRaWAN modules
- Cellular modules (AT command interface)
- WiFi modules
- Zigbee coordinators

## Advantages

- **Simple**: No complex protocol or arbitration
- **Universal**: Supported by every microcontroller
- **Asynchronous**: No shared clock required
- **Long Distance**: RS-232 reliable up to 15 meters; industrial variants (RS-422/RS-485) much longer
- **Low Cost**: Minimal hardware requirements
- **Full-Duplex**: Simultaneous send/receive
- **Proven**: Decades of deployment and debugging experience

## Disadvantages

- **Point-to-Point**: No multi-drop (without RS-485 conversion)
- **Manual Configuration**: Must match baud rate, format at both ends
- **No Error Recovery**: No built-in retransmission
- **Limited Distance**: TTL UART <few meters; RS-232 <15m without repeaters
- **No Standards**: Many vendor-specific variations
- **Connector**: DB-9 connectors bulky compared to modern USB

## Reference

- [TIA-232-F Standard (RS-232)](https://www.normsplash.com/Samples/TIA/127475168/TIA-232-F-1997-(R2012)-en.pdf)
- [Analog Devices: Fundamentals of RS-232 Serial Communications](https://www.analog.com/en/resources/technical-articles/fundamentals-of-rs232-serial-communications.html)
- [Wikipedia: RS-232](https://en.wikipedia.org/wiki/RS-232)
- [The RS-232 Standard](https://mil.ufl.edu/4744/docs/RS232_standard_files/RS232_standard.html)
