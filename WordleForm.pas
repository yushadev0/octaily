unit WordleForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  System.Net.HttpClient, System.JSON, System.Net.URLClient,
  System.Net.HttpClientComponent, uniTimer;

type
  TWORDLE_FORM = class(TUniForm)
    WordleHTML: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    procedure WordleHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniTimer1Timer(Sender: TObject);
    procedure UniFormShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function WORDLE_FORM: TWORDLE_FORM;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;

function WORDLE_FORM: TWORDLE_FORM;
begin
  Result := TWORDLE_FORM(UniMainModule.GetFormInstance(TWORDLE_FORM));
end;

procedure TWORDLE_FORM.UniFormShow(Sender: TObject);
begin
  UniTimer1.Enabled := True;
end;

procedure TWORDLE_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  PuzzleID: string;
  ReqURL: string; // Dinamik URL'mizi tutacak değişken
begin
  if MainForm.WordleLang = 'tr' then
  begin
    UniSession.AddJS
      ('document.getElementById("wordleTitle").textContent = "WORDLE TÜRKÇE";');
    UniSession.AddJS('window.setWordleLang("tr");');
  end
  else
  begin
    UniSession.AddJS
      ('document.getElementById("wordleTitle").textContent = "WORDLE İNGİLİZCE";');
    UniSession.AddJS('window.setWordleLang("en");');
  end;

  Client := TNetHTTPClient.Create(nil);
  try
    try
      ReqURL := 'http://hasup.net:9000/api/game/wordle_' + MainForm.WordleLang +
        '?nocache=' + FormatDateTime('yymmddhhnnsszzz', Now);

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

              UniSession.AddJS('window.initWordleWithServer("' +
                PuzzleID + '");');
            end
            else
              UniSession.AddJS('window.initWordleWithServer("");');
          finally
            JSONRes.Free;
          end;
        end;
      end;
    except
      UniSession.AddJS('window.initWordleWithServer("");');
    end;
  finally
    Client.Free;
  end;

  UniTimer1.Enabled := False;
end;

procedure TWORDLE_FORM.WordleHTMLAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  Client: TNetHTTPClient;
  PostData: TStringStream;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LGuess, Prefix: string;
  LGameMode: string;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
  LTime, LTries: Integer;
  LGrade, LGameType: string;
  LIsWin: Boolean;
begin
  if EventName = 'closePage' then
  begin
    MainForm.Show;
    Self.Close;
  end;

  if EventName = 'SubmitGuess' then
  begin
    LGuess := Params.Values['guess'];

    if MainForm.WordleLang = 'tr' then
    begin
      LGameMode := 'wordle_tr';
    end
    else
    begin
      LGameMode := 'wordle_en';
    end;

    Client := TNetHTTPClient.Create(nil);
    PostData := TStringStream.Create(LGuess, TEncoding.UTF8);
    try
      try
        // Kendi canlı API sunucuna POST atıyorsun!
        Response := Client.Post('http://hasup.net:9000/api/guess/' + LGameMode,
          PostData);

        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString)
            as TJSONObject;
          if Assigned(JSONRes) then
            try
              // API'den "success": true geldiyse
              if JSONRes.GetValue<Boolean>('success') then
              begin
                // result dizisini (JSON Array) doğrudan JS fonksiyonuna parametre olarak fırlatıyoruz
                UniSession.AddJS('window.processWordleResult(' +
                  JSONRes.GetValue<TJSONArray>('result').ToJSON + ');');
              end
              else
              begin
                // API'den "Kelime bulunamadı" gibi bir hata döndüyse
                UniSession.AddJS('window.showWordleError("' +
                  JSONRes.GetValue<string>('error') + '");');
              end;
            finally
              JSONRes.Free;
            end;
        end;
      except
        on E: Exception do
          UniSession.AddJS('window.showWordleError("Sunucu bağlantı hatası: ' +
            E.Message + '");');
      end;
    finally
      PostData.Free;
      Client.Free;
    end;
  end;

  if EventName = 'GameOver' then
  begin
    LTime := StrToIntDef(Params.Values['time'], 0);
    LTries := StrToIntDef(Params.Values['tries'], 0);
    LGrade := Params.Values['grade'];
    LIsWin := Params.Values['isWin'] = '1';
    LGameType := Params.Values['game_type'];
    // 'wordle_tr' veya 'wordle_en' gelecek

    // 1. Ana menü rozetini (Badge) güncellemek için Prefix'i belirliyoruz
    Prefix := '';
    if LGameType = 'wordle_tr' then
      Prefix := 'wtr'
    else if LGameType = 'wordle_en' then
      Prefix := 'wen';

    // 2. Kullanıcının mevcut istatistiklerini veritabanından çek
    UniMainModule.StatsTable.Close;
    UniMainModule.StatsTable.SQL.Text :=
      'SELECT current_streak, max_streak, total_played, total_wins, streak_shields '
      + 'FROM user_game_stats WHERE user_id = :uid AND game_type = :gt';
    UniMainModule.StatsTable.ParamByName('uid').AsInteger :=
      UniMainModule.logged_user_id;
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
      // DÜZELTİLDİ: QueryExec değil StatsExec olacak
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now;
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

      TotPlayed := TotPlayed + 1; // Oynama sayısı her halükarda artar

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
      // DÜZELTİLDİ: QueryExec değil StatsExec olacak
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now;
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ExecSQL;
    end;

    // 3. ALTIN VURUŞ: Arka planda rozeti (Badge) canlı olarak güncelle!
    if Prefix <> '' then
    begin
      MainForm.UpdateStreakBadge(Prefix, CurrStreak);
    end;

  end;

end;

end.
