@echo off
title Glitch Text
color 0A
setlocal enabledelayedexpansion

rem Move the command prompt window to the top center
powershell -Command " = Get-Process -Id 9196; .MainWindowHandle | ForEach-Object {  = Set-WindowPosition -Handle  -X ((Get-Host).UI.RawUI.WindowSize.Width / 2) -Y 0 }"

:loop
cls
set "line="
for /l %%i in (1,1,50) do (
    set /a "char=!random! %% 62"
    if !char! lss 10 (
        set "char=!char!"
    ) else if !char! lss 36 (
        set /a "char=!char! - 10 + 65"  # ASCII A-Z
    ) else (
        set /a "char=!char! - 36 + 97"  # ASCII a-z
    )
    for /f %%j in ('cmd /u /c echo !char!') do set "line=!line!%%j"
)

echo !line!
timeout /nobreak /t 1 >nul
goto loop
