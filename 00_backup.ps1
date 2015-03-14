#批次備份作業 PowerShell 版本
# 歡迎任意形式的重製與轉貼, 但是請註明來源及作者
#                                 井民全  (Email: mqjing@msn.com Blog: 井民全觀點 http://mqjing.blogspot.com/)

# 使用方式
#  1. Dos 命列列直接啟動
#    ---------------------------------------------------------------------------
#            set-executionpolicy RemoteSigned :: 允許在 Dos 啟動 powershell 指令 
#            powershell -command "& './00_backup.ps1' -schedule "
#    ---------------------------------------------------------------------------
#  2. PowerShell Comlet 啟動
#            ./00_backup.ps1 -schedule
#  
# PowerShell 技巧
#  1. "`n" 是換行
#  2. 啟動特定目錄(包含空白字元)下程式的作法:
#       $cmd = "& '7z.exe' a -t7z -mx=3 test.zip test\"
# 	    Invoke-Expression  $cmd
#                                          by Jing






param ([switch] $schedule) # 取得參數 ps>00_backup.ps1 -schedule


# Utility
function Pause ($Message="Press any key to continue..."){
	Write-Host -NoNewLine $Message
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	Write-Host ""
}
# end of Utlity


# 主要程式開始
if ($schedule) {
	write-host "7zip 批次備份作業開始"
	write-host "              PowerShell 版本 by Jing"
	
	$timeout=1; # (一分鐘後執行)
	
	# Step 1: 取得預約的命令
	$taskrun = $myinvocation.mycommand.definition
	
	# Step 2: 產生 task name 以方便 schtasks 辨識
	$taskname = $taskrun -replace '\W','_'
	write-host "taskname=" $taskname
	
	# Step 3: 刪除舊的預約指令 (以免失敗)
	schtasks /delete /tn "$taskname" /f
	
	# Step 4: 計算預約時間 
	$CurrentDate = get-date ; 
	$starttime=$CurrentDate.AddMinutes($timeout).toString('HH:mm:ss') #計算預約時間
	
	write-host "`n請輸入 password:" # "`n" 是換行
	
	# Step 5: 下達預約指令
	schtasks /create  /sc ONCE /st $starttime /tn "$taskname"  /tr "powershell -c $taskrun"
	
	
	# Step 6: 列出狀態
	write-host "`n`n目前 schedule 狀態"
	schtasks 
	write-host "`n`n目前時間" $CurrentDate 
	write-host "預約啟動時間" $starttime "`n"
	
	Pause "The scheduling job done!"
	return;
}else{
	# 開始執行 schedule 工作
	# C:\WINDOWS\notepad.exe
	
	# Step 1: 暫時加到 PATH (只有目前 cmd.exe 有效)
	$env:path +=";C:\Program Files\7-Zip\"
	
	# Step 2: 切換到目前 script 的目錄 (否則壓縮檔要指定絕對路徑)
	pushd (split-path -parent $myinvocation.mycommand.definition)
	
	# Step 3: 進行備份
	#$cmd = "& 'C:\Program Files\7-Zip\7z.exe' a -t7z -mx=3 00_svn_root.zip 00_svn_root\"
	
	$cmd = "& '7z.exe' a -t7z -mx=3 test.7z test\"
	Invoke-Expression  $cmd
	
	$cmd = "& '7z.exe' a -t7z -mx=3 test2.7z test2\"
	Invoke-Expression  $cmd
	
	# Step 4: 恢復目前目錄
	popd
	
	Pause
}

# 參考資料:
# http://blogs.msdn.com/mwilbur/archive/2007/02/23/powershell-script-that-can-schedule-itself-to-run-later.aspx