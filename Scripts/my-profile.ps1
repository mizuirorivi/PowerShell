# MY POWERSHELL PROFILE (this profile file defines the look & feel of PowerShell)
# set "$ScriptDirectory = (script directory path)" if run set-profile.ps1

# WINDOW TITLE
if ($IsLinux) { $Username = $(whoami) } else { $Username = $env:USERNAME }
$host.ui.RawUI.WindowTitle = "$Username @ $(hostname)"

# COMMAND PROMPT
function prompt { write-host -noNewline -foregroundColor yellow "`n➤"; return " " }
# SET SCRIPT DIRECTORY 

# ALIAS NAMES
del alias:pwd -force -errorAction SilentlyContinue
set-alias -name pwd -value $ScriptDirectory/$list-workdir.ps1	# pwd = print working directory
set-alias -name ll -value get-childitem		# ll = list folder (long format)
del alias:ls -force -errorAction SilentlyContinue 
set-alias -name ls -value $ScriptDirectory/list-folder.ps1	# ls = list folder (short format)
