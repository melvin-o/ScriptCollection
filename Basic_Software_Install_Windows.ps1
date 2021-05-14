###################################################################################################
<#Variables#>
###################################################################################################

$DownloadFolder = "$env:SystemDrive\Temp_Downloads"

#Set variables for download links and local file location
$TutanotaDownloadLink = "https://mail.tutanota.com/desktop/tutanota-desktop-win.exe"
$TutanotaFileLocation = "$DownloadFolder\tutanota-desktop-win.exe"

#Set variables for the current version of Windows Package Manager (Preview) | Needs to be updated when new version is released!
$PackageManagerAppxBundleUri = "https://github.com/microsoft/winget-cli/releases/download/v-0.3.11201-preview/Microsoft.DesktopAppInstaller_8wekyb3d8bbwe.appxbundle"
$PackageManagerAppxBundleFileLocation = "$DownloadFolder\PackageManager.appxbundle"

###################################################################################################
<#Preperations#>
###################################################################################################

#Use TLS 1.2
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

#Create temporary folder to store downloaded files
New-Item -Path $DownloadFolder -ItemType Directory -Force

#Exclude the temporary folder from Windows Defender RTP and scheduled scans
Add-MpPreference -ExclusionPath $DownloadFolder

#Download and install Windows Package Manager
Invoke-WebRequest -Uri $PackageManagerAppxBundleUri -OutFile $PackageManagerAppxBundleFileLocation
Add-AppxPackage -Path $PackageManagerAppxBundleFileLocation

###################################################################################################
<#Software Install#>
###################################################################################################

#Download and install Tutanota Desktop Client
Invoke-WebRequest -Uri $TutanotaDownloadLink -OutFile $TutanotaFileLocation
Start-Process -FilePath $TutanotaFileLocation -ArgumentList @("/allusers", "/S") -Wait

winget install --id 7zip.7zip --silent
winget install --id Mozilla.Firefox --silent
winget install --id Bitwarden.Bitwarden --silent
winget install --id Notepad++.Notepad++ --silent
winget install --id Signal.Signal --silent
winget install --id SumatraPDF.SumatraPDF --override "-install -s -with-filter -with-preview"
winget install --id VideoLAN.VLC --silent
winget install --id Microsoft.WindowsTerminal --silent
winget install --id WinSCP.WinSCP --silent
winget install --id GitHub.Atom --silent

###################################################################################################
<#Cleanup#>
###################################################################################################

#Remove temporary folder
Remove-Item -Path $DownloadFolder -Recurse -Force

#Remove Windows Defender exclusion
Remove-MpPreference -ExclusionPath $DownloadFolder

#Reboot
Restart-Computer -Force
