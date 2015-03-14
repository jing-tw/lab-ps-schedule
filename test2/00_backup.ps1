#�妸�ƥ��@�~ PowerShell ����

# powershell �{���`�N�ƶ�
#  1. "`n" �O����
#  2. Dos �R�C�C�����Ұ� (�b�ɮ��`�� Dobule-Clicked �N�i�H����)
#    -------------------------
#      00_backup_ps.bat
#            set-executionpolicy RemoteSigned :: ���\�b Dos �Ұ� powershell ���O 
#            powershell -command "& './00_backup.ps1' -schedule "
#    -------------------------
#                                          by Jing


param ([switch] $schedule) # ���o�Ѽ� ps>00_backup.ps1 -schedule


# Utility
function Pause ($Message="Press any key to continue..."){
	Write-Host -NoNewLine $Message
	$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
	Write-Host ""
}
# end of Utlity


# �D�n�{���}�l
if ($schedule) {
	write-host "7zip �妸�ƥ��@�~�}�l"
	write-host "              PowerShell ���� by Jing"
	
	$timeout=1; # (�@���������)
	
	# Step 1: ���o�w�����R�O
	$taskrun = $myinvocation.mycommand.definition
	
	# Step 2: ���� task name �H��K schtasks ����
	$taskname = $taskrun -replace '\W','_'
	write-host "taskname=" $taskname
	
	# Step 3: �R���ª��w�����O (�H�K����)
	schtasks /delete /tn "$taskname" /f
	
	# Step 4: �p��w���ɶ� 
	$CurrentDate = get-date ; 
	$starttime=$CurrentDate.AddMinutes($timeout).toString('HH:mm:ss') #�p��w���ɶ�
	
	write-host "`n�п�J password:" # "`n" �O����
	
	# Step 5: �U�F�w�����O
	schtasks /create  /sc ONCE /st $starttime /tn "$taskname"  /tr "powershell -c $taskrun"
	
	
	# Step 6: �C�X���A
	write-host "`n`n�ثe schedule ���A"
	schtasks 
	write-host "`n`n�ثe�ɶ�" $CurrentDate 
	write-host "�w���Ұʮɶ�" $starttime "`n"
	
	Pause "The scheduling job done!"
	return;
}else{
	# �}�l���� schedule �u�@
	# C:\WINDOWS\notepad.exe
	
	# Step 1: �Ȯɥ[�� PATH (�u���ثe cmd.exe ����)
	$env:path +=";C:\Program Files\7-Zip\"
	
	# Step 2: ������ثe script ���ؿ� (�_�h���Y�ɭn���w������|)
	pushd (split-path -parent $myinvocation.mycommand.definition)
	
	# Step 3: �i��ƥ�
	#$cmd = "& 'C:\Program Files\7-Zip\7z.exe' a -t7z -mx=3 00_svn_root.zip 00_svn_root\"
	
	#$cmd = "& '7z.exe' a -t7z -mx=3 00_svn_root.zip 00_svn_root\"
	$cmd = "& '7z.exe' a -t7z -mx=3 bacd.zip bacd\"
	
	Invoke-Expression  $cmd
	
	# Step 4: ��_�ثe�ؿ�
	popd
	
	Pause
}

# �ѦҸ��:
# http://blogs.msdn.com/mwilbur/archive/2007/02/23/powershell-script-that-can-schedule-itself-to-run-later.aspx