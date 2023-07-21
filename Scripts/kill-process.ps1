<#
.SYNOPSIS
	kill a process by folder
.DESCRIPTION
    kill a process by folder
.EXAMPLE
	PS> ./kill-process
.LINK
	https://github.com/mizuirorivi/PowerShell
.PARAMETER Folder
	Specifies the folder, and then kill the process that is using the folder
.NOTES
	Author: mizuirorivi
.DEPENDS
    handle.exe (https://docs.microsoft.com/en-us/sysinternals/downloads/handle)
#>

param([string]$Folder = "")
try {
    if($Folder -eq "") { $Folder = read-host "Enter folder" }
    if(!(Get-Command "handle.exe" -ErrorAction SilentlyContinue)) {
        throw "handle.exe not found. install handle.exe from https://docs.microsoft.com/en-us/sysinternals/downloads/handle"
    }
    
	$process = & " C:\Users\rivi\Tools\SysinternalsSuite\handle.exe" $Folder 
    $np = $process -replace  "pid", "`r`npid"

    $pid = $process | ? { $_ -match 'pid: (\d+)' } | % { $matches[1] }
    Write-Host $np
    verbose to kill process by input with "y"
    $killFlag = Read-Host "kill process? (y/n)"
    if($killFlag -eq "y") {
        $pid | % { Stop-Process -Id $_ -Force }
        "✔️ killed process $process"
    } else {
        "⚠️ no process killed"
    }
    exit 0 
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
