##Admin Account @ Workstation
$CName = $ENV:ComputerName
$PSV = $PSVersionTable.PSVersion
$Host.PrivateData.ProgressBackgroundColor='Green'
$Host.PrivateData.ProgressForegroundColor='Black'
$ErrorActionPreference = "STOP"
IF ($PSV.Major -eq "5") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell\Modules -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
}
IF ($PSV.Major -eq "6") {
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\PowerShell -Include *.psm1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
	Try {Import-Module (Get-ChildItem -Path C:\Users\Petersson_L_a\Documents\PowerShell -Include *.psd1 -ErrorAction SilentlyContinue -Recurse | Select-Object FullName).fullname -Force -NoClobber }Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
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
$Aliases | ForEach {Remove-Item -Path Alias:$_ -verbose -ErrorAction SilentlyContinue}
Try {New-Alias -Name CLS -Value Clear-Host}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
Try {New-Alias -Name IH -Value Invoke-History}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
Try {New-Alias -Name H -Value Get-History}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}
Try {New-Alias -Name CD -Value Set-Location}Catch{$_ | Get-ErrorInfo;Start-Sleep -s 5}

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


$LPCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LP, $LPPWD
$LPEmailCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPEmail, $LPEMAILPWD
$LPAdminCredential = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdmin, $LPAdminPWD
$LPAdminCredentialBDS = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdminBDS, $LPAdminBDSPWD
$LPAdminCredentialWTD = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $LPAdminWTD, $LPAdminWTDPWD
$BDAZCred = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $serv_serverbuild, $serv_serverbuildPWD
$SNOWCreds = New-Object -TypeName "System.Management.Automation.PSCredential" -ArgumentList $serv_serverbuild, $serv_serverbuildPWD

$LogPath = "\\brewindolphin.net\branchdata$\BD\Users\Petersson_L\PS.Transcripts\"
$LogFileName = "$(get-date -f yyyy.MM.dd.HH.mm.ss)."+$CName+".txt"
$LogFile = $LogPath + $LogFileName
Set-Location C:\Temp

Clear-Host
"Welcome to PowerShell $($PSV.Major) on " +$CName + " " + $ENV:UserName
Get-date -f "HH:mm:ss dd/MM/yyyy"
Get-ThoughtFortheDay
Start-Transcript -path $LogFile -append
