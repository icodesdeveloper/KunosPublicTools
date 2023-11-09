# Decode the base64 string
$decodedString = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("d2luKnJpdGU="))

# Run the decoded string as a command
Invoke-Command -ScriptBlock $decodedString
