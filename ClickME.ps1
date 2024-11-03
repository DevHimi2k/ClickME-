Add-Type -AssemblyName System.Windows.Forms

# Define the path for the README file relative to the script location
$scriptDirectory = Split-Path -Parent $MyInvocation.MyCommand.Path
$readmeFilePath = Join-Path $scriptDirectory "README!!!!!!.txt"  # Path to the README file

# Create and open the README file if it doesn't exist
if (-Not (Test-Path $readmeFilePath)) {
    $readmeContent = @"
read me: hello!
my name is himi and this is ClickME! software, not actually but it's exe file from powershell script "ps1"
but hey this is just from ChatGPT
IMPORTANT: if you wanna run the game just click on "ClickME.exe" file and done
but it will show up powershell with nothing on it but if you close the powershell window,
the clickme.exe will also close.

So in the future, maybe I will update this.

note: 9 billion is "congrate"
and if you cheat or use an autoclicker, it's fine
'cause this script is too powerful.
Every click will save the file "0" every time you click the button.
Good luck with your PC and laptop to get 9 billion points :D

- himi
"@
    Set-Content -Path $readmeFilePath -Value $readmeContent
}

# Create the main form
$form = New-Object System.Windows.Forms.Form
$form.Text = "Simple Cookie Clicker"
$form.Size = New-Object System.Drawing.Size(300, 200)
$form.StartPosition = "CenterScreen"
$form.BackColor = [System.Drawing.Color]::Black

# Initialize click counts
$global:clickCount = 0
$global:bestCount = 0

# Create labels for displaying clicks
$clickLabel = New-Object System.Windows.Forms.Label
$clickLabel.Text = "Clicks: 0"
$clickLabel.ForeColor = [System.Drawing.Color]::White
$clickLabel.Location = New-Object System.Drawing.Point(100, 50)
$clickLabel.AutoSize = $true
$form.Controls.Add($clickLabel)

$bestLabel = New-Object System.Windows.Forms.Label
$bestLabel.Text = "Best: 0"
$bestLabel.ForeColor = [System.Drawing.Color]::White
$bestLabel.Location = New-Object System.Drawing.Point(100, 80)
$bestLabel.AutoSize = $true
$form.Controls.Add($bestLabel)

# Create the click button
$button = New-Object System.Windows.Forms.Button
$button.Text = "Click Me!"
$button.Location = New-Object System.Drawing.Point(100, 120)
$button.Size = New-Object System.Drawing.Size(100, 30)
$button.Add_Click({
    $global:clickCount++
    $clickLabel.Text = "Clicks: $global:clickCount"
    if ($global:clickCount > $global:bestCount) {
        $global:bestCount = $global:clickCount
        $bestLabel.Text = "Best: $global:bestCount"
    }
    if ($global:clickCount -ge 9000000000) {
        Show-WinnerMessage
    }
})
$form.Controls.Add($button)

# Show warning if README file is not opened
$messageResult = [System.Windows.Forms.MessageBox]::Show("Please open 'README!!!!!!.txt' to start the game.", "Warning", [System.Windows.Forms.MessageBoxButtons]::YesNoCancel, [System.Windows.Forms.MessageBoxIcon]::Warning)

if ($messageResult -eq [System.Windows.Forms.DialogResult]::Yes) {
    # Open the README file
    Start-Process $readmeFilePath
    exit
} elseif ($messageResult -eq [System.Windows.Forms.DialogResult]::Cancel) {
    # Exit if they choose Cancel
    exit
}

# Create the introductory window
function Show-IntroWindow {
    $introForm = New-Object System.Windows.Forms.Form
    $introForm.Text = "Welcome to ClickME!"
    $introForm.Size = New-Object System.Drawing.Size(300, 150)
    $introForm.StartPosition = "CenterScreen"
    $introForm.BackColor = [System.Drawing.Color]::Black

    $introLabel = New-Object System.Windows.Forms.Label
    $introLabel.Text = "Get ready to click!"
    $introLabel.ForeColor = [System.Drawing.Color]::White
    $introLabel.Location = New-Object System.Drawing.Point(80, 50)
    $introLabel.AutoSize = $true
    $introForm.Controls.Add($introLabel)

    # Show the intro window
    $introForm.Show()
    Start-Sleep -Seconds 10
    $introForm.Close()
}

# Create the credits window
function Show-CreditsWindow {
    $creditsForm = New-Object System.Windows.Forms.Form
    $creditsForm.Text = "Credits"
    $creditsForm.Size = New-Object System.Drawing.Size(300, 150)
    $creditsForm.StartPosition = "CenterScreen"
    $creditsForm.BackColor = [System.Drawing.Color]::Black

    $creatorLabel = New-Object System.Windows.Forms.Label
    $creatorLabel.Text = "Created by: www.youtube.com/@hmx.01"
    $creatorLabel.ForeColor = [System.Drawing.Color]::White
    $creatorLabel.Location = New-Object System.Drawing.Point(20, 30)
    $creatorLabel.AutoSize = $true
    $creditsForm.Controls.Add($creatorLabel)

    # Show the credits window
    $creditsForm.Show()
    Start-Sleep -Seconds 10
    $creditsForm.Close()

    # Now show the helper text in a new window
    Show-HelperWindow
}

# Create the helper window
function Show-HelperWindow {
    $helperForm = New-Object System.Windows.Forms.Form
    $helperForm.Text = "Helper"
    $helperForm.Size = New-Object System.Drawing.Size(200, 100)
    $helperForm.StartPosition = "Manual"
    $helperForm.Location = New-Object System.Drawing.Point(10, 100)  # Position on the left side
    $helperForm.BackColor = [System.Drawing.Color]::Black

    $helperLabel = New-Object System.Windows.Forms.Label
    $helperLabel.Text = "Helped by: chatgpt.com"
    $helperLabel.ForeColor = [System.Drawing.Color]::White
    $helperLabel.Location = New-Object System.Drawing.Point(10, 30)
    $helperLabel.AutoSize = $true
    $helperForm.Controls.Add($helperLabel)

    # Show the helper window
    $helperForm.Show()
    Start-Sleep -Seconds 10
    $helperForm.Close()

    # Now show the final message window
    Show-FinalMessageWindow
}

# Create the final message window
function Show-FinalMessageWindow {
    $finalForm = New-Object System.Windows.Forms.Form
    $finalForm.Text = "Final Message"
    $finalForm.Size = New-Object System.Drawing.Size(300, 150)
    $finalForm.StartPosition = "CenterScreen"
    $finalForm.BackColor = [System.Drawing.Color]::Black

    $finalLabel = New-Object System.Windows.Forms.Label
    $finalLabel.Text = "PLEASE I NEED TO SLEEP. I worked hard with this."
    $finalLabel.ForeColor = [System.Drawing.Color]::White
    $finalLabel.Location = New-Object System.Drawing.Point(20, 50)
    $finalLabel.AutoSize = $true
    $finalForm.Controls.Add($finalLabel)

    # Show the final message window
    $finalForm.Show()
    Start-Sleep -Seconds 10
    $finalForm.Close()

    # Ask if the user wants to open the console
    $consoleResult = [System.Windows.Forms.MessageBox]::Show("Do you want to open the console [for advanced]?", "Open Console", [System.Windows.Forms.MessageBoxButtons]::YesNo, [System.Windows.Forms.MessageBoxIcon]::Question)

    if ($consoleResult -eq [System.Windows.Forms.DialogResult]::Yes) {
        Start-Process "cmd.exe"
    }

    # Start the game
    Start-Game
}

# Function to start the game
function Start-Game {
    $form.ShowDialog()
}

# Call the intro and credits window before starting the game
Show-IntroWindow
Show-CreditsWindow

# Show winner message and reset game
function Show-WinnerMessage {
    $messageBox = New-Object System.Windows.Forms.Form
    $messageBox.Text = "Congratulations!"
    $messageBox.Size = New-Object System.Drawing.Size(250, 150)
    $messageBox.StartPosition = "CenterScreen"
    $messageLabel = New-Object System.Windows.Forms.Label
    $messageLabel.Text = "Congratulations!!! You won!"
    $messageLabel.ForeColor = [System.Drawing.Color]::Green
    $messageLabel.Location = New-Object System.Drawing.Point(25, 40)
    $messageLabel.AutoSize = $true
    $messageBox.Controls.Add($messageLabel)

    $messageBox.Show()

    Start-Sleep -Seconds 10
    $messageBox.Close()

    # Reset game
    $global:clickCount = 0
    $clickLabel.Text = "Clicks: 0"
    $bestCount = 0
    $bestLabel.Text = "Best: 0"
}

# Show the form
[void]$form.ShowDialog()
