# Specifications

<!-- Source: Acute_TLmanual_en.pdf, Chapter 1, Pages 8-10 -->

Technical specifications for TravelLogic series logic and protocol analyzers.

## Hardware specifications

| Model | TL3017E | TL4134E | TL3134E | TL4134B | TL3134B | TL4234B | TL3234B+ |
|-------|---------|---------|---------|---------|---------|---------|----------|
| **Power** |
| Power source | USB bus-power (+5V) |
| Static power consumption | 0.75W |
| Max power consumption | <2.5W |
| **Hardware interface** | USB3.0 |
| **Timing Analyzer (Asynchronous, Max. sample rate)** | 1GHz | 2GHz |
| **State clock rate (Synchronous, external clock)** | 250MHz / 200MHz |
| **Storage** | Conventional Timing, Transitional Timing |
| **Channels (Data / Clock / Analog / Ground)** | 16 / 1 / 1 / 2 | 32 / 2 / 2 / 4 |
| **Total memory** | 16Mb | 1Gb | 8Gb |

## Timing Analyzer

### Available channels and memory

**Available channels (Conventional Timing, Transitional Timing) / Memory per channel**

| Sample rate | TL3017E | TL4134E | TL3134E | TL4134B | TL3134B | TL4234B | TL3234B+ |
|-------------|---------|---------|---------|---------|---------|---------|----------|
| 2GHz | 8 / 2Mb | 16 / 1Mb | (8/7)-512Mb, (4/3)-1Gb | (16/14)-256Mb, (8/7)-512Mb | (32/28)-128Mb, (16/14)-256Mb |
| 1GHz | 16 / 1Mb | 8 / 2Mb | (8/7)-1Gb, (4/3)-2Gb | (16/14)-512Mb, (8/7)-1Gb | (32/28)-256Mb, (16/14)-512Mb |
| 500MHz | 8 / 2Mb, 16 / 1Mb | (32/32)-128Mb | (32/32)-256Mb |
| 250MHz | | | (32/32)-128Mb | (32/32)-256Mb |
| 200MHz | | | (32/32)-128Mb | (32/32)-256Mb |

### Channel specifications

**Channel to channel skew:** <1ns

**Threshold:**

- Group: 4 (ch0~7, ch8~15 & clk0, ch16~23, ch24~31 & clk1)
- Range: +5V ~ -5V
- Resolution: 50mV
- Accuracy: ±100mV + 5%*Vth

**Non-destructive input voltage:** ±30V DC, 12Vpp AC

**Operation:**

- Impedance: 200KΩ//< 7pF | 20KΩ//< 3pF
- Threshold: +10V ~ -10V

### Analog inputs (Protocol Analyzer)

- Sensitivity: 0.25Vpp @50MHz, 0.5Vpp @150MHz, 0.8Vpp @250MHz
- Data channels: -0.5V ~ +8V DC + AC peak
- Analog channels: 0V ~ 4V
- Maximum (Non-destructive): 12 bits
- Operation resolution: 250KHz
- Sampling rate: (varies by model)

### Environmental

**Temperature:**

- Operating: 5℃~40℃ (41℉~104℉)
- Storage: -10℃~65℃ (14℉~149℉)

### I/O ports

- **Trig-In:** TTL 3.3V level (Rising / Falling), > 8ns
- **Trig-Out:** TTL 3.3V, pulse width
- **Ref. Clock Input:** 10MHz, Vpp=3.3 to 5V
- **Ref. Clock Output:** 10MHz, TTL 3.3V
- **Connector type:** MCX jack / female

### Trigger specifications

- **Resolution:** 500ps / 1ns | 500ps
- **Channels:** 16 | 32
- **States:** 16 | 16
- **Events:** Yes
- **Pre / Post:** Yes (0~1048575 times)
- **Pass Counter:** Range, Word, Channel, Width, Time-out, Single / Multi Level

## Supported protocols

### Bus I

**TL3000 series:**

- I2C

**TL4000 series:**

- eMMC4.5, eSPI, MIPI SPMI 2, NAND Flash, SD3.0, Serial Flash (SPI NAND), SVID2

### Bus II

**TL3000 series:**

- DP Aux¹, I2C, SPI, UART, USB PD3.0

**TL4000 series:**

- BiSS-C, CAN2.0B/CAN FD, DP Aux¹, HID over I2C, I2C, I2S, LIN2.2, SPI, UART (RS232), USB PD 3.0

### Bus III

**TL3000 series:**

- BiSS-C, CAN 2.0B/CAN FD, DALI, HID over I2C, I²S, I3C, LIN2.2, LPC, MDIO, MII, Mini/Micro LED, MIPI RFEE, Modbus, PMBus, Profibus, RMII, SMBus, SVI2, USB1.1

**TL4000 series:**

- DALI, I3C, LPC, MDIO, Mini/Micro LED, MIPI RFEE, MIPI SPMI 2, Modbus, PMBus, Profibus, SMSBus, SVI2, USB1.1

### Protocol Analyzer/Logger/Monitor support

**Bus I:**

**TL3000 series:** I2C

**TL4000 series:** eSPI, MII, RGMII, RMII, SVID3

**Bus II:**

**TL3000 series:** DP Aux¹, I2C, SPI, UART, USB PD3.0

**TL4000 series:** BiSS-C, CAN2.0B/CAN FD, DP Aux¹, HID over I2C, I2C, I2S, LIN2.2, SPI, UART (RS232), USB PD 3.0

**Bus III:**

**TL3000 series:** BiSS-C, CAN 2.0B/CAN FD, DALI, HID over I2C, I²S, I3C, LIN2.2, LPC, MDIO, MII, Mini/Micro LED, MIPI RFEE, Modbus, PMBus, Profibus, RMII, SMBus, SVI2, USB1.1

**TL4000 series:** DALI, I3C, LPC, MDIO, Mini/Micro LED, MIPI RFEE, MIPI SPMI 2, Modbus, PMBus, Profibus, SMSBus, SVI2, USB1.1, eMMC 4.5, eSPI, MII, NAND Flash, RGMII, RMII, SD 3.0 (SDIO2.0), SVID, Serial Flash (SPI NAND), SVID2, SVID3

## Software features

- **Zoom In / Out:** Yes
- **Language:** English / Simplified Chinese / Traditional Chinese
- **Waveform height:** Adjustable
- **Zoom / Report window:** Yes
- **Quick cursor-positioning:** Yes
- **Import label(s):** Yes
- **Quick bus decode setup:** Yes
- **Trigger / Auxiliary cursors:** 1/25
- **Data logger:** Yes
- **Bus decode:** Refer to the Acute_DeTrig_en.PDF
- **Line decoding:** Biphase Mark, Differential-Manchester, Manchester (Thomas, IEEE802.3), Miller, Modified Miller, NRZI, and more
- **Line encoding:** AMI (Standard, B8ZS, HDB3), Biphase Mark, CMI, Differential-Manchester, Manchester (Thomas, IEEE802.4), MLT-3, Miller, Modified Miller, NRZI, Pseudoternary, and more
- **Save to hard disk drive:** Yes

## Physical specifications

- **Dimensions (L × W × H):** 123 × 76 × 21 mm³
- **Lead cable (Data / CLK / Analog / GND):** 40-pin lead cable (32 / 2 / 2 / 4)
- **Grippers:** 20 | 40

---

## Notes

¹ Optional DP AUX adapter needed.

² Upon request ONLY by users who have signed CNDA with Intel, SVID decode supported by all TL4000 models.

³ Upon request ONLY by users who have signed CNDA with Intel, SVID trigger & PA supported by TL4234B ONLY.

*Specifications marked in BLUE (in the original PDF) are different from TL3000 series.*
