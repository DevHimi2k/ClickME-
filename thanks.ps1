# Function to show a command prompt with specified text
function Show-CommandPrompt {
    param (
        [string]$text,
        [string]$color = "0B",  # Light blue
        [int]$duration = 5
    )

    # Create the batch file to display the text
    $batchFilePath = [System.IO.Path]::GetTempFileName() + ".bat"
    $batchContent = @"
@echo off
color $color
echo $text
timeout /t $duration > nul
exit
"@
    Set-Content -Path $batchFilePath -Value $batchContent

    # Start the command prompt with the batch file
    Start-Process cmd.exe -ArgumentList "/c start cmd.exe /k `"$batchFilePath`""
}

# Show "Thanks For Playing!" in light blue
Show-CommandPrompt "Thanks For Playing!" "0B"

# Wait for a moment before showing the next message
Start-Sleep -Seconds 1

# Show "Created By : Ml_HimiGamer" in light blue
Show-CommandPrompt "Created By : Ml_HimiGamer" "0B"

# Wait for the light blue message to close
Start-Sleep -Seconds 5

# Show "Coded By : Ml_HimiGamer" in light blue
Show-CommandPrompt "Coded By : Ml_HimiGamer" "0B"

# Wait for the light blue message to close
Start-Sleep -Seconds 10

# Show "Assets By : Ml_HimiGamer" in light blue
Show-CommandPrompt "Assets By : Ml_HimiGamer" "0B"

# Wait for the light blue message to close
Start-Sleep -Seconds 5

# Function to show glitch text in a command prompt
function Show-GlitchText {
    $glitchBatchFilePath = [System.IO.Path]::GetTempFileName() + ".bat"
    $glitchContent = @"
@echo off
color 0A
:loop
cls
set "line="
for /l %%i in (1,1,50) do (
    set /a "char=!random! %% 36"
    if !char! lss 10 (
        set "line=!line!!char!"
    ) else (
        set "line=!line!!char! + A"
    )
)
echo !line!
timeout /nobreak /t 1 >nul
goto loop
"@

    Set-Content -Path $glitchBatchFilePath -Value $glitchContent

    # Start the command prompt with glitch text
    Start-Process cmd.exe -ArgumentList "/c start cmd.exe /k `"$glitchBatchFilePath`""
}

# Show glitch text for 30 seconds
Show-GlitchText
Start-Sleep -Seconds 30

# Close all command prompts
Get-Process cmd -ErrorAction SilentlyContinue | Stop-Process

# Show "The End" in a command prompt
Show-CommandPrompt "The End" "0B"

# Wait for the final message to close
Start-Sleep -Seconds 10

# Show "Please Close All the Command Prompts" in light blue
Show-CommandPrompt "Please Close All the Command Prompts" "0B"

# Wait for the final message to close
Start-Sleep -Seconds 5
