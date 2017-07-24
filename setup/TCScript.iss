#define MyAppName "TCScript"
#define MyAppURL "http://www.pm-codeworks.de"
#define MyAppExeName "tcscript.bat"

[Setup]
AppId={{CEC2B9D6-D391-470A-8A1A-EBC0B6CFF71B}
AppName={#MyAppName}
AppVersion=2.7
AppVerName={#MyAppName} 2.7
AppCopyright=Philipp Meisberger
AppPublisher=PM Code Works
AppPublisherURL={#MyAppURL}
AppSupportURL={#MyAppURL}/tcscript.html
ArchitecturesInstallIn64BitMode=x64 ia64
CreateAppDir=yes
DefaultDirName={pf}\{#MyAppName}
DisableDirPage=yes
DisableProgramGroupPage=yes
LicenseFile=..\LICENCE.txt
InfoAfterFile=post.txt
OutputDir=.
OutputBaseFilename=tcscript_setup
Compression=lzma
SolidCompression=yes
VersionInfoVersion=2.7
SignTool=MySignTool sign /v /n "PM Code Works" /tr http://timestamp.globalsign.com/scripts/timstamp.dll /td SHA256 /fd SHA256 $f

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"
Name: "french"; MessagesFile: "compiler:Languages\French.isl"
Name: "german"; MessagesFile: "compiler:Languages\German.isl"

[Tasks]
Name: "recyclebin"; Description: "{cm:RecycleBinContextDesc}"; GroupDescription: "{cm:GroupContextDesc}"
Name: "computer"; Description: "{cm:ComputerContextDesc}"; GroupDescription: "{cm:GroupContextDesc}"

[Files]
Source: "..\src\{#MyAppExeName}"; DestDir: GetTrueCryptInstallDir; Flags: ignoreversion
Source: "..\src\tcscript.conf.cmd"; DestDir: GetTrueCryptInstallDir; Flags: onlyifdoesntexist

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

function GetTrueCryptInstallDir(): string;
begin
  if RegQueryStringValue(HKCR, 'TypeLib\{1770F56C-7881-4591-A179-79B8001C7D42}\2.4\HELPDIR', '', Result) then
    Result := AddBackslash(Result)
  else
    Result := '';
end;

function InitializeSetup(): Boolean;
begin
  if (GetTrueCryptInstallDir() = '') then
  begin
    MsgBox('TrueCrypt-Installationsordner wurde nicht gefunden! Bitte installieren Sie zuerst TrueCrypt!' +#13+ 'Setup wird beendet!', mbERROR, MB_OK);
    Result := False;
  end  //of begin
  else
    Result := True;
end;

[Registry]
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\TrueCrypt Mount/Dismount"; Flags: dontcreatekey uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{20D04FE0-3AEA-1069-A2D8-08002B30309D}\shell\TrueCrypt Mount/Dismount\command"; ValueType: string; ValueName: ""; ValueData: "{pf}\TrueCrypt\tcscript.bat /auto /interactive"; Tasks: "computer"
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{645FF040-5081-101B-9F08-00AA002F954E}\shell\TrueCrypt Mount/Dismount"; Flags: dontcreatekey uninsdeletekey
Root: HKLM; Subkey: "SOFTWARE\Classes\CLSID\{{645FF040-5081-101B-9F08-00AA002F954E}\shell\TrueCrypt Mount/Dismount\command"; ValueType: string; ValueName: ""; ValueData: "{pf}\TrueCrypt\tcscript.bat /auto /interactive"; Tasks: "recyclebin"

[UninstallDelete]
Type: filesandordirs; Name: "{pf}\TrueCrypt\tcscript.bat"
Type: filesandordirs; Name: "{pf}\TrueCrypt\tcscript.conf.cmd"
Type: filesandordirs; Name: "{pf}\TCScript"
