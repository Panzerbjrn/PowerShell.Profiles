$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'
$CName = $ENV:ComputerName
#$ErrorActionPreference = Stop
IF (!(Get-Command Get-Mailbox -erroraction silentlycontinue))
	{
	Write-Host "Importing Exchange Commands"
	$Session = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://LonExch2.rathbones.net/PowerShell/ -Authentication Kerberos
	Import-PSSession $Session -ErrorAction SilentlyContinue
	}

Clear-Host
$PSV = $PSVersionTable.PSVersion
$HomePath = Test-Path "C:\Dropbox\Scripts\Transcripts"
$WerkPath = Test-Path "\\LonDataVS1\Users\LPeterss\Scripts\Transcripts"
$WinVer = (Get-WmiObject -class Win32_OperatingSystem).Caption
IF (($PSV.Major -eq "2") -OR ($WinVer -like "*2008*"))
	{
		Import-Module TroubleshootingPack -ErrorAction SilentlyContinue
		Import-Module Servermanager -ErrorAction SilentlyContinue
		Import-Module GroupPolicy -ErrorAction SilentlyContinue
		Import-Module ActiveDirectory -ErrorAction SilentlyContinue
		#Clear-Host
	}
ELSE {}
IF ($HomePath -eq $True)
	{
		$Host.UI.RawUI.WindowTitle = "PowerShell Operations Console"
		$LogPath = "C:\Dropbox\Scripts\Transcripts\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$CName+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-Location D:\
	}
ELSEIF ($WerkPath -eq $True)
	{
		$LogPath = "\\LonDataVS1\Users\LPeterss\Scripts\Transcripts\Transcripts"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$CName+".txt"
		$LogFile = $LogPath + $LogFileName
		Set-Location C:\Temp
		#Get-Childitem -Path "C:\Users\admLP\Documents\WindowsPowerShell\Modules" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
		Get-Childitem -Path "\\LonDataVS1\Users\LPeterss\PS.mine\PowerShell.Modules" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
	}
ELSE
	{
		$TempPath = Test-Path "C:\Temp\"
		IF (!($TempPath)) {New-Item -ItemType "Directory" -Path C:\TEMP -Force}
		ELSE {}
		$LogPath = "C:\Temp\"
		$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$CName+".txt"
		$LogFile = $LogPath + $LogFileName
		Get-Childitem -Path "\\LonDataVS1\Users\LPeterss\PS.mine\PowerShell.Modules" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
	}

Update-Lars
Clear-Host
Set-ConsoleConfig
Write-Host "Starting Transcript"
IF (!($CName -eq "PanzerPro")) {Start-Transcript -path $LogFile -append}
ELSE {}
"Welcome to PowerShell " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
