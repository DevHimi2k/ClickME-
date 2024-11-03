Add-Type -AssemblyName System.Windows.Forms

# Show warning about the autoclicker
$warningForm = New-Object System.Windows.Forms.Form
$warningForm.Text = "Warning"
$warningForm.Size = New-Object System.Drawing.Size(300, 150)
$warningForm.StartPosition = "CenterScreen"

$label = New-Object System.Windows.Forms.Label
$label.Text = "Warning: You are using OP AutoClicker. Please close it to continue."
$label.AutoSize = $true
$label.Location = New-Object System.Drawing.Point(10, 20)
$warningForm.Controls.Add($label)

$okButton = New-Object System.Windows.Forms.Button
$okButton.Text = "OK"
$okButton.Location = New-Object System.Drawing.Point(100, 80)
$okButton.Add_Click({
    $warningForm.Close()
})
$warningForm.Controls.Add($okButton)

$yesButton = New-Object System.Windows.Forms.Button
$yesButton.Text = "Yes"
$yesButton.Location = New-Object System.Drawing.Point(200, 80)
$yesButton.Add_Click({
    # Close the AutoClicker process
    Get-Process | Where-Object { $_.ProcessName -like "*AutoClicker*" } | Stop-Process -Force
    $warningForm.Close()
})
$warningForm.Controls.Add($yesButton)

# Show the warning form
$warningForm.ShowDialog()
