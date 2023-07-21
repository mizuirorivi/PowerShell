<#
.SYNOPSIS
	Sends a  message by piping.io
.DESCRIPTION
    Sends a  message by piping.io
.PARAMETER Message
	Specifies the message to send
.PARAMETER FilePath
    Specifies the FilePath to send
.PARAMETER PipingUrl
    Specifies the piping url
.EXAMPLE
	PS> ./send-content "test"
.LINK
	https://github.com/mizuirorivi/PowerShell
.NOTES
	Author: mizuirorivi | License: CC0
#>

param([string]$Message = "", [string]$FilePath = "", [string]$PipingUrl = "")

try {
    Write-Host $Message
	if (($Message -eq "") -and ($FilePath -eq "") ) { $Message = read-host "Enter message to send" }
    if($PipingUrl -eq "") {
        $rand = New-Object System.Random
        $randString = $rand.Next(1000000000, 9999999999)
        $PipingUrl = "https://ppng.io/$randString"
    }

    if(!($Message -eq "")){
        Write-Host "[+] url -> $PipingUrl"
        Invoke-RestMethod -Uri $PipingUrl -Method Put -Body $Message
    }
    elseif(!($FilePath -eq "")){
        Write-Host "[+] url -> $PipingUrl"
        $content = Get-Content $FilePath - Encoding Byte -Raw
        Invoke-RestMethod -Uri $PipingUrl -Method Put -Body $content
    }
    else{
        throw "no message or file"
    }
	Write-Host "✔️  Done."
	exit 0 # success
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
