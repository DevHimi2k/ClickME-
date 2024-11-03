Add-Type -AssemblyName System.Windows.Forms

# Function to check if the autoclicker is running
function Check-AutoClicker {
    $processName = "AutoClicker"  # Adjust this name to match the actual process name of the autoclicker
    $process = Get-Process | Where-Object { $_.ProcessName -like "*$processName*" }

    if ($process) {
        # Run the anti-clicker script
        & ".\anticlick.ps1"
        exit  # Exit if the autoclicker is detected
    }
}

# Function to run the glitch script
function Run-GlitchScript {
    $glitchScriptPath = ".\assets\glitch.ps1"

    if (Test-Path $glitchScriptPath) {
        & $glitchScriptPath
    } else {
        [System.Windows.Forms.MessageBox]::Show("Glitch script not found!", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
        exit
    }
}

# Function to display the password prompt
function Show-PasswordPrompt {
    $password = "you"
    
    # Create the password input form
    $inputBox = New-Object System.Windows.Forms.Form
    $inputBox.Text = "Password"
    $inputBox.Size = New-Object System.Drawing.Size(300, 150)
    $inputBox.StartPosition = "CenterScreen"

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "Please enter the password:"
    $label.AutoSize = $true
    $label.Location = New-Object System.Drawing.Point(10, 20)
    $inputBox.Controls.Add($label)

    $textBox = New-Object System.Windows.Forms.TextBox
    $textBox.Location = New-Object System.Drawing.Point(10, 50)
    $textBox.Size = New-Object System.Drawing.Size(260, 20)
    $textBox.UseSystemPasswordChar = $true
    $inputBox.Controls.Add($textBox)

    $okButton = New-Object System.Windows.Forms.Button
    $okButton.Text = "OK"
    $okButton.Location = New-Object System.Drawing.Point(220, 80)
    $okButton.Add_Click({
        if ($textBox.Text -eq $password) {
            $inputBox.DialogResult = [System.Windows.Forms.DialogResult]::OK
            $inputBox.Close()
        } else {
            [System.Windows.Forms.MessageBox]::Show("Incorrect password. Please try again.", "Error", [System.Windows.Forms.MessageBoxButtons]::OK, [System.Windows.Forms.MessageBoxIcon]::Error)
            $textBox.Clear()
        }
    })
    $inputBox.Controls.Add($okButton)

    # Show the password input box
    $inputBox.ShowDialog()
    
    if ($inputBox.DialogResult -ne [System.Windows.Forms.DialogResult]::OK) {
        exit
    }
}

# Function to display the game selection
function Start-GameSelection {
    # Show the initial window
    $initialForm = New-Object System.Windows.Forms.Form
    $initialForm.Text = "The Game is Starting but Before That"
    $initialForm.Size = New-Object System.Drawing.Size(300, 150)
    $initialForm.StartPosition = "CenterScreen"
    $initialForm.BackColor = [System.Drawing.Color]::White

    $label = New-Object System.Windows.Forms.Label
    $label.Text = "The Game is Starting but Before That"
    $label.ForeColor = [System.Drawing.Color]::Black
    $label.Location = New-Object System.Drawing.Point(30, 50)
    $label.AutoSize = $true
    $initialForm.Controls.Add($label)

    # Show the initial window
    $initialForm.Show()
    Start-Sleep -Seconds 3
    $initialForm.Close()

    # Show the selection window
    $selectionForm = New-Object System.Windows.Forms.Form
    $selectionForm.Text = "Select Theme"
    $selectionForm.Size = New-Object System.Drawing.Size(300, 150)
    $selectionForm.StartPosition = "CenterScreen"
    $selectionForm.BackColor = [System.Drawing.Color]::White

    $lightButton = New-Object System.Windows.Forms.Button
    $lightButton.Text = "Light"
    $lightButton.Location = New-Object System.Drawing.Point(50, 50)
    $lightButton.Size = New-Object System.Drawing.Size(75, 30)
    $lightButton.Add_Click({
        Start-Process "./LightVersion.exe.lnk"
        $selectionForm.Close()
    })
    $selectionForm.Controls.Add($lightButton)

    $darkButton = New-Object System.Windows.Forms.Button
    $darkButton.Text = "Dark"
    $darkButton.Location = New-Object System.Drawing.Point(150, 50)
    $darkButton.Size = New-Object System.Drawing.Size(75, 30)
    $darkButton.Add_Click({
        Start-Process "./ClickME.exe.lnk"
        $selectionForm.Close()
    })
    $selectionForm.Controls.Add($darkButton)

    # Show the selection window
    $selectionForm.ShowDialog()
}

# Check for autoclicker before proceeding
Check-AutoClicker

# Run the glitch script
Run-GlitchScript

# Show the password prompt
Show-PasswordPrompt

# Start game selection
Start-GameSelection
