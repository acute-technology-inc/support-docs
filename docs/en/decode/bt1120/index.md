# BT1120

## What is BT1120?

### Overview

ITU-R BT.1120 is a digital interface standard developed by the International Telecommunication Union Radiocommunication Sector (ITU-R) for transmitting HDTV studio signals. The standard defines serial digital interfaces for high-definition video equipment used in broadcast production, post-production, and international program exchange. BT.1120 provides a robust, standardized method for transmitting uncompressed HD video signals between professional video equipment such as cameras, video switchers, monitors, and recording devices.

The standard has evolved significantly since its initial approval in 1994, with the current version (BT.1120-9, approved December 2017) supporting modern image formats including 1920×1080 pixel arrays at various frame rates up to 60 Hz, High Dynamic Range (HDR) content, and Hybrid Log-Gamma (HLG) formats. BT.1120 maintains backward compatibility with legacy frame rates and image formats, ensuring that both new and existing broadcast equipment can interoperate seamlessly.

### Historical Context and Evolution

BT.1120 emerged during the transition from analog to digital broadcasting, providing a standardized digital interface for the then-new high-definition television systems. Over its 30+ year evolution through nine revisions, the standard has continuously adapted to industry needs, incorporating support for higher frame rates, HDR imaging, wider color gamuts, and increased bit depths. This evolutionary approach has allowed broadcast facilities to upgrade incrementally rather than requiring complete infrastructure replacement.

## Technical Specifications

### Serial Digital Interface

BT.1120-9 specifies serial digital interfaces operating at two nominal clock frequencies:

- **1.485 GHz (1.485/1.001 GHz)**: Standard HD-SDI bit rate for 1080i and 1080p formats
- **2.97 GHz (2.97/1.001 GHz)**: Higher bit rate for demanding applications including 1080p60 and HDR content

The serial interface uses differential signaling over 75-ohm coaxial cables with BNC connectors, standard equipment in professional broadcast environments. Signal integrity is maintained over substantial distances (typically 100-200 meters depending on cable quality and bit rate).

### Image Format Support

**Resolution**: 1920×1080 pixels (Full HD)

**Frame Rates**: 60 Hz, 50 Hz, 30 Hz, 25 Hz, 24 Hz, and related fractional rates (e.g., 59.94 Hz, 29.97 Hz)

**Scan Types**:
- **Progressive**: All lines displayed sequentially (1080p)
- **Interlaced**: Odd and even lines displayed alternately (1080i)
- **Segmented Frame**: Progressive capture with interlaced transport (1080PsF)

**Sample Structures**:
- **4:2:2 (YCbCr)**: Luma sampled at full resolution, chroma subsampled horizontally by 2:1
- **4:4:4 (YCbCr or RGB)**: All components sampled at full resolution

### Color Spaces and Dynamic Range

BT.1120-9 references image format parameters from:

- **ITU-R BT.709**: Standard dynamic range (SDR) HD color space
- **ITU-R BT.2100**: High dynamic range (HDR) including Perceptual Quantization (PQ) and Hybrid Log-Gamma (HLG)

This comprehensive color space support enables BT.1120 to carry both standard dynamic range content and modern HDR productions within the same interface framework.

## Parallel Interface (BT1120 8-bit)

While BT.1120 primarily defines serial interfaces, parallel 8-bit implementations exist for shorter connections and lower-cost applications:

### Signal Lines

**Clock (CLK)**: Pixel clock signal synchronizing data transfer, typically 74.25 MHz or 148.5 MHz

**Data Lines (Data[7:0])**: Eight parallel data lines carrying pixel component values

### Data Format

**Y, Cb, Cr Streams**: The parallel interface multiplexes luminance (Y) and chrominance (Cb, Cr) components:

- **4:2:2 Format**: Y samples alternate with Cb and Cr samples (Y0 Cb0 Y1 Cr0 Y2 Cb1 Y3 Cr1...)
- Each component represented as 8-bit or 10-bit values
- Timing references (SAV/EAV - Start of Active Video/End of Active Video) embedded in data stream

### Synchronization

Unlike analog video with separate sync signals, digital video embeds timing information within the data stream using special timing reference codes (0x800 and 0x3FF in 10-bit, 0x80 and 0xFF in 8-bit after proper encoding). These codes mark active video regions, blanking intervals, field identification, and line numbers.

## Decoder Configuration

When configuring a BT1120 decoder:

- **Channel Assignment**: Specify logic analyzer channels for CLK and Data[7:0]
- **Quick Setup**: Enable to automatically assign sequential data channels (Data0, Data1, Data2... on consecutive analyzer channels)
- **Stream Selection**: Choose Y (luminance) or Cb/Cr (chrominance) component decoding
- **Sample Rate**: Specify pixel clock frequency (74.25 MHz or 148.5 MHz typical)
- **Format**: Select 4:2:2 or 4:4:4 sampling structure

## Common Applications

BT.1120 interfaces are ubiquitous in professional broadcast and production environments:

- **Broadcast Studios**: Interconnection of cameras, switchers, routers, and monitors
- **Production Trucks**: Mobile broadcast units for sports, news, and events
- **Post-Production Facilities**: Editing suites, color grading, visual effects
- **Playout Systems**: Broadcast automation and transmission systems
- **Professional Monitors**: Reference monitors for critical viewing
- **Video Routers**: Central routing infrastructure in large facilities
- **Recording Systems**: Professional video recorders and servers
- **Live Event Production**: Concert venues, conferences, houses of worship
- **Medical Imaging**: Surgical visualization and diagnostic displays
- **Industrial Machine Vision**: High-resolution inspection systems

## Advantages of BT.1120

- **Uncompressed Quality**: No compression artifacts, ideal for production workflows
- **Low Latency**: Minimal processing delay, critical for live production
- **Industry Standard**: Universal support across professional equipment manufacturers
- **Robust Signaling**: Differential signaling with error detection
- **Scalability**: Support from SD through HD to UHD (via related standards)
- **Flexibility**: Multiple frame rates, scan types, and color spaces

## Reference

- [ITU-R BT.1120-9: Digital Interfaces for HDTV Studio Signals](https://www.itu.int/rec/R-REC-BT.1120-9-201712-I/en)
- [ITU-R BT.1120 Specification (PDF)](https://www.itu.int/dms_pubrec/itu-r/rec/bt/R-REC-BT.1120-9-201712-I!!PDF-E.pdf)
- [Wikipedia: BT.1120](https://en.wikipedia.org/wiki/BT.1120)
- [ITU-R BT.1120 Official Page](https://www.itu.int/rec/R-REC-BT.1120/en)
