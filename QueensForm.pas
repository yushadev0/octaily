unit QueensForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  uniTimer, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent,
  System.JSON;

type
  TQUEENS_FORM = class(TUniForm)
    QueensHTML: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    procedure UniTimer1Timer(Sender: TObject);
    procedure QueensHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function QUEENS_FORM: TQUEENS_FORM;

implementation

{$R *.dfm}

// DİKKAT: Main ünitesini buraya ekledik (Rozet güncellemesi için)
uses
  MainModule, uniGUIApplication, Main;

function QUEENS_FORM: TQUEENS_FORM;
begin
  Result := TQUEENS_FORM(UniMainModule.GetFormInstance(TQUEENS_FORM));
end;

procedure TQUEENS_FORM.QueensHTMLAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  LTime, LMoves: Integer;
  LGrade, LGameType, Prefix: string;
  LIsWin: Boolean;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
begin
  if EventName = 'closePage' then
  begin
    Self.Close;
  end
  else if EventName = 'GameOver' then
  begin
    LTime := StrToIntDef(Params.Values['time'], 0);
    LMoves := StrToIntDef(Params.Values['moves'], 0);
    LGrade := Params.Values['grade'];
    LIsWin := Params.Values['isWin'] = '1';
    LGameType := Params.Values['game_type']; // 'queens' gelecek

    Prefix := 'qns'; // Queens için ana menü prefixi

    UniMainModule.StatsTable.Close;
    UniMainModule.StatsTable.SQL.Text := 'SELECT current_streak, max_streak, total_played, total_wins, streak_shields ' +
                                         'FROM user_game_stats WHERE user_id = :uid AND game_type = :gt';
    UniMainModule.StatsTable.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.StatsTable.ParamByName('gt').AsString := LGameType;
    UniMainModule.StatsTable.Open;

    if UniMainModule.StatsTable.IsEmpty then
    begin
      // --- İLK DEFA OYNUYOR (INSERT) ---
      TotPlayed := 1;
      Shields := 0;

      if LIsWin then
      begin
        CurrStreak := 1;
        MaxStreak := 1;
        TotWins := 1;
      end
      else
      begin
        CurrStreak := 0;
        MaxStreak := 0;
        TotWins := 0;
      end;

      UniMainModule.QueryExec.SQL.Text := 'INSERT INTO user_game_stats ' +
        '(user_id, game_type, current_streak, max_streak, last_played_date, total_played, total_wins, streak_shields) ' +
        'VALUES (:uid, :gt, :cs, :ms, :ld, :tp, :tw, :sh)';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.QueryExec.ParamByName('ms').AsInteger := MaxStreak;
      // YENİ: Tarih ve SAAT olarak Now kaydediliyor
      UniMainModule.QueryExec.ParamByName('ld').AsDateTime := Now;
      UniMainModule.QueryExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.QueryExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.QueryExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.QueryExec.ExecSQL;
    end
    else
    begin
      // --- DAHA ÖNCE OYNAMIŞ (UPDATE VE KALKAN MANTIĞI) ---
      CurrStreak := UniMainModule.StatsTable.FieldByName('current_streak').AsInteger;
      MaxStreak  := UniMainModule.StatsTable.FieldByName('max_streak').AsInteger;
      TotPlayed  := UniMainModule.StatsTable.FieldByName('total_played').AsInteger;
      TotWins    := UniMainModule.StatsTable.FieldByName('total_wins').AsInteger;
      Shields    := UniMainModule.StatsTable.FieldByName('streak_shields').AsInteger;

      TotPlayed := TotPlayed + 1;

      if LIsWin then
      begin
        TotWins := TotWins + 1;
        CurrStreak := CurrStreak + 1;

        if CurrStreak > MaxStreak then
          MaxStreak := CurrStreak;

        // Özel Kalkan (Shield) Ödülleri
        if CurrStreak = 30 then Shields := 2
        else if CurrStreak = 100 then Shields := 3;
      end
      else
      begin
        if Shields > 0 then
          Shields := Shields - 1
        else
          CurrStreak := 0;
      end;

      UniMainModule.QueryExec.SQL.Text := 'UPDATE user_game_stats SET current_streak = :cs, max_streak = :ms, ' +
        'total_played = :tp, total_wins = :tw, streak_shields = :sh, last_played_date = :ld ' +
        'WHERE user_id = :uid AND game_type = :gt';
      UniMainModule.QueryExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.QueryExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.QueryExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.QueryExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.QueryExec.ParamByName('sh').AsInteger := Shields;
      // YENİ: Tarih ve SAAT olarak Now güncelleniyor
      UniMainModule.QueryExec.ParamByName('ld').AsDateTime := Now;
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ExecSQL;
    end;

    // ALTIN VURUŞ: Ana Menüdeki Queens rozetini canlı olarak güncelle!
    MainForm.UpdateStreakBadge(Prefix, CurrStreak);
  end;
end;

procedure TQUEENS_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  ReqURL: string;
begin
  UniTimer1.Enabled := False;

  Client := TNetHTTPClient.Create(nil);
  try
    try
      // ÖNBELLEK KIRICI BURAYA DA EKLENDİ
      ReqURL := 'http://hasup.net:9000/api/game/queens?nocache=' + FormatDateTime('yymmddhhnnsszzz', Now);
      Response := Client.Get(ReqURL);

      if Response.StatusCode = 200 then
      begin
        JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
        if Assigned(JSONRes) then
        begin
          try
            if JSONRes.GetValue<Boolean>('success') then
            begin
              UniSession.AddJS('window.receiveQueensData(' + JSONRes.ToJSON + ');');
            end
            else
            begin
              UniSession.AddJS('alert("Harita yüklenirken hata oluştu!");');
            end;
          finally
            JSONRes.Free;
          end;
        end;
      end;
    except
      on E: Exception do
        UniSession.AddJS('alert("Sunucu bağlantı hatası: ' + E.Message + '");');
    end;
  finally
    Client.Free;
  end;
end;

end.
