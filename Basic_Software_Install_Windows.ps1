###################################################################################################
<#Variables#>
###################################################################################################

$DownloadFolder = "$env:SystemDrive\FOG_Downloads"
$MSIexecLocation = [System.Environment]::SystemDirectory + "\msiexec.exe"

#Set variables for download links and local file location
$ChromeDownloadLink = "https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi"
$ChromeFileLocation = "$DownloadFolder\Google_Chrome.msi"

$FirefoxDownloadLink = "https://download.mozilla.org/?product=firefox-msi-latest-ssl&os=win64&lang=de"
$FirefoxFileLocation = "$DownloadFolder\Mozilla_Firefox.msi"

$7ZIPDownloadLink = "https://7-zip.org/a/7z1900-x64.msi"
$7ZIPFileLocation = "$DownloadFolder\7z1900-x64.msi"

$SteamDownloadLink = "https://cdn.cloudflare.steamstatic.com/client/installer/SteamSetup.exe"
$SteamFileLocation = "$DownloadFolder\SteamSetup.exe"

$TutanotaDownloadLink = "https://mail.tutanota.com/desktop/tutanota-desktop-win.exe"
$TutanotaFileLocation = "$DownloadFolder\tutanota-desktop-win.exe"

$SignalDownloadLink = "https://updates.signal.org/desktop/signal-desktop-win-1.40.0.exe"
$SignalFileLocation = "$DownloadFolder\signal-desktop-win-1.40.0.exe"

$KeepassXCDownloadLink = "https://github.com/keepassxreboot/keepassxc/releases/download/2.6.4/KeePassXC-2.6.4-Win64.msi"
$KeepassXCFileLocation = "$DownloadFolder\KeePassXC-2.6.4-Win64.msi"

$NotepadPlusPlusDownloadLink = "https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v7.9.3/npp.7.9.3.Installer.exe"
$NotepadPlusPlusFileLocation = "$DownloadFolder\npp.7.9.3.Installer.exe"

$OBSStudioDownloadLink = "https://cdn-fastly.obsproject.com/downloads/OBS-Studio-26.1.1-Full-Installer-x64.exe"
$OBSStudioFileLocation = "$DownloadFolder\OBS-Studio-26.1.1-Full-Installer-x64.exe"

$OracleVirtualboxDownloadLink = "https://download.virtualbox.org/virtualbox/6.1.18/VirtualBox-6.1.18-142142-Win.exe"
$OracleVirtualboxFileLocation = "$DownloadFolder\VirtualBox-6.1.18-142142-Win.exe"

$SumatraPDFDownloadLink = "https://www.sumatrapdfreader.org/dl2/SumatraPDF-3.2-64-install.exe"
$SumatraPDFFileLocation = "$DownloadFolder\SumatraPDF-3.2-64-install.exe"

$VLCDownloadLink = "https://download.videolan.org/pub/videolan/vlc/3.0.12/win64/vlc-3.0.12-win64.msi"
$VLCFileLocation = "$DownloadFolder\vlc-3.0.12-win64.msi"

###################################################################################################
<#Preperations#>
###################################################################################################

#Create temporary folder to store downloaded files
New-Item -Path $DownloadFolder -ItemType Directory -Force

#Exclude the temporary folder from Windows Defender RTP and scheduled scans
Add-MpPreference -ExclusionPath $DownloadFolder

###################################################################################################
<#Software Install#>
###################################################################################################

#Download and install Google Chrome
Invoke-WebRequest -Uri $ChromeDownloadLink -OutFile $ChromeFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$ChromeFileLocation", "/quiet", "/norestart") -Wait

#Download and install Mozilla Firefox
Invoke-WebRequest -Uri $FirefoxDownloadLink -OutFile $FirefoxFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$FirefoxFileLocation", "/quiet", "/norestart") -Wait

#Download and install 7-ZIP 19.00
Invoke-WebRequest -Uri $7ZIPDownloadLink -OutFile $7ZIPFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$7ZIPFileLocation", "/quiet", "/norestart") -Wait

#Download and install Steam
Invoke-WebRequest -Uri $SteamDownloadLink -OutFile $SteamFileLocation
Start-Process -FilePath $SteamFileLocation -ArgumentList @("/S") -Wait

#Download and install Tutanota Desktop Client
Invoke-WebRequest -Uri $TutanotaDownloadLink -OutFile $TutanotaFileLocation
Start-Process -FilePath $TutanotaFileLocation -ArgumentList @("/allusers", "/S") -Wait

#Download and install Signal Desktop 1.40
Invoke-WebRequest -Uri $SignalDownloadLink -OutFile $SignalFileLocation
Start-Process -FilePath $SignalFileLocation -ArgumentList @("/S") -Wait

#Download and install KeepassXC 2.6.4
Invoke-WebRequest -Uri $KeepassXCDownloadLink -OutFile $KeepassXCFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$KeepassXCFileLocation", "/quiet", "/norestart") -Wait

#Download and install Notepad++ 7.9.3
Invoke-WebRequest -Uri $NotepadPlusPlusDownloadLink -OutFile $NotepadPlusPlusFileLocation
Start-Process -FilePath $NotepadPlusPlusFileLocation -ArgumentList @("/S") -Wait

#Download and install OBS-Studio 26.1.1
Invoke-WebRequest -Uri $OBSStudioDownloadLink -OutFile $OBSStudioFileLocation
Start-Process -FilePath $OBSStudioFileLocation -ArgumentList @("/S") -Wait

#Download and install Oracle VM Virtualbox 6.1.18
Invoke-WebRequest -Uri $OracleVirtualboxDownloadLink -OutFile $OracleVirtualboxFileLocation
Start-Process -FilePath $OracleVirtualboxFileLocation -ArgumentList @("--silent", "--ignore-reboot") -Wait

#Download and install SumatraPDF 3.2
Invoke-WebRequest -Uri $SumatraPDFDownloadLink -OutFile $SumatraPDFFileLocation
Start-Process -FilePath $SumatraPDFFileLocation -ArgumentList @("-s", "-with-filter", "-with-preview") -Wait

#Download and install VLC 3.0.12
Invoke-WebRequest -Uri $VLCDownloadLink -OutFile $VLCFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$VLCFileLocation", "/quiet", "/norestart") -Wait


###################################################################################################
<#Cleanup#>
###################################################################################################

#Remove temporary folder
Remove-Item -Path $DownloadFolder -Recurse -Force

#Remove Windows Defender exclusion
Remove-MpPreference -ExclusionPath $DownloadFolder

###################################################################################################
<#Testing#>
###################################################################################################

<#
$DISMLocation = [System.Environment]::SystemDirectory + "\dism.exe"
$LinuxKernelUpdateDownloadLink = "https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi"
$LinuxKernelUpdateFileLocation = "$DownloadFolder\wsl_update_x64.msi"

#Install requirements for WSL2 (still needed in 20H2)
Start-Process -FilePath $DISMLocation -ArgumentList @("/online", "/enable-feature", "/featurename:Microsoft-Windows-Subsystem-Linux", "/all", "/norestart")
Start-Process -FilePath $DISMLocation -ArgumentList @("/online", "/enable-feature", "/featurename:VirtualMachinePlatform", "/all", "/norestart")
#Restart-Computer, but have to continue script afterwards
Invoke-WebRequest -Uri $LinuxKernelUpdateDownloadLink -OutFile $LinuxKernelUpdateFileLocation
Start-Process -FilePath $MSIexecLocation -ArgumentList @("/i", "$LinuxKernelUpdateFileLocation", "/quiet", "/norestart") -Wait

#>