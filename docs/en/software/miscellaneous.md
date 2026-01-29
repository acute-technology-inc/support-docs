# Miscellaneous

This guide covers software installation, SDK setup, and gRPC configuration for TravelLogic analyzers.

### Launch the software

You can start TravelLogic in several ways:

- Use the desktop shortcut or program menu icon
- After starting, the main menu appears where you can choose to enter Logic Analyzer or Protocol Analyzer mode

### Add analyzer windows

Once in the application, you can add analyzer windows:

- Select the icon to add a Logic Analyzer or Protocol Analyzer window
- Use the **File** menu to select **Add Logic Analyzer** or **Add Protocol Analyzer**

### First-time setup

On first launch, you'll be prompted to set up the working directory. Choose a hard disk with sufficient remaining space for storing temporary files and captured waveforms.

---

## SDK

We provide SDKs to control software and hardware behavior.

### Software behavior SDK

Control the software while it's running using the AqLAVISA Manager.

**Access the SDK:**

- GitHub: [https://github.com/acute-technology-inc/aqvisa-grpc](https://github.com/acute-technology-inc/aqvisa-grpc)
- Official website: **Download** → **SDK (DLL)** → **[Logic Analyzer] AqLAVISA SDK**
- Email us for assistance

### Hardware behavior SDK

Control the hardware directly without keeping the software running.

**Access the SDK:**

- Official website: **Download** → **SDK (DLL)** → **[Logic Analyzer] TravelLogic SDK**
- Email us for assistance

**Note:** This SDK only captures data and saves it. It does not include decode processing.

---

## gRPC

We provide gRPC support for remote control of our devices.

**Access gRPC:**

- GitHub: [https://github.com/acute-technology-inc/aqvisa-grpc](https://github.com/acute-technology-inc/aqvisa-grpc)
- Search for "aqvisa-grpc"
- Email us for assistance
