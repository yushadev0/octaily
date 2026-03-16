{$define UNIGUI_VCL} // Comment out this line to turn this project into an ISAPI module

{$ifndef UNIGUI_VCL}
library
{$else}
program
{$endif}
  OctailyClient;

uses
  uniGUIISAPI,
  Forms,
  ServerModule in 'ServerModule.pas' {UniServerModule: TUniGUIServerModule},
  MainModule in 'MainModule.pas' {UniMainModule: TUniGUIMainModule},
  Main in 'Main.pas' {MainForm: TUniForm},
  WordleForm in 'WordleForm.pas' {WORDLE_FORM: TUniForm},
  SudokuForm in 'SudokuForm.pas' {SUDOKU_FORM: TUniForm},
  QueensForm in 'QueensForm.pas' {QUEENS_FORM: TUniForm},
  NerdleForm in 'NerdleForm.pas' {NERDLE_FORM: TUniForm},
  ZipForm in 'ZipForm.pas' {ZIP_FORM: TUniForm},
  HexleForm in 'HexleForm.pas' {HEXLE_FORM: TUniForm},
  WorldleForm in 'WorldleForm.pas' {WORLDLE_FORM: TUniForm},
  LoginForm in 'LoginForm.pas' {LOGIN_FORM: TUniLoginForm},
  SecretConsts in 'SecretConsts.pas';

{$R *.res}

{$ifndef UNIGUI_VCL}
exports
  GetExtensionVersion,
  HttpExtensionProc,
  TerminateExtension;
{$endif}

begin
{$ifdef UNIGUI_VCL}
  ReportMemoryLeaksOnShutdown := True;
  Application.Initialize;
  TUniServerModule.Create(Application);
  Application.Run;
{$endif}
end.
