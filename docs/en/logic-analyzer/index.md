# Logic Analyzer Mode

The Logic Analyzer mode allows you to capture and analyze digital signals with advanced triggering, timing analysis, and bus decoding capabilities.

**New to Logic Analyzer?** Follow our [Quick Start Tutorial](quick-start.md) for a complete step-by-step walkthrough from connection to export.

## Key Features

### Robust Analysis Tools

<div class="grid cards" markdown>

-   :material-open-in-new:{ .middle } Bus Decoding
    
    ---
    
    Decode I2C, SPI, UART, I3C, and many other protocols
    
    [:octicons-arrow-right-24: Learn more](bus-decode.md)

-   :material-open-in-new:{ .middle } Cursor
    
    ---
    
    Place up to 25 cursors for precise timing analysis
    
    [:octicons-arrow-right-24: Learn more](cursor.md)

-   :material-open-in-new:{ .middle } Waveform Statistics

    ---
  
    Measure period, frequency, pulse width, delays, and more

    [:octicons-arrow-right-24: Learn more](navigate-report.md#waveform-statistics)

-   :material-open-in-new:{ .middle } Timing Check
    
    ---

    Import CSV timing configuration files to automate power sequence validation
    
    [:octicons-arrow-right-24: Learn more](power-sequence-validation.md)

</div>

### Powerful Trigger Options

The Logic Analyzer supports numerous trigger types for different capture scenarios:

<div class="grid cards" markdown>

-   :material-open-in-new:{ .middle } Trigger Settings

    ---

    Single-level / Multi-level / Width / Timeout / External triggers

    [:octicons-arrow-right-24: Learn more](trigger-settings.md)

-   :material-open-in-new:{ .middle } Protocol Triggers

    ---

    Configure trigger conditions for protocol events

    [:octicons-arrow-right-24: Learn more](trigger-settings.md)

</div>

### Various Capture Configurations

<div class="grid cards" markdown>

-   :material-open-in-new:{ .middle } Storage Modes

    ---

    Store to Device RAM / PC RAM / PC HDD (Waveform Logger) along with Transitional Storage for long captures

    [:octicons-arrow-right-24: Learn more](capture-settings.md#storage-modes)

-   :material-open-in-new:{ .middle } Capture Modes
    
    ---

    Asynchronous (Timing analysis) mode / Synchronous (State analysis) mode

    [:octicons-arrow-right-24: Learn more](advanced-capture.md)

</div>

### Integration

<div class="grid cards" markdown>

-   :material-open-in-new:{ .middle } Stack Oscilloscope

    ---

    Combine logic and analog analysis by connecting to supported oscilloscopes

    [:octicons-arrow-right-24: Learn more](stack-oscilloscope.md)

-   :material-open-in-new:{ .middle } Various Export Options

    ---

    Save as VCD, binary, MATLAB, or DGW/PGV formats

    [:octicons-arrow-right-24: Learn more](export-data.md)

</div>

## Typical Workflows

### Basic Signal Capture and Measurement

1. [Configure channels](tutorial.md#step-2-configure-channels) and [trigger](tutorial.md#step-3-set-up-trigger)
2. [Capture waveform](tutorial.md#step-6-capture-waveform)
3. [Place cursors](cursor.md) to measure timing
4. [Save results](export-data.md)

**Use case:** Measuring clock frequency, pulse width, or timing relationships.

### Protocol Debugging

1. Use [Quick Setting](quick-start.md#step-2-capture-settings) for your protocol
2. [Capture bus transactions](tutorial.md#step-6-capture-waveform)
3. [Review decode results](bus-decode.md) in report area
4. [Export decode report](export-data.md#export-decode-reports) for documentation

**Use case:** Debugging I2C, SPI, UART, or other bus protocols.

### Timing Verification

1. [Import CSV](power-sequence-validation.md) with timing specifications
2. Configure [automated measurements](navigate-report.md#waveform-statistics)
3. Capture and verify results
4. [Export report](export-data.md) with pass/fail status

**Use case:** Production testing, design verification, compliance testing.

### Signal Integrity Analysis

1. Enable [hardware glitch filter](advanced-capture.md#hardware-glitch-filter)
2. Capture with [high sample rate](capture-settings.md#storage-modes)
3. Use [Stack Oscilloscope](stack-oscilloscope.md) for analog view
4. Compare filtered vs. unfiltered with [software filter](advanced-capture.md#software-glitch-filter)

**Use case:** Identifying noise, glitches, or signal quality issues.

## Documentation Structure

**Getting Started**

- [Understanding the Interface](interface-guide.md): Learn the UI components and layout
- [Quick Start Tutorial](quick-start.md): Step-by-step walkthrough for beginners

**Capturing Data**

- [Capture Settings](capture-settings.md): Configure triggers, memory, and thresholds
- [Trigger Settings](trigger-settings.md): Configure trigger type and conditions
- [Advanced Capture Settings](advanced-capture.md): Asynchronous/Synchronous modes and glitch filters

**Analyzing Waveforms**

- [Navigate the data](navigate-data.md): Navigate the captured data
<!-- - [Channel labels](channel-labels.md): Customize the channel labels -->
- Channel labels: Customize the channel labels
<!-- - [Cursor measurements](cursor.md): Precise timing measurements with cursors -->
- Cursor measurements: Precise timing measurements with cursors
<!-- - [Protocol decoders](bus-decode.md): Protocol decoding and custom reports -->
- Protocol decoders: Protocol decoding and custom reports
- [Navigate the report](navigate-report.md): Navigate the analysis results

**File Operations**

<!-- - [Open & Save Files](file-operations.md): Manage waveform files and import data -->
- Open & Save Files: Manage waveform files and import data
<!-- - [Export Data](export-data.md): Export to various formats and batch operations -->
- Export Data: Export to various formats and batch operations

**Advanced Features**

- [Power Sequence Validation](power-sequence-validation.md): Automate checks the horiztonal timing validation with customized timing configuration files
- [Stack External Oscilloscope](stack-oscilloscope.md): Integrate with external oscilloscopes with your analysis

**Preferences**

- [Environment options](preferences.md): A collection of environment settings
- [Keyboard Shortcuts](keyboard-shortcuts.md): Manage your favorite shortcuts
