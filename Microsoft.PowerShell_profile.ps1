##A few functions that I find super useful to have in the Microsoft.PowerShell_profile.ps1 so they are loaded first.

#This Functions makes errors easier to read.
#Pipe the error to the function; Example: TRY{Error}catch{$_|Get-ErrorInfo}
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

#This will check if you are an administrator
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

#This will change the console window title appropriately.
Function Set-ConsoleConfig
{
 IF(-not (Test-IsAdministrator))
	{$Host.UI.RawUI.WindowTitle = "Regular PowerShell Operations Console"}
 else {$Host.UI.RawUI.WindowTitle = "***ROOT PowerShell Operations Console ROOT***"}
} #end Function set-consoleconfig

Set-ConsoleConfig