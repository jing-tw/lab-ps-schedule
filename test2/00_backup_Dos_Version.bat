@echo off
@echo 7zip 批次備份作業開始 by Jing

:: 直接添加到系統 PATH (每次開 cmd.exe 都會有效)
:: 搭配 SetEnv.exe http://www.codeproject.com/KB/applications/SetEnv.aspx
:: SetEnv -a PATH %%"C:\Program Files\7-Zip

:: 暫時加到 PATH (只有目前 cmd.exe 有效)
set PATH=%PATH%;C:\Program Files\7-Zip\

:: 00_svn_root backup
:: Fast compressing (x=3)
7z a -t7z -mx=3 00_svn_root.zip 00_svn_root\ 

:: test
7z a -t7z -mx=3 test.zip test\

:: Work
7z a -t7z -mx=3 Work.zip Work\

@echo 備份工作列表
@echo -------------------------------
@echo 00_svn_root -> 00_svn_root.zip
@echo test -> test.zip
@echo work -> work.zip
@echo -------------------------------
@echo 7zip 批次備份作業完成