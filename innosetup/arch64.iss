[Setup]
AppName=Paragon Launcher
AppPublisher=Paragon
UninstallDisplayName=Paragon
AppVersion=${project.version}
AppSupportURL=https://Paragon.net/
DefaultDirName={localappdata}\Paragon

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=arm64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Paragon.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=ParagonSetupAArch64

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win-aarch64\Paragon.exe"; DestDir: "{app}"
Source: "${basedir}\native-win-aarch64\Paragon.jar"; DestDir: "{app}"
Source: "${basedir}\native\buildaarch64\Release\launcher_aarch64.dll"; DestDir: "{app}"
Source: "${basedir}\native-win-aarch64\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win-aarch64\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Paragon\Paragon"; Filename: "{app}\Paragon.exe"
Name: "{userprograms}\Paragon\Paragon (configure)"; Filename: "{app}\Paragon.exe"; Parameters: "--configure"
Name: "{userprograms}\Paragon\Paragon (safe mode)"; Filename: "{app}\Paragon.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Paragon"; Filename: "{app}\Paragon.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Paragon.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Paragon.exe"; Description: "&Open Paragon"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Paragon.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.paragon\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"