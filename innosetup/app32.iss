[Setup]
AppName=Elvarg Launcher
AppPublisher=Elvarg
UninstallDisplayName=Elvarg
AppVersion=${project.version}
AppSupportURL=https://elvarg.net/
DefaultDirName={localappdata}\Elvarg

; ~30 mb for the repo the launcher downloads
ExtraDiskSpaceRequired=30000000
ArchitecturesAllowed=x86 x64
PrivilegesRequired=lowest

WizardSmallImageFile=${basedir}/app_small.bmp
WizardImageFile=${basedir}/left.bmp
SetupIconFile=${basedir}/app.ico
UninstallDisplayIcon={app}\Elvarg.exe

Compression=lzma2
SolidCompression=yes

OutputDir=${basedir}
OutputBaseFilename=ElvargSetup32

[Tasks]
Name: DesktopIcon; Description: "Create a &desktop icon";

[Files]
Source: "${basedir}\native-win32\Elvarg.exe"; DestDir: "{app}"
Source: "${basedir}\native-win32\Elvarg.jar"; DestDir: "{app}"
Source: "${basedir}\native\build32\Release\launcher_x86.dll"; DestDir: "{app}"
Source: "${basedir}\native-win32\config.json"; DestDir: "{app}"
Source: "${basedir}\native-win32\jre\*"; DestDir: "{app}\jre"; Flags: recursesubdirs

[Icons]
; start menu
Name: "{userprograms}\RuneLite\Elvarg"; Filename: "{app}\Elvarg.exe"
Name: "{userprograms}\RuneLite\Elvarg (configure)"; Filename: "{app}\Elvarg.exe"; Parameters: "--configure"
Name: "{userprograms}\RuneLite\Elvarg (safe mode)"; Filename: "{app}\Elvarg.exe"; Parameters: "--safe-mode"
Name: "{userdesktop}\RuneLite"; Filename: "{app}\Elvarg.exe"; Tasks: DesktopIcon

[Run]
Filename: "{app}\Elvarg.exe"; Parameters: "--postinstall"; Flags: nowait
Filename: "{app}\Elvarg.exe"; Description: "&Open Elvarg"; Flags: postinstall skipifsilent nowait

[InstallDelete]
; Delete the old jvm so it doesn't try to load old stuff with the new vm and crash
Type: filesandordirs; Name: "{app}\jre"
; previous shortcut
Type: files; Name: "{userprograms}\Elvarg.lnk"

[UninstallDelete]
Type: filesandordirs; Name: "{%USERPROFILE}\.elvarg\repository2"
; includes install_id, settings, etc
Type: filesandordirs; Name: "{app}"

[Code]
#include "upgrade.pas"