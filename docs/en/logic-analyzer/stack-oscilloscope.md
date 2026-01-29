# Stack Oscilloscope

<!-- Source: Acute_TLmanual_en.pdf, Chapter 2, Pages 56-58 (Stack Oscilloscope section) -->

Combine Logic Analyzer and oscilloscope measurements for mixed-signal analysis.

## Overview

The Stack Oscilloscope feature integrates TravelLogic with oscilloscopes from various manufacturers, enabling simultaneous digital and analog signal analysis.

**Benefits:**

- Correlate digital logic with analog waveforms
- Measure signal integrity
- Identify glitches and noise
- Verify timing relationships between digital and analog signals

---

## Required software

Install manufacturer-specific software before using Stack Oscilloscope:

| Oscilloscope brand | Required software |
|-------------------|-------------------|
| **Acute** | Acute DSO software |
| **Gwinstek** | GW USB driver ([Download from Gwinstek website](http://www.gwinstek.com)) |
| **Tektronix** | TEKVISA CONNECTIVITY SOFTWARE ([Download from Tektronix website](http://www.tektronix.com)) |
| **Agilent/Keysight** | KEYSIGHT IO LIBRARIES SUITE ([Download from Keysight website](http://www.keysight.com)) |
| **LeCroy** | NI-VISA and Drivers ([Download from NI website](http://www.ni.com)) |
| **HAMEG** | NI-VISA and Drivers ([Download from NI website](http://www.ni.com)) |
| **Rohde & Schwarz** | NI-VISA and Drivers ([Download from NI website](http://www.ni.com)) |

---

## Supported oscilloscope models

### Acute

- DS-1000
- MSO3000
- TravelScope2000/3000

**Connectivity:** USB, TCP/IP

### Gwinstek

- GDS-1000A/2000/2000E/3000

**Connectivity:** USB, TCP/IP

### Tektronix

- TDS series: 1000B/1000C/2000B/2000C/3000/3000B/3000C/5000/5000B/7000
- DPO series: 2000/3000/4000/4000B/5000/7000/7000C/70000/70000B
- DSA series: 70000/70000B
- MSO series: 2000/3000/4000/4000B/5000
- MDO series: 3000/4000/4000B/4000C, 32/34, 54/56/58, 64
- MDO-B series: 4014B-3, 4034B-3, 4054B-3, 4054B-6, 4104B-3, 4104B-6
- MDO-C series: 4024C, 4034C, 4054C, 4104C

**Connectivity:** USB, TCP/IP

### Keysight (Agilent)

- DSO series: 1000A/5000A/6000A/6000L/7000A/7000B/9000A
- MSO series: 6000A/7000A/7000B/9000A
- DSO-X series: 2000A/3000T/3000G/4000A/6000A/9000A
- DSA series: 9000A
- DSA-X series: 9000A/9000Q
- MSO-X series: 2000A/3000T/3000G/4000A/6000A
- EXR series: 100A/400A
- High-end models: DSAZ/DSOZ/DSOS/MSOS series (various model numbers)

**Connectivity:** USB, TCP/IP

### LeCroy

- WaveRunner
- WaveSurfer
- HDO4000/HDO6000
- SDA 8 Zi-A
- DDA 8 Zi-A

**Connectivity:** USB, TCP/IP

### HAMEG

- HMO3000/2000/1000

**Connectivity:** USB, TCP/IP

### Rohde & Schwarz

- RTO1000/2000/3000
- RTE1000
- RTM3000
- RTP164
- MXO44/54/58

**Connectivity:** USB, TCP/IP

---

## Hardware wiring methods

### Method 1: TravelLogic as master, oscilloscope as slave

**Wiring:** TravelLogic Trig-Out → Oscilloscope Trig-In

**Setup:**

1. Connect TravelLogic and oscilloscope to computer via USB or TCP/IP
2. Use BNC-MCX cable to connect:
   - TravelLogic **Trig-Out** port
   - Oscilloscope trigger input (Ext-Trig, Aux In, or Trig-In)

**Note:** For MDO4000 series, the trigger input is fixed to analog channel CH4.

---

### Method 2: Oscilloscope as master, TravelLogic as slave

**Wiring:** Oscilloscope Trig-Out → TravelLogic Trig-In

**Setup:**

1. Use BNC-MCX cable to connect:
   - Oscilloscope **Trig-Out** port
   - TravelLogic **Trig-In** port
2. After hardware connection, click **Stack Oscilloscope** button in software

**Additional configuration required:**

When using the oscilloscope as master, you must also configure external trigger in TravelLogic:

1. Press **Trigger Condition** → **External Trigger**
2. Complete the configuration

---

## Software configuration

### Select the oscilloscope

**Options:**

- Choose oscilloscope brand
- Select **Emulation** mode when no physical oscilloscope is available (used to read saved DSO stack files)

---

### Connection type

Select how the oscilloscope connects to the computer:

- **USB:** Direct USB connection
- **TCP/IP:** Network connection

---

### Connect IP (TCP/IP mode only)

Enter the oscilloscope's IP address when using TCP/IP connection.

**Recommended IP settings for direct crossover cable:**

- TravelLogic: 192.168.1.2
- Oscilloscope: 192.168.1.3
- Gateway: 192.168.1.1
- DHCP: OFF

**If IP settings don't take effect:**

1. Disable and re-enable the network interface
2. Reboot the computer

---

### Test connection / Connection status

**Test connection:** Verify communication with the oscilloscope

**Connection status:** Displays the current connected oscilloscope model and automatically adds oscilloscope channels to the waveform window

---

## Stack delay compensation

When TravelLogic is triggered, the Trig-Out signal travels through the cable to the oscilloscope, creating a time delay. This causes misalignment between logic and analog waveforms.

**To compensate:**

1. In the waveform display, position mouse over the oscilloscope waveforms
2. Hold down the **Shift** key
3. Use the left mouse button to drag the oscilloscope waveforms to align them properly

This corrects the stack delay and synchronizes the digital and analog displays.

---

## Stacking cables

**For Acute oscilloscopes:**

- Standard MCX-MCX cable (included)

**For standalone oscilloscopes:**

- Optional BNC-MCX cable
- Available lengths: 50cm or 100cm

---

## Tips and best practices

### Signal integrity analysis

Use Stack Oscilloscope to:

- Verify digital signal quality
- Measure rise/fall times
- Identify overshoot and ringing
- Correlate glitches with data errors

---

### Trigger coordination

**Master-slave considerations:**

- **TravelLogic as master:** Better for logic-triggered events
- **Oscilloscope as master:** Better for voltage-triggered events

Choose based on which domain (logic or analog) defines the event of interest.

---

### Channel alignment

After stack delay compensation:

- Verify alignment using known signal edges
- Check multiple points across the capture
- Save configuration for repeated measurements
