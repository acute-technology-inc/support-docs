# ITU-R BT.656

## What is ITU-R BT.656?

ITU-R Recommendation BT.656 defines the electrical and mechanical interface for digital component video signals in 525-line (NTSC) and 625-line (PAL) television systems operating at the 4:2:2 sampling level specified in ITU-R BT.601. The standard was developed by the International Telecommunication Union Radiocommunication Sector (ITU-R) to provide a standardized method for transmitting digital video between equipment such as cameras, video processors, encoders, and broadcast equipment. BT.656 eliminates the need for separate horizontal and vertical synchronization signals by embedding timing information directly within the video data stream.

The interface transmits video as multiplexed 8-bit or 10-bit digital words containing luminance (Y) and chrominance (Cb, Cr) components in 4:2:2 format, along with timing reference codes and ancillary data. Rather than using dedicated HSYNC, VSYNC, and BLANK signals like analog video interfaces, BT.656 uses special embedded timing reference codes called SAV (Start of Active Video) and EAV (End of Active Video) that mark the boundaries of active picture data within the serial data stream. These timing codes include field identification, vertical blanking indicators, and error protection bits, enabling receivers to synchronize and extract video timing without additional control signals.

The current specification, BT.656-5 approved in December 2007, defines both parallel and serial implementations operating at 27 MHz for standard definition video. Parallel BT.656 transmits 8 or 10 bits per clock cycle over dedicated data lines, while serial versions multiplex all data onto a single high-speed serial connection. The standard supports both 525-line/60 Hz (NTSC-based) and 625-line/50 Hz (PAL-based) formats with active resolutions of 720×486 and 720×576 pixels respectively. BT.656 remains widely used in professional broadcast equipment, video processing systems, and interfacing between digital video components despite the industry transition toward HD-SDI and IP-based video transport.

## Technical Specifications

### Video Format - 4:2:2 YCbCr

BT.656 transmits video in 4:2:2 component digital format:
- **Y (Luminance)**: Sampled at 13.5 MHz
- **Cb (Blue chrominance)**: Sampled at 6.75 MHz
- **Cr (Red chrominance)**: Sampled at 6.75 MHz

**Multiplexing Order:**
Cb₀ Y₀ Cr₀ Y₁ Cb₂ Y₂ Cr₂ Y₃ ... (repeated)

This results in alternating samples where luminance appears for every pixel, while chrominance components are sampled at half the horizontal resolution (4:2:2 subsampling).

### Physical Interface - Parallel Mode

**8-bit Parallel Interface:**
- **D7-D0**: 8-bit data bus carrying multiplexed Y/Cb/Cr samples
- **CLOCK**: 27 MHz clock signal (13.5 MHz × 2 for 4:2:2 multiplexing)
- **Data rate**: 216 Mbps (27 MHz × 8 bits)

**10-bit Parallel Interface:**
- **D9-D0**: 10-bit data bus for higher precision (broadcast quality)
- **CLOCK**: 27 MHz
- **Data rate**: 270 Mbps (27 MHz × 10 bits)

**Electrical Characteristics:**
- **Logic levels**: TTL or CMOS compatible (typically 3.3V or 5V)
- **Data valid**: Data sampled on rising edge of clock
- **No separate sync signals**: Timing embedded in data stream

### SAV and EAV Timing Reference Codes

BT.656 embeds timing information using special 4-byte sequences:

**Preamble Sequence:**
1. **0xFF** (255): Fixed value
2. **0x00** (0): Fixed value
3. **0x00** (0): Fixed value
4. **XY Status Word**: Encodes timing and field information

**XY Status Word Bit Assignment:**
- **Bit 7**: 1 (always set)
- **Bit 6**: F (Field bit): 0 for field 1, 1 for field 2 (interlaced video)
- **Bit 5**: V (Vertical blanking): 1 during vertical blank, 0 during active video
- **Bit 4**: H (Horizontal timing): 0 for SAV, 1 for EAV
- **Bits 3-0**: P3, P2, P1, P0 (Protection bits for error detection/correction)

**SAV (Start of Active Video):**
- Appears at the start of each active video line
- XY status word has H = 0

**EAV (End of Active Video):**
- Appears at the end of each active video line
- XY status word has H = 1

### Video Timing Parameters

**525-line/60 Hz System (NTSC-based):**
- **Active samples per line**: 720
- **Active lines per frame**: 486 (243 per field)
- **Total samples per line**: 858
- **Total lines per frame**: 525
- **Frame rate**: 29.97 Hz (59.94 fields/s interlaced)
- **Field identification**: F alternates between fields

**625-line/50 Hz System (PAL-based):**
- **Active samples per line**: 720
- **Active lines per frame**: 576 (288 per field)
- **Total samples per line**: 864
- **Total lines per frame**: 625
- **Frame rate**: 25 Hz (50 fields/s interlaced)
- **Field identification**: F alternates between fields

### Ancillary Data

During horizontal and vertical blanking intervals, BT.656 can carry ancillary data:
- **Audio data**: Embedded digital audio (AES/EBU)
- **Closed captioning**: Text data for subtitles
- **Timecode**: SMPTE timecode information
- **Teletext**: Text services (European systems)
- **Control data**: Camera control, tally signals, metadata

Ancillary data packets are identified by specific header codes and include checksum protection.

## Common Applications

ITU-R BT.656 is used extensively in professional video applications:

- **Broadcast cameras**: Digital video output from professional cameras
- **Video switchers**: Input/output connections for video production switchers
- **Video routers**: Matrix routers for broadcast facilities
- **Video servers**: Playout and recording systems
- **Video encoders**: MPEG, H.264 encoders for broadcast transmission
- **Video decoders**: Decoding compressed video to baseband
- **Frame synchronizers**: Video timing and synchronization equipment
- **Video processors**: Color correction, scaling, and effects processing
- **Character generators**: Graphics and text overlay systems
- **Video monitors**: Professional monitoring equipment
- **Video capture cards**: Professional video capture for editing systems
- **Intercom systems**: Video and audio distribution in studios
- **Multiviewers**: Multi-screen monitoring displays
- **Test equipment**: Waveform monitors, vectorscopes, video analyzers
- **Medical imaging**: Surgical cameras and imaging equipment output
- **Industrial vision systems**: Machine vision cameras and processors

## Decoder Configuration

When configuring a logic analyzer to decode ITU-R BT.656 signals:

### Channel Assignment - 8-bit Interface

**Data Lines:**
- **D7-D0**: 8-bit data bus

**Clock:**
- **CLK**: 27 MHz clock signal

### Protocol Parameters

- **Interface width**: Select 8-bit or 10-bit mode
- **Video standard**: Select 525/60 (NTSC) or 625/50 (PAL)
- **Sample rate**: 27 MHz (fixed for BT.656)
- **Field mode**: Interlaced field detection enabled

### Decoding Options

- **SAV/EAV detection**: Highlight Start and End of Active Video markers
- **Field identification**: Display field 1 vs. field 2 (F bit)
- **Blanking intervals**: Show vertical and horizontal blanking periods
- **Active video regions**: Highlight active picture data
- **Ancillary data**: Detect and parse ancillary data packets
- **Timing measurements**: Measure line and field timing
- **Error detection**: Flag invalid SAV/EAV sequences or protection bit errors
- **YCbCr display**: Show demultiplexed Y, Cb, Cr sample values

### Trigger Configuration

- **SAV trigger**: Trigger on Start of Active Video sequence (0xFF 0x00 0x00 + SAV status)
- **EAV trigger**: Trigger on End of Active Video sequence
- **Field transition**: Trigger when F bit changes (field boundary)
- **V-sync**: Trigger on vertical blanking interval (V bit = 1)
- **Specific line**: Trigger on specific line number (count SAV occurrences)
- **Ancillary data**: Trigger on ancillary data packet headers

### Sampling Requirements

**Sampling Rate:**
- Minimum: 108 MHz (4× the 27 MHz clock rate)
- Recommended: 270 MHz or higher (10× clock) for clear waveform analysis

**Buffer Depth:**
- For single frame capture: 
  - 525/60: 858 × 525 = 450,450 samples minimum
  - 625/50: 864 × 625 = 540,000 samples minimum
- For multi-frame analysis: Scale accordingly

### Analysis Tips

When analyzing BT.656 video signals:

1. **Verify SAV/EAV sequences**: Look for correct 0xFF 0x00 0x00 preambles followed by valid status words
2. **Check protection bits (P0-P3)**: Verify error detection/correction bits are correct
3. **Monitor field transitions**: Ensure F bit toggles correctly between fields (interlaced video)
4. **Validate timing**: Count samples per line (858 or 864) and lines per field
5. **Detect ancillary data**: During blanking, watch for ancillary data packets
6. **Measure active video**: Confirm 720 active samples per line for both formats
7. **Check data range**: Y samples should be in range 16-235, CbCr in range 16-240 (8-bit)

### Common Protocol Patterns

**Typical Line Sequence (Active Video Line):**
1. EAV sequence (end of previous line)
2. Horizontal blanking (138 or 144 samples, may contain ancillary data)
3. SAV sequence (start of current line)
4. Active video data (720 samples: Cb₀Y₀Cr₀Y₁... pattern)
5. EAV sequence (end of current line)

**Field Structure:**
- Field 1: First half of interlaced frame (odd lines)
- Vertical blanking period with V=1
- Active video lines with V=0
- Field 2: Second half of interlaced frame (even lines)
- Vertical blanking and active video

**Status Word Examples:**
- **0x80**: F=0, V=0, H=0, SAV during field 1 active video
- **0xC7**: F=1, V=0, H=1, EAV during field 2 active video
- **0xB6**: F=0, V=1, H=1, EAV during field 1 vertical blanking

## Reference

- [ITU-R Recommendation BT.656-5 (PDF)](https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.656-5-200712-I!!PDF-E.pdf)
- [ITU-R BT.656 Overview](https://www.itu.int/rec/R-REC-BT.656/)
- [ITU-R Recommendation BT.601: Digital Video Encoding](https://www.itu.int/rec/R-REC-BT.601/)
- [Analog Devices AN-9728: BT.656 Digital Video Interfaces](https://ez.analog.com/cfs-file/__key/communityserver-wikis-components-files/00-00-00-01-91/an9728.pdf)
