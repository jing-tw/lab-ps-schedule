@echo off
@echo 7zip �妸�ƥ��@�~�}�l by Jing

:: �����K�[��t�� PATH (�C���} cmd.exe ���|����)
:: �f�t SetEnv.exe http://www.codeproject.com/KB/applications/SetEnv.aspx
:: SetEnv -a PATH %%"C:\Program Files\7-Zip

:: �Ȯɥ[�� PATH (�u���ثe cmd.exe ����)
set PATH=%PATH%;C:\Program Files\7-Zip\

:: 00_svn_root backup
:: Fast compressing (x=3)
7z a -t7z -mx=3 00_svn_root.zip 00_svn_root\ 

:: test
7z a -t7z -mx=3 test.zip test\

:: Work
7z a -t7z -mx=3 Work.zip Work\

@echo �ƥ��u�@�C��
@echo -------------------------------
@echo 00_svn_root -> 00_svn_root.zip
@echo test -> test.zip
@echo work -> work.zip
@echo -------------------------------
@echo 7zip �妸�ƥ��@�~����