unit MainModule;

interface

uses
  uniGUIMainModule, SysUtils, Classes, Data.DB, MemDS, DBAccess, Uni,
  UniProvider, SQLServerUniProvider, System.Hash, System.NetEncoding,
  uniGUIVars, uniGUIApplication, SecretConsts; // Kütüphaneler tam

type
  TUniMainModule = class(TUniGUIMainModule)
    UniConnection1: TUniConnection;
    SQLServerUniProvider1: TSQLServerUniProvider;
    LoginTable: TUniQuery;
    RegisterTable: TUniQuery;
    StatsTable: TUniQuery;
    StatsExec: TUniQuery;
    QueryExec: TUniQuery;
    procedure UniGUIMainModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    logged_user_id: Integer;
    logged_username: string;
    logged_email: string;
    ResetOTP: string;
    OTPExpireTime: TDateTime;
  end;

function UniMainModule: TUniMainModule;

implementation

{$R *.dfm}

uses
  ServerModule;

function UniMainModule: TUniMainModule;
begin
  Result := TUniMainModule(UniApplication.UniMainModule);
end;

procedure TUniMainModule.UniGUIMainModuleCreate(Sender: TObject);
begin
  UniConnection1.Username :=  DB_USERNAME;
  UniConnection1.Password := DB_PASS;
  UniConnection1.Connect;
end;

initialization

RegisterMainModuleClass(TUniMainModule);

end.
