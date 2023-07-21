<#
.SYNOPSIS
	Create a file and its directory if it does not exist
.DESCRIPTION
	This PowerShell script creates a file and its directory if it does not exist.
.PARAMETER Name
    Name of the file or directory
.PARAMETER flag
    create directory if file exists
.EXAMPLE
	PS> ./make_file_dir -d "test"
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>
param(
    [Parameter(Mandatory = $true)]
    [string]$Name = "",
    [Parameter(Mandatory = $false)]
    [string]$flag = ""
)
try {
    if ($Name -eq "") { $Name = read-host "Enter name for directory or file" }

    if (!$flag) {
        New-Item -Name $Name -ItemType "file"
    }
    else {
        New-Item -Name $Name -ItemType "directory"
    }
    exit 0 # success
}
catch {
    "⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
    exit 1
}