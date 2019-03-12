# Region Credentials
$ErrorActionPreference = "STOP"
"ac","cat","cp","cpi","curl","dir","history","h","ls" | ForEach {Remove-Item -Path Alias:$_ -verbose -ErrorAction SilentlyContinue}
New-Alias -Name IH -Value Invoke-History
New-Alias -Name H -Value Get-History
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
$Name = $ENV:ComputerName

Clear-Host
$PSV = $PSVersionTable.PSVersion
$HomePath = Test-Path "C:\Dropbox\Scripts\Transcripts"
$WerkPath = Test-Path "C:\Users\LarsPetersson\Dropbox\Scripts\Transcripts"
$WinVer = (Get-WmiObject -class Win32_OperatingSystem).Caption
#Write-Host "Setting AWS REgion" -F Cyan
<# IF ($HomePath -eq $True) {Set-DefaultAWSRegion eu-west-2}
ELSE {Set-DefaultAWSRegion eu-west-1} #>
#Write-Host "Getting PS Version" -F Cyan
IF (($PSV.Major -eq "2") -OR ($WinVer -like "*2008*"))
	{
		Write-Host "PS Version is "$PSV.Major -F Cyan
		Get-Childitem -Path $Env:UserProfile -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -erroraction silentlycontinue}
		Import-Module TroubleshootingPack -ErrorAction SilentlyContinue
		Import-Module Servermanager -ErrorAction SilentlyContinue
		Import-Module GroupPolicy -ErrorAction SilentlyContinue
		Import-Module ActiveDirectory -ErrorAction SilentlyContinue
	}
ELSE {}
IF ($HomePath -eq $True)
	{
#		#Write-Host "Homepath is True" -F Cyan
		$host.ui.RawUI.WindowTitle = "PowerShell Operations Console"
		$LogPath = "C:\Dropbox\Scripts\Transcripts\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$Name+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-ConsoleConfig
		Set-Location D:\
	}
ELSEIF ($WerkPath -eq $True)
	{
		Write-Host "WerkPath is true" -F Cyan
		$LogPath = "C:\Users\LarsPetersson\Dropbox\Scripts\Transcripts\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$Name+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-ConsoleConfig
		Set-Location C:\Users\LarsPetersson
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
Write-Host "Starting Transcript" -F Cyan
Start-Transcript -path $LogFile -append
"Welcome to PowerShell " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
