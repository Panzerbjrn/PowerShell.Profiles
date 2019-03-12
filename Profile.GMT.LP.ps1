$ErrorActionPreference = "STOP"
$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'

Try {Import-Module (Get-ChildItem -Path \\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse -Verbose| Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
Try {Set-ConsoleConfig}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
$Aliases = (Get-Alias|Select-Object -ExpandProperty Name)
$Aliases | ForEach {Remove-Item -Path Alias:$_ -Verbose:$False -ErrorAction SilentlyContinue}
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo}


$LogPath = "\\itss.global\prod\gmt\hf\UK\01\LPeterss\PowerShell.Transcripts\"
$LogFileName = "$(Get-Date -f yyyy.MM.dd.HHmmss)."+$CName+".txt"
$LogFile = $LogPath + $LogFileName
Set-Location C:\Temp

Function prompt {
	# Determine Admin; set Symbol variable.
	IF ([bool](([System.Security.Principal.WindowsIdentity]::GetCurrent()).Groups -match 'S-1-5-32-544')) {
		$Symbol = '#'
	} Else {
		$Symbol = '$'
	}
	IF ((Get-Location).Path -eq $env:USERPROFILE) {
		$Path = '~'
	} Else {
		$Path = (Get-Location).Path
	}
 
	# Create prompt.
	"[PS$($PSV.Major) $Path]$Symbol "
} # End Function: prompt.

Clear-Host
Set-ConsoleConfig
"Welcome to PowerShell $($PSV.Major) on " +$CName + " " + $ENV:UserName
Get-Date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
Start-Transcript -path $LogFile -append
