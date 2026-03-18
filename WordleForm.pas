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
  public
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
  ReqURL: string;
  LGameMode: string;
  HasPlayedToday: Boolean;
  LMoves, LTimeSec: Integer;
  LIsWin: Boolean;
begin
  UniTimer1.Enabled := False;
  HasPlayedToday := False;
  LMoves := 0;
  LTimeSec := 0;
  LIsWin := False;

  UniSession.AddJS('window.currentUserId = ' + IntToStr(UniMainModule.logged_user_id) + ';');

  if MainForm.WordleLang = 'tr' then
  begin
    LGameMode := 'wordle_tr';
    UniSession.AddJS('window.setWordleLang("tr");');
  end
  else
  begin
    LGameMode := 'wordle_en';
    UniSession.AddJS('window.setWordleLang("en");');
  end;

  UniMainModule.StatsTable.Close;
// DİKKAT: :td ve Now iptal edildi, direkt GETDATE() kullanılıyor!
  UniMainModule.StatsTable.SQL.Text :=
    'SELECT last_played_date FROM user_game_stats ' +
    'WHERE user_id = :uid AND game_type = :gt ' +
    'AND CAST(last_played_date AS DATE) = CAST(GETDATE() AS DATE)';
  UniMainModule.StatsTable.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
  UniMainModule.StatsTable.ParamByName('gt').AsString := LGameMode;
  UniMainModule.StatsTable.Open;

  if not UniMainModule.StatsTable.IsEmpty then
    HasPlayedToday := True;

  if HasPlayedToday then
  begin
    UniSession.AddJS('window.wordleGameOver = true;');

    UniMainModule.QueryExec.SQL.Text :=
      'SELECT tries, solve_time_sec, is_win FROM daily_scores ' +
      'WHERE user_id = :uid AND game_type = :gt ' +
      'AND CAST(puzzle_date AS DATE) = CAST(:td AS DATE)';
    UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.QueryExec.ParamByName('gt').AsString := LGameMode;
    UniMainModule.QueryExec.ParamByName('td').AsDateTime := Now;
    UniMainModule.QueryExec.Open;

    if not UniMainModule.QueryExec.IsEmpty then
    begin
      LMoves := UniMainModule.QueryExec.FieldByName('tries').AsInteger;
      LTimeSec := UniMainModule.QueryExec.FieldByName('solve_time_sec').AsInteger;
      LIsWin := UniMainModule.QueryExec.FieldByName('is_win').AsBoolean;
      UniSession.AddJS(Format('if(typeof window.showWordleGameOver === "function") window.showWordleGameOver(true, %d, %d, %s);', [LMoves, LTimeSec, LowerCase(BoolToStr(LIsWin, True))]));
    end
    else
    begin
      UniSession.AddJS('if(typeof window.showWordleGameOver === "function") window.showWordleGameOver(true, 0, 0, false);');
    end;

    UniMainModule.QueryExec.Close;
    UniMainModule.StatsTable.Close;
    Exit;
  end;

  UniMainModule.StatsTable.Close;

  Client := TNetHTTPClient.Create(nil);
  try
    try
      ReqURL := 'http://hasup.net:9000/api/game/' + LGameMode + '?nocache=' + FormatDateTime('yymmddhhnnsszzz', Now);
      Response := Client.Get(ReqURL);

      if Response.StatusCode = 200 then
      begin
        JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
        if Assigned(JSONRes) then
        begin
          try
            if JSONRes.GetValue<Boolean>('success') then
            begin
              if not JSONRes.TryGetValue<string>('id', PuzzleID) then PuzzleID := '';
              UniSession.AddJS('window.initWordleWithServer("' + PuzzleID + '");');
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
end;

procedure TWORDLE_FORM.WordleHTMLAjaxEvent(Sender: TComponent; EventName: string; Params: TUniStrings);
var
  Client: TNetHTTPClient;
  PostData: TStringStream;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LGuess, Prefix, LGameMode: string;
  LTime, LTries: Integer;
  LGrade, LGameType, LPayload: string;
  LIsWin: Boolean;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
begin
  if EventName = 'closePage' then
  begin
    MainForm.Show;
    Self.Close;
    Exit;
  end;

  if EventName = 'GetPanelStats' then
  begin
    LGameType := Params.Values['game_type'];

    UniMainModule.StatsTable.Close;
    // DİKKAT: CAST(GETDATE() AS DATE) KULLANILIYOR
    UniMainModule.StatsTable.SQL.Text :=
      'SELECT ISNULL(AVG(solve_time_sec), 0) AS avg_time FROM daily_scores ' +
      'WHERE game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE) AND is_win = 1';
    UniMainModule.StatsTable.ParamByName('gt').AsString := LGameType;
    UniMainModule.StatsTable.Open;
    LTime := UniMainModule.StatsTable.FieldByName('avg_time').AsInteger;

    UniMainModule.QueryExec.SQL.Text :=
      'SELECT solve_time_sec FROM daily_scores ' +
      'WHERE user_id = :uid AND game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE)';
    UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
    UniMainModule.QueryExec.Open;

    if not UniMainModule.QueryExec.IsEmpty then
      LTries := UniMainModule.QueryExec.FieldByName('solve_time_sec').AsInteger
    else
      LTries := -1;
    UniMainModule.QueryExec.Close;

    if LTries > -1 then
    begin
      UniMainModule.QueryExec.SQL.Text :=
        'SELECT COUNT(*) AS total_users, ' +
        'SUM(CASE WHEN solve_time_sec > :mytime THEN 1 ELSE 0 END) AS slower_users ' +
        'FROM daily_scores WHERE game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE) AND is_win = 1';
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('mytime').AsInteger := LTries;
      UniMainModule.QueryExec.Open;

      TotPlayed := UniMainModule.QueryExec.FieldByName('total_users').AsInteger;
      TotWins := UniMainModule.QueryExec.FieldByName('slower_users').AsInteger;

      if TotPlayed > 1 then
        CurrStreak := Round((TotWins / (TotPlayed - 1)) * 100)
      else
        CurrStreak := 100;

      UniMainModule.QueryExec.Close;
    end
    else
      CurrStreak := 0;

    LPayload := 'GİZLİ';
    Client := TNetHTTPClient.Create(nil);
    try
      try
        Response := Client.Get('http://hasup.net:9000/api/fetch_answer/' + LGameType + '/' + IntToStr(UniMainModule.logged_user_id));
        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
          if Assigned(JSONRes) then
          begin
            try
              if JSONRes.GetValue<Boolean>('success') then
                LPayload := JSONRes.GetValue<string>('answer');
            finally
              JSONRes.Free;
            end;
          end;
        end;
      except
        LPayload := 'HATA';
      end;
    finally
      Client.Free;
    end;

    UniSession.AddJS(Format('window.updatePanelStats(%d, %d, "%s");', [LTime, CurrStreak, LPayload]));
    Exit;
  end;

  if EventName = 'SubmitGuess' then
  begin
    LGuess := Params.Values['guess']; // JSON iptal, artık direkt string alıyoruz.
    if MainForm.WordleLang = 'tr' then LGameMode := 'wordle_tr' else LGameMode := 'wordle_en';

    Client := TNetHTTPClient.Create(nil);
    Client.ContentType := 'application/json';
    PostData := TStringStream.Create(LGuess, TEncoding.UTF8); // Metni saf şekilde yolluyoruz
    try
      try
        Response := Client.Post('http://hasup.net:9000/api/guess/' + LGameMode, PostData);
        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString) as TJSONObject;
          if Assigned(JSONRes) then
            try
              if JSONRes.GetValue<Boolean>('success') then
              begin
                UniSession.AddJS('window.processWordleResult(' + JSONRes.GetValue<TJSONArray>('result').ToJSON + ');');
              end
              else
                UniSession.AddJS('window.showWordleError("' + JSONRes.GetValue<string>('error') + '");');
            finally
              JSONRes.Free;
            end;
        end;
      except
        on E: Exception do UniSession.AddJS('window.showWordleError("Sunucu baglanti hatasi: ' + E.Message + '");');
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

    Prefix := '';
    if LGameType = 'wordle_tr' then Prefix := 'wtr' else if LGameType = 'wordle_en' then Prefix := 'wen';

    try
      UniMainModule.QueryExec.SQL.Text := 'DELETE FROM daily_scores WHERE user_id = :uid AND game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE)';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ExecSQL;

      // INSERT İŞLEMİNDE GETDATE() KULLANILIYOR
      UniMainModule.QueryExec.SQL.Text :=
        'INSERT INTO daily_scores (user_id, game_type, puzzle_date, is_win, solve_time_sec, tries, played_at) ' +
        'VALUES (:uid, :gt, CAST(GETDATE() AS DATE), :win, :time, :tries, GETDATE())';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('win').AsBoolean := LIsWin;
      UniMainModule.QueryExec.ParamByName('time').AsInteger := LTime;
      UniMainModule.QueryExec.ParamByName('tries').AsInteger := LTries;
      UniMainModule.QueryExec.ExecSQL;
    except
    end;

    UniMainModule.StatsTable.Close;
    UniMainModule.StatsTable.SQL.Text := 'SELECT current_streak, max_streak, total_played, total_wins, streak_shields FROM user_game_stats WHERE user_id = :uid AND game_type = :gt';
    UniMainModule.StatsTable.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.StatsTable.ParamByName('gt').AsString := LGameType;
    UniMainModule.StatsTable.Open;

    if UniMainModule.StatsTable.IsEmpty then
    begin
      TotPlayed := 1; Shields := 0;
      if LIsWin then begin CurrStreak := 1; MaxStreak := 1; TotWins := 1; end else begin CurrStreak := 0; MaxStreak := 0; TotWins := 0; end;

UniMainModule.StatsExec.SQL.Text := 'INSERT INTO user_game_stats (user_id, game_type, current_streak, max_streak, last_played_date, total_played, total_wins, streak_shields) VALUES (:uid, :gt, :cs, :ms, GETDATE(), :tp, :tw, :sh)';
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.StatsExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.StatsExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.StatsExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.StatsExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.StatsExec.ExecSQL;
    end
    else
    begin
      CurrStreak := UniMainModule.StatsTable.FieldByName('current_streak').AsInteger;
      MaxStreak := UniMainModule.StatsTable.FieldByName('max_streak').AsInteger;
      TotPlayed := UniMainModule.StatsTable.FieldByName('total_played').AsInteger;
      TotWins := UniMainModule.StatsTable.FieldByName('total_wins').AsInteger;
      Shields := UniMainModule.StatsTable.FieldByName('streak_shields').AsInteger;

      TotPlayed := TotPlayed + 1;
      if LIsWin then
      begin
        TotWins := TotWins + 1; CurrStreak := CurrStreak + 1;
        if CurrStreak > MaxStreak then MaxStreak := CurrStreak;
        if CurrStreak >= 100 then Shields := 3 else if CurrStreak >= 30 then Shields := 2;
      end
      else
      begin
        if Shields > 0 then Shields := Shields - 1 else CurrStreak := 0;
      end;

UniMainModule.StatsExec.SQL.Text := 'UPDATE user_game_stats SET current_streak = :cs, max_streak = :ms, total_played = :tp, total_wins = :tw, streak_shields = :sh, last_played_date = GETDATE() WHERE user_id = :uid AND game_type = :gt';
      UniMainModule.StatsExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.StatsExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.StatsExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.StatsExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.StatsExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.StatsExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ExecSQL;
    end;

    if Prefix <> '' then MainForm.UpdateStreakBadge(Prefix, CurrStreak);
  end;
end;

end.
