
:: 允許在 Dos 啟動 powershell 指令 
set-executionpolicy RemoteSigned
powershell -command "& './00_backup.ps1' -schedule "
:: powershell -command "& './test.ps1' "

:: 參考資料: 
::  http://www.searchmarked.com/windows/how-to-schedule-a-windows-powershell-script.php