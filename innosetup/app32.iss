[Setup]
AppName=Daeyalt Launcher
AppPublisher=Daeyalt
UninstallDisplayName=Daeyalt
AppVersion=${project.version}
AppSupportURL=https://Daeyalt.net/
DefaultDirName={localappdata}\Daeyalt

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Daeyalt.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=DaeyaltSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Daeyalt.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Daeyalt.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\Daeyalt\Daeyalt"; Filename: "{app}\Daeyalt.exe"
Name: "{userprograms}\Daeyalt\Daeyalt (configure)"; Filename: "{app}\Daeyalt.exe"; Parameters: "--configure"
Name: "{userprograms}\Daeyalt\Daeyalt (safe mode)"; Filename: "{app}\Daeyalt.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\Daeyalt"; Filename: "{app}\Daeyalt.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Daeyalt.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Daeyalt.exe"; Description: "&Open Daeyalt"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Daeyalt.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.Daeyalt\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"