$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'

Set-Location C:\

$Name = $ENV:ComputerName
$LogPath = "\\FCH114966\C$\Users\Lars.Petersson\Dropbox\Scripts\Transcripts\"
$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$Name+".txt"
$LogFile = $LogPath + $LogFileName
Write-Host "Starting Transcript"
Start-Transcript -path $LogFile -append

<#
Write-Host "Loading Exchange Modules"
#$PS = New-PSSession -ConfigurationName Microsoft.Exchange -ConnectionUri http://PDVMEX01.fpdsavills.co.uk/PowerShell/ -Authentication Kerberos 
Import-PSSession $PS
Set-ADServerSettings -ViewEntireForest $true
#>

Set-ConsoleConfig

"Welcome to PowerShell " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay