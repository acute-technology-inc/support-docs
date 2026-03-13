# 3-Wire

## What is 3-Wire Protocol?

### Overview

The 3-Wire protocol is a proprietary serial communication interface established by Holtek Semiconductor Inc. for controlling LED/LCD driver ICs and EEPROM devices. Unlike standard SPI which typically uses four lines (MOSI, MISO, SCK, and CS), the 3-Wire protocol simplifies connectivity by using only three essential signal lines: chip select (CS), clock (WR or SK), and a bidirectional data line (DATA). This reduction in pin count makes it particularly attractive for cost-sensitive applications and devices with limited I/O availability.

The protocol is specifically optimized for Holtek's product ecosystem, including LED matrix controllers, LCD segment drivers, and serial EEPROM memory devices. It provides a simple yet effective means of transferring configuration data, display patterns, and memory contents between a microcontroller and peripheral devices. The bidirectional nature of the data line allows both read and write operations using a minimal hardware interface.

### Key Features

The 3-Wire protocol offers several advantages for embedded system design. Its simplified three-signal interface reduces PCB routing complexity and connector pin requirements compared to standard four-wire SPI. The protocol supports flexible data transfer with configurable chip select polarity (active high or active low) and data edge selection (rising or falling edge), allowing designers to adapt to various system timing requirements.

For EEPROM applications, 3-Wire devices like the HT93LC66 and HT93LC46 support wide voltage operation (2.0V to 5.5V for reads, 2.4V to 5.5V for writes), making them suitable for both battery-powered and standard logic applications. The protocol's low-speed serial nature results in minimal electromagnetic interference (EMI), an important consideration for noise-sensitive applications.

## Signal Lines

### CS (Chip Select)

The chip select line controls when the target device is active and ready to receive commands. It can be configured as either active high or active low depending on the specific device requirements. The CS line must be asserted (activated) before any data transfer begins and must remain in the active state throughout the entire transaction.

### WR/SK (Write Clock/Serial Clock)

The clock line synchronizes data transfer between the master (typically a microcontroller) and the slave device (LED/LCD driver or EEPROM). Data is typically sampled on either the rising or falling edge of this clock signal, depending on the device configuration and application requirements.

### DATA (Bidirectional Data)

The DATA line carries information in both directions—from the master to the slave during write operations and from the slave to the master during read operations. The bidirectional nature requires proper timing control to avoid bus contention. Typically, the master drives the line during writes and tri-states its output during reads, allowing the slave to drive the line.

### RD (Read Clock - Optional)

Some 3-Wire implementations include a separate read clock line (RD) as a fourth signal, creating a "3+1 wire" configuration. This allows simultaneous read and write operations or provides clearer separation between read and write timing domains, though it deviates from the minimal three-wire configuration.

## Application Types

### LED Driver IC Applications

When interfacing with LED driver ICs, the 3-Wire protocol transfers display data, brightness control commands, and configuration settings. The master microcontroller sends display patterns that are stored in the driver's internal RAM, which then controls the LED matrix or digit outputs. Commands can configure features such as:

- Display on/off control
- Brightness levels (typically 16-step dimming)
- Blink rates and patterns
- Row/column scanning configurations

### LCD Driver IC Applications

For LCD segment drivers, the 3-Wire interface sends segment data and control commands to populate the driver's display memory. This controls which LCD segments are activated, enabling the display of alphanumeric characters, icons, and custom symbols. Configuration includes:

- Segment mapping and duty cycle
- Bias voltage selection
- Frame frequency control
- Power-saving modes

### EEPROM Applications

In EEPROM applications (HT93LC46, HT93LC66, and similar devices), the 3-Wire protocol facilitates reading, writing, and erasing non-volatile memory. The protocol supports various EEPROM operations:

- **Read**: Sequential or random access to memory locations
- **Write**: Programming individual addresses or pages
- **Erase**: Clearing specific addresses or the entire chip
- **Write Enable/Disable**: Protection control for data integrity
- **Organization Select**: Configuring word width (8-bit or 16-bit)

## Decoder Settings

When configuring a 3-Wire decoder:

- **Channel Assignment**: Specify which logic analyzer channels are connected to CS, WR, DATA, and optionally RD
- **Application Type**: Select LED Driver IC, LCD Driver IC, or EEPROM mode based on the device being analyzed
- **CS Polarity**: Choose Active High or Active Low based on the device specification
- **Data Edge**: Select Rising Edge or Falling Edge for data sampling to match the device timing requirements

## Common Applications

The 3-Wire protocol is commonly found in:

- Appliance control panels and displays
- Consumer electronics with LED indicators
- Automotive dashboard displays
- Industrial control panels
- Smart home devices with LED feedback
- Battery-powered devices requiring non-volatile storage
- Cost-sensitive embedded systems

## Reference

- [Holtek: Display Driver Products](https://www.holtek.com/page/vg/HT16K33A)
- [Holtek HT93LC66 3-Wire EEPROM Datasheet](https://www.alldatasheet.com/datasheet-pdf/pdf/64516/HOLTEK/HT93LC66.html)
- [Holtek HT93LC46 3-Wire EEPROM](https://www.alldatasheetde.com/html-pdf/348522/HOLTEK/HT93LC46/217/1/HT93LC46.html)
