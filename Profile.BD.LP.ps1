$ErrorActionPreference = "STOP"
$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'

IF ($PSV.Major -eq "5") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L\Documents\WindowsPowerShell\Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse -Verbose| Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L\Documents\WindowsPowerShell\Modules -Include *.psd1 -ErrorAction SilentlyContinue -Recurse -Verbose| Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
}
IF ($PSV.Major -eq "6") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L\Documents\PowerShell -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L\Documents\PowerShell -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
}
Try {Set-ConsoleConfig}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 1}
$MyDevBox1 = "DEV-AP337140"
$MyDevBox2 = "DEV-AP337142"
$MyVDI = "VM-W10VDI-SI"
$Infoblox = "infoblox.brewindolphin.net"
$Aliases = (Get-Alias|Select-Object -ExpandProperty Name)
$Aliases | ForEach {Remove-Item -Path Alias:$_ -Verbose:$False -ErrorAction SilentlyContinue}
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo}

$LP = "BDS\Petersson_L"
$LPKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\Petersson_L.AES.key"
$LPPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\Petersson_L.Password.txt" | ConvertTo-SecureString -Key $LPkey
$LPEmail = "lars.petersson@brewin.co.uk"
$LPEmailKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\lars.petersson@brewin.co.uk.AES.key"
$LPEmailPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\lars.petersson@brewin.co.uk.Password.txt" | ConvertTo-SecureString -Key $LPEmailkey
$LPAdmin = "Petersson_L_a"
$LPAdminKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\Petersson_L_a.AES.key"
$LPAdminPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\Petersson_L_a.Password.txt" | ConvertTo-SecureString -Key $LPAdminKey
$LPAdminBDS = "BDS\Petersson_L_a"
$LPAdminBDSKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\BDSPetersson_L_a.AES.key"
$LPAdminBDSPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\BDSPetersson_L_a.Password.txt" | ConvertTo-SecureString -Key $LPAdminBDSkey
$LPAdminWTD = "WTD\Petersson_L_a"
$LPAdminWTDKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\WTDPetersson_L_a.AES.key"
$LPAdminWTDPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\WTDPetersson_L_a.Password.txt" | ConvertTo-SecureString -Key $LPAdminWTDkey
$serv_serverbuild = "serv_serverbuild@brewin.co.uk"
$serv_serverbuildKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\serv_serverbuild@brewin.co.uk.AES.key"
$serv_serverbuildPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PowerShell.Snippets\_Keys\serv_serverbuild@brewin.co.uk.Password.txt" | ConvertTo-SecureString -Key $serv_serverbuildkey
$LPAZKey = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\Documents\LPAzcreds.AES.key"
$LPAZPWD = Get-Content "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\Documents\LPAzcreds.Password.txt" | ConvertTo-SecureString -Key $LPAZKey
$LPAZEmail = "lars@panzerbjrn.net"
$AZCred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAZEmail, $LPAZPWD

$LPCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LP, $LPPWD
$LPEmailCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPEmail, $LPEmailPWD
$LPAdminCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdmin, $LPAdminPWD
$LPAdminCredentialBDS = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdminBDS, $LPAdminBDSPWD
$LPAdminCredentialWTD = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdminWTD, $LPAdminWTDPWD
$BDAZCred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $serv_serverbuild, $serv_serverbuildPWD
$SNOWCreds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $serv_serverbuild, $serv_serverbuildPWD

$proxyString = "http://10.5.117.90:8080"
$proxyUri = new-object System.Uri($proxyString)
[System.Net.WebRequest]::DefaultWebProxy = new-object System.Net.WebProxy ($proxyUri, $true)
[System.Net.WebRequest]::DefaultWebProxy = new-object System.Net.WebProxy ($proxyUri, $true)
[System.Net.WebRequest]::DefaultWebProxy.Credentials = [System.Net.CredentialCache]::DefaultCredentials

$LogPath = "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PS.Transcripts\"
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
