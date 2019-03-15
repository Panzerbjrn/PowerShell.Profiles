#Because this forces you into good habits ;-)
$ErrorActionPreference = "STOP"
$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
#I prefer my progressbars to look like this.
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'

#If, like me' you keep some modules in non-standard locations...
Try {Import-Module (Get-ChildItem -Path <INSERT PATH HERE>\PowerShell.Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse -Verbose| Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
#Sets the console to let me know whether I am Admin or not.
Try {Set-ConsoleConfig}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
#I really don't like aliases. I wish I could get rid of %/?/etc with these commands
$Aliases = (Get-Alias|Select-Object -ExpandProperty Name)
$Aliases | ForEach {Remove-Item -Path Alias:$_ -Verbose:$False -ErrorAction SilentlyContinue}
#But some are actually useful....
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo}

#Logging what you do is very useful, and you never know when you need to check what you actually did...
$LogPath = "C:\Temp\PowerShell.Transcripts\"
$LogFileName = "$(Get-Date -f yyyy.MM.dd.HHmmss)."+$CName+".txt"
$LogFile = $LogPath + $LogFileName
Set-Location C:\Temp

#I like my prompt to be useful and look different.
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
#I like to start with a clean slate
Clear-Host
#Nothing like a greeting, and a reminder of which account you are using...
"Welcome to PowerShell $($PSV.Major) on " +$CName + " " + $ENV:UserName
Get-Date -f "HH:mm:ss dd/MM/yyyy"
#A little bit of wisdom to set you on the right path. https://github.com/Panzerbjrn/ThoughtForTheDay
Get-ThoughtFortheDay
#And here we start logging all that we do
Start-Transcript -path $LogFile -append
