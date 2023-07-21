<#
.SYNOPSIS
	convert and copy a file
.DESCRIPTION
    Copy a file, converting and formatting according to the operands
.EXAMPLE
	PS> .dd.ps1 -if 'C:\rivi.txt' -of 'C:\out.txt' -bs 1 -skip 27274156 -count 756375
.LINK
	https://github.com/mizuirorivi/PowerShell
.PARAMETER if
	read from FILE instead of stdin
.PARAMETER of
    write to FILE instead of stdout
.PARAMETER ibs
    read BYTES bytes at a time(default: 512)
.PARAMETER obs
    write BYTES bytes at a time(default: 512)
.PARAMETER bs
    read and write up to BYTES bytes at a time(default: 512); overrides ibs and obs
.PARAMETER skip
    skip N ibs-sized blocks at start of input
.PARAMETER count
    copy only N ibs-sized blocks
.NOTES
	Author: mizuirorivi
#>

param(
    [string]$if = "", 
    [string]$of = "", 
    [int]$ibs = 512, 
    [int]$obs = 512, 
    [int]$bs = 512,
    [int]$skip = 0, 
    [int]$count = 0
)


try {
    if(!($bs -eq 512)){
        $ibs = $bs
        $obs = $bs
    }
    $readBufferSize = $ibs * $count
    $readBuffer = New-Object Byte[] $readBufferSize
    
    $sourceFileStream = New-Object IO.FileStream($if,[IO.fileMode]::Open)
    $sourceFileStream.Seek($skip*$ibs,[IO.SeekOrigin]::Begin) > $null
    $sourceFileStream.Read($readBuffer,0,$readBufferSize) > $null
    $sourceFileStream.Close()

    $writeBufferSize = $obs * $count
    
    $destFileStream = New-Object IO.FileStream($of,[IO.fileMode]::Create)
    $destFileStream.Write($readBuffer, 0, $writeBufferSize) > $null
    $destFileStream.Close()
    exit 0 
} catch {
	"⚠️ Error in line $($_.InvocationInfo.ScriptLineNumber): $($Error[0])"
	exit 1
}
