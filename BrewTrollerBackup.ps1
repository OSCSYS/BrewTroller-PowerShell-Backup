Param(
  $portName = $null,
  $operation = 'Usage',
  $fileName = $null,
  $scope = 'all',
  $baudRate = 115200,
  $dataBits = 8,
  [System.IO.Ports.Parity]$parity = [System.IO.Ports.Parity]::None,
  [System.IO.Ports.StopBits]$stopBits = [System.IO.Ports.StopBits]::One
)

#######################################################################
# Global Protocol Object Definition
#######################################################################
$BrewTrollerBackupProtocol = @"
Name,ScopeList,BackupCommand,RestoreCommand,MaximumIndex
Volume Calibration,Volume;VolumeCalibration,B,L,29
Output Profiles,OutputProfiles,d,Q,23
Recipes,Recipes,@,?,19
Boil Temperature,SystemSettings;BoilTemp,A,K,-1
Boil Power,SystemSettings;BoilPower,f,i,-1
Evaporation Rate,SystemSettings;EvapRate,C,M,-1
Outputs,Outputs,D,N,2
Temperature Sensors,TemperatureSensors,F,P,8
Volume Capacity,Volume;VolumeCapacity,H,R,2
"@ | ConvertFrom-CSV

$BrewTrollerBackupProtocol | % {
	$_.ScopeList = $_.ScopeList -split ";"
}


#######################################################################
# Functions
#######################################################################

function Show-Usage {
  "BrewTroller PowerShell Backup Script"
  "------------------------------------"
  ""
  "Usage:"
  ""
  "  BrewTrollerBackup.ps1 -portName <PortName> -operation <Operation> -fileName <FileName> [-scope <Scope>] [-indexScope <IndexScope>] [-baudRate <BaudRate>] [-dataBits <DataBits>] [-parity <Parity>] [-stopBits <StopBits>]"
  "      <PortName>  Windows serial port name used to connect to BrewTroller device. (ex. 'COM1')"
  "     <Operation>  Backup, Restore, ScopeList, PortList"
  "      <FileName>  File name to backup to or restore from"
  "         <Scope>  Scope of settings to backup or restore. Default = 'all'. Use -Operation ScopeList for a list of available scope values."
  "      <BaudRate>  Baud rate configured in BrewTroller firmware. Default = 115200"
  "      <DataBits>  Data bits configured in BrewTroller firmware. Default = 8"
  "        <Parity>  Parity configured in BrewTroller firmware. Default = 'None'. Also supported 'Even', 'Odd', 'Mark', 'Space'"
  "      <StopBits>  Stop bits configured in BrewTroller firmware. Default = 'One'. Also available 'None', 'OnePointFive', 'Two'"
  ""
}

function Show-ScopeList {
	$scopeList = @()
	$BrewTrollerBackupProtocol | % {
		$scopeList += $_.ScopeList
	}
	$scopeList = $scopeList | select -unique
	$scopeList
}

function Get-BTVersion {
  Param(
    $port,
	$retries = 20
  )
  $message = "Verifying communication"
  while ($retries -gt 0) {
	  try {
		  $message += "."
		  Clear
		  Write-Host $message
		  $port.Write("G`r")
		  $version = $port.ReadLine()
		  $message += " Success"
		  Clear
		  Write-Host $message
		  $version = $version -split "`t"
		  $versionInfo = "" | select version, build, metric
		  $versionInfo.version = $version[1]
		  $versionInfo.build = $version[2]
		  $versionInfo.metric = $version[4]
		  return $versionInfo
	  } catch {
		  $retries = $retries - 1
	  }
  }
  return $null
}

function Get-CommandSetInScope {
  Param(
    $scope
  )
  $commandSet = $BrewTrollerBackupProtocol
	if ($scope -ne 'All') {
		$commandSet = $commandSet | ? {$_.ScopeList -Contains $scope}
	}
	return $commandSet
}

function Do-Backup {
  Param(
    $port,
    $scope,
    $fileName,
	$version
  )
	$commandSet = Get-CommandSetInScope -scope $scope
	$data = @()
	$commandSet | % {
		$command = $_
		$commandList = @()
		if ([int]$_.MaximumIndex -ge 0) {
			(0..([int]$_.MaximumIndex)) | % { $commandList += "$($command.BackupCommand)$_`r" }
		} else {
			$commandList += "$($command.BackupCommand)`r" 
		}
		$commandList | % {
			$indexText = ""
			if ($commandList.count -gt 1) {$indexText = "Index $([array]::indexof($commandList,$_))"}
			Write-Host "Retrieving $($command.Name) $indexText"
			$port.Write($_)
			$line = $port.ReadLine().trim()
			$line = $command.RestoreCommand + $line.substring(1)
			$data += $line
		}
	}

	$data | out-file $fileName -encoding ASCII
	"Wrote $($data.count) items to $fileName"

}

function Do-Restore {
  Param(
    $port,
    $scope,
    $fileName,
	$version
  )
	$commandSet = Get-CommandSetInScope -scope $scope
	
	try {
		$data = Get-Content $fileName -encoding ASCII
	} catch {
		Write-Error "Failed to open $fileName"
		return
	}
	$data | % {
		$line = $_
		$commandField = ($line -split "`t")[0]
		$commandCode = $commandField.substring(0, 1)
		$commandIndex = $commandField.substring(1)
		$indexText = ""
		if ($commandIndex){$indexText = "Index $commandIndex"}
		$restoreCommand = $commandSet | ? { $_.RestoreCommand -eq $commandCode }
		
		if ($restoreCommand) {
			if ($restoreCommand.Name -eq "Recipes") { $line = (($line -split"`t")[0..22]) -join "`t" }
			$port.write("$line`r")
			$response = ""
			$response = $port.ReadLine()
			
			if ($response -ne "" -And ($response.substring(0, 1) -eq $restoreCommand.BackupCommand)) {
				"Restore: $($restoreCommand.Name) $($indexText): Success"
			} else {
				Write-Warning "Command failed: $line`r`nResponse: $response"
			}
		} else {
			$commandDefinition = $BrewTrollerBackupProtocol | ? {$_.RestoreCommand -eq $commandCode}
			$commandName = "Unknown command $commandField"
			if ($commandDefinition) { $commandName = $commandDefinition.name }
			Write-Host "Skipping (Out of Scope) $commandName $indexText"
		}
	}
}


#######################################################################
# Start of Main Script
#######################################################################

if ($operation -eq "ScopeList") {
  "The following scope options are available:"
  Show-ScopeList
  return
}

if ($operation -eq "PortList") {
  "The following port names are available:"
  [System.IO.Ports.SerialPort]::getportnames()
  return
}

if ($operation -eq "Usage") {
	Show-Usage
	return
}

if ($portName -eq $null) {
	Write-Error "Missing PortName parameter"
	Show-Usage
	return
}

if ($operation -eq "Usage") {
	Show-Usage
	return
}

$port = new-Object System.IO.Ports.SerialPort $portName, $baudRate, $parity, $databits, $stopBits
$port.ReadTimeout = 1000
$port.open()

if (-Not $port.IsOpen) {return}

$versionInfo = Get-BTVersion -port $port
if (-Not $versionInfo) {
	Write-Error "Communication failed"
	$port.Close()
	return
}

if ($versionInfo.metric -eq 0) { $unit = "Imperial" } else { $unit = "Metric" }
"BrewTroller v" + $versionInfo.version + " Build " + $versionInfo.build + " ($unit)"

if ($operation -eq "Version") {
  $port.Close()
  return
} 

if ($filename -eq $null) {
	Write-Error "Missing FileName parameter"
	Show-Usage
	return
}

if ($operation -eq "backup") {
  Do-Backup -port $port -scope $scope -fileName $fileName -version $versionInfo
} elseif ($operation -eq "restore") {
  Do-Restore -port $port -scope $scope -fileName $fileName -version $versionInfo
} else {
  Write-Error "Invalid operation specified"
  Show-Usage
}
$port.Close()