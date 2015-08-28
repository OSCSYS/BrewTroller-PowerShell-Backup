# BrewTroller-PowerShell-Backup
Windows PowerShell Script for Backup and Restore of BrewTroller Settings via USB/Serial

  BrewTroller PowerShell Backup Script
  ------------------------------------
  
  Usage:
  
    BrewTrollerBackup.ps1 -portName <PortName> -operation <Operation> -fileName <FileName> [-scope <Scope>] [-indexScope <IndexScope>] [-baudRate <BaudRate>] [-dataBits <DataBits>] [-parity <Parity>] [-stopBits <StopBits>]
        <PortName>  Windows serial port name used to connect to BrewTroller device. (ex. 'COM1')
      <Operation>  Backup, Restore, ScopeList, PortList
        <FileName>  File name to backup to or restore from
           <Scope>  Scope of settings to backup or restore. Default = 'all'. Use -Operation ScopeList for a list of available scope values.
        <BaudRate>  Baud rate configured in BrewTroller firmware. Default = 115200
        <DataBits>  Data bits configured in BrewTroller firmware. Default = 8
          <Parity>  Parity configured in BrewTroller firmware. Default = 'None'. Also supported 'Even', 'Odd', 'Mark', 'Space'
        <StopBits>  Stop bits configured in BrewTroller firmware. Default = 'One'. Also available 'None', 'OnePointFive', 'Two'


    PS > .\BrewTrollerBackup.ps1 -operation backup -fileName .\Backup.txt -portName COM25
    
    Verifying communication. Success
    BrewTroller v2.7 Build 12 (Imperial)
    Retrieving Volume Calibration Index 0
    Retrieving Volume Calibration Index 1
    Retrieving Volume Calibration Index 2
    Retrieving Volume Calibration Index 3
    Retrieving Volume Calibration Index 4
    Retrieving Volume Calibration Index 5
    Retrieving Volume Calibration Index 6
    Retrieving Volume Calibration Index 7
    Retrieving Volume Calibration Index 8
    Retrieving Volume Calibration Index 9
    Retrieving Volume Calibration Index 10
    Retrieving Volume Calibration Index 11
    Retrieving Volume Calibration Index 12
    Retrieving Volume Calibration Index 13
    Retrieving Volume Calibration Index 14
    Retrieving Volume Calibration Index 15
    Retrieving Volume Calibration Index 16
    Retrieving Volume Calibration Index 17
    Retrieving Volume Calibration Index 18
    Retrieving Volume Calibration Index 19
    Retrieving Volume Calibration Index 20
    Retrieving Volume Calibration Index 21
    Retrieving Volume Calibration Index 22
    Retrieving Volume Calibration Index 23
    Retrieving Volume Calibration Index 24
    Retrieving Volume Calibration Index 25
    Retrieving Volume Calibration Index 26
    Retrieving Volume Calibration Index 27
    Retrieving Volume Calibration Index 28
    Retrieving Volume Calibration Index 29
    Retrieving Output Profiles Index 0
    Retrieving Output Profiles Index 1
    Retrieving Output Profiles Index 2
    Retrieving Output Profiles Index 3
    Retrieving Output Profiles Index 4
    Retrieving Output Profiles Index 5
    Retrieving Output Profiles Index 6
    Retrieving Output Profiles Index 7
    Retrieving Output Profiles Index 8
    Retrieving Output Profiles Index 9
    Retrieving Output Profiles Index 10
    Retrieving Output Profiles Index 11
    Retrieving Output Profiles Index 12
    Retrieving Output Profiles Index 13
    Retrieving Output Profiles Index 14
    Retrieving Output Profiles Index 15
    Retrieving Output Profiles Index 16
    Retrieving Output Profiles Index 17
    Retrieving Output Profiles Index 18
    Retrieving Output Profiles Index 19
    Retrieving Output Profiles Index 20
    Retrieving Output Profiles Index 21
    Retrieving Output Profiles Index 22
    Retrieving Output Profiles Index 23
    Retrieving Recipes Index 0
    Retrieving Recipes Index 1
    Retrieving Recipes Index 2
    Retrieving Recipes Index 3
    Retrieving Recipes Index 4
    Retrieving Recipes Index 5
    Retrieving Recipes Index 6
    Retrieving Recipes Index 7
    Retrieving Recipes Index 8
    Retrieving Recipes Index 9
    Retrieving Recipes Index 10
    Retrieving Recipes Index 11
    Retrieving Recipes Index 12
    Retrieving Recipes Index 13
    Retrieving Recipes Index 14
    Retrieving Recipes Index 15
    Retrieving Recipes Index 16
    Retrieving Recipes Index 17
    Retrieving Recipes Index 18
    Retrieving Recipes Index 19
    Retrieving Boil Temperature
    Retrieving Boil Power
    Retrieving Evaporation Rate
    Retrieving Outputs Index 0
    Retrieving Outputs Index 1
    Retrieving Outputs Index 2
    Retrieving Temperature Sensors Index 0
    Retrieving Temperature Sensors Index 1
    Retrieving Temperature Sensors Index 2
    Retrieving Temperature Sensors Index 3
    Retrieving Temperature Sensors Index 4
    Retrieving Temperature Sensors Index 5
    Retrieving Temperature Sensors Index 6
    Retrieving Temperature Sensors Index 7
    Retrieving Temperature Sensors Index 8
    Retrieving Volume Capacity Index 0
    Retrieving Volume Capacity Index 1
    Retrieving Volume Capacity Index 2
    Wrote 92 items to .\Backup.txt

    PS > .\BrewTrollerBackup.ps1 -operation restore -fileName .\Backup.txt -portName COM25
    
    Verifying communication. Success
    BrewTroller v2.7 Build 12 (Imperial)
    Restore: Volume Calibration Index 0: Success
    Restore: Volume Calibration Index 1: Success
    Restore: Volume Calibration Index 2: Success
    Restore: Volume Calibration Index 3: Success
    Restore: Volume Calibration Index 4: Success
    Restore: Volume Calibration Index 5: Success
    Restore: Volume Calibration Index 6: Success
    Restore: Volume Calibration Index 7: Success
    Restore: Volume Calibration Index 8: Success
    Restore: Volume Calibration Index 9: Success
    Restore: Volume Calibration Index 10: Success
    Restore: Volume Calibration Index 11: Success
    Restore: Volume Calibration Index 12: Success
    Restore: Volume Calibration Index 13: Success
    Restore: Volume Calibration Index 14: Success
    Restore: Volume Calibration Index 15: Success
    Restore: Volume Calibration Index 16: Success
    Restore: Volume Calibration Index 17: Success
    Restore: Volume Calibration Index 18: Success
    Restore: Volume Calibration Index 19: Success
    Restore: Volume Calibration Index 20: Success
    Restore: Volume Calibration Index 21: Success
    Restore: Volume Calibration Index 22: Success
    Restore: Volume Calibration Index 23: Success
    Restore: Volume Calibration Index 24: Success
    Restore: Volume Calibration Index 25: Success
    Restore: Volume Calibration Index 26: Success
    Restore: Volume Calibration Index 27: Success
    Restore: Volume Calibration Index 28: Success
    Restore: Volume Calibration Index 29: Success
    Restore: Output Profiles Index 0: Success
    Restore: Output Profiles Index 1: Success
    Restore: Output Profiles Index 2: Success
    Restore: Output Profiles Index 3: Success
    Restore: Output Profiles Index 4: Success
    Restore: Output Profiles Index 5: Success
    Restore: Output Profiles Index 6: Success
    Restore: Output Profiles Index 7: Success
    Restore: Output Profiles Index 8: Success
    Restore: Output Profiles Index 9: Success
    Restore: Output Profiles Index 10: Success
    Restore: Output Profiles Index 11: Success
    Restore: Output Profiles Index 12: Success
    Restore: Output Profiles Index 13: Success
    Restore: Output Profiles Index 14: Success
    Restore: Output Profiles Index 15: Success
    Restore: Output Profiles Index 16: Success
    Restore: Output Profiles Index 17: Success
    Restore: Output Profiles Index 18: Success
    Restore: Output Profiles Index 19: Success
    Restore: Output Profiles Index 20: Success
    Restore: Output Profiles Index 21: Success
    Restore: Output Profiles Index 22: Success
    Restore: Output Profiles Index 23: Success
    Restore: Recipes Index 0: Success
    Restore: Recipes Index 1: Success
    Restore: Recipes Index 2: Success
    Restore: Recipes Index 3: Success
    Restore: Recipes Index 4: Success
    Restore: Recipes Index 5: Success
    Restore: Recipes Index 6: Success
    Restore: Recipes Index 7: Success
    Restore: Recipes Index 8: Success
    Restore: Recipes Index 9: Success
    Restore: Recipes Index 10: Success
    Restore: Recipes Index 11: Success
    Restore: Recipes Index 12: Success
    Restore: Recipes Index 13: Success
    Restore: Recipes Index 14: Success
    Restore: Recipes Index 15: Success
    Restore: Recipes Index 16: Success
    Restore: Recipes Index 17: Success
    Restore: Recipes Index 18: Success
    Restore: Recipes Index 19: Success
    Restore: Boil Temperature : Success
    Restore: Boil Power : Success
    Restore: Evaporation Rate : Success
    Restore: Outputs Index 0: Success
    Restore: Outputs Index 1: Success
    Restore: Outputs Index 2: Success
    Restore: Temperature Sensors Index 0: Success
    Restore: Temperature Sensors Index 1: Success
    Restore: Temperature Sensors Index 2: Success
    Restore: Temperature Sensors Index 3: Success
    Restore: Temperature Sensors Index 4: Success
    Restore: Temperature Sensors Index 5: Success
    Restore: Temperature Sensors Index 6: Success
    Restore: Temperature Sensors Index 7: Success
    Restore: Temperature Sensors Index 8: Success
    Restore: Volume Capacity Index 0: Success
    Restore: Volume Capacity Index 1: Success
    Restore: Volume Capacity Index 2: Success

Restore Example (Partial Scope)
----
You may also choose to backup or restore a subset of settings using the -scope parameter.
    PS > .\BrewTrollerBackup.ps1 -operation restore -fileName .\Backup.txt -portName COM25 -scope SystemSettings
    Verifying communication. Success
    BrewTroller v2.7 Build 12 (Imperial)
    Skipping (Out of Scope) Volume Calibration Index 0
    Skipping (Out of Scope) Volume Calibration Index 1
    Skipping (Out of Scope) Volume Calibration Index 2
    Skipping (Out of Scope) Volume Calibration Index 3
    Skipping (Out of Scope) Volume Calibration Index 4
    Skipping (Out of Scope) Volume Calibration Index 5
    Skipping (Out of Scope) Volume Calibration Index 6
    Skipping (Out of Scope) Volume Calibration Index 7
    Skipping (Out of Scope) Volume Calibration Index 8
    Skipping (Out of Scope) Volume Calibration Index 9
    Skipping (Out of Scope) Volume Calibration Index 10
    Skipping (Out of Scope) Volume Calibration Index 11
    Skipping (Out of Scope) Volume Calibration Index 12
    Skipping (Out of Scope) Volume Calibration Index 13
    Skipping (Out of Scope) Volume Calibration Index 14
    Skipping (Out of Scope) Volume Calibration Index 15
    Skipping (Out of Scope) Volume Calibration Index 16
    Skipping (Out of Scope) Volume Calibration Index 17
    Skipping (Out of Scope) Volume Calibration Index 18
    Skipping (Out of Scope) Volume Calibration Index 19
    Skipping (Out of Scope) Volume Calibration Index 20
    Skipping (Out of Scope) Volume Calibration Index 21
    Skipping (Out of Scope) Volume Calibration Index 22
    Skipping (Out of Scope) Volume Calibration Index 23
    Skipping (Out of Scope) Volume Calibration Index 24
    Skipping (Out of Scope) Volume Calibration Index 25
    Skipping (Out of Scope) Volume Calibration Index 26
    Skipping (Out of Scope) Volume Calibration Index 27
    Skipping (Out of Scope) Volume Calibration Index 28
    Skipping (Out of Scope) Volume Calibration Index 29
    Skipping (Out of Scope) Output Profiles Index 0
    Skipping (Out of Scope) Output Profiles Index 1
    Skipping (Out of Scope) Output Profiles Index 2
    Skipping (Out of Scope) Output Profiles Index 3
    Skipping (Out of Scope) Output Profiles Index 4
    Skipping (Out of Scope) Output Profiles Index 5
    Skipping (Out of Scope) Output Profiles Index 6
    Skipping (Out of Scope) Output Profiles Index 7
    Skipping (Out of Scope) Output Profiles Index 8
    Skipping (Out of Scope) Output Profiles Index 9
    Skipping (Out of Scope) Output Profiles Index 10
    Skipping (Out of Scope) Output Profiles Index 11
    Skipping (Out of Scope) Output Profiles Index 12
    Skipping (Out of Scope) Output Profiles Index 13
    Skipping (Out of Scope) Output Profiles Index 14
    Skipping (Out of Scope) Output Profiles Index 15
    Skipping (Out of Scope) Output Profiles Index 16
    Skipping (Out of Scope) Output Profiles Index 17
    Skipping (Out of Scope) Output Profiles Index 18
    Skipping (Out of Scope) Output Profiles Index 19
    Skipping (Out of Scope) Output Profiles Index 20
    Skipping (Out of Scope) Output Profiles Index 21
    Skipping (Out of Scope) Output Profiles Index 22
    Skipping (Out of Scope) Output Profiles Index 23
    Skipping (Out of Scope) Recipes Index 0
    Skipping (Out of Scope) Recipes Index 1
    Skipping (Out of Scope) Recipes Index 2
    Skipping (Out of Scope) Recipes Index 3
    Skipping (Out of Scope) Recipes Index 4
    Skipping (Out of Scope) Recipes Index 5
    Skipping (Out of Scope) Recipes Index 6
    Skipping (Out of Scope) Recipes Index 7
    Skipping (Out of Scope) Recipes Index 8
    Skipping (Out of Scope) Recipes Index 9
    Skipping (Out of Scope) Recipes Index 10
    Skipping (Out of Scope) Recipes Index 11
    Skipping (Out of Scope) Recipes Index 12
    Skipping (Out of Scope) Recipes Index 13
    Skipping (Out of Scope) Recipes Index 14
    Skipping (Out of Scope) Recipes Index 15
    Skipping (Out of Scope) Recipes Index 16
    Skipping (Out of Scope) Recipes Index 17
    Skipping (Out of Scope) Recipes Index 18
    Skipping (Out of Scope) Recipes Index 19
    Restore: Boil Temperature : Success
    Restore: Boil Power : Success
    Restore: Evaporation Rate : Success
    Skipping (Out of Scope) Outputs Index 0
    Skipping (Out of Scope) Outputs Index 1
    Skipping (Out of Scope) Outputs Index 2
    Skipping (Out of Scope) Temperature Sensors Index 0
    Skipping (Out of Scope) Temperature Sensors Index 1
    Skipping (Out of Scope) Temperature Sensors Index 2
    Skipping (Out of Scope) Temperature Sensors Index 3
    Skipping (Out of Scope) Temperature Sensors Index 4
    Skipping (Out of Scope) Temperature Sensors Index 5
    Skipping (Out of Scope) Temperature Sensors Index 6
    Skipping (Out of Scope) Temperature Sensors Index 7
    Skipping (Out of Scope) Temperature Sensors Index 8
    Skipping (Out of Scope) Volume Capacity Index 0
    Skipping (Out of Scope) Volume Capacity Index 1
    Skipping (Out of Scope) Volume Capacity Index 2

ScopeList Example
----
    PS > .\BrewTrollerBackup.ps1 -operation scopelist
    The following scope options are available:
    Volume
    VolumeCalibration
    OutputProfiles
    Recipes
    SystemSettings
    BoilTemp
    BoilPower
    EvapRate
    Outputs
    TemperatureSensors
    VolumeCapacity
    
PortList Example
----
    PS > .\BrewTrollerBackup.ps1 -operation portlist
    The following port names are available:
    COM25
