# Internal Node

## I3C Node
![Internal Node 1](../../img/i3c/Internal_Node_Settings_1.png)
![Internal Node 2](../../img/i3c/Internal_Node_Settings_2.png)

1. Name: Set the Name for this node to help users identify it.
2. Static Address: Set the Address value.
3. Register Settings:
    1. Register Type: Set the Register Type. We now only support 32-bit Register.
    2. Sub-Address Type:
        1. Without Sub-Address: Do not use Sub-Address.
        ![Without Sub-Address](../../img/i3c/No_Sub.png)
        2. 8-bit Sub-Address: Sub-Address type. We now only support 8-bit Sub-Address.
    3. Sub-Address Data Format: This setting only avaliable while the `Sub-Address Type` is set to `8-bit Sub-Address`
        1. Repeat Sub-Address
        ![Repeat Sub-Address](../../img/i3c/Sub_Repeat.png)
        2. Increment Sub-Address
        ![Increment Sub-Address](../../img/i3c/Sub_Inc.png)
        3. Increment Loop Sub-Address
        ![Increment Loop Sub-Address](../../img/i3c/Sub_Inc_Loop.png)
        4. Ignore Sub-Address
        ![Ignore Sub-Address](../../img/i3c/Sub_Ignore.png)

4. I3C Node Information:
    1. PID: Build the Unique ID
    2. BCR: Build the Bus Characteristic Register (This settings will affect other settings)
    3. DCR: Device Characteristic Register (Select **Custom** allows to type in the value in the spinbox ) 
    4. Additional Settings: 
        1. GETCAPS:
        ![CAPS Ver1.0](../../img/i3c/GETCAPS_Ver1_0.png)
        This only enabled when selecting Version 1.0

        Format 1:
        ![CAPS Simple](../../img/i3c/GETCAPS_Ver1_1.png)
        Set CAPS Defining bit will enable the GETCAPS Format 2
        Set STATUS Defining bit will enable the GETSTATUS Format 2
        
        Format 2:
        *Defining Byte Format only support 1 kind of defining byte.*
        ![CAPS Defining](../../img/i3c/GETCAPS_Ver1_1_Def.png)
        This is the same as the GETCAPS Format 1

        TESTPAT: 
        ![CAPS TEST Defining](../../img/i3c/GETCAPS_Ver1_1_Def_Test.png)
        
        CRCAPS: 
        ![CAPS CRCAPS Defining](../../img/i3c/GETCAPS_Ver1_1_Def_CRCAPS.png)
        
        VRCAPS: 
        ![CAPS VTCAPS Defining](../../img/i3c/GETCAPS_Ver1_1_Def_VTCAPS.png)
        
        DBGCAPS:
        ![CAPS DBGCAPS Defining](../../img/i3c/GETCAPS_Ver1_1_Def_DBGCAPS.png)

        2. GETSTATUS:
        GETSTATUS Format 1:
        ![STATUS Simple](../../img/i3c/GETSTATUS.png)

        GETSTATUS Format 2:
        *Defining Byte Format only support 1 kind of defining byte.*
        ![STATUS Defining](../../img/i3c/GETSTATUS_Def.png)
        This is the same as the GETSTATUS Format 1

        NASTAT:
        ![STATUS NASTAT Defining](../../img/i3c/GETSTATUS_Def_NASTAT.png)

        PRECR:
        ![STATUS PRECR Defining](../../img/i3c/GETSTATUS_Def_PRECR.png)

        SCMSTAT:
        ![STATUS SCMSTAT Defining](../../img/i3c/GETSTATUS_Def_SCMSTAT.png)

        
        3. GETMXDS:
        Format 1 & 2:
        ![MXDS Simple](../../img/i3c/GETMXDS.png)

        Select *Support* in Defining Byte slot will enable the Defining byte format(Format 3) 

        Format 3
        *Defining Byte Format only support 1 kind of defining byte.*
        ![MXDS Defining](../../img/i3c/GETMXDS_Def_WRRDTURN.png)

        This is the same as the GETMXDS Format 1 or 2

        CRHDLY:
        ![MXDS Defining](../../img/i3c/GETMXDS_Def_CRHDLY.png)

        4. MWL & MRL:
        *IBI Size only enabled when BCR IBI related bit set to Support*
        ![MWL MRL Simple](../../img/i3c/MWLMRL.png)
        

## Legacy I2C Node
![Internal Node I2C](../../img/i3c/Internal_Node_I2C.png)

1. Name: Set the Name for this node to help users identify it.
2. Static Address: Set the Address value.
3. Register Settings:
    1. Register Type: Set the Register Type. We now only support 32-bit Register.
    2. Sub-Address Type:
        1. Without Sub-Address: Do not use Sub-Address.
        ![I2C Without Sub-Address](../../img/i3c/No_Sub_I2C.png)

        2. 8-bit Sub-Address: Sub-Address type. We now only support 8-bit Sub-Address.
    3. Sub-Address Data Format: This setting only avaliable while the `Sub-Address Type` is set to `8-bit Sub-Address`
        1. Repeat Sub-Address
        ![I2C Repeat Sub-Address](../../img/i3c/Sub_Repeat_I2C.png)

        2. Increment Sub-Address
        ![I2C Increment Sub-Address](../../img/i3c/Sub_Inc_I2C.png)

        3. Increment Loop Sub-Address
        ![I2C Increment Loop Sub-Address](../../img/i3c/Sub_Inc_Loop_I2C.png)

        4. Ignore Sub-Address
        ![I2C Ignore Sub-Address](../../img/i3c/Sub_Ignore_I2C.png)



## I3C Stress Test
![Internal Node Stress](../../img/i3c/Internal_Node_Stress.png)
Continuously send out IBI packet for testing the ability of controller to deal with the great amount of IBI.