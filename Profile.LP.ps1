$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
Import-Module (Get-ChildItem -Path C:\Dropbox\Scripts\PowerShell.Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber
Import-Module (Get-ChildItem -Path C:\Dropbox\Scripts\PowerShell.Modules -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber

$ErrorActionPreference = "STOP"
$Aliases = (Get-Alias|Select-Object -ExpandProperty Name)
$Aliases | ForEach {Remove-Item -Path Alias:$_ -verbose -ErrorAction SilentlyContinue}
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo}

# Region Credentials
Write-Host "Setting Azure Credentials"
$AZAccount = "lars@panzerbjrn.net"
$AZPassword = "S@nderalle88"
$AZSecureStringPWD = $AZPassword | ConvertTo-SecureString -AsPlainText -Force
$AzCred = New-Object System.Management.Automation.PSCredential -ArgumentList $AZAccount,$AZSecureStringPWD
$SecUserName = "BOFH"
$SecPassword = "S@nderalle88"
$SecSecureStringPWD = $SecPassword | ConvertTo-SecureString -AsPlainText -Force
$SecCred = New-Object System.Management.Automation.PSCredential -ArgumentList $SecUserName,$SecSecureStringPWD
$PriUserName = "Administrator"
$PriPassword = "S@nderalle88"
$PriSecureStringPWD = $PriPassword | ConvertTo-SecureString -AsPlainText -Force
$PriCred = New-Object System.Management.Automation.PSCredential -ArgumentList $PriUserName,$PriSecureStringPWD
# Region Credentials
Write-Host "Setting Progress Bars" -F Cyan 
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'


Clear-Host
$HomePath = Test-Path "C:\Dropbox\Scripts\Transcripts"
$WerkPath = Test-Path "C:\Users\LarsPetersson\Dropbox\Scripts\Transcripts"
$WinVer = (Get-WmiObject -class Win32_OperatingSystem).Caption
#Write-Host "Setting AWS REgion" -F Cyan
<# IF ($HomePath -eq $True) {Set-DefaultAWSRegion eu-west-2}
ELSE {Set-DefaultAWSRegion eu-west-1} #>
IF (($CName -eq "PanzerPro") -OR ($CName -eq "Beast"))
	{
		$host.ui.RawUI.WindowTitle = "PowerShell Operations Console"
		$LogPath = "C:\Dropbox\Scripts\Transcripts\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$Name+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-ConsoleConfig
		Set-Location D:\
	}
ELSE
	{
		Write-Host "TempPath is True" -F Cyan
		$TempPath = Test-Path "C:\Temp\"
		IF ($TempPath -eq $False) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
		ELSE {}
		$LogPath = "C:\Temp\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$Name+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-ConsoleConfig
	}
"Welcome to PowerShell $($PSV.Major) on " +$CName + " " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
Write-Host "Starting Transcript" -F Cyan
Start-Transcript -path $LogFile -append
