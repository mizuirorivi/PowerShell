
$fontFolder = "C:\Windows\Fonts"
$fontName = "NotoSansCJKjp-Regular.otf"
Write-Host "$fontFolder\$fontName"
if (Test-Path "$fontFolder\$fontName") {
    Write-Host "Font installed successfully."
}
else {
    # Noto Sans CJK JP Regular fontをダウンロードします。
    $url = 'https://noto-website-2.storage.googleapis.com/pkgs/NotoSansCJKjp-hinted.zip'
    $output = 'NotoSansCJKjp-hinted.zip'
    Invoke-WebRequest -Uri $url -OutFile $output

    # ダウンロードしたzipファイルを解凍します。
    Expand-Archive $output -DestinationPath '.'

    # フォントをインストールします。
    
    $fontFullPath = Join-Path -Path $pwd -ChildPath 'NotoSansCJKjp-Regular.otf'
    Copy-Item -Path $fontFullPath -Destination $fontFolder -Force
}
$fontRegistryPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\Fonts"
$fontName = "NotoSansCJKjp-Regular"
$fontFileName = "NotoSansCJKjp-Regular.otf"
New-ItemProperty -path $fontRegistryPath -name $fontName -value $fontFileName -propertyType STRING -force
# Windows Terminalの設定ファイルへアクセスします。
$terminalSettingsPath = "C:\Users\$env:USERNAME\scoop\persist\windows-terminal\settings\settings.json"


#設定ファイルが存在するか確認します。
if (Test-Path $terminalSettingsPath) {

    # Read the existing content from the settings.json file
    $settingsContent = Get-Content -Path $terminalSettingsPath -Raw | ConvertFrom-Json

    # Check if the 'defaults' property exists, if not add it
    if ($settingsContent.profiles.PSObject.Properties.Name -notcontains 'defaults') {
        $settingsContent.profiles | Add-Member -MemberType NoteProperty -Name "defaults" -Value @{}
    }
    # Check if the 'fontFace' property exists, if not add it
    if ($settingsContent.profiles.defaults.PSObject.Properties.Name -notcontains 'fontFace') {
        $settingsContent.profiles.defaults | Add-Member -MemberType NoteProperty -Name "fontFace" -Value ""
    }
    # Set the fontFace attribute
    $settingsContent.profiles.defaults.fontFace = "Noto Sans CJK JP Regular"

    # Convert the JSON object back to a string and save it to the settings.json file
    $settingsContent | ConvertTo-Json -Depth 20 | Set-Content -Path $terminalSettingsPath -Force
}
else {
    Write-Host "Windows Terminal settings file not found."
}

# # 作業ファイルを削除します。
# Remove-Item -Path $output -Force
# Remove-Item -Path $fontName -Force