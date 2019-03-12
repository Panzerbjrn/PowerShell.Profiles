$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'
$CName = $ENV:ComputerName
Get-Childitem -Path "\\londatavs1\users\lpeterss\ps.mine\powershell.modules\larsmoduletftd" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
Get-Childitem -Path "\\londatavs1\users\lpeterss\ps.mine\powershell.modules\larsmodulegeneric" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
Set-ConsoleConfig
Get-ThoughtFortheDay
Set-Location C:\Temp
