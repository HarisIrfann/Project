@ECHO OFF

msiexec /passive /l*v  C:\temp\ca-install.log /i "E:\Support\QRM-Software\QRM_CA_16_1_2917T_Install\Installers\CA 16.1.2917T\QRM Central Administration 2019 Q4 Update 2917_T.msi" INSTALLLOCATION="E:\QRM\Central Administration" 
REGISTERAGAINSCA="smrczccdwcas002" SQLSERVERNAME="smrczccdwdbs002"
SQLDATABASE="CAv16DB" SQLCREDENTIALSUSERNAME="qrmsvc"
SQLCREDENTIALSPASSWORD="Fall2019" CASERVICEDOMAIN="office"
CASERVICEUSERNAME="SMRCLAAPPSRVC" CASERVICEPASSWORD="Bgy65Fdr4Vbj7Y5D8"
ADDLOCAL="CentralAdminServer,CentralAdminClient,QrmHpcIntegrationService"
HPCSERVICEDOMAIN="office" HPCSERVICEUSERNAME="SMRCLAAPPSRVC"
HPCSERVICEPASSWORD="Bgy65Fdr4Vbj7Y5D8" CAADMINUSERDOMAIN="office"
CAADMINUSERNAME="ROL-SMRCTNOADMINS" CAHOSTNAME="smrczccdwcas002" CAPORT="1820"
Copy-Item "E:\QRM\Central Administration\HPC\Qrm.Hpc.IntegrationServer.exe.config"
"E:\QRM\Central Administration\HPC\Qrm.Hpc.IntegrationServer.exe.config.$(Get-Date -f yyyyMMdd)" -Force
(Get-Content "E:\QRM\Central Administration\HPC\Qrm.Hpc.IntegrationServer.exe.config") | ForEach-Object {$_ -replace "Impersonation","ConnectAsServiceClient"} | Set-Content 
"E:\QRM\Central Administration\HPC\Qrm.Hpc.IntegrationServer.exe.config"
Restart-Service HpcIntegrationService
$WScriptShell = New-Object -ComObject WScript.Shell
$TargFileQRMCA = "E:\QRM\Central Administration\CentralAdminClientMain.exe"
$ShortcutFileQRMCA = "$env:Public\Desktop\QRM Central Administration.lnk"
$ShortcutQRMCA = $WScriptShell.CreateShortcut($ShortcutFileQRMCA)
$ShortcutQRMCA.TargetPath = $TargFileQRMCA
$ShortcutQRMCA.WorkingDirectory = "E:\QRM\Central Administration\"
$ShortcutQRMCA.Save()
"d:\Support\QRM-Software\QRMCA2019Q4Fix.exe" /auto
D:\Support\MISC\ReportViewer.exe /q
msiexec /quiet /i D:\support\QRM-Software\SQL2016_AS_ADOMD.msi /norestart
msiexec /quiet /i D:\support\QRM-Software\SQL2016_AS_AMO.msi /norestart
mkdir M:\WorkingFolder
New-SMBShare -Name WorkingFolder -Path "M:\WorkingFolder" -FullAccess "office\ROL-SMRCTNOADMINS","office\ROL-qrmadministrators","office\rol-qrmusers","Authenticated Users"
&CACLS "M:\WorkingFolder" "/E" "/T" "/C" "/G" "office\ROL-SMRCTNOADMINS:F" "office\ROL-qrmadministrators:F" "office\rol-qrmusers:F"
mkdir I:\MSSQL\Backup\Manual
New-SMBShare -Name SQLBackup -Path "I:\MSSQL\Backup\" -FullAccess "office\ROL-SMRCTNOADMINS","office\ROL-qrmadministrators","Authenticated Users"
&CACLS "I:\MSSQL\Backup" "/E" "/T" "/C" "/G" "office\ROL-SMRCTNOADMINS:R" "office\ROL-qrmadministrators:R"
&CACLS "I:\MSSQL\Backup\Manual" "/E" "/T" "/C" "/G" "office\ROL-SMRCTNOADMINS:F" "office\ROL-qrmadministrators:F"
msiexec /passive /l*v  C:\temp\ca-install.log /i "E:\Support\QRM-
Software\QRM_CA_16_1_2917T_Install\Installers\CA 16.1.2917T\QRM Central Administration 2019 Q4 Update 2917_T.msi" INSTALLLOCATION="E:\QRM\Central Administration" 
REGISTERAGAINSCA="smrczccdwcas002" ADDLOCAL="CentralAdminClient
CAADMINUSERDOMAIN="office" CAADMINUSERNAME="ROL-SMRCTNOADMINS"
CAHOSTNAME="smrczccdwcas002" CAPORT="1820"
New-SMBShare -Name QRM -Path "E:\QRM" -FullAccess Everyone
&CACLS "E:\QRM" "/E" "/C" "/T" "/G" "office\ROL-SMRCTNOADMINS:F" "office\ROL-qrmadministrators:F" "office\ROL-qrmusers:F"
$WScriptShell = New-Object -ComObject WScript.Shell
$TargFileQRMCA = "E:\QRM\Central Administration\CentralAdminClientMain.exe"
$ShortcutFileQRMCA = "$env:Public\Desktop\QRM Central Administration.lnk"
$ShortcutQRMCA = $WScriptShell.CreateShortcut($ShortcutFileQRMCA)
$ShortcutQRMCA.TargetPath = $TargFileQRMCA
$ShortcutQRMCA.WorkingDirectory = "E:\QRM\Central Administration\"
$ShortcutQRMCA.Save()
"d:\Support\QRM-Software\QRMCA2019Q4Fix.exe" /auto
D:\Support\MISC\ReportViewer.exe /q
msiexec /quiet /i D:\support\QRM-Software\SQL2016_AS_ADOMD.msi /norestart
msiexec /quiet /i D:\support\QRM-Software\SQL2016_AS_AMO.msi /norestart

ECHO SUCCESS

PAUSE