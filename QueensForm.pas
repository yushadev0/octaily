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
  public
  end;

function QUEENS_FORM: TQUEENS_FORM;

implementation

{$R *.dfm}

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
    Exit;
  end;

  if EventName = 'GetPanelStats' then
  begin
    LGameType := Params.Values['game_type'];

    UniMainModule.StatsTable.Close;
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
      LMoves := UniMainModule.QueryExec.FieldByName('solve_time_sec').AsInteger
    else
      LMoves := -1;
    UniMainModule.QueryExec.Close;

    if LMoves > -1 then
    begin
      UniMainModule.QueryExec.SQL.Text :=
        'SELECT COUNT(*) AS total_users, ' +
        'SUM(CASE WHEN solve_time_sec > :mytime THEN 1 ELSE 0 END) AS slower_users ' +
        'FROM daily_scores WHERE game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE) AND is_win = 1';
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('mytime').AsInteger := LMoves;
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

    UniSession.AddJS(Format('window.updatePanelStats(%d, %d);', [LTime, CurrStreak]));
    Exit;
  end;

  if EventName = 'GameOver' then
  begin
    LTime := StrToIntDef(Params.Values['time'], 0);
    LMoves := StrToIntDef(Params.Values['moves'], 0);
    LGrade := Params.Values['grade'];
    LIsWin := Params.Values['isWin'] = '1';
    LGameType := Params.Values['game_type'];
    Prefix := 'qns';

    try
      UniMainModule.QueryExec.SQL.Text := 'DELETE FROM daily_scores WHERE user_id = :uid AND game_type = :gt AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE)';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ExecSQL;

      UniMainModule.QueryExec.SQL.Text :=
        'INSERT INTO daily_scores (user_id, game_type, puzzle_date, is_win, solve_time_sec, tries, played_at) ' +
        'VALUES (:uid, :gt, CAST(GETDATE() AS DATE), :win, :time, :tries, GETDATE())';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('win').AsBoolean := LIsWin;
      UniMainModule.QueryExec.ParamByName('time').AsInteger := LTime;
      UniMainModule.QueryExec.ParamByName('tries').AsInteger := LMoves;
      UniMainModule.QueryExec.ExecSQL;
    except
    end;

    UniMainModule.StatsTable.Close;
    UniMainModule.StatsTable.SQL.Text := 'SELECT current_streak, max_streak, total_played, total_wins, streak_shields ' +
                                         'FROM user_game_stats WHERE user_id = :uid AND game_type = :gt';
    UniMainModule.StatsTable.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.StatsTable.ParamByName('gt').AsString := LGameType;
    UniMainModule.StatsTable.Open;

    if UniMainModule.StatsTable.IsEmpty then
    begin
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
        'VALUES (:uid, :gt, :cs, :ms, GETDATE(), :tp, :tw, :sh)';
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.QueryExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.QueryExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.QueryExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.QueryExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.QueryExec.ExecSQL;
    end
    else
    begin
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
        'total_played = :tp, total_wins = :tw, streak_shields = :sh, last_played_date = GETDATE() ' +
        'WHERE user_id = :uid AND game_type = :gt';
      UniMainModule.QueryExec.ParamByName('cs').AsInteger := CurrStreak;
      UniMainModule.QueryExec.ParamByName('ms').AsInteger := MaxStreak;
      UniMainModule.QueryExec.ParamByName('tp').AsInteger := TotPlayed;
      UniMainModule.QueryExec.ParamByName('tw').AsInteger := TotWins;
      UniMainModule.QueryExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.QueryExec.ExecSQL;
    end;

    MainForm.UpdateStreakBadge(Prefix, CurrStreak);
  end;
end;

procedure TQUEENS_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  ReqURL: string;
  HasPlayedToday: Boolean;
  LMoves, LTimeSec: Integer;
begin
  UniTimer1.Enabled := False;
  HasPlayedToday := False;
  LMoves := 0;
  LTimeSec := 0;

  UniMainModule.StatsTable.Close;
  UniMainModule.StatsTable.SQL.Text :=
    'SELECT last_played_date FROM user_game_stats ' +
    'WHERE user_id = :uid AND game_type = ''queens'' ' +
    'AND CAST(last_played_date AS DATE) = CAST(GETDATE() AS DATE)';
  UniMainModule.StatsTable.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
  UniMainModule.StatsTable.Open;

  if not UniMainModule.StatsTable.IsEmpty then
    HasPlayedToday := True;

  if HasPlayedToday then
  begin
    UniSession.AddJS('window.isQueensCompleted = true;');

    UniMainModule.QueryExec.SQL.Text :=
      'SELECT tries, solve_time_sec FROM daily_scores ' +
      'WHERE user_id = :uid AND game_type = ''queens'' ' +
      'AND CAST(puzzle_date AS DATE) = CAST(GETDATE() AS DATE)';
    UniMainModule.QueryExec.ParamByName('uid').AsInteger := UniMainModule.logged_user_id;
    UniMainModule.QueryExec.Open;

    if not UniMainModule.QueryExec.IsEmpty then
    begin
      LMoves := UniMainModule.QueryExec.FieldByName('tries').AsInteger;
      LTimeSec := UniMainModule.QueryExec.FieldByName('solve_time_sec').AsInteger;
      UniSession.AddJS(Format('if(typeof window.showQueensGameOver === "function") window.showQueensGameOver(true, %d, %d);', [LMoves, LTimeSec]));
    end
    else
    begin
      UniSession.AddJS('if(typeof window.showQueensGameOver === "function") window.showQueensGameOver(true, 0, 0);');
    end;
    UniMainModule.QueryExec.Close;
    UniMainModule.StatsTable.Close;
    Exit;
  end;

  UniMainModule.StatsTable.Close;

  Client := TNetHTTPClient.Create(nil);
  try
    try
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
    end;
  finally
    Client.Free;
  end;
end;

end.
