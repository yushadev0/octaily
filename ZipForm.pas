unit ZipForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  uniTimer, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.JSON;

type
  TZIP_FORM = class(TUniForm)
    ZipHTML: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    procedure UniTimer1Timer(Sender: TObject);
    procedure ZipHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function ZIP_FORM: TZIP_FORM;

implementation

{$R *.dfm}

// DİKKAT: Main ünitesini rozet güncellemesi için buraya ekledik
uses
  MainModule, uniGUIApplication, Main;

function ZIP_FORM: TZIP_FORM;
begin
  Result := TZIP_FORM(UniMainModule.GetFormInstance(TZIP_FORM));
end;

procedure TZIP_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  PuzzleID: string;
  ReqURL: string;
begin
  UniTimer1.Enabled := False;
  Client := TNetHTTPClient.Create(nil);
  try
    try
      // ÖNBELLEK KIRICI (nocache) EKLENDİ
      ReqURL := 'http://hasup.net:9000/api/game/zip?nocache=' + FormatDateTime('yymmddhhnnsszzz', Now);
      Response := Client.Get(ReqURL);

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
              UniSession.AddJS('window.initZipWithServer("' + PuzzleID + '", '''
                + JSONRes.ToJSON + ''');');
            end;
          finally
            JSONRes.Free;
          end;
        end;
      end;
    except
      // Hata durumu...
    end;
  finally
    Client.Free;
  end;
end;

procedure TZIP_FORM.ZipHTMLAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  Client: TNetHTTPClient;
  PostData: TStringStream;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LGuess, ErrorMessage: string;
  // GameOver Değişkenleri
  LTime: Integer;
  LGrade, LGameType, Prefix: string;
  LIsWin: Boolean;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
begin
  // 1. Geri Dönüş Butonu
  if EventName = 'closePage' then
  begin
    MainForm.Show;
    Self.Close;
  end;

  // 2. Tahmin Gönderme ve Kontrol (POST)
  if EventName = 'SubmitGuess' then
  begin
    LGuess := Params.Values['guess'];

    Client := TNetHTTPClient.Create(nil);
    PostData := TStringStream.Create(LGuess, TEncoding.UTF8);
    try
      try
        Response := Client.Post('http://hasup.net:9000/api/guess/zip',
          PostData);

        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString)
            as TJSONObject;
          if Assigned(JSONRes) then
          begin
            try
              if JSONRes.GetValue<Boolean>('success') then
              begin
                UniSession.AddJS('window.processZipResult(true, "");');
              end
              else
              begin
                if not JSONRes.TryGetValue<string>('error', ErrorMessage) then
                  ErrorMessage := 'Yol kurallara uygun değil!';
                UniSession.AddJS('window.processZipResult(false, "' +
                  ErrorMessage + '");');
              end;
            finally
              JSONRes.Free;
            end;
          end
          else
            UniSession.AddJS
              ('window.processZipResult(false, "Geçersiz sunucu yanıtı!");');
        end
        else
        begin
          UniSession.AddJS('window.processZipResult(false, "Sunucu hatası: ' +
            IntToStr(Response.StatusCode) + '");');
        end;
      except
        on E: Exception do
          UniSession.AddJS('window.processZipResult(false, "Bağlantı hatası: ' +
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
    LGrade := Params.Values['grade'];
    LIsWin := Params.Values['isWin'] = '1';
    LGameType := Params.Values['game_type']; // 'zip' gelecek

    Prefix := 'zip'; // Zip için ana menü badge prefixi

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
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now; // DATETIME
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

        if CurrStreak >= 100 then
          Shields := 3
        else if CurrStreak >= 30 then
          Shields := 2;
      end
      else
      begin
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
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now; // DATETIME
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ExecSQL;
    end;

    // ALTIN VURUŞ: Arka planda rozeti (Badge) canlı olarak güncelle!
    if Prefix <> '' then
    begin
      MainForm.UpdateStreakBadge(Prefix, CurrStreak);
    end;

  end;

end;

end.
