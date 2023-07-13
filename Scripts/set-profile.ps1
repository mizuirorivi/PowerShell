<#
.SYNOPSIS
	Sets the user's PowerShell profile
.DESCRIPTION
	This PowerShell script sets the PowerShell profile for the current user.
.EXAMPLE
	PS> ./set-profile
.LINK
	https://github.com/fleschutz/PowerShell
.NOTES
	Author: Markus Fleschutz | License: CC0
#>

try {
	"⏳ (1/4) Querying path to PowerShell profile 'CurrentUserCurrentHost'..."
	$PathToProfile = $PROFILE.CurrentUserCurrentHost
	"$PathToProfile"

	"⏳ (2/4) Creating the profile (if non-existent)..."
	$Null = New-Item -Path $profile -ItemType "file" -Force

	"⏳ (3/4) Copying my-profile.ps1..."
	$PathToRepo = "$PSScriptRoot/.."
	Copy-Item "$PathToRepo/Scripts/my-profile.ps1" "$PathToProfile" -force
	"⏳ (4/4) Setting Script Directory to my-profile.ps1..."
	$foundLine = $false
	$newTextToAdd = '$ScriptDirectory = ' + "`"$PSScriptRoot`""
	$tempFile = "temp.ps1"
	Write-Output $PathToProfile
	Get-Content $PathToProfile | ForEach-Object {
		if($foundLine){
			Add-Content -Path $tempFile -Value $newTextToAdd
			$foundLine = $false
		}
		if($_ -match "# SET SCRIPT DIRECTORY "){
			Write-Output "found line"
			$foundLine = $true
		}
		Add-Content -Path $tempFile -Value $_
	}
	Move-Item -Path $tempFile -Destination $PathToProfile -Force
	"✔️ updated your PowerShell profile by my-profile.ps1 - it gets active on next login"
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
