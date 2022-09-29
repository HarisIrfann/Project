@ECHO OFF


net localgroup "Remote Desktop Users" "Domain Users" /delete
net localgroup "Remote Desktop Users" "office\SMRCAPAPP02SRVC" /add
net localgroup "Remote Desktop Users" "office\rol-smrctnoadmins" /add
net localgroup "Remote Desktop Users" "office\rol-qrmadministrators" /add
net localgroup "Remote Desktop Users" "office\rol-qrmusers" /add
"E:\Support\MISC\pcl6-x64-6.6.5.23510\install.exe" /q /n"HP Universal Printing PCL 6" /sm LPT1:
Set-Service -Name Spooler -StartupType Automatic -Status Running
&"reg" "import" "E:\Support\Powershell\RegKeys\TRM_Default_Printer.reg"
E:\Support\MISC\MSOFFICE2016\setup.exe /adminfile E:\Support\Powershell\OfficeMSP\QRM_Office_MSP.msp&E:\Support\MISC\AcroRdrDCUpd1902120047\setup.exe "/sPB" "/rs"
E:\Support\ntrights +r SeInteractiveLogonRight -u "office\SMRCLAAPP02SRVC"
E:\Support\ntrights +r SeInteractiveLogonRight -u "Remote Desktop Users"
Expand-Archive -Path E:\Support\MISC\LRM-E.zip -DestinationPath E:\
&CACLS "E:\LRM" "/E" "/T" "/C" "/G" "office\SMRCLAAPPSRVC:F" "office\SMRCLAAPP02SRVC:F" "office\ROL-qrmadmini$
Copy-Item "E:\Support\Powershell\cscript\cscript.exe.config" "C:\Windows\System32" -Force
Expand-Archive -Path E:\Support\MISC\AdhocTool.zip -DestinationPath E:\LRM
mkdir M:\CTSHare
New-SMBShare -Name CTShare -Path "M:\CTShare" -FullAccess Everyone
&CACLS "M:\CTShare" "/E" "/T" "/C" "/G" "office\ROL-SMRCTNOADMINS:F" "office\ROL-
qrmadministrators:F" "office\rol-qrmusers:F"
Expand-Archive -Path E:\Support\MISC\AutoDrvMap.zip -DestinationPath E:\LRM
(Get-Content "E:\LRM\AutoDrvMap\AutoDrvMap.cmd") | ForEach-Object {$_ -replace "FileShareSvr","smrczccdwdbs00$
$WScriptShell = New-Object -ComObject WScript.Shell
$TargFileADM = "E:\LRM\AutoDrvMap\AutoDrvMap.cmd"
$ShortcutFileADM = "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp\AutoDrvMap.lnk"
$ShortcutADM = $WScriptShell.CreateShortcut($ShortcutFileADM)
$ShortcutADM.TargetPath = $TargFileADM
$ShortcutADM.WorkingDirectory = "E:\LRM\AutoDrvMap"
$ShortcutADM.Save()
Expand-Archive -Path E:\Support\MISC\BGinfo.zip -DestinationPath C:\Windows
Move-Item C:\Windows\sysinfo.lnk "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\StartUp" -force
&"E:\Support\MS-SQL\SQL2016_Tools\SSMS-Setup-ENU.exe" "/install" "/passive" "/norestart"
&"E:\Support\MS-SQL\SQL2016_Tools\DataMigrationAssistant.msi" "/passive" "/norestart"
E:\Support\Powershell\SQLScripts\InstallSSIS2016.ps1
sc config "MsDtsServer130" start= delayed-auto
&"E:\Support\MISC\Microsoft OLE DB Driver 18\msoledbsql.msi" "/passive" "/norestart"
"IACCEPTMSOLEDBSQLLICENSETERMS=YES"
D :
cd D:\Support\MISC\db2client\CLIENT
setup /l C:\Windows\Temp\Db2client.log /u D:\Support\MISC\db2client\db2client.rsp
Add-LocalGroupMember -Group "DB2ADMNS" -Member "ROL-SMRCTNOADMINS"
Add-LocalGroupMember -Group "DB2USERS" -Member "office\rol-qrmadministrators", "office\rol-qrmusers"
"E:\Support\MISC\NetezzaDrv7219\nzodbcsetup.exe" -i silent
"E:\Support\MISC\NetezzaDrv7219\nzoledbsetup64.exe" -i silent
regsvr32.exe /c C:\windows\SysWOW64\NZOLEDB.DLL /s
regsvr32.exe /c C:\windows\System32\NZOLEDB.DLL /s
Expand-Archive -Path E:\Support\MISC\Dataloader.zip -DestinationPath E:\
(Get-Content "E:\wwwroot\DataLoadAdmin\web.config") | ForEach-Object {$_ -replace "QRMSQLInstanceName","smrcz$
"E:\wwwroot\DataLoadAdmin\web.config"
(Get-Content "E:\wwwroot\QRMDataLoad\web.config") | ForEach-Object {$_ -replace "QRMSQLInstanceName","smrczcc$
"E:\wwwroot\QRMDataLoad\web.config"
&CACLS "E:\wwwroot" "/E" "/T" "/C" "/G" "office\ROL-qrmadministrators:R" "Office\ROL-SMRCTNOAdmins:R" "IIS_IU$
Install-WindowsFeature -name Web-Server -IncludeManagementTools
Import-Module ServerManager
Add-WindowsFeature Web-Scripting-Tools
Import-Module WebAdministration
Set-ItemProperty "IIS:\Sites\Default Web Site" -name physicalpath -value D:\wwwroot
New-WebApplication -Name QRMDataLoad -Site 'Default Web Site' -PhysicalPath D:\wwwroot\QRMDataLoad -Applicati$
New-WebApplication -Name DataLoadAdmin -Site 'Default Web Site' -PhysicalPath D:\wwwroot\DataLoadAdmin -Appli$
Set-WebConfigurationProperty -filter
"/system.webServer/security/authentication/windowsAuthentication" -name enabled -value true -PSPath "IIS:\" -$
Set-WebConfigurationProperty -filter
"/system.webServer/security/authentication/anonymousAuthentication" -name enabled -value false -PSPath "IIS:\$
Set-ItemProperty ("IIS:\AppPools\DefaultAppPool") -Name managedPipelineMode -Value 1
&"reg" "import" "E:\Support\Powershell\RegKeys\RegkeyODBC32.reg"        
&"reg" "import" "E:\Support\Powershell\RegKeys\RegkeyODBC64.reg"
msiexec /passive /i "D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\SQL2012_AS_AMO.msi"
msiexec /passive /i "D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\SQL2014_AS_AMO.msi"
msiexec /passive /l*v D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\OWC11-install.log $
D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\OWC11.MSI /update D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\OWC11SP1.msp
"D:\support\QRM-Software\QRM_BSM_16_1_2502CZ_Install\Redistributables\ReportViewer.exe" /q

ECHO SUCCESS

PAUSE
