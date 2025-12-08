# TravelLogic 2 in 1 Analyzer (Protocol + Logic) Manual

**Publish: 2024/12**

**Acute Technology Inc.**  
**Copyright©2024**

---

## Table of Contents

### Chapter 1: Installation and Setting

- [Hardware Installation](#hardware-installation) ................................................................................... 3
- [Software installation](#software-installation) ..................................................................................... 4
- [SDK](#sdk) ................................................................................................................... 6
- [gRPC](#grpc) ................................................................................................................. 7
- [Specification Table](#specification-table) ........................................................................................ 8

### Chapter 2: Function list and operation

#### Protocol Analyzer ........................................................................................ 11

- [File](#file) ....................................................................................................................... 11
- [Keyboard Shortcuts](#keyboard-shortcuts) ....................................................................................... 15
- [Capture](#capture) ............................................................................................................... 16
- [Cursor](#cursor) ................................................................................................................. 29

#### Logic Analyzer .............................................................................................. 30

- [File](#file-1) ....................................................................................................................... 31
- [Keyboard Shortcuts](#keyboard-shortcuts-1) ....................................................................................... 41
- [Capture](#capture-1) ............................................................................................................... 42
- [Advanced Capture Setting](#advanced-capture-setting) ............................................................................... 56
- [Cursor](#cursor-1) ................................................................................................................. 59
- [Waveform Area](#waveform-area) ................................................................................................. 62
- [Report Area](#report-area) ........................................................................................................ 64
- [Bus decode Settings](#bus-decode-settings) ........................................................................................ 65
- [Customized Report Settings](#customized-report-settings) ........................................................................... 65
- [Timing Check](#timing-check) ................................................................................................ 66
  - [Time Sequence](#time-sequence) ................................................................................................. 66
  - [Column Items](#column-items) ................................................................................................... 66

### Chapter 3: Technical support ........................................... 78

### Appendix 1: Report List Advanced Instructions .............. 80

---

## Chapter 1: Installation and Setting

### Hardware Installation

Connect the USB 3.0 cable to the USB slot on the computer. After confirming that the connection is complete, you can turn on the software and connect the signal cable to the object to be tested for observation.

**Appearance and functions of the Master:**

- Indicator LED
- Reference clock out
- Reference clock in
- Trigger out
- Trigger in
- USB 3.0 Type B slot: connected with computer.
- Pin assignment:

---

### Software installation

**NOTE:** Since 2024, we will not provide x86(32 bit) software, only x64(64 bit) software. Whoever needs x86 software, please contact us.

Please visit the official website of Acute Technology Inc., go to the Download page->Software, and then select **[Logic Analyzer] Logic Analyzer (TL3000. TL4000 series)** to download the TravelLogic series software. After completion of installation, the "start icon" of TravelLogic series will appear on the desktop and the program set. User can select either one to start TravelLogic. After starting the software, the main menu screen will show up. You can choose to enter logic Analyzer or protocol Analyzer.

Or after entering the function window, you can select the icon below to add Logic Analyzer or Protocol Analyzer window.

Or click the Add Logic Analyzer or Add Protocol Analyzer window within the file functions.

For the first-time use, the following screen will show up. Please set up the working directory that you will surely use. It is recommended that you choose the hard disk with larger remaining space for the storage of the working directory.

---

### SDK

We provide SDK for user to control the software and hardware behavior.

- **Software behavior** (need to keep the software executing): User can monitor the software behavior by AqLAVISA Manager. Please check our official GitHub website: https://github.com/acute-technology-inc/aqvisa-grpc. Or find the label: Download→SDK(DLL)→[Logic Analyzer]AqLAVISA SDK, in our official website. Or contact us with e-mail.

- **Hardware behavior** (DO NOT need to keep the software executing): Please find the label, Download->SDK(DLL)->[Logic Analyzer] TravelLogic SDK；Or contact us with e-mail. Please note it, there has no any decode processing, only capture data and save.

---

### gRPC

We provide gRPC for user to remote control our device. Please check our official GitHub website: https://github.com/acute-technology-inc/aqvisa-grpc. Or search: "aqvisa-grpc". Or contact us with e-mail.

---

### Specification Table

| Model | TL3017E | TL4134E | TL3134E | TL4134B | TL3134B | TL4234B | TL3234B+ |
|-------|---------|---------|---------|---------|---------|---------|----------|
| **Power** |
| Power Source | USB bus-power (+5V) |
| Static Power Consumption | 0.75W |
| Max Power Consumption | <2.5W |
| **Hardware Interface** | USB3.0 |
| **Timing Analyzer (Asynchronous, Max. Sample Rate)** | 1GHz | 2GHz |
| **State Clock Rate (Synchronous, External Clock)** | 250MHz / 200MHz |
| **Storage** | Conventional Timing, Transitional Timing |
| **Channels (Data / Clock / Analog / Ground)** | 16 / 1 / 1 / 2 | 32 / 2 / 2 / 4 |
| **Total Memory** | 16Mb | 1Gb | 8Gb |

#### Timing Analyzer

**Available channels(Conventional Timing, Transitional Timing) / Memory per channel**

| Timing vs. Channels vs. Memory | | | | | |
|--------------------------------|---|---|---|---|---|
| 2GHz | 8 / 2Mb | 16 / 1Mb | (8/7)-512Mb, (4/3)-1Gb | (16/14)-256Mb, (8/7)-512Mb | (32/28)-128Mb, (16/14)-256Mb |
| 1GHz | 16 / 1Mb | 8 / 2Mb | (8/7)-1Gb, (4/3)-2Gb | (16/14)-512Mb, (8/7)-1Gb | (32/28)-256Mb, (16/14)-512Mb |
| 500MHz | 8 / 2Mb, 16 / 1Mb | (32/32)-128Mb | (32/32)-256Mb |
| 250MHz | | | (32/32)-128Mb | (32/32)-256Mb |
| 200MHz | | | (32/32)-128Mb | (32/32)-256Mb |

**Channel to channel skew:** <1ns

**Threshold:**
- Group: 4(ch0~7, ch8~15 & clk0, ch16~23, ch24~31 & clk1)
- Range: +5V ~ -5V
- Resolution: 50mV
- Accuracy: ±100mV + 5%*Vth

**Non-Destructive Input Voltage:** ±30V DC, 12Vpp AC

**Operation:**
- Impedance: 200KΩ//< 7pF | 20KΩ//< 3pF
- Threshold: +10V ~ -10V

**Analog Inputs(2) (Protocol Analyzer):**
- Sensitivity: 0.25Vpp @50MHz, 0.5Vpp @150MHz, 0.8Vpp @250MHz
- Data channels: -0.5V ~ +8V DC + AC peak
- Analog channels: 0V ~ 4V
- Maximum (Non-destructive): 12bits
- Operation Resolution: 250KHz
- Sampling Rate: 

**Temperature:**
- Operating/Storage: 5℃~40℃(41℉~104℉) / -10℃~65℃(14℉~149℉)

**I/O port:**
- Trig-In: TTL 3.3V level(Rising / Falling), > 8ns
- Trig-Out: TTL 3.3V, pulse Width
- Ref. Clock Input: 10MHz, Vpp=3.3 to 5V
- Ref. Clock Output: 10MHz, TTL 3.3V
- Connector type: MCX jack / female

**Trigger:**
- Resolution: 500ps / 1ns | 500ps
- Channels: 16 | 32

**States:** 16 | 16

**Events:** Yes

**Pre / Post:** Yes (0~1048575 times)

**Pass Counter:** Range, Word, Channel, Width, Time-out, Single / Multi Level

**Types:**

#### Bus I

**TL3000 series:**
- I²C

**TL4000 series:**
- eMMC4.5, eSPI, MIPI SPMI 2, NAND Flash, SD3.0, Serial Flash (SPI NAND), SVID2

#### Bus II

**TL3000 series:**
- DP Aux1, I²C，SPI，UART，USB PD3.0

**TL4000 series:**
- BiSS-C, CAN2.0B/CAN FD, DP Aux1, HID over I2C, I2C, I2S, LIN2.2, SPI, UART (RS232), USB PD 3.0

#### Bus III

**TL3000 series:**
- BiSS-C, CAN 2.0B/CAN FD, DALI, HID over I²C, I²S, I3C, LIN2.2, LPC, MDIO, MII, Mini/Micro LED, MIPI RFEE, Modbus, PMBus, Profibus, RMII, SMBus, SVI2, USB1.1

**TL4000 series:**
- DALI, I3C, LPC, MDIO, Mini/Micro LED, MIPI RFEE, MIPI SPMI 2, Modbus, PMBus, Profibus, SMSBus, SVI2, USB1.1

#### Protocol Analyzer/Protocol Logger/Protocol Monitor

**Bus I:**

**TL3000 series:**
- I²C

**TL4000 series:**
- eSPI, MII, RGMII, RMII, SVID3

**Bus II:**

**TL3000 series:**
- DP Aux1, I²C，SPI，UART，USB PD3.0

**TL4000 series:**
- BiSS-C, CAN2.0B/CAN FD, DP Aux1, HID over I2C, I2C, I2S, LIN2.2, SPI, UART (RS232), USB PD 3.0

**Bus III:**

**TL3000 series:**
- BiSS-C, CAN 2.0B/CAN FD, DALI, HID over I²C, I²S, I3C, LIN2.2, LPC, MDIO, MII, Mini/Micro LED, MIPI RFEE, Modbus, PMBus, Profibus, RMII, SMBus, SVI2, USB1.1

**TL4000 series:**
- DALI, I3C, LPC, MDIO, Mini/Micro LED, MIPI RFEE, MIPI SPMI 2, Modbus, PMBus, Profibus, SMSBus, SVI2, USB1.1
- eMMC 4.5, eSPI, MII, NAND Flash, RGMII, RMII, SD 3.0(SDIO2.0), SVID, Serial Flash (SPI NAND), SVID2
- eSPI, MII, RGMII, RMII, SVID3

#### Software Features

**Zoom In / Out:** Yes

**Language:** English / Simplified Chinese / Traditional Chinese

**Waveform Height:** Adjustable

**Zoom / Report Window:** Yes

**Quick Cursor-positioning:** Yes

**Import Label(s):** Yes

**Quick Bus Decode Setup:** Yes

**Trigger / Auxiliary cursors:** 1/25

**Data Logger:** Yes

**Bus Decode:** Refer to the Acute_DeTrig_en.PDF

**Line Decoding:** Biphase Mark, Differential-Manchester, Manchester (Thomas, IEEE802.3), Miller, Modified Miller, NRZI, …

**Line Encoding:** AMI(Standard，B8ZS，HDB3)，Biphase Mark，CMI，Differential-Manchester, Manchester (Thomas, IEEE802.4)，MLT-3, Miller, Modified Miller, NRZI, Pseudoternary, …

**Save to Hard Disk Drive:** Yes

**Dimension L x W x H (mm³):** 123 x 76 x 21 (mm³)

**Lead Cable (Data / CLK / Analog / GND):** A 40-pin lead cable (32 / 2 / 2 / 4)

**Grippers:** 20 | 40

---

**Notes:**

¹ Optional DP AUX adapter needed.

² Upon request ONLY by users who have signed CNDA with Intel, SVID decode supported by all TL4000 models.

³ Upon request ONLY by users who have signed CNDA with Intel, SVID trigger & PA supported by TL4234B ONLY.

Specifications marked in BLUE are different from TL3000 series.

---

## Chapter 2: Function list and operation

### Protocol Analyzer

#### File

- **Open file:** Load the file
- **Save:** Save the current window to file
- **Save as:** Save with a new file name with specified storage range
- **Save all:** Save all Protocol Analyzer/Logic Analyzer windows to files
- **Add Protocol Analyzer:** Add a Protocol Analyzer window
- **Add Logic Analyzer:** Add a Logic Analyzer window
- **Convert to Logic Analyzer:** When the "show waveform" capture mode is enabled, you can click this function to transfer the waveform and setting parameters into the Logic Analyzer window and continue to use the Logic Analyzer window to capture Protocol.
- **Stack Oscilloscope:** You may stack a DSO to become a MSO under the Protocol Analyzer mode. But, you must choose the "show waveform" capture mode to capture the protocol data with the waveforms. Then, click the DSO icon to enter the Logic Analyzer window.
- **Language:** Display language. You can select English, Traditional Chinese, or Simplified Chinese
- **Options:** Here you can set the working directory, the label height, whether to load the last setting, the waveform display mode and its color.

**Options Settings:**

1. **Default Label Height:** Modify the channel height of the waveform area.
2. **Working Directory:** The directory where the temporary files and waveforms are stored when the software is in operation.
3. **Waveform Display Type:** Select which information to display between waveform edges. You can select either display time value, logic value or not to display.
4. **Expanded waveform color:** You can choose whether the colors are different between channels.
5. **Load Last Environment on Software Start:** When the software starts, load the settings as the file that was previously closed, waveforms will not be loaded.
6. **Save Waveform After Each Acquisition:** This file is stored in the working directory.
7. **Repeat Acquisition Behavior:** Whether to display waveform decoding, to display, choose display time (1/2/5 s).
8. **Display row number in LA Decode Report:** Show row number on the left to the reporting area.
9. **Trigger Out Pulse Width (us):** The default length is from trigger point to the end of capture. The following 2 items will be controlled by the cursor, which will display the contents of the "Select Cursor", which can be set in the waveform area shift and A-Z, and moved to the cursor position by pressing A-Z (T is the trigger point mark, not available).
10. **Show Waveform Value Tooltip on Cursor Position:** Show numbers of used channels, show additional names for bus decode.
11. **Auto-reconnect device:** Reconnect the device while re-plug the USB after device offline.
12. **Show Channel Information In Waveform Display:** Display the channel number in waveform area.
13. **Show Value Information in Waveform Display:** Digital channels display 0/1, analog channels display the voltage value.
14. **Show Trigger Information in Waveform Display:** Display trigger setting values.
15. **Show Channel Activity In Waveform Display:** Sum up the change types of the edge channel of the captured waveform.
16. **Use Multicore Processing:** Use multi-core to speed up data processing.
17. **Display Report Timestamp Information:** Display the timestamp column with timing info format / timing info with date time format (trigger point is at 0 s) / sample count format.
18. **Show Cursor Position in Decode/Transition Report:** Show cursor position in the report area time field.
19. **Show Cursor Separate Time on Cursor bar:** Add additional time between cursors on the horizontal timeline of the waveform area.
20. **Cursor Font Size in Report Area:** Cursor font size for cursor position in decode/transition report (refer to item 18).
21. **Report Data Display Byte Number:** This is an item set for protocol analyzer mode, and you can modify the report field to show the number of Bytes.
22. **Display Waveform Time Scale Dash Line:** Add dash lines on the waveform area to correspond time line to report area.
23. **Enable Label Combine by Mouse Dragging:** Use the left mouse button to drag a channel label onto another channel label to combine channels.
24. **Max. Logic Analyzer Cursor Measurement Tab Count:** Displays the number of groups of cursor measurement values in the lower right corner. Minimum of 3 groups, maximum of 10 groups.
25. **Detail Report Byte Numbers:** Set the limitation of displaying byte number of each detail report.

**Font Settings:** User can set the font type and font size that used in display the text in waveform area, note and label.

---

#### Keyboard Shortcuts

| Function | Key |
|----------|-----|
| Move to cursor position | A-Z |
| Add a cursor to the mouse position | Shift + A-Z |
| Start capture | Enter |
| Stop capture | ESC |
| Search | F3 or Ctrl+F |
| Zoom In on waveform area | Number Pad + |
| Zoom Out on waveform area | Number Pad - |

---

#### Capture

##### Protocol Settings

**Style 1 for those protocols with easy setting**

1. Select the Protocol
2. Channel setting
3. Waveform Preview: The signal's waveform and frequency is automatically detected.
4. Options: You can set the capture and decoding parameters for Protocol.
5. Threshold: It can be set according to the voltage level of the signal.

**Style 2 for those protocols needs more setting**

1. Select the Protocol
2. Set the Sample Rate
3. Channel setting
4. Trigger on
5. Options: You can set the capture and decoding parameters for Protocol.
6. Threshold: It can be set according to the voltage level of the signal.

---

##### Operating mode and memory setting

There are three modes for operating mode and memory setting.

**Mode 1: Protocol Analyzer**

**Functional description:**

Captured data will be sent back to the PC for real time display. You can immediately see the protocol data right away.

**Rule:**

1. Data can be seen immediately.
2. If the amount of captured data is not big, you do not have to set the amount of memory.

**Notice for use:**

- As data will be captured and displayed at the same time the performance requirement for the USB and the computer will be higher.
- If the computer cannot handle the data in time, the device may automatically stop due to full memory.
- If software is in operation during the capture period the computer will respond more slowly.

**Rules for repetitive times and automatic stop:**

**Repetitive Times:**

- If it is not enabled, the device will be stopped after the stop condition matched.
- If it is enabled, the device will be stopped after the stop condition matched, then save the captured data and repeat the captures again, according to the number of captures that has been set.
- If the number of captures is set at 0, the device will capture data repetitively.

**Two Stop Conditions to stop the device automatically are provided as follows:**

- **Number of Data Lines:** Stop the capture when the stored data line number matched the setup data line number, you can select this function if you need only sufficiently number of data lines without capturing data for a long time. This function is set to OFF by default.
- **Maximum Device Memory Limit:** Stop the capture when the device memory is filled to the set condition.

---

**Mode 2: Protocol Logger**

**Functional description:**

Data will be sent back to the PC for saving without being processed and displayed. Only after the user presses to stop the operation will data begin to be processed and displayed.

**Rule:**

1. As long as the hard disk is big enough to respond quickly enough, it can save a great amount of data.
2. Logger file (.LOG) can be opened for Analyzer later, no need to analyze them right after their capture

**Notice for use:**

1. Performance requirements for the USB and the computer (hard disk) are high.
2. Due to the large amount of logger data, the requirements for the hard disk space and the time for follow up Analyzer will be very great.

**Run data process after capture stopped:**

Check this option to process the data after Logger capture stopped, or the software will only save the logger data without analyzing process.

You can reload the .LOG file from Load file to reanalyze the data.

Whether you check the results immediately or load them into the file, the file name will be converted from LOG to TLW.

---

**Mode 3: Protocol Monitor**

**Functional description:**

Data will be kept in the device and overwrote the old data without returning to the PC, the capture can be stopped by user manually or by trigger condition matched, then the device will fill the device memory until memory full and return to PC for display.

**Rule:**

1. During the capture period, data are not returned to the PC, reducing the performance requirements on the USB and the computer.
2. The total amount of data is the total amount of device memory.
3. Trigger conditions can be set and monitored for a long time Device memory will be filled only when the amount of data matches the trigger conditions.

**Notice for use:**

1. If the trigger is not set or you have set the trigger but want to retrieve the data before the memory is full, you must manually press "Stop" to send data back to the computer.

**Work options:**

- **Maximum Device memory limit:** If the checkbox is unchecked, the max memory of the device is used. If the checkbox is checked, the usage ratio of the device memory can be adjusted; less memory can shorten the subsequent processing time.

- **Data capture will continue until "Stop" is pressed (Wait for stop):** Data capture will continue. If memory is full the new data will be still captured to replace the old data, until "Stop" is pressed Then the newest data will be sent back to the computer.

- **Data capture will continue until the trigger condition is met (Wait for Trigger):** If the trigger condition is not set, there will be no Pre/Post Trigger relationship and only the Capturing will be shown until the device memory is full.

If the trigger condition is set, user can do more detail setting of software behavior after triggered.

  - **Fill the device memory then stop:** Fill the rest memory with data, according to the trigger position, then stop.
  - **Stop immediately:** Stop capturing immediately since triggered. The rest memory will not be filled.
  - **Wait for seconds then stop:** Since triggered, software will keep capturing data with seconds that user set, then stop. But if the rest memory full first, capturing stop.

Data will be filled according to the set Trigger Position. Data capture will continue until the trigger condition and the after triggered software behavior setting is met, or "Stop" is pressed. Then, data capture will stop and the set memory will be filled.

---

##### Show Waveforms

If "Show Waveforms" is selected, the device will capture the waveform data, but show the waveforms only after the capture stops. Selection of Show Waveforms will take up more device memory.

When "Show Waveforms" is enabled, the waveform area will provide the following functions:

1. **Bus Decode:** Press this button to refresh the bus decode.
2. **Stop the bus decode:** This button can stop the bus decode right away.
3. **Add User Notes**
4. **Waveform zoom in / out:** This button can scale up or down the waveforms, but it is recommended to use the mouse cursor to zoom the waveforms in or out for your convenience.

---

##### Search

Search function can search data in the report window.

1. Enter the search text: A mark will appear in front of the data meeting the search criteria.
2. Search the previous piece / the next piece of data.
3. Specifiy all fields or target fields for search. Specifiy fields for search can reduce the search range, thus speeding up the search.

In actual search, the searched data will be shown in green background color togther with the total number of packets found. If no data is found, the search result will be shown in orange background color.

---

##### To bottom

When viewing data, you press this button to move directly to the last end of data. If you press this button while the device is capturing data, the most up-to-date data will be displayed.

---

##### Window

Select to enable/disable multiple display report, such as: Report List, Show Both Report…etc.

1. Select different display list.
2. Use the control buttons to move the current position, or input row number to jump to specified row.
3. Use the control buttons to add /remove selected row to Bookmark List.

For detailed usage steps, please refer to Appendix 1: Report List Advanced Instructions.

---

##### Saved as text file

Contents of the report may be saved as .TXT or .CSV.

**Save options:**

1. You can select to save the data as a file or according to the number of rows.
2. Advanced reports: If it was checkd, the detailed data would be saved.
3. Splitting timestamp into separate timestamp and duration columns: If it was checked, the timestamp column would be separated into to two columns, timestamp and duration time. (It was combined together by default).
4. Maximum saving byte per column: Set the limitation of byte numbers in one column.

---

##### Detail window

Many protocols contain a large number of numerical data, it is not suitable to display in the report window at one time, so User can click the Data column of the report window with the mouse first, and the data will be displayed in the detail window.

---

##### Statistics window

According to protocols' different characteristics, statistics are made to understand the entire transmission situation, User may also click on the statistic trace to summarize all records of the selected trace into the statistic list window.

For detailed usage steps, please refer to Appendix 1: Report List Advanced Instructions.

---

##### Hide Data window

In this screen, you can select to hide the data items. Software is used in this function to hide data and to restore the data as long as you click the "Clear" botton.

---

##### Stack Oscilloscope

The stack oscilloscope can only be enabled in the Logic Analyzer mode. If you want to enable the stack oscilloscope in the protocol Analyzer mode, you must first press the "Convert to Logic Analyzer and Stack Oscilloscope" button to switch to the Logic Analyzer mode to enable this function. It should be noted that you must open Show Waveforms in the Protocol Analyzer mode and capture the data / waveform to switch.

---

#### Cursor

This function includes the cursor setting and the waveform search function matching the cursor.

But it can only be operated while the 'Show Waveform' function was turned on. Otherwise, user will see these buttons turn gray and disabled.

---

### Logic Analyzer

**Main Window Components:**

1. **Toolbar:** Including trigger, sampling rate, threshold and other capture parameters.
2. **Channel Label:** You can use the icon below to add and delete the channel. Pressing mouse left button on the channel label to change the channel parameter settings; Click the gear button on the top-right corner of the Bus channel to change the advanced parameter settings; Select and drag a channel label to other channel label to combine two or more channel labels.
3. **Report Window Toolbar:** In the report window, you can choose to display the channel data or decode result, waveform statistics, and report the result as .CSV and .TXT output.
4. **Status Bar:** Connection status of the device is displayed.
5. **Info:** Display channel, Value and Trigger information, can be selected to Show/Hide in Environment settings.
6. **Waveform Area:** Mouse wheel can be used to zoom in/out the waveform scale; press Shift + Key to place cursors to calculate the time interval or frequency. Please refer to the cursor section below for the cursor usage.

---

#### File

- **Open file:** Load the file
- **Save file:** Save the current file
- **Save as:** Save with a new file name and may set the storage range

User can save file as:

1. TravelLogic files (*.TLW)
2. Transitional Text File(*.txt)
3. Text File(*.txt)
4. Matlab Array File(*.m)
5. Binary Data File(*.bin)
6. TravelLogic files + Report file (*.TLW + *.TXT)
7. Value Change Dump (*.vcd)
8. Timestamp Binary File (*.bin)
   - i. 64b time + 16b data
   - ii. 64b time + 32b data
   - iii. 64b time + 64b data
   - iv. 64b time + 128b data

The format of Timestamp Binary File is, the first 64 bits represented time, the rest bits used to present data.

In this figure, the green block represents time, the red block means data. Take the values shown in this figure as an example, the data from left to right represents the direction from lsb to msb, so for the second line of data, the archive value is 0010b = 0x02. Note that if you choose a data bit archive format that is less than the number of channels, the extra bits will be discarded.

- **Save all:** Save all files at once

- **Saved as a DGW / PGV file:** Convert captured waveform to DGW / PGV format for the Acute Digital Data Generator(PKPG、PG2000、DG Series、TD Series), which can be used to resend the digital signals.

**DGW / PGV File Settings:**

1. **Select PG Model:** The software will check the maximum working frequency and memory depth according to the selected PG model.
2. **Enter a file name or browse:** Enter a file name and directory to save the converted PGV file.
3. **Save range:** Select the waveform range to convert to PGV file, you may select either waveform within cursor range, or select maximum available range according to PG's maximum memory. (Exported file size larger than PG's maximum memory may not be opened by the PG's software.)
4. **Repeat output:** Check to add "Jump to start" command at the end of PGV file.
5. **Idle Convert Method:** Select to replace signal pulse width greater than specified time to a short block of waveform with Loop instructions to save the PG's memory. (The waveform will become more complicated and not easy to read/edit after enable this option.)
6. **PG Working Frequency:** Specify the PG working frequency.
7. **Waveform Convert Method:** When the LA's sampling frequency is faster than the PG's working frequency, the software provides two different ways to convert the PGV waveform, one is the real time sampling mode with PG's maximum working frequency (Small signal might be lost during the conversion), the other is convert the original high speed waveform to slower PGV waveform (Slower signal speed might introduce some signal timing issue since the setup/hold time will also be changed).

---

##### Import CSV (Require hardware device connected)

LA can convert digital or analog data stored in text format to TLW format file, and turn on viewing waveforms and analysis. This function is located in the toolbar -> File -> Import CSV

After opening, you can see a variety of formatting options. Select the loading format and file name to start the conversion. If you select DSO Text File or LA Text File, you must go to the next step for advanced settings. Please be noted that the DSO Text File format will only be enabled when you have the BF6264B, BF 7000 series, BF 7264 Pro, LA3068B, LA3134B, LA4068B, LA4136B, TL3134B, TL3234B+, TL4131B, TL4234B device connected.

**Import Format Options:**

1. **Agilent LA Module CSV text file:** After the file is opened by the Agilent LA software, the data can be exported through Export. Note that only the waveform file exported by the Module CSV text file is supported here. (You can find the option to export Module CSV Text File in Toolbar -> File -> Export... after opening .Ala file)

2. **Tektronix TLA Data Exchange Format:** After opening the file by the TLA software, first click the File->Export Data... button after outputting the top of the List screen. Note that only the TLA Data Exchange Format is supported here. Change to TLA Data Exchange Format.

3. **LA Text File:** This format still requires further confirmation of separators, data start and time fields, etc. after the file is selected. The data start line default will be treated as the channel label name

4. **DSO Text File:** When selecting the DSO waveform, multiple files can be selected for import. After the data is added, the data processing mode can be set individually.

The program default will check if the first ten lines of data are:
- (1). Sample Rate/Sample Interval
- (2). Trigger Position

And automatically entered the information into the settings

It is important to note that the numerical basic unit must be specified by the user

Ex: the default voltage unit is mV
- Data 1357 will be interpreted as 1.357V
- Basic unit selection uV
- Data 135790 will be interpreted as 0.13579V

When analyzing with the differential signal mode, it should be noted that the settings of the positive and negative channels must be the same, and the number of positive and negative channels must be matched to be able to analyze.

5. The user can import waveforms from other logic analyzer into LA for analysis by arranging waveform data according to the following format.

---

##### Batch Rpt. Save

Store the decode report to .CSV file from multiple captured waveform files.

**Batch Report Save Dialog:**

1. Select the source waveform files, accepting file formats including Acute Logic Analyzer Waveform File .TLW or .LAW.
2. Select the file directory to save the converted report file, the saved file will be saved with source file name with different extension name.
3. Select the saved file extension to .CSV or .TXT.
4. Select to use the decode settings in each file, or use the decode settings in specified file to generate the decode report.
5. Select to save the report in separated files or combine all reports into on file with separation text.
6. Select to include the timestamp column information.
7. Select to include the Header column information.

---

- **Add Protocol Analyzer:** Add a protocol Analyzer window
- **Add Logic Analyzer:** Add a logic Analyzer window
- **Language:** Display language. You can select English, Traditional Chinese, or Simplified Chinese
- **System environment settings:** Here you can set the working directory, the label height, whether to load the last setting, the waveform display mode and its color.

**System Environment Settings:**

1. **Default Label Height:** Modify the channel height of the waveform area.
2. **Working Directory:** The directory where the temporary files and waveforms are stored when the software is in operation.
3. **Waveform Display Type:** Select which information to display between waveform edges. You can select either display time value, logic value or not to display.
4. **Expanded waveform color:** You can choose whether the colors are different between channels.
5. **Load Last Environment on Software Start:** When the software starts, load the settings as the file that was previously closed, waveforms will not be loaded.
6. **Save Waveform After Each Acquisition:** This file is stored in the working directory.
7. **Repeat Acquisition Behavior:** Whether to display waveform decoding, to display, choose display time (1/2/5 s).
8. **Display row number in LA Decode Report:** Show row number on the left to the reporting area.
9. **Trigger Out Pulse Width (us):** The default length is from trigger point to the end of capture. The following 2 items will be controlled by the cursor, which will display the contents of the "Select Cursor", which can be set in the waveform area shift and A-Z, and moved to the cursor position by pressing A-Z (T is the trigger point mark, not available).
10. **Show Waveform Value Tooltip on Cursor Position:** Show numbers of used channels, show additional names for bus decode.
11. **Auto-reconnect device:** Reconnect the device while re-plug the USB after device offline.
12. **Show Channel Information In Waveform Display:** Display the channel number in waveform area.
13. **Show Value Information in Waveform Display:** Digital channels display 0/1, analog channels display the voltage value.
14. **Show Trigger Information in Waveform Display:** Display trigger setting values.
15. **Show Channel Activity In Waveform Display:** Sum up the change types of the edge channel of the captured waveform.
16. **Use Multicore Processing:** Use multi-core to speed up data processing.
17. **Display Report Timestamp Information:** Display the timestamp column with timing info format / timing info with date time format (trigger point is at 0 s) / sample count format.
18. **Show Cursor Position in Decode/Transition Report:** Show cursor position in the report area time field.
19. **Show Cursor Separate Time on Cursor bar:** Add additional time between cursors on the horizontal timeline of the waveform area.
20. **Cursor Font Size in Report Area:** Cursor font size for cursor position in decode/transition report (refer to item 18).
21. **Report Data Display Byte Number:** This is an item set for protocol analyzer mode, and you can modify the report field to show the number of Bytes.
22. **Display Waveform Time Scale Dash Line:** Add dash lines on the waveform area to correspond time line to report area.
23. **Enable Label Combine by Mouse Dragging:** Use the left mouse button to drag a channel label onto another channel label to combine channels.
24. **Max. Logic Analyzer Cursor Measurement Tab Count:** Displays the number of groups of cursor measurement values in the lower right corner. Minimum of 3 groups, maximum of 10 groups.
25. **Detail Report Byte Numbers:** Set the limitation of displaying byte number of each detail report.

**Font Settings:** User can set the font type and font size that used in display the text in waveform area, note and label.

---

#### Keyboard Shortcuts

| Function | Key |
|----------|-----|
| Move to cursor position | A-Z |
| Add a cursor to the mouse position | Shift + A-Z |
| Start capture | Enter |
| Stop capture | ESC |
| Search | F3 or Ctrl+F |
| Zoom In on waveform area | Number Pad + |
| Zoom Out on waveform area | Number Pad - |

---

#### Capture

**Operating Steps:** Quick Setting→Trigger→Sample Rate→Memory→Threshold

##### Quick Setting

Immediately configure required channels and related settings. When configuring specific bus decode, the sampling rate and threshold will also be set according to the default conditions.

---

##### Trigger Parameter Setting

**Manual Trigger:**

After setting up, Click "Stop" button to position trigger point.

**Single Level Trigger:**

1. **Channel / Label:** You can select Don't care (X), Rising Edge (↑), Falling Edge (↓), Low (0), High (1), Either or specified Value as trigger conditions.
2. **Pass Count:** The number of triggering signals that match the trigger parameters is ignored. It is preset as 0 by default to indicate that it is not ignored.

**Multi Level Trigger:**

Multi Level triggering is composed of multiple single-stage trigger conditions. This function can have up to 16 states, each of which must be set separately and set in the same way as the single level trigger. When adding a new state, you can press the button on the top to select the relationship between each state. The relationship between each state can be a continuous trigger (Next IF) or a non-continuous trigger (Then IF). This function is not supported when the sampling frequency is greater than or equal to 2 GHz.

1. Schematic diagram of the current set of trigger conditions
2. Trigger conditions setting

As shown in the following diagram, the first and the second classes are continuous trigger, the relationship between the second and third classes are non-continuous trigger, and the third, fourth, fifth and sixth classes are continuous trigger.

**Difference between the continuous trigger and the non-continuous trigger lies in:**

- **Continuous trigger:** The signal captured by two adjacent sample clocks must meet the conditions to trigger.
- **Non-continuous trigger:** It is triggered only when both the first condition and the second condition are met, no matter how many signals appear in between the first condition and the second condition. Therefore, such a trigger condition is not continuous at all.

A continuous trigger mode is usually set when Synchronous or State is used for measurement, because the use of synchronous clock is usually in a measurement state, and the signal is in a continuous state. Under the Asynchronous or Timing situation, it is common for the signal at the changing edge to meet the continuous triggering condition, while it is difficult for most of the signals to meet the conditions of continuous triggering, and therefore it is suitable to set non-continuous trigger as a condition for them.

3. The area to set the trigger condition for each class.
4. **OR IF** is the condition for establishing a parallel trigger. At this point, each set of trigger conditions are judging the conditions at the same time. It is triggered when any set of conditions is met.
5. **Sequence by:** The user can also set incidental conditions for triggering. In general, the data taken at the sampling point are used for trigger settings. If you want the specified channel at the changing edge to be triggered only, you should use the "Sequence by" setting. With such a function, the user does not have to set trigger conditions for each change at the edge, but just focus on the data to be set.

For example, the signal data to be measured is valid only when the clock is at the rising edge. There are four data lines. In this case, you can set the Sequence by as Custom Rising, and then select the Clock pin as the valid condition for the data. Then, you can set the conditions for other data lines in accordance with Multi Level triggering conditions.

Sequence By function is only supported when the sampling frequency is below than or equal to 250 MHz.

**Width Trigger:**

The width trigger can set the trigger signal when the channel meets the trigger conditions and the length of the full pulse width.

**Timeout Trigger:**

Timeout trigger can set the time width for trigger conditions. When the signal duration exceeds the set value, it will produce a trigger signal without waiting until a complete pulse is formed.

**External Trigger:**

The Trigger In input pulse signal of the device is taken as the trigger condition

---

##### Device Memory Usage

1. **Device memory usage:** Setup the storage depth for capturing data, the capture will be stopped when reach the setup value.
2. **Recordable time:** Estimate the length of the actual capture waveform based on the current settings. The time estimation will be disabled when using Transitional Storage mode.
3. **Memory / Channel:** The device allocates available memory based on the number of channels selected. The less the number of channels in use, the more memory can be allocated per channel.
4. **Trigger position:** Percentage is used to set the trigger point in the memory. For example, if 50% is set, it indicates that up to 50% of the device memory will be retained to store the pre-trigger data.
5. **Capture Stop Condition:** User can set the stop condition.

---

##### Threshold

**Threshold Settings:**

The threshold is defined as follows: When the level of the captured signal is higher than the threshold, it is Logic High, while lower than the threshold is called Logic Low. From the quick setting, you can select to set the commonly used voltage level, and then adjust the voltage. It is proposed that the threshold of a signal voltage to be measured is set at the half of the signal voltage.

**Schmitt Circuit Threshold Mode:**

When the threshold is only one set of voltage and when the voltage is close to the threshold during the signal transition, the signal may be slowed down to allow the device to capture a signal that may be 0 or 1 at this critical point. This will cause trouble for viewing the waveform, as shown in Figure CH-01 below.

The use of a hardware surge filter (that is, Low-Pass Filter) may filter out the noise (Glitch) and solve this problem, but may filter out true noise or high frequency signals. Therefore, the use of hardware surge filter is not suitable for solving such problems.

Therefore, the appropriate approach is to use two sets of thresholds to determine the digital signal. In electronics, the use of Schmitt Trigger will cause the phenomenon of hysteresis on the voltage signal, thus eliminating noise interference and solving the phenomenon of signal jitter (transient state).

When using Schumacher Circuit functions, both channels must be used for measurements. Therefore, each measurement point must be connected with two test lines to form two sets of thresholds. As there is no limit on which set should be Threshold-High or Threshold High, you can arbitrarily select either one.

- Threshold of the first set is A0-A15
- Threshold of the second set is A16-A31

In actual wiring, the two sets must be paired. For example, A0 and A16 are paired, A1 and A17 are paired, and so on.

The rules for logic judgment are: The signal voltage to be measured must exceed Threshold-High to be logic 1, and when the signal drops, the signal voltage to be measured must be lower than Threshold-Low to be recognized as logic 0. Those signals between the Threshold-High and Threshold-Low are falling in the non-transposed area. The last logical state is shown as below:

**Set individual threshold on each Tip:**

User can detailly adjust the threshold of each tip while setting this checkbox be checked. Or even more, click the button, user can directly type the value in need.

---

##### Stack Oscilloscope

Using TravelLogic and the Oscilloscope Stack functions, you need to install the special software provided by each oscilloscope brand. The software names are shown in the following table.

| DSO brand | Software |
|-----------|----------|
| Acute | Acute DSO software |
| Gwinstek | Please download the GW USB driver from the Gwinstek website |
| Tektronix | Please download the TEKVISA CONNECTIVITY SOFTWARE from the Tektronix website. |
| Agilent/Keysight | Please download the KEYSIGHT IO LIBRARIES SUITE from the Keysight website. |
| LeCroy | Please download the NI-VISA and Drivers from the NI website. |
| HAMEG | Please download the NI-VISA and Drivers from the NI website. |
| Rohde & Schwarz | Please download the NI-VISA and Drivers from the NI website. |

**Oscilloscope-supportive models:**

| DSO brand         | Model                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           | USB | TCP/IP |
| ----------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | --- | ------ |
| Acute             | • DS-1000<br>• MSO3000<br>• TravelScope2000/3000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | √   | √      |
| Gwinstek          | • GDS-1000A/2000/2000E/3000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | √   | √      |
| Tektronix         | • TDS1000B/1000C/2000B/2000C/3000/3000B/3000C/5000/5000B/7000<br>• DPO2000/3000/4000/4000B/5000/7000/7000C/70000/70000B<br>• DSA70000/70000B<br>• MSO2000/3000/4000/4000B/5000<br>• MDO3000/4000/4000B/4000C<br>• MDO32, MDO34, MSO54, MSO56, MSO58, MSO64<br>• MDO4014B-3, MDO4034B-3, MDO4054B-3, MDO4054B-6, MDO4104B-3, MDO4104B-6, MDO4024C, MDO4034C, MDO4054C, MDO4104C                                                                                                                                                                  | √   | √      |
| Keysight(Agilent) | • DSO1000A/5000A/6000A/6000L/7000A/7000B/9000A<br>• MSO6000A/7000A/7000B/9000A<br>• DSO-X 2000A/3000T/3000G/4000A/6000A/9000A<br>• DSA 9000A<br>• DSA-X 9000A/9000Q<br>• MSO-X 2000A/3000T/3000G/4000A/6000A<br>• EXR 100A/400A<br>• DSAZ634A, DSOZ634A, DSAZ632A, DSOZ632A, DSAZ594A, DSOZ594A, DSAZ592A, DSOZ592A, DSAZ504A, DSOZ504A, DSAZ334A, DSOZ334A, DSAZ254A, DSOZ254A, DSAZ204A, DSOZ204A, DSOS054A, DSOS104A, DSOS204A, DSOS254A, DSOS404A, DSOS604A, DSOS804A, MSOS054A, MSOS104A, MSOS204A, MSOS254A, MSOS404A, MSOS604A, MSOS804A | √   | √      |
| LeCroy            | • WaveRunner / WaveSurfer / HDO4000 / HDO6000 / SDA 8 Zi-A / DDA 8 Zi-A                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | √   | √      |
| HAMEG             | • HMO3000/2000/1000                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             | √   | √      |
| R & S             | • RTO1000 / 2000 / 3000<br>• RTE1000<br>• RTM3000<br>• RTP164<br>• MXO44, MXO54, MXO58                                                                                                                                                                                                                                                                                                                                                                                                                                                          | √   | √      |

**There are two methods for hardware wiring:**

**TravelLogic is the Master, while the oscilloscope is the Slave.**

Wiring direction is from TravelLogic's Trig-Out ➔the oscilloscope's Trig-In (see Figure 1)

In Figure 1, the USB or Ethernet (TCP / IP) interface is connected to the computer, and then connect the BNC-MCX cable to the TravelLogic Trig-Out and the trigger input interface (Ext-Trig, Aux In or Trig-In) of the oscilloscope. MDO4000 series is fixed in the analog channel CH4.

**The oscilloscope is the Master, while the TravelLogic is the Slave.**

Wiring direction is from the oscilloscope's Trig-Out ➔TravelLogic's Trig-In (see Figure 2).

In Figure 2, the BNC-MCX cable is connected to the TravelLogic Trig-In and the trigger output interface (Trig-Out) of the oscilloscope. After completing the above actions, press the "Stack Oscilloscope" button, as shown below:

**Select the DSO:**

Select the brand that needs to be stacked on the oscilloscope. When there is no DSO hardware available for stacking, emulation is the mode used to read back the storage files of DSO stack.

**Connection Type:**

It can be used to select USB, TCP / IP, according to the connection interface provided by the oscilloscope brands.

**Connect IP:**

It can be used to select TCP / IP for the connection mode and enter IP address. When the Ethernet crossover cable is used, it is recommended that the IP settings of the two machines be 192.168.1.2 and 192.168.1.3 respectively. Gateway is the same, set to 192.168.1.1, and DHCP is set to OFF. If the IP setting does not take effect, please disable and then enable the network, or reboot to make the network settings effective.

**Test Connection / Connection Status:**

It can be used to connect the oscilloscope / display the current stack oscilloscope model and automatically add the oscilloscope channel to the waveform window.

**Screen of oscilloscope stack:**

**Oscilloscope is set as the master, while the TravelLogic is set as the slave:**

If the stack is composed of the oscilloscope as the master and TravelLogic as the slave, you must not only complete the above-mentioned basic settings but also set the external trigger signal. For the hardware wiring, please refer to Figure 2. Press "Trigger Condition" → "External Trigger", as shown below.

**Stack Delay:**

When TravelLogic is triggered successfully, the Trig-Out signal is transmitted through Cable to the DSO with a time delay, resulting in a deviation between the logic and the analog signal time displayed by the waveforms. Therefore, the stack delay time must be set to compensate the delay. In the waveform display screen, you can put the mouse on the top of the DSO waveforms, hold down the Shift key, and then use the mouse's left button to drag the DSO waveforms to the appropriate location to complete the stack delay correction.

**Stacking line:**
- Standard MCX-MCX line for Acute DSO
- Optional BNC-MCX line (50cm or 100cm) for standalone DSOs

---

#### Advanced Capture Setting

**Capture mode setting:**

**Asynchronous mode:**

Asynchronous mode, also known as timing Analyzer, is based on the internal clock as a sampling frequency. It is recommended that the sampling frequency be set at about 10 times the signal to be measured, with the minimum not less than 5 times. Any rates lower than 5 times will cause distortion. Asynchronous sampling will cause sampling error from the actual capture to the signal, with the error time being the reciprocal of the sampling frequency.

The default mode is to capture the signal at the sampling frequency. If you want to increase the signal capture frequency, you can add a qualifier by selecting CK0 and setting a channel to be 0 or 1. For example, when Chip Select is 0 to allow to capture the signal, you can select the asynchronous mode (recorded when CK0 = 0) to add the qualifier. After the qualifier condition is selected, the device will automatically turn on the transpose mode to capture the signal.

**Synchronous mode:**

Synchronous mode, also known as the state Analyzer, uses the external input clock as the sampling frequency. The channel marked with CK0 on the signal line is the external clock input channel. When the external clock stops, the signal capture will also stop, forming a synchronous operation between the two.

**Easy setting:**

CK0 is used as the input clock when it is at the edge of Rising / Falling / Either.

**Advanced setting:**

The content of the easy setting looks like the following figure. Only the Ck0 at the changing edge is used for synchronous sampling.

Advanced setting allows you to use multiple sets of Edge conditions to sample at the same time. Each set of Edge conditions has two sets of qualifiers, any of which is met, sampling will take place immediately. Take the following conditions as an example:

- CK0↑ Sampling will take place immediately.
- CK0↑+Ck2=0 Sampling will take place immediately.

**Glitch filter settings:**

The hardware glitch filter function is used to filter out unwanted glitches and logical misjudgment caused by slow transitions. It can be regarded as a low-pass filter to remind the user that the glitches may sometimes lead to poor quality of data transmission. You can use the Logic Analyzer and Oscilloscope Stack to determine the signal integrity and whether there are unexpected glitches.

This filter function can be set to filter the signals of less than 5ns-35ns wide. After this filter function is enabled, it will filter before the hardware is triggered.

Channels that use the glitch filter function are marked with a red dot on the channel label for identification.

**Software Glitch filter settings:**

This filter function can be set to filter the signals with pulse width range from 1ps to 1ms. Applying this filter function will only change the display and decode contents, the trigger and recordable time will remain not effected. Disabling this filter function will restore all waveform contents back to the original un-filtered waveform.

---

#### Cursor

This function includes the cursor setting and the waveform search function matching the cursor.

**Move To:** Move the focused timestamp position in the waveform area according to the selection.

- **Waveform Start:** Move to the beginning of waveform
- **First Transition:** Move to first waveform transition
- **First Transition on Selected Label:** Move to first waveform transition of selected label
- **Waveform End:** Move to the end of waveform
- **Last Transition:** Move to the last waveform transition
- **Last Transition on Selected Label:** Move to the last waveform transition of selected label
- **Trigger Position:** Move to the trigger position
- **Cursor A-Z:** Move to the Cursor position

**Waveform search is divided into four modes:**

1. **By Edge:** Move the specified cursor position according to the number of Rising / Falling / Either edges (x1 ~ x4096) of the specified channel.
2. **By Time:** Move the specified cursor position forward or backward to specify the amount of time.
3. **By Value Match:** In search of displayed value content of the specified channel, if the specified channel is the bus Protocol, the text comparison will be used for the search; if the specified channel is the bus or channel, the numerical comparison will be used for the search.
4. **Search Pulse Width:** The waveform pulse widths meeting the conditions can be searched on the specified channels. The single-cursor movement function on the left side or the multiple-cursor movement function on the right side can be used on any operation meeting or exceeding the conditions.

The starting point of the search is set to the current position of the selected cursor.

**Cursor usage:**

The cursor system has two special-purpose cursors: the triggering cursor T and the search-specific cursor B, respectively.

To add a new cursor, you can use the left mouse button to click the "Add Cursor Button" on the top or press the Shift+ letter key. To delete a cursor, you can click the "Delete Cursor Button" on the top.

**Cursor movement method:**

1. Using the left mouse button to drag the cursor sign or cursor line on the top of the waveform window, you can achieve the purpose of moving the cursor.
2. Use the keyboard A-Z to quickly navigate to the mouse cursor location.
3. Use the keyboard Shift + A-Z to move the cursor to the place where the mouse cursor is. If the cursor does not exist, you can add the cursor to the mouse cursor without dragging the cursor.

The value on the frequency / time display bar at the bottom right of the screen will change as the cursor moves.

- From left to right are the interval time, frequency calculation, the number of sampling statistics, respectively.
- Clicking the cursor name, you can switch the cursor.

---

#### Waveform Area

1. Use the left mouse button to drag the waveform in the waveform display area.
2. You can use the mouse wheel or click the zoom in button on the screen to zoom the waveforms in or out.
3. **To add text / graphic annotation:** you can add text or graphic annotation data in the waveform area.
4. **Quick calculation function:** If you press the right button to drag in the waveform display area, you can circle the range to be observed, and show the number of signal transitions in the observation interval, the length of time and the average frequency information. This function can also be used in the waveform display area under the protocol Analyzer mode.
5. **Add/Delete the waveform label:**
   - Add labels
   - Add parallel bus
   - Add protocol decode
   - **Label Save/Recall:** Save the current channel settings or load the saved channel label.
   - **Import channel label from CSV file.** The file format like the following:

Notice: The feature can only import channel name and number. It can't import parallel bus or protocol decode.

---

#### Report Area

1. Display the channel status.
2. Display the results of the bus decode, or create customize report from multiple decodes.
60

Acute Technology Inc.
Copyright©2024

Cursor usage:

The cursor system has two special-purpose cursors: the triggering cursor T and the

search-specific cursor B, respectively.

To add a new cursor, you can use the left mouse button to click the “Add Cursor

Button” (

) on the top or press the Shift+ letter key. To delete a cursor, you can

click the “Delete Cursor Button” (

) on the top.

Cursor movement method:

1.  Using the left mouse button to drag the cursor sign or cursor line on the top of the

waveform window, you can achieve the purpose of moving the cursor.

2.  Use the keyboard A-Z to quickly navigate to the mouse cursor location.

3.  Use the keyboard Shift + A-Z to move the cursor to the place where the mouse

cursor is. If the cursor does not exist, you can add the cursor to the mouse cursor

without dragging the cursor.

The value on the frequency / time display bar at the bottom right of the screen will

change as the cursor moves.

  From left to right are the interval time, frequency calculation, the number of

sampling statistics, respectively.

Clicking the cursor name, you can switch the cursor.

61

Acute Technology Inc.
Copyright©2024

  Waveform Area

1.  Use the left mouse button to drag the waveform in the waveform display area.

2.  You can use the mouse wheel or click the zoom in button on the screen to zoom

the waveforms in or out

.

3.  To add text / graphic annotation

, you can add text or graphic annotation data in

the waveform area.

4.  Quick calculation function

If you press the right button to drag in the waveform display area, you can circle

the range to be observed, and show the number of signal transitions in the

observation interval, the length of time and the average frequency information.

This function can also be used in the waveform display area under the protocol

Analyzer mode.

5.  Add/Delete the waveform label.

  Add labels

62

Acute Technology Inc.
Copyright©2024

  Add parallel bus

  Add protocol decode

  Label Save/Recall: Save the current channel settings or load the saved channel

    label.

  Import channel label from CSV file. The file format like the following,

Notice: The feature can only import channel name and number. It can’t import parallel

bus or protocol decode.

63

Acute Technology Inc.
Copyright©2024

Report Area

1.  Display the channel status.

2.  Display the results of the bus decode, or create customize report from multiple

decodes.

3.  Waveform data statistics

When setting, select the channel and determine the type of statistics. If you only

need to count the specific range, you can use the cursor to select the specified

range. By default, the range is the entire waveform area. To apply the same

measurement values to other channels, you need only click and drag the items to

be copied, and multiple sets of the same measurements will be added to the other

channels. To add a variety of measurement values on the same channel, you

need only to click and drag on the channel name, and a number of different types

of measurements will be added.

Type

Period

Frequency

Edge Count

Cycle Count

Positive Cycle Count

Negative Cycle Count

Positive Pulse count

Negative Pulse count

Positive Pulse Width

Negative Pulse Count

Channel-to-Channel Rising Delay

Channel-to-Channel Falling Delay

Channel Rising to Channel Falling Delay

Channel Falling to Channel Rising Delay

Phase Delay

4.  Report area storage

Report contents can be saved as text files.

Channels

1

1

1

1

1

1

1

1

1

1

2

2

2

2

2

64

Acute Technology Inc.
Copyright©2024

Bus decode Settings

Please see the bus trigger and Analyzer manual

Customized Report Settings

All Bus Decoders enabled in waveform area will be listed in the setting window, you

may select interested columns from each Reports, the preview window will show how

many columns you have selected and combine them to create your customized

report.

Note: The Bus Decoders must be setup correctly in order to fetch the correct column

names for the customized report.

65

Acute Technology Inc.
Copyright©2024

Timing Check

Time Sequence

This function can import a CSV file containing the parameters and measurement

items. The logic analyzer will adjust the parameters, channel names and

measurement types according to the settings in this file.

The CSV file compilation rules need to be based on the field names at the beginning,

then separate the values in different fields with a comma. and it need to end with a

semicolon (;).

The text after the double slash (//) will be regarded as a comment and ignored.

(For sample files, Please contact us.)

Feature Select

The LA software will ask user which function that user want to apply while reading the

configure file. Set the trigger condition according to the configure file, and hide the

channels which are not in use.

Column Items:

[SampleRate]

Only accept single line input.

Input the sample rate value, Units: MHz, KHz, Hz.

The maximum sampling rate range that can be used will be affected by the

number of channels and trigger types, and the minimum sampling rate cannot be

lower than 100KHz.

66

Acute Technology Inc.
Copyright©2024

This item will affect both Analog and Digital Sample Rate settings, use

[AnalogSampleRate] and [DigitalSampleRate] items to change the Sample

Rate settings separately.

[SampleRate]

Example

200MHz

;

[DigitalSampleRate]

Only accept single line input.

Input the digital sample rate value, Units: MHz, KHz, Hz.

The maximum digital sampling rate range that can be used will be affected by the

number of channels and trigger types, and the minimum sampling rate cannot be

lower than 100KHz.

[DigitalSampleRate]

Example

25MHz

;

[ChannelNumber]

Only accept single line input.

Input the channel counts, Units: None.

  Available channel counts depend on the value of sample rate and transitional

storage mode is enabled.

Sample Rate

LA Non-Transition

LA Transition

2G (TL3234B+

only)

1G

500M

0:3 (4 Channels)

0:2 (3 Channels)

0:7 (8 Channels)

0:5 (6 Channels)

0:15 (16 Channels)

0:11 (12 Channels)

250M, 200M

0:31 (32 Channels)

0:23 (24 Channels)

67

Acute Technology Inc.
Copyright©2024

[ChannelNumber]

Example

24

;

[RecordLength]

Only accept single line input.

Input the recording memory. Unit: MB, Mb.

The maximum of the recording memory depends on the different models. The

minimum recording memory value be lower than 16Mb.

[RecordLength]

Example

100Mb

;

[TransitionalMode]

Only accept single line input.

Transitional Mode setup. Unit: None.

[TransitionalMode]

Example

1 //Transitional storage mode ON

;

[Threshold]

Available to input multiple line for adjust different threshold for the

channels. Enter the threshold level in each row, Unit: mV, V.

For different model, it has different range of threshold level.

TL series threshold voltage range : ±5V

*For TL series, when the Schmitt circuit function is enabled, Channel 16-31

will turn into the secondary Ref. threshold voltage.

[Threshold]

Example

1.6V //Ch 00-07

1.5V //Ch 08-15

68

Acute Technology Inc.
Copyright©2024

1.2V //Ch 16-23 or the secondary of input for Ch00-07

2.5V //Channel 24-31 or the secondary of input for

Ch08-15

;

[UseSchmittCircuit]

Only accept single line input.

TL series

Control whether to enable Schmitt circuit function. This will affect the

significance of the parameters of the voltage level, and the maximum

number of available channels will drop to 16 channels.

[UseSchmittCircuit]

Example

1 //Input 1 to enable Schmitt circuit

;

[Channel]

Available to enter multiple lines of settings to add different channels, each

line is entered in sequence:

1.  Select Channel. CH0 -> Digital CH0, CH(A)0 -> Analog CH0

2.  Label for Channel. It is available to enter less than 31 alphabets or numbers.

3.  (Option)Select TimingCheck or HwStrap (TimingCheck+HwStrap means

enable both)

4.  (Option)Enter the expect maximum voltage for auto calculate the voltage

division for analog channel.

5.  (Option) Enter the expect minimum voltage for auto calculate the voltage

division for analog channel.

The available channels will vary according to different models and the

selected sampling rate.

[Channel]

CH20, MyData0, HwStrap

Example

CH22, MyData1, TimingCheck

CH24, MyData2, TimingCheck+HwStrap

;

69

Acute Technology Inc.
Copyright©2024

Check Mode

Description

HwStrap

TimingCheck

CH  is  only  for  H/W  Strap.  It  will  be  hidden  while  in
Timing Check.
CH is only for Timing Check. It will be hidden while in
H/W Strap.

TimingCheck+HwStrap  For both mode.

[Trigger]

Only accept single line input. Enter in order:

1.  Trigger Channel Label: Reference to the Label in [Channel] settings for

trigger settings.

2.  Trigger Type:

Trigger Type

CHANNEL_LOW

CHANNEL_HIGH

CHANNEL_ANY

CHANNEL_RISING

CHANNEL_FALLING

CHANNEL_CHANGING

3.  (Optional)Select TimingCheck or HwStrap (TimingCheck+HwStrap for both)
4.  (Optional)Analog Trigger Voltage, Unit: mV、V. (Only when selecting analog

CH in MSO series.

[Trigger]

// For H/W Strap, selecting MyData1 (Triggered when Ch22

Rise)

MyData1, CHANNEL_RISING, HwStrap

//For Timing Check, selecting MyData2 (Triggered when Ch24

Example

Rise)

MyData2, CHANNEL_RISING, TimingCheck

;

[TriggerPosition]

Only accept single line input.

Entering the trigger position in percentage. Input Range: 1% to 99%

70

Acute Technology Inc.
Copyright©2024

[TriggerPosition]

Example

20% //Set the trigger position to 20%

;

[RangeStart]

Only accept single line input.

Set measurement start position, available input from CursorA to CursorZ.

[RangeStart]

Example

CursorS //Set measurement starts from Cursor S

;

[RangeEnd]

Only accept single line input.

Set measurement end position, available input from CursorA to CursorZ.

[RangeStart]

Example

CursorE //Set measurement ends at Cursor E

;

[TimingCheck]

Available to enter multiple lines of settings to add different settings, Enter

in order:

1.  Timing Check Spec, Only for display.

2.  Timing Check Description, Only for display.

3.  Target CH A: Need reference [Channel] label name.

4.  Target CH B: Need reference [Channel] label name.

5.  Timing Check Type, items marked in orange are for MSO series only.

Item

Remark

CHA_RISE_TO_CHB_RISE

Time difference from:

First CH A Rising Edge

TO

First CH B Rising Edge.

71

Acute Technology Inc.
Copyright©2024

CHA_RISE_TO_CHB_FALL

Time difference from:

First CH A Rising Edge

TO

First CH B Falling Edge.

CHA_FALL_TO_CHB_RISE

Time difference from:

First CH A Falling Edge

TO

First CH B Rising Edge.

CHA_FALL_TO_CHB_FALL

Time difference from:

First CH A Falling Edge

TO

First CH B Falling Edge.

CHA_RISE_TO_NEXT_CHB_RISE

Time difference from:

First CH A Rising Edge

TO

Next CH B Rising Edge.

72

Acute Technology Inc.
Copyright©2024

CHA_RISE_TO_NEXT_CHB_FALL

Time difference from:

First CH A Rising Edge

TO

Next CH B Falling Edge.

CHA_FALL_TO_NEXT_CHB_RISE

Time difference from:

First CH A Falling Edge

TO

Next CH B Rising Edge.

CHA_FALL_TO_NEXT_CHB_FALL

Time difference from:

First CH A Falling Edge

TO

Next CH B Falling Edge.

CHA_RISE_TO_PREV_CHB_RISE

Time difference from:

First CH A Rising Edge

TO

Previous CH B Rising Edge.

73

Acute Technology Inc.
Copyright©2024

CHA_RISE_TO_PREV_CHB_FALL

Time difference from:

First CH A Rising Edge

TO

Previous CH B Falling Edge.

CHA_FALL_TO_PREV_CHB_RISE

Time difference from:

First CH A Falling Edge

TO

Previous CH B Rising Edge.

CHA_FALL_TO_PREV_CHB_FALL

Time difference from:

First CH A Falling Edge

TO

Previous CH B Falling Edge.

CHA_RISE_TO_FAREST_CHB_RISE  Time difference from:

First CH A Rising Edge

TO

Farthest CH B Rising Edge.

74

Acute Technology Inc.
Copyright©2024

CHA_RISE_TO_

Time difference from:

FAREST_CHB_FALL

First CH A Falling Edge

TO

Farthest CH B Rising Edge.

CHA_FALL_TO_

Time difference from:

FAREST_CHB_RISE

First CH A Falling Edge

TO

Farthest CH B Rising Edge.

CHA_FALL_TO_

Time difference from:

FAREST_CHB_FALL

First CH A Falling Edge

TO

Farthest CH B Falling Edge.

CHA_HIGH_TIME

CHA_LOW_TIME

CHA_HIGH_PULSE_COUNT

CHA_LOW_PULSE_COUNT

CHA_RISE_EDGE_COUNT

CHA_FALL_EDGE_COUNT

75

Acute Technology Inc.
Copyright©2024

CHA_EDGE_COUNT

CHA_SLEW_RATE*1

CHA_V_MAX

CHA_V_MIN

CHA_V_PP

CHA_V_HIGH

CHA_V_LOW

CHA_V_AMPLITUDE

CHA_V_MEAN

CHA_RISE_TIME

CHA_FALL_TIME

6.  Min. Limit:

I.  For Timing Measurement, Unit: ns, us, ms, s.

II.  For Voltage Measurement, Unit: mV, V.

III.  For SLEW_RATE, available units: mV/us, mV/ms, V/us, V/ms.

mV/us or V/us will be the default units.

Input X stands for don’t care.

7.  Max. Limit:

I.  For Timing Measurement, Unit: ns, us, ms, s.

II.  For Voltage Measurement, Unit: mV, V.

III.  For SLEW_RATE, available units: mV/us, mV/ms, V/us, V/ms.

mV/us or V/us will be the default units.

Input X stands for don’t care.

*1: Slew Rate will decide whether it is rise or fall edge by Ref. voltage.

[TimingCheck]

Spec_00, Desc_00, MyData0, MyData1, CHA_RISE_TO_CHB_RISE, 1ns, 10ms

Example

Spec_01, Desc_01, MyData1, MyData2, CHA_FALL_TO_CHB_RISE, X, 100ms

Spec_02, Desc_02, MyData2, MyData3, CHA_FALL_TO_CHB_FALL, 100us, X

;

76

Acute Technology Inc.
Copyright©2024

Timing check report area:

While the waveform finished capture, the software will do the result(Pass/Fail)

analysis and display it.

Double click the report data for positioning the CHA & the CHB referenced location in

waveform area.

Timing sequence: Measuring power-on(off) sequence.

77

Acute Technology Inc.
Copyright©2024

Contact information

Acute website: http://www.acute.com.tw

E-Mail: service@acute.com.tw
Chapter 3      Technical support

Tel: +886-2-29993275      Fax: +886-2-29993276

If

  shows up in the Demo mode during the execution of

TravelLogic software, please try the following steps to solve the issue:

(1) Install the latest version of the TravelLogic software, please go to the official

website of Acute Technology Inc. - Download - Software, and then select the [Logic

Analyzer ] Logic Analyzer (TL3000. TL4000 series)to download and install.

(2) Please use the original USB3.0 Cable in the kit.

(3) Go to the device manager and check the driver status.

Please connect the device USB cable to the computer and then go to the system

device manager to check whether the Acute USB BootLoader or Acute USB3.0

Product shows up. Please go to the Acute Website - Download - Software,

download the USB3.0 driver and follow the troubleshoot manual in the package

to reinstall the driver.

78

Acute Technology Inc.
Copyright©2024

(4) Remove all probes and re-plug the USB3.0 Cable or restart the computer to check

whether the driver appears.

(5) After the above steps are taken but the problem is still there, please contact us.

79

Acute Technology Inc.
Copyright©2024

Appendix 1    Report List Advanced Instructions

1. Select the Window button-> Report list on the toolbar, the software will open the

report list function and present it at the bottom of the main window. It can be adjusted

the most suitable viewing size.

2. This function can be combined with the statistics function, please click the

Navigator tab on the right side of the main window.

80

Acute Technology Inc.
Copyright©2024

3. Click the items of the statistical function in sequence, the statistical results will be

presented in the Statistic List in the report list, and can be clicked on this table to track

the position of this data in the main report area.

4. This function also provides Search, Trigger and Bookmark List can be used,

     (1). Search List

81

Acute Technology Inc.
Copyright©2024

     (2). Trigger List

     (3). Bookmark List (right click in the main report area to add)

82

Acute Technology Inc.
Copyright©2024

