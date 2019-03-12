$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'
$CName = $ENV:ComputerName
Get-Childitem -Path "\\LonDataVS1\Users\lpeterss\PS.Mine\PowerShell.Modules\LarsModuleTFTD" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
Get-Childitem -Path "\\LonDataVS1\Users\LPeterss\PS.mine\PowerShell.Modules\LarsModuleGeneric" -Recurse -Include *.psm1 | foreach {Import-Module $_.FullName -ErrorAction SilentlyContinue -noclobber}
Set-ConsoleConfig
Get-ThoughtFortheDay
Set-Location C:\Temp