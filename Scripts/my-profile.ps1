# MY POWERSHELL PROFILE (this profile file defines the look & feel of PowerShell)
# set "$ScriptDirectory = (script directory path)" if run set-profile.ps1

# WINDOW TITLE
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"
# CHECK USER PRIVILEGES
$IsAdmin = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
# COMMAND PROMPT
function prompt { write-host -noNewline -foregroundColor Cyan  '( ^ * ^) >'; return " " }
# SET SCRIPT DIRECTORY 


# ALIAS NAMES
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value "$ScriptDirectory/list-workdir.ps1"	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list folder (long format)
set-alias -name la -value get-childitem		# ll = list folder (long format)
del alias:ls -force -errorAction SilentlyContinue 
set-alias -name ls -value "$ScriptDirectory/list-folder.ps1"	# ls = list folder (short format)
set-alias -name touch -value "$ScriptDirectory/make_file_dir.ps1"	# touch = create file
set-alias -name which -value Get-Command # which = find command
# SET PATH
$upath =  [System.Environment]::GetEnvironmentVariable("Path","User")
$syspath =  [System.Environment]::GetEnvironmentVariable("Path","Machine")
$item_for_path = "$ScriptDirectory",
"C:\Users\rivi\Tools\SysinternalsSuite",
"C:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\bin",
"C:\Users\rivi\Tools",
"C:\Users\rivi\Tools\WDExtract\Bin\bin64"


foreach($item in  $item_for_path){
  # check if item is already in path
  if(($upath -match [regex]::Escape($item)) -or ($syspath -match [regex]::Escape($item))) { 
    continue 
  }
  $upath += ";" + $item
  $syspath += ";" + $item
}
[System.Environment]::SetEnvironmentVariable("Path", $upath, "User")
$env:Path = $upath
if ($IsAdmin) { 
  [System.Environment]::SetEnvironmentVariable("Path", $syspath, "Machine")
  $env:SysPath = $syspath
}
# ALIAS APPS
set-alias -name typora -value "C:\Program Files\Typora\Typora.exe"
set-alias -name marktext -value "C:\Users\rivi\AppData\Local\Programs\MarkText\MarkText.exe"