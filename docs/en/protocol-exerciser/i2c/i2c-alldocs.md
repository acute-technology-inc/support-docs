# I2C

## Quick Setup
FOLLOWING STEPS:
1. Activate [Selecting Bus](#bus-select).
2. Set up the [PX pod parameters](#px-pair-settings).
3. *(Optional)*Add your [Internal node](#add-internal-node) to topology.
4. *(Optional)*Set up your [DC output](../index.md#power-supply).
5. [Decode settings](#decode-settings) for I2C signals analysis.
6. [Assign your topology](#assign).
7. *(Optional)*[Scan all available address](#scan-external-node)(0x08 ~ 0x77) in [Controller mode](#controller-mode) only.
8. Send commands using [I2C wizard](#send-packets) in [Controller mode](#controller-mode) only.

## Bus Select
![Bus Select](../../images/protocol-exerciser/i2c/bus-select.png)
There has four buses for user to use. User can set different mode on different bus, by simply clicking the bus.
For example, users can simulate one controller located on Bus 1 and another controller located on Bus 3.
But all the channel for each bus is fixed, user can NOT adjust it arbitrarily.
{==We now only support ONE bus for user to use.==}

## Px Pair Settings
![Px Pair Settings](../../images/protocol-exerciser/i2c/px-pair-setting.png)
Pressing the button on the left side (in the red box) of this dialog, it will pop out a new dialog called "PX Pair Settings".

### Mode Settings
User can set the mode to:
1. Controller mode: Set Exerciser as controller on this bus.
2. Target mode: Set Exerciser as target on this bus.
3. or Disable
* {++No matter in Controller or Target mode, user can create virtual internal nodes for simulate multiple targets on the bus.++}
* {++The total number of controllers and internal nodes shall not exceed 4.++}

### Voltage Settings
All units for these settings are in {++*mV*++}.
1. Vdd: Set the working voltage.
2. LA Threshold: Set the LA threshold for decoding.
3. Hysteresis Range: Set the Hysteresis range.

### Resistance Settings
1. Pull-Up Enabled: User can activate this function by checking the checkbox.
2. Pull-Up Resistance: User can set the resistance by typing the value, or select some common resistance values.

## Add Internal Node
![Internal Node](../../images/protocol-exerciser/i2c/add-internal-node.png)

Create internal nodes. After completing all necessary settings, press the `Assign` button to place it on the bus.

1. Name: Set the Name for this node to help users identify it.
2. Address Type: Set the Address Type of this node. We now only support 7-bit mode.
3. Address Settings:
    1. I2C Standard Address: User can only set the standard address value (0x08 ~ 0x77).
    2. I2C Address (Include Reserved Address): User can set all the available address value (0x00 ~ 0x7F).
4. Address: Set the Address value.
5. Register Settings:
    1. Register Type: Set the Register Type. We now only support 32-bit Register.
    2. Sub-Address Type:
        1. Without Sub-Address: Do not use Sub-Address.
        2. 8-bit Sub-Address: Sub-Address type. We now only support 8-bit Sub-Address.
    3. Sub-Address Data Format: This setting only avaliable while the `Sub-Address Type` is set to `8-bit Sub-Address`
        1. Repeat Sub-Address
        ![Repeat Sub-Address](../../images/protocol-exerciser/i2c/sub-repeat-i2c.png)
        2. Increment Sub-Address
        ![Increment Sub-Address](../../images/protocol-exerciser/i2c/sub-inc-i2c.png)
        3. Increment Loop Sub-Address
        ![Increment Loop Sub-Address](../../images/protocol-exerciser/i2c/sub-inc-loop-i2c.png)
        4. Ignore Sub-Address
        ![Ignore Sub-Address](../../images/protocol-exerciser/i2c/sub-ignore-i2c.png)

## Controller Mode

### Timing Settings
![Timing Settings](../../images/protocol-exerciser/i2c/timingsetting.png)

User can adjust I2C timing, including:

1. Clock Frequency, {++range from 1kHz to 1000kHz.++}
2. Each components, {++scale from 5ns to 20us.++}
    * User can drag the slider bar to adjust the Setup and Hold time of Data.

### Functions
![Functions](../../images/protocol-exerciser/i2c/buttons.png)

#### Assign
Assign the edited topology to the Exerciser device, so it can clearly understand the status of the bus and send commands or response data correctly.
The topology including the number of controller, internal node, the address, the type of internal node, etc.

#### Reload
Reload the topology from the Exerciser divice and display it.

#### Scan External Node
Scan all the available address, from 0x08 to 0x77. If any node return ACK, it will appear on the topology.

#### Decode Settings
![Decode Settings](../../images/protocol-exerciser/i2c/decode.png)
Set the parameters for LA to decode I2C signal.

### Send packet {#send-packets}
To open the wizard, please check the [Wizard](../index.md#wizard)

#### Quick Send
![Quick Send](../../images/protocol-exerciser/i2c/quick-send.png)

1. User can decide to send packet from any bus.
2. User can choose to build 7-bit, 8-bit or 10-bit mode packet. {++*In this document, we use 7-bit mode packet as example.*++}
3. User can specifically set the detail of the packet:
    1. R / W: Set this packet is WRITE or READ operation.
    2. Address: Set the address.
    3. Sub-Address: Set the sub-address value while enable this funciton.
    4. Write Data: Set the data for writing.
    5. Read Byte Count: Set the read byte count while doing READ operation.
4. Display address table. It will display information of internal and exteranl nodes.
5. Send out the packet.
6. Reload the address table.

#### Packet Constructor
![Send packet from bus](../../images/protocol-exerciser/i2c/send-packet-from-bus.png)

Switch to bus tab, click the buttom right `Add` button, it allows user to add 7-bit, 8-bit or 10-bit WRITE or READ packet.
After edit the packets, click the `Execute` to send out the packets.
As the same, we take 7-bit packet as example.

##### Edit Packet
![Edit Packet](../../images/protocol-exerciser/i2c/edit-packet.png)

1. Adjust the packet order.
2. Open the detail editing dialog.
    ![Sequence packet](../../images/protocol-exerciser/i2c/sequence-packet.png)
    1. Add WRITE or READ packet.
    2. Detailly edit the packet.
        ![Detail edit the packet](../../images/protocol-exerciser/i2c/detail-edit-packet.png)
        1. Address: User can set the packet address and WRITE or READ operation.
        2. Sub-Address: Set the sub-address if this function is enabled.
        3. Write Data: Data for writing. If the operation is switched to READ, user can set the read byte count.
        4. Next Packet: User can decide there is START or REPEAT START between two packets.
    3. Drop the packet.
    4. Adjust the order of packets.

## Target Mode
![Target Mode](../../images/protocol-exerciser/i2c/target.png)

All the buttons in Target Mode is the same in Controller Mode, but without `Timing Settings` and `Scan External Node`. Please reference the description of [buttons in Controller Mode](#functions).

![Targer Mode Wizard](../../images/protocol-exerciser/i2c/target-mode-wizard.png)
And in Target Mode, users are NOT allowed to send out any packet. Therefore the buttons of I2C wizard are all disable.