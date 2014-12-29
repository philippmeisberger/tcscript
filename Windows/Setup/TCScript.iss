#define MyAppName "TCScript"
#define MyAppURL "http://www.pm-codeworks.de"
#define MyAppExeName "tcscript.bat"

[Setup]
AppId={{CEC2B9D6-D391-470A-8A1A-EBC0B6CFF71B}
AppName={#MyAppName}
AppVersion=2.5
AppVerName={#MyAppName} 2.5
AppCopyright=Philipp Meisberger
AppPublisher=PM Code Works
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/tcscript.html
ArchitecturesInstallIn64BitMode=x64 ia64
CreateAppDir=yes
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
LicenseFile=copying.txt
InfoAfterFile=post.txt
OutputDir=.
OutputBaseFilename=tcscript_setup
Compression=lzma
SolidCompression=yes
VersionInfoVersion=2.2
SignTool=Sign {srcexe}

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "recyclebin"; Description: "{cm:RecycleBinContextDesc}"; GroupDescription: "{cm:GroupContextDesc}"
Name: "computer"; Description: "{cm:ComputerContextDesc}"; GroupDescription: "{cm:GroupContextDesc}"

[Files]
Source: "..\{#MyAppExeName}"; DestDir: "{pf}\TrueCrypt"; Flags: ignoreversion
Source: "..\tcscript.conf.cmd"; DestDir: "{pf}\TrueCrypt"; Flags: onlyifdoesntexist

[CustomMessages]
GroupContextDesc=Kontextmenü-Einträge hinzufügen
RecycleBinContextDesc=Kontextmenü-Eintrag "TrueCrypt Mount/Dismount" in Papierkorb hinzufügen
ComputerContextDesc=Kontextmenü-Eintrag "TrueCrypt Mount/Dismount" in Computer hinzufügen

[Messages]
BeveledLabel=Inno Setup

[Code]
procedure UrlLabelClick(Sender: TObject);
var
  ErrorCode : Integer;
  
begin
  ShellExec('open', ExpandConstant('{#MyAppURL}'), '', '', SW_SHOWNORMAL, ewNoWait, ErrorCode);
end;


procedure InitializeWizard;
var
  UrlLabel: TNewStaticText;
  CancelBtn: TButton;

begin
  CancelBtn := WizardForm.CancelButton;
  UrlLabel := TNewStaticText.Create(WizardForm);
  UrlLabel.Top := CancelBtn.Top + (CancelBtn.Height div 2) -(UrlLabel.Height div 2);
  UrlLabel.Left := WizardForm.ClientWidth - CancelBtn.Left -CancelBtn.Width;
  UrlLabel.Caption := 'www.pm-codeworks.de';
  UrlLabel.Font.Style := UrlLabel.Font.Style + [fsUnderline] ;
  UrlLabel.Cursor := crHand;
  UrlLabel.Font.Color := clHighlight;
  UrlLabel.OnClick := @UrlLabelClick;
  UrlLabel.Parent := WizardForm;
end;

function InitializeSetup(): Boolean;
var
  Path: string;

begin
  if not RegQueryStringValue(HKLM, 'SOFTWARE\Classes\TrueCryptVolume\DefaultIcon', '', Path) then
  begin
    MsgBox('TrueCrypt-Installationsordner wurde nicht gefunden! Bitte installieren Sie zuerst TrueCrypt!' +#13+ 'Setup wird beendet!', mbERROR, MB_OK);
    result := False;
  end  //of begin
  else
    result := True;
end;

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\TrueCrypt Mount/Dismount"; Flags: dontcreatekey uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\TrueCrypt Mount/Dismount\command"; ValueType: string; ValueName: ""; ValueData: "{pf}\TrueCrypt\tcscript.bat /auto /interactive"; Tasks: "computer"
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{645FF040-5081-101B-9F08-00AA002F954E}\shell\TrueCrypt Mount/Dismount"; Flags: dontcreatekey uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{645FF040-5081-101B-9F08-00AA002F954E}\shell\TrueCrypt Mount/Dismount\command"; ValueType: string; ValueName: ""; ValueData: "{pf}\TrueCrypt\tcscript.bat /auto /interactive"; Tasks: "recyclebin"

[UninstallDelete]     
Type: filesandordirs; Name: "{pf}\TrueCrypt\tcscript.bat"
Type: filesandordirs; Name: "{pf}\TrueCrypt\tcscript.conf.cmd"
