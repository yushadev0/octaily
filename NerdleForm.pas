unit NerdleForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  System.Net.URLClient, System.Net.HttpClient, System.Net.HttpClientComponent,
  System.JSON, uniTimer;

type
  TNERDLE_FORM = class(TUniForm)
    NerdleHTML: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    procedure NerdleHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniTimer1Timer(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function NERDLE_FORM: TNERDLE_FORM;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;

function NERDLE_FORM: TNERDLE_FORM;
begin
  Result := TNERDLE_FORM(UniMainModule.GetFormInstance(TNERDLE_FORM));
end;

procedure TNERDLE_FORM.NerdleHTMLAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  Client: TNetHTTPClient;
  PostData: TStringStream;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LGuess: string;
  // GameOver Değişkenleri
  LTime, LTries: Integer;
  LGrade, LGameType, Prefix: string;
  LIsWin: Boolean;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
begin

  if EventName = 'closePage' then
  begin
    MainForm.Show;
    Self.Close;
  end;

  if EventName = 'SubmitGuess' then
  begin
    LGuess := Params.Values['guess'];

    Client := TNetHTTPClient.Create(nil);
    PostData := TStringStream.Create(LGuess, TEncoding.UTF8);
    try
      try
        Response := Client.Post('http://hasup.net:9000/api/guess/nerdle',
          PostData);

        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString)
            as TJSONObject;
          if Assigned(JSONRes) then
            try
              if JSONRes.GetValue<Boolean>('success') then
              begin
                UniSession.AddJS('window.processNerdleResult(' +
                  JSONRes.GetValue<TJSONArray>('result').ToJSON + ');');
              end
              else
              begin
                UniSession.AddJS('window.showNerdleError("' +
                  JSONRes.GetValue<string>('error') + '");');
              end;
            finally
              JSONRes.Free;
            end;
        end
        else
        begin
          UniSession.AddJS('window.showNerdleError("Sunucu hatası: ' +
            IntToStr(Response.StatusCode) + '");');
        end;
      except
        on E: Exception do
          UniSession.AddJS('window.showNerdleError("Sunucu bağlantı hatası: ' +
            E.Message + '");');
      end;
    finally
      PostData.Free;
      Client.Free;
    end;
  end;

  // 3. Oyun Sonu Kaydı (Veritabanı Entegrasyonu)
  if EventName = 'GameOver' then
  begin
    LTime := StrToIntDef(Params.Values['time'], 0);
    LTries := StrToIntDef(Params.Values['tries'], 0);
    LGrade := Params.Values['grade'];
    LIsWin := Params.Values['isWin'] = '1';
    LGameType := Params.Values['game_type']; // 'nerdle' gelecek

    Prefix := 'nrd'; // Nerdle ana menü badge prefixi

    // Veritabanından mevcut statları çek
    UniMainModule.StatsTable.Close;
    UniMainModule.StatsTable.SQL.Text :=
      'SELECT current_streak, max_streak, total_played, total_wins, streak_shields '
      + 'FROM user_game_stats WHERE user_id = :uid AND game_type = :gt';
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

      UniMainModule.StatsExec.SQL.Text := 'INSERT INTO user_game_stats ' +
        '(user_id, game_type, current_streak, max_streak, last_played_date, total_played, total_wins, streak_shields) '
        + 'VALUES (:uid, :gt, :cs, :ms, :ld, :tp, :tw, :sh)';
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.StatsExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now; // DATETIME olarak Now kullanılıyor
      UniMainModule.StatsExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.StatsExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.StatsExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.StatsExec.ExecSQL;
    end
    else
    begin
      // --- DAHA ÖNCE OYNAMIŞ (UPDATE VE KALKAN MANTIĞI) ---
      CurrStreak := UniMainModule.StatsTable.FieldByName('current_streak').AsInteger;
      MaxStreak := UniMainModule.StatsTable.FieldByName('max_streak').AsInteger;
      TotPlayed := UniMainModule.StatsTable.FieldByName('total_played').AsInteger;
      TotWins := UniMainModule.StatsTable.FieldByName('total_wins').AsInteger;
      Shields := UniMainModule.StatsTable.FieldByName('streak_shields').AsInteger;

      TotPlayed := TotPlayed + 1;

      if LIsWin then
      begin
        TotWins := TotWins + 1;
        CurrStreak := CurrStreak + 1;

        if CurrStreak > MaxStreak then
          MaxStreak := CurrStreak;

        // Özel Kalkan (Shield) Ödülleri
        if CurrStreak >= 100 then
          Shields := 3
        else if CurrStreak >= 30 then
          Shields := 2;
      end
      else
      begin
        // Kaybetme Durumu: Kalkan varsa koru, yoksa sıfırla
        if Shields > 0 then
          Shields := Shields - 1
        else
          CurrStreak := 0;
      end;

      UniMainModule.StatsExec.SQL.Text :=
        'UPDATE user_game_stats SET current_streak = :cs, max_streak = :ms, ' +
        'total_played = :tp, total_wins = :tw, streak_shields = :sh, last_played_date = :ld '
        + 'WHERE user_id = :uid AND game_type = :gt';
      UniMainModule.StatsExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.StatsExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.StatsExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.StatsExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.StatsExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now;
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ExecSQL;
    end;

    // ALTIN VURUŞ: Arka planda Nerdle rozetini (Badge) canlı olarak güncelle!
    if Prefix <> '' then
    begin
      MainForm.UpdateStreakBadge(Prefix, CurrStreak);
    end;

  end;

end;

procedure TNERDLE_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  PuzzleID: string;
begin
  UniTimer1.Enabled := False;

  Client := TNetHTTPClient.Create(nil);
  try
    try
      // ÖNBELLEK KIRICI (nocache) EKLENDİ
      Response := Client.Get('http://hasup.net:9000/api/game/nerdle?nocache=' + FormatDateTime('yymmddhhnnsszzz', Now));

      if Response.StatusCode = 200 then
      begin
        JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString)
          as TJSONObject;
        if Assigned(JSONRes) then
        begin
          try
            if JSONRes.GetValue<Boolean>('success') then
            begin
              if not JSONRes.TryGetValue<string>('id', PuzzleID) then
                PuzzleID := '';

              UniSession.AddJS('window.initNerdleWithServer("' +
                PuzzleID + '");');
            end
            else
              UniSession.AddJS('window.initNerdleWithServer("");');
          finally
            JSONRes.Free;
          end;
        end;
      end;
    except
      UniSession.AddJS('window.initNerdleWithServer("");');
    end;
  finally
    Client.Free;
  end;
end;

end.
