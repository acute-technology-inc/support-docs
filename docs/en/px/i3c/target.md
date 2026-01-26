# Target Mode
If you have your own external controller, you may use the Target Mode to simulates the targets for your controller.
![Target Mode](../../img/i3c/Topo_Mode_Target.png)

## Decode Settings
Same as the Controller Mode.
Set the parameters for LA to decode I3C signal.
![Decode Settings](../../img/i3c/I3C_Decode.png)

1. **Color**: Select the colors for the LA decode elements
2. **Starup Mode**: Select the startup mode for the LA decode. Ususally, you can keep it default(SDR mode).
3. **Extended Specification**: Enable MIPI I3C Debug information
4. **Report Detail Option**: Enable more detail for the decode

## Run
Assign the edited topology to the Exerciser device, so it can clearly understand the status of the bus and send commands or response data correctly. 

Some of the steps of the process are not available in Target Mode.

(The topology including detail of internal nodes, etc.)
![Wait Run](../../img/i3c/Run_Target.png)

![Light Err](../../img/i3c/Red.png) : Error Occured. Check the Status.
![Light Wait](../../img/i3c/Blue.png) : Wait for processing
![Light Skip](../../img/i3c/Gray.png) : Skip this process
![Light Pass](../../img/i3c/Green.png) : Process succeed

When the process succeed:
![Timing OK Run](../../img/i3c/Run_Target_OK.png)


## Reload
Same as the Controller Mode.
If you build up the topology via python code, you may use the Reload button to refresh the current status of the exerciser topology.
![Timing Reload](../../img/i3c/Topo_Mode_Target.png)