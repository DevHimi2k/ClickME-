Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# Function to load an image with error handling
function Load-Image {
    param (
        [string]$path
    )
    try {
        return [System.Drawing.Image]::FromFile($path)
    } catch {
        [System.Windows.Forms.MessageBox]::Show("Error loading image: $path`n$_", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        exit
    }
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Welcome"
$form.WindowState = [System.Windows.Forms.FormWindowState]::Maximized  # Set to fullscreen
$form.FormBorderStyle = [System.Windows.Forms.FormBorderStyle]::None  # Remove borders

# Set the background image
$backgroundImage = Load-Image ".\assets\back.png"
$form.BackgroundImage = $backgroundImage
$form.BackgroundImageLayout = [System.Windows.Forms.ImageLayout]::Stretch

# Create a PictureBox for the logo
$logo = New-Object System.Windows.Forms.PictureBox
$logo.Image = Load-Image ".\assets\clickme.png"
$logo.SizeMode = [System.Windows.Forms.PictureBoxSizeMode]::Zoom
$logo.Size = New-Object System.Drawing.Size(0, 0)  # Increased size for the logo

# Center the logo
$logo.Location = New-Object System.Drawing.Point(
    [Math]::Floor(($form.ClientSize.Width - $logo.Width) / 1),
    [Math]::Floor(($form.ClientSize.Height - $logo.Height) / 1)
)

$form.Controls.Add($logo)

# Show the main form for 10 seconds
$form.Show()

# Create the glitch text batch file
$batchFilePath = ".\startglitch.bat"  # No spaces in the name
Set-Content -Path $batchFilePath -Value @"
@echo off
title Glitch Text
color 0A
setlocal enabledelayedexpansion

rem Move the command prompt window to the top center
powershell -Command "$h = Get-Process -Id $PID; $h.MainWindowHandle | ForEach-Object { $null = Set-WindowPosition -Handle $_ -X ((Get-Host).UI.RawUI.WindowSize.Width / 2) -Y 0 }"

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
"@

# Start the command prompt with the batch file
Start-Process cmd.exe -ArgumentList "/c start cmd.exe /k `"$batchFilePath`""

# Wait for 10 seconds before closing the form
Start-Sleep -Seconds 10

# Close the command prompt
Get-Process -Name cmd | Stop-Process

# Close the form
$form.Close()

# Start the executable
Start-Process "D:\ClickME\start.exe [console].lnk"
