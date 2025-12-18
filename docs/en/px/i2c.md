# I2C

## Px Pair Settings
![Px Pair Settings](/img/i2c/px pair setting.png)
Pressing the button on the left side (in the red box) of this dialog, it will pop out a new dialog called "PX Pair Settings".

### Mode Select
User can set the mode to:
1. Controller mode: set Exerciser as controller on this bus.
2. Target mode: set Exerciser as target on this bus.
3. or Disable

### Voltage Settings
All units for these settings are in {++*mV*++}.
1. Vdd: set the working voltage.
2. LA Threshold: set the LA threshold for decoding.
3. Hysteresis Range: set the Hysteresis range.

### Resistance Settings
1. Pull-Up Enabled: User can activate this function by checking the checkbox.
2. Pull-Up Resistance: User can set the resistance by typing the value, or select some common resistance values.

## Bus Select
![Bus Select](/img/i2c/bus select.png)
There has four buses for user to use. User can set different mode on different bus, by simply clicking the bus.
For example, users can simulate one controller located on Bus 1 and another controller located on Bus 3.

## Buttons

### Add Internal Node

### Assign

### Reload

### Scan External Node
Scan all the possible external node, from 0x08 to 0x77

### Decode Settings

## Send packet

### Quick Send
![Quick Send](/img/i2c/quick send.png)


### Packet Constructor