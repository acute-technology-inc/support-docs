# Controller Mode
![Ctrl_Topo](../../img/i3c/Topo_Mode_Controller.png)

## Address Table
![Address Table Settings](../../img/i3c/Addr_Table.png)

### I3C Address Table
Add the PID, BCR, and DCR to reserve a dynamic address for assignment by the controller. If the dynamic address is already in use, the controller will increment the value until an available address is found.
(X = Don't Care) 
![Address Table I3C Settings](../../img/i3c/Addr_Table_I3C_Resv.png)

### I2C Address Table
Add the I2C Nodes especially external I2C device to controller
![Address Table I2C Settings](../../img/i3c/Addr_Table_I2C.png)

### In-Used Table
Display the I3C nodes that are already in use. 
![Address Table Used Settings](../../img/i3c/Addr_Table_I3C_Used.png)


## Decode Settings
Set the parameters for LA to decode I3C signal.
![Decode Settings](../../img/i3c/I3C_Decode.png)

1. **Color**: Select the colors for the LA decode elements
2. **Starup Mode**: Select the startup mode for the LA decode. Ususally, you can keep it default(SDR mode).
3. **Extended Specification**: Enable MIPI I3C Debug information
4. **Report Detail Option**: Enable more detail for the decode


## Timing Settings
The base unit for Acute Exerciser is *5 ns*. Users are not allowed to set the value under *5 ns*.

### Common settings
![Timing Common Settings](../../img/i3c/Timing_Common.png)
1. The clock speed range of the I3C is ***13MHz ~ 100Hz*** 
2. The Open Drain clock speed range is ***5MHz ~ 100Hz***
3. tCAS, tCBP, tCASr, tCBSr value adjustment (**Base Unit is 5 ns**)

### Push Pull Header
![Timing Push Pull Settings](../../img/i3c/Timing_PP.png)

### Optimized Header
![Timing Optimized Settings](../../img/i3c/Timing_OPT.png)

### Open Drain
1. Open Drain Fast:
![Timing ODF Settings](../../img/i3c/Timing_ODF.png)

2. Open Drain Slow
![Timing ODS Settings](../../img/i3c/Timing_ODS.png)

3. Open Drain Read 8 Bytes
![Timing ODR8 Settings](../../img/i3c/Timing_ODR8.png)

### I3C Read
*This is Push Pull Speed*
![Timing I3C RD Settings](../../img/i3c/Timing_I3CRD.png)

### I3C Write
*This is Push Pull Speed*
![Timing I3C WR Settings](../../img/i3c/Timing_I3CWR.png)

### Legacy I2C
Speed Range for Legacy I2C is ***1MHz ~ 100Hz***
![Timing I2C RW Settings](../../img/i3c/Timing_I2CRW.png)

## Run
Assign the edited topology to the Exerciser device, so it can clearly understand the status of the bus and send commands or response data correctly. 

Some of the steps of the process are optional.

(The topology including the number of controller, internal node, the address, the type of internal node, etc.)
![Wait Run](../../img/i3c/Run_Wait.png)

![Light Err](../../img/i3c/Red.png) : Error Occured. Check the Status.
![Light Wait](../../img/i3c/Blue.png) : Wait for processing
![Light Skip](../../img/i3c/Gray.png) : Skip this process
![Light Pass](../../img/i3c/Green.png) : Process succeed

When the process succeed:
![Timing OK Run](../../img/i3c/Run_OK.png)



## Reload
If you build up the topology via python code, you may use the Reload button to refresh the current status of the exerciser topology.
![Timing Reload](../../img/i3c/Topo_Mode_Controller.png)