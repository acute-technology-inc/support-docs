# Functions
![Topology](../../images/protocol-exerciser/uart/topology.png)

After enable, the buttons below will be turned on.

## Connect
Establish a connection with an external UART device.

## Reload
Reload the connection status and display.

## Decode & Timing
![UART decode](../../images/protocol-exerciser/uart/decode.png)
Set the UART decode parameter for LA to decode.

## Send packet {#send-packets}
To open the wizard, please check the [Wizard](../index.md#wizard)

### Quick Send
![Quick Send](../../images/protocol-exerciser/uart/quick-send.png)

1. User can decide to send packet from which bus.
2. User can choose the input data format, for easily read. We now support:
    1. Hexadecimal
    2. Decimal
    3. Binary
    4. Binary (Space Separate), user use SPACE to separate the binary value.
    5. ASCII
In Binary format, Binary values are grouped in units of bit size, with any remaining bits padded with zeros. For instance, bit size is 4, the data is 10101, then the send out data would be 0001 0101.
3. Data that want to send out, based on the input format.
4. Send out the packet.

### Packet Constructor
![Send packet from bus](../../images/protocol-exerciser/uart/send-packet-from-bus.png)

Switch to the bus tab, click the bottom right `Add` button, it will automatically create a packet.
After edit the packets, click the `Execute` to send out the packets.

#### Edit Packet
![Edit Packet](../../images/protocol-exerciser/uart/edit-packet.png)

1. Adjust the packet order.
2. Open the detail editing dialog.
    ![Sequence packet](../../images/protocol-exerciser/uart/sequence-packet.png)

    1. Add a UART packet
    2. Detailly edit the packet.
        ![Detail edit the packet](../../images/protocol-exerciser/uart/detail-edit-packet.png)

        1. Data Format: Like the description in [Quick Send](#quick-send)
        2. Data: Data that want to send out. The precautions are the same as those described in [Quick Send](#quick-send)
        3. Parity Error: User can decide to send out a Parity Error purposely.

    3. Drop the packet
    4. Adjust the order of packets.
    5. Change the display format, We now suppor two formats:
        1. Packet Mode: Not only display the data, but also display the START bit and STOP bit.
            ![Packet Mode](../../images/protocol-exerciser/uart/packet-mode.png)

        2. Data Mode: only display the data.
            ![Data Mode](../../images/protocol-exerciser/uart/data-mode.png)
