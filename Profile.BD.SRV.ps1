##Admin Account @ Servers
Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy Unrestricted
$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'
$ErrorActionPreference = "STOP"
IF (!(Test-Path "C:\Users\Petersson_L_a\Documents\PowerShell")){New-Item -ItemType "Directory" -Path "C:\Users\Petersson_L_a\Documents\PowerShell" -Force}
Try {Copy-Item "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PS.Profiles\Profile.BD.SRV.ps1" "C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Profile.ps1" -Force}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
Try {Copy-Item "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PS.Profiles\Profile.BD.SRV.ps1" "C:\Users\Petersson_L_a\Documents\PowerShell\Profile.ps1" -Force}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
IF ($PSV.Major -eq "5") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber -Verbose}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber -Verbose}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
}
IF ($PSV.Major -eq "6") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\PowerShell -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber -Verbose}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\PowerShell -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber -Verbose}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
}
Try {Set-ConsoleConfig}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
##########################
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
##########################

$MyDevBox1 = "DEV-AP337140"
$MyDevBox2 = "DEV-AP337142"
$MyVDI = "VM-W10VDI-SI"
$Infoblox = "infoblox.brewindolphin.net"
$Aliases = (Get-Alias|Select-Object -ExpandProperty Name)
$Aliases | ForEach {Try {Remove-Item -Path Alias:$_ -verbose -ErrorAction SilentlyContinue}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 2}}
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}

$LogPath = "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PS.Transcripts\"
$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$CName+".txt"
$LogFile = $LogPath + $LogFileName

Set-Location C:\Temp

Clear-Host
"Welcome to PowerShell $($PSV.Major) on " +$CName + " " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
Start-Transcript -path $LogFile -append
