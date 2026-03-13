# RGB Interface

## What is RGB Interface?

The RGB (Red-Green-Blue) parallel interface, also known as RGB parallel video interface or RGB TTL interface, is a digital display interface that transmits video data using separate parallel data lines for red, green, and blue color components. This interface directly connects display controllers or graphics processors to TFT LCD panels, small embedded displays, and other flat-panel display technologies. The RGB interface represents one of the simplest and most straightforward methods of transmitting digital video data, with each pixel's color information sent simultaneously across multiple parallel data lines synchronized to a pixel clock.

The interface consists of three primary components: pixel data lines (RGB color values), timing control signals (horizontal and vertical sync), and a pixel clock. Data widths vary depending on color depth requirements, with common configurations including 16-bit (RGB565 with 5-6-5 bits per channel), 18-bit (RGB666 with 6-6-6 bits per channel), and 24-bit (RGB888 with 8-8-8 bits per channel for true color). The timing signals HSYNC and VSYNC define the structure of the video frame, indicating when each new line and each new frame begins, while the Data Enable (DE) signal marks periods when valid pixel data is being transmitted versus blanking intervals.

RGB parallel interfaces are widely used in embedded systems, industrial displays, medical equipment, and consumer electronics where direct panel connections are required. The interface offers advantages including simplicity of implementation, deterministic timing, low latency, and direct pixel control without encoding or compression overhead. While modern high-resolution displays have largely transitioned to serial interfaces like LVDS, MIPI DSI, and DisplayPort for bandwidth and EMI reasons, RGB parallel interfaces remain prevalent in embedded applications with small to medium display sizes (up to approximately 1280×800 resolution) where the pin count and PCB routing complexity are manageable.

## Technical Specifications

### Signal Lines

**Timing and Control Signals:**
- **PCLK (Pixel Clock)**: Clock signal for synchronizing pixel data transmission
- **HSYNC (Horizontal Sync)**: Start of new horizontal line indicator
- **VSYNC (Vertical Sync)**: Start of new frame indicator
- **DE (Data Enable)**: Valid pixel data indicator (active high during active video)

**Data Lines by Color Depth:**

**RGB565 (16-bit):**
- **R[4:0]**: 5 bits for Red (32 levels)
- **G[5:0]**: 6 bits for Green (64 levels)
- **B[4:0]**: 5 bits for Blue (32 levels)
- **Total**: 16 data lines, 65,536 colors

**RGB666 (18-bit):**
- **R[5:0]**: 6 bits for Red (64 levels)
- **G[5:0]**: 6 bits for Green (64 levels)
- **B[5:0]**: 6 bits for Blue (64 levels)
- **Total**: 18 data lines, 262,144 colors

**RGB888 (24-bit true color):**
- **R[7:0]**: 8 bits for Red (256 levels)
- **G[7:0]**: 8 bits for Green (256 levels)
- **B[7:0]**: 8 bits for Blue (256 levels)
- **Total**: 24 data lines, 16,777,216 colors

### Timing Parameters

**Horizontal Timing (per scan line):**
- **Active Width**: Number of visible pixels per line (e.g., 800 for 800×480)
- **HFP (Horizontal Front Porch)**: Clocks between end of active video and HSYNC assertion
- **HSYNC Pulse Width**: Duration of HSYNC active period
- **HBP (Horizontal Back Porch)**: Clocks between HSYNC de-assertion and start of active video
- **Total Line Time**: Active + HFP + HSYNC + HBP

**Vertical Timing (per frame):**
- **Active Height**: Number of visible lines per frame (e.g., 480 for 800×480)
- **VFP (Vertical Front Porch)**: Lines between end of active frame and VSYNC assertion
- **VSYNC Pulse Width**: Duration of VSYNC active period (in lines)
- **VBP (Vertical Back Porch)**: Lines between VSYNC de-assertion and start of active video
- **Total Frame Time**: Active + VFP + VSYNC + VBP

**Pixel Clock Calculation:**
```
Pixel Clock (Hz) = Total Pixels per Line × Total Lines per Frame × Frame Rate

Example for 800×480 @ 60 Hz:
Total Horizontal = 800 (active) + 40 (FP) + 48 (sync) + 40 (BP) = 928
Total Vertical = 480 (active) + 13 (FP) + 3 (sync) + 32 (BP) = 528
Pixel Clock = 928 × 528 × 60 = 29.4 MHz
```

### Common Resolutions and Pixel Clocks

| Resolution | Refresh Rate | Typical Pixel Clock | Total H × V |
|------------|--------------|---------------------|-------------|
| 320×240 | 60 Hz | ~9 MHz | 408 × 262 |
| 480×272 | 60 Hz | ~10 MHz | 525 × 286 |
| 640×480 | 60 Hz | ~25 MHz | 800 × 525 |
| 800×480 | 60 Hz | ~30 MHz | 928 × 525 |
| 800×600 | 60 Hz | ~40 MHz | 1056 × 628 |
| 1024×600 | 60 Hz | ~51 MHz | 1344 × 635 |
| 1024×768 | 60 Hz | ~65 MHz | 1344 × 806 |
| 1280×800 | 60 Hz | ~83 MHz | 1440 × 823 |

### Sync Polarities

HSYNC and VSYNC can be active high or active low depending on display specifications:
- **Active High**: Logic level goes high during sync pulse
- **Active Low**: Logic level goes low during sync pulse

The required polarity is specified by the display panel datasheet and must be configured correctly in the display controller.

### Data Enable (DE) Mode

Many RGB interfaces use Data Enable mode where:
- **DE = 1 (high)**: Valid pixel data on RGB lines
- **DE = 0 (low)**: Blanking period, RGB data ignored

In DE mode, HSYNC and VSYNC still provide frame structure timing but the DE signal precisely indicates when each pixel should be sampled.

## Common Applications

RGB parallel interfaces are used across numerous display applications:

- **Embedded LCD displays**: Industrial HMIs, kiosks, medical devices
- **Automotive displays**: Dashboard instruments, infotainment systems
- **Handheld devices**: Portable terminals, test equipment, gaming devices
- **Industrial control panels**: Machine interfaces, process control displays
- **Point-of-sale terminals**: Retail payment and checkout systems
- **Medical equipment**: Patient monitors, diagnostic equipment displays
- **Home appliances**: Washing machines, refrigerators, thermostats with displays
- **Security systems**: Access control panels, alarm system displays
- **Audio/video equipment**: Mixing consoles, effects processors
- **Test and measurement**: Oscilloscopes, multimeters, function generators
- **Single-board computers**: Raspberry Pi, BeagleBone display connections
- **DIY electronics projects**: Maker projects with small TFT displays
- **Wearable devices**: Smartwatches with direct LCD connection
- **Robotics**: Robot control interfaces and status displays
- **IoT devices**: Smart home hubs and controllers with integrated displays

## Decoder Configuration

When configuring a logic analyzer to decode RGB interface signals:

### Channel Assignment

**Minimum Required Signals:**
- **PCLK**: Pixel clock (required)
- **HSYNC**: Horizontal sync (required)
- **VSYNC**: Vertical sync (required)
- **DE**: Data enable (strongly recommended)

**Data Lines (based on color depth):**
- **RGB565**: R[4:0], G[5:0], B[4:0] = 16 channels
- **RGB666**: R[5:0], G[5:0], B[5:0] = 18 channels
- **RGB888**: R[7:0], G[7:0], B[7:0] = 24 channels

For initial analysis, capturing at least the MSBs of each color channel (e.g., R7, G7, B7) plus timing signals can provide useful insight with fewer channels.

### Protocol Parameters

- **Color depth**: Select 16-bit (RGB565), 18-bit (RGB666), or 24-bit (RGB888)
- **HSYNC polarity**: Active high or active low
- **VSYNC polarity**: Active high or active low
- **DE mode**: Enable if Data Enable signal is used
- **Pixel clock edge**: Specify data sampling edge (usually rising edge)

### Decoding Options

- **Frame timing display**: Show horizontal and vertical timing parameters
- **Pixel data visualization**: Display RGB color values in hex or decimal
- **Active video highlighting**: Mark active video regions vs. blanking
- **Resolution detection**: Auto-detect resolution from timing
- **Color bar test pattern**: Recognize standard test patterns
- **Pixel counting**: Count pixels per line and lines per frame
- **Timing measurement**: Measure front porch, sync pulse, back porch durations
- **Frame rate calculation**: Compute refresh rate from timing

### Trigger Configuration

- **VSYNC edge**: Trigger on frame start (VSYNC assertion)
- **HSYNC edge**: Trigger on line start
- **DE assertion**: Trigger when active video begins
- **Specific color**: Trigger when RGB data matches specific color value
- **Pattern detection**: Trigger on specific pixel pattern sequence

### Sampling Requirements

**Minimum Sampling Rate:**
- At least 4× the pixel clock frequency
- Example: For 30 MHz pixel clock, use 120 MHz minimum sampling rate

**Recommended Sampling Rate:**
- 10× pixel clock for detailed waveform analysis
- Example: For 30 MHz pixel clock, use 300 MHz sampling rate

**Buffer Depth:**
For complete frame capture:
```
Samples needed = Total Pixels per Line × Total Lines per Frame × Samples per Pixel

Example for 800×480 display:
= 928 × 528 × 10 (samples per pixel)
= 4,899,840 samples minimum
```

### Analysis Tips

When analyzing RGB interface signals:

1. **Start with timing signals**: Capture PCLK, HSYNC, VSYNC, and DE first to verify timing structure
2. **Measure timing parameters**: Count PCLK cycles for horizontal and vertical timing values
3. **Verify sync polarities**: Confirm HSYNC and VSYNC polarities match display requirements
4. **Check DE alignment**: Ensure DE assertion aligns with expected active video periods
5. **Sample pixel data**: Verify RGB values during known test patterns (e.g., color bars)
6. **Calculate refresh rate**: Measure frame period and compute actual refresh rate
7. **Look for glitches**: Watch for timing violations, missing syncs, or unstable DE
8. **Monitor signal integrity**: Check for ringing, overshoot, or crosstalk on high-speed data lines

### Common Timing Patterns

**Start of Frame:**
1. VSYNC asserts (frame start)
2. Wait VBP lines (vertical back porch)
3. First active line begins

**Each Horizontal Line:**
1. HSYNC asserts (line start)
2. Wait HBP clocks (horizontal back porch)
3. DE asserts (active video begins)
4. 800 pixels transmitted (for 800-width display)
5. DE de-asserts (active video ends)
6. Wait HFP clocks (horizontal front porch)
7. Next HSYNC

**Typical Blanking:**
- During horizontal blanking (HFP + HSYNC + HBP): RGB data is ignored, DE = 0
- During vertical blanking (VFP + VSYNC + VBP lines): RGB data is ignored, DE = 0

## Reference

- [Riverdi: The Parallel RGB Display Interface Explained](https://riverdi.com/blog/the-parallel-rgb-interface-explained)
- [Rocktech: Understanding TFT LCD RGB Interface](https://www.rocktech.com.hk/rocktech-blog/tft-lcd-rgb-interface/)
- [Hackaday: Displays We Love Hacking - Parallel RGB](https://hackaday.com/2024/01/25/displays-we-love-hacking-parallel-rgb/)
- [TI: VGA Interface Testing](https://e2e.ti.com/cfs-file/__key/communityserver-discussions-components-files/14/vga_5F00_interface_5F00_testing.pdf)
