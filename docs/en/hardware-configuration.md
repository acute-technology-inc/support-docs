# Hardware Configuration

Connect the USB 3.0 cable to the USB slot on your computer. After confirming the connection is complete, you can turn on the software and connect the signal cable to the device under test for observation.

## Master device features

The TravelLogic master device includes the following components:

- Indicator LED
- Reference clock out
- Reference clock in
- Trigger out
- Trigger in
- USB 3.0 Type B slot (connects to computer)
- Pin assignment

## Signal Measurement Issues

Signal measurement problems typically have the following causes:

1. When the probe capacitance load is large, it filters out high-frequency noise, making the signal appear clean, but the actual high-frequency signal is also filtered out
2. Excessively long leads introduce inductive loading, amplifying high-frequency gain. Instruments with lower frequency response specifications may not detect this
3. Instruments with higher frequency specifications will show worse results under non-ideal wiring conditions because they allow high-frequency signals to pass through, revealing more noise response
4. The distance between the signal measurement lead and its own loop ground line varies, causing impedance variations that trigger multiple reflections. Therefore, the ground line paired with the test signal should be connected next to the signal
5. The measurement lead is pulled out from the original circuit, forming a circuit branch/stub that causes an impedance discontinuity. A 20~50 ohm resistor should be added to avoid secondary reflections
6. Different probes have different input impedances and lead configurations, so the phenomena after connecting to the DUT will also differ. However, if the leads are short enough and can avoid secondary reflections, and the signal/ground are kept close together to maintain impedance stability, then the instrument will meet its own specifications
