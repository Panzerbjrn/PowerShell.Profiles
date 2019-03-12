# notepad C:\Users\Petersson_L_a\Documents\WindowsPowerShell\profile.ps1
# mkdir C:\Users\Petersson_L_a\Documents\WindowsPowerShell
# New-Item -Path C:\Users\Petersson_L_a\Documents\WindowsPowerShell -Name Profile.ps1 -ItemType File

Function Get-ErrorInfo {
	param
	(
		[Parameter(ValueFrompipeline)]
		[Management.Automation.ErrorRecord]$ErrorRecord
	)
	process
	{
		$Info = [PSCustomObject]@{
		Exception = $ErrorRecord.Exception.Message
		Testing = $ErrorRecord.Exception.Message
		Reason= $ErrorRecord.CategoryInfo.Reason
		Fullname= $ErrorRecord.exception.GetType().fullname
		Target= $ErrorRecord.CategoryInfo.TargetName
		Script= $ErrorRecord.InvocationInfo.ScriptName
		Line= $ErrorRecord.InvocationInfo.ScriptLineNumber
		Column= $ErrorRecord.InvocationInfo.OffsetInLine
		Date= Get-Date
		User= $env:username
		}
	$Info
	}
}

Function Test-IsAdministrator
{
<#
	.SYNOPSIS 
	Tests if the user is an administrator 

	.Description
	Returns true if a user is an administrator, false if the user is not an administrator 

	.Example
	Test-IsAdministrator 

	.Notes 
	NAME: Test-IsAdministrator 
	AUTHOR: Ed Wilson 
	LASTEDIT: 5/20/2009 
	KEYWORDS: 

	.Link
	Http://www.ScriptingGuys.com 
	
	#Requires -Version 2.0 
#>
param()
$currentUser = [Security.Principal.WindowsIdentity]::GetCurrent() 
(New-Object Security.Principal.WindowsPrincipal $currentUser).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}

Function Set-ConsoleConfig
{
 IF(-not (Test-IsAdministrator))
	{$Host.UI.RawUI.WindowTitle = "Regular PowerShell Operations Console"}
 else {$Host.UI.RawUI.WindowTitle = "***ROOT PowerShell Operations Console ROOT***"}
} #end Function set-consoleconfig

Function Replace-SpacesFullStop {
	Param ([Parameter(Mandatory=$True)][string]$Paths)
	ForEach ($Path in $Paths)
	{
		Write-Host $Path -ForegroundColor Red
		$Files = Get-ChildItem * -Include "* *" -recurse -path $Path
		ForEach ($File in $Files)
		{
			$CurrentName = $File.Name
			$NewName = $CurrentName.Replace(" ",".")
			$File | Rename-Item -NewName $NewName
			Write-Host $NewName -ForegroundColor Green
		}
	}
}

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
