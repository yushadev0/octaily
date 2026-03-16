unit WorldleForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIForm, uniGUIBaseClasses, uniPanel, uniHTMLFrame,
  uniTimer, System.JSON, System.Net.URLClient, System.Net.HttpClient,
  System.Net.HttpClientComponent, System.StrUtils;

type
  TWORLDLE_FORM = class(TUniForm)
    WorldleHTML: TUniHTMLFrame;
    UniTimer1: TUniTimer;
    procedure UniTimer1Timer(Sender: TObject);
    procedure WorldleHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

function WORLDLE_FORM: TWORLDLE_FORM;

implementation

{$R *.dfm}

uses
  MainModule, uniGUIApplication, Main;

function WORLDLE_FORM: TWORLDLE_FORM;
begin
  Result := TWORLDLE_FORM(UniMainModule.GetFormInstance(TWORLDLE_FORM));
end;

procedure TWORLDLE_FORM.UniTimer1Timer(Sender: TObject);
var
  Client: TNetHTTPClient;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LCountriesArr: TJSONArray;
  PuzzleID, ObfuscatedISO: string;
begin
  UniTimer1.Enabled := False;
  Client := TNetHTTPClient.Create(nil);
  try
    try
      Response := Client.Get('http://hasup.net:9000/api/game/worldle');

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
              if not JSONRes.TryGetValue<string>('iso', ObfuscatedISO) then
                ObfuscatedISO := '';

              LCountriesArr := JSONRes.GetValue<TJSONArray>('countries');

              if Assigned(LCountriesArr) then
              begin
                // YENİ YÖNTEM: Ülke listesini güvenli bir şekilde global JS değişkenine ata
                UniSession.AddJS('window.OCTAILY_WORLDLE_DATA = ' +
                  LCountriesArr.ToJSON + ';');
              end
              else
                UniSession.AddJS('window.OCTAILY_WORLDLE_DATA = [];');

              // SONRA: Sadece basit string parametrelerle init fonksiyonunu çağır!
              UniSession.AddJS('window.initWorldleWithServer("' + PuzzleID +
                '", "' + ObfuscatedISO + '");');
            end
            else
              UniSession.AddJS('alert("Worldle verisi alınamadı!");');
          finally
            JSONRes.Free;
          end;
        end;
      end;
    except
      on E: Exception do
        UniSession.AddJS('alert("Bağlantı hatası: ' + E.Message + '");');
    end;
  finally
    Client.Free;
  end;
end;

procedure TWORLDLE_FORM.WorldleHTMLAjaxEvent(Sender: TComponent;
  EventName: string; Params: TUniStrings);
var
  Client: TNetHTTPClient;
  PostData: TStringStream;
  Response: IHTTPResponse;
  JSONRes: TJSONObject;
  LGuess, ErrorMessage: string;
  LTime, LTries: Integer;
  LGrade, LGameType, Prefix: string;
  LIsWin: Boolean;
  CurrStreak, MaxStreak, TotPlayed, TotWins, Shields: Integer;
begin
  // 1. GERİ DÖNÜŞ BUTONU
  if EventName = 'closePage' then
  begin
    Self.Close;
    MainForm.Show; // Kendi ana menü formuna göre burayı düzenle
    Exit;
  end;

  // 2. TAHMİN KONTROLÜ (ENTER'A BASILDIĞINDA VEYA BUTONA TIKLANDIĞINDA)
  if EventName = 'SubmitGuess' then
  begin
    LGuess := Params.Values['guess']; // Örn: 'TÜRKİYE' veya 'TURKIYE'

    Client := TNetHTTPClient.Create(nil);
    PostData := TStringStream.Create(LGuess, TEncoding.UTF8);
    try
      try
        // Kendi sunucunun Worldle POST (Kontrol) endpointi
        Response := Client.Post('http://hasup.net:9000/api/guess/worldle',
          PostData);

        if Response.StatusCode = 200 then
        begin
          JSONRes := TJSONObject.ParseJSONValue(Response.ContentAsString)
            as TJSONObject;
          if Assigned(JSONRes) then
          begin
            try
              // SUNUCU TAHMİNİ KABUL ETTİ VE YANIT DÖNDÜ
              if JSONRes.GetValue<Boolean>('success') then
              begin
                // DİKKAT: Worldle'da Dizi (Array) değil, direkt Obje (Object) dönüyoruz.
                // İçinde country_name, distance, direction, proximity var.
                UniSession.AddJS('window.processWorldleResult(' +
                  JSONRes.ToJSON + ');');
              end
              // TAHMİN BULUNAMADI (Örn: Yanlış veya olmayan ülke ismi girildi)
              else
              begin
                if not JSONRes.TryGetValue<string>('error', ErrorMessage) then
                  ErrorMessage := 'Ülke bulunamadı!';
                UniSession.AddJS('window.showWorldleError("' +
                  ErrorMessage + '");');
              end;
            finally
              JSONRes.Free;
            end;
          end
          else
            UniSession.AddJS
              ('window.showWorldleError("Geçersiz sunucu yanıtı!");');
        end
        else
          UniSession.AddJS('window.showWorldleError("Sunucu bağlantı hatası (' +
            IntToStr(Response.StatusCode) + ')");');
      except
        on E: Exception do
          UniSession.AddJS('window.showWorldleError("Bağlantı hatası: ' +
            E.Message + '");');
      end;
    finally
      PostData.Free;
      Client.Free;
    end;
  end;

  // 3. OYUN BİTİŞİ VE VERİTABANI KAYDI
  if EventName = 'GameOver' then
  begin
    LTime := StrToIntDef(Params.Values['time'], 0);
    LTries := StrToIntDef(Params.Values['tries'], 0);
    LGrade := Params.Values['grade'];
    LGameType := Params.Values['game_type']; // 'worldle'

    Prefix := 'wld';

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
      // İLK DEFA OYNUYOR (Oyun bittiği için kesin zafer)
      UniMainModule.StatsExec.SQL.Text := 'INSERT INTO user_game_stats ' +
        '(user_id, game_type, current_streak, max_streak, last_played_date, total_played, total_wins, streak_shields) '
        + 'VALUES (:uid, :gt, 1, 1, :ld, 1, 1, 0)';
      UniMainModule.StatsExec.ParamByName('uid').AsInteger :=
        UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ParamByName('ld').AsDateTime := Now;
      UniMainModule.StatsExec.ExecSQL;

      CurrStreak := 1;
    end
    else
    begin
      // DAHA ÖNCE OYNAMIŞ (Kesin zafer olduğu için seriler direkt artar)
      CurrStreak := UniMainModule.StatsTable.FieldByName('current_streak')
        .AsInteger;
      MaxStreak := UniMainModule.StatsTable.FieldByName('max_streak').AsInteger;
      TotPlayed := UniMainModule.StatsTable.FieldByName('total_played')
        .AsInteger;
      TotWins := UniMainModule.StatsTable.FieldByName('total_wins').AsInteger;
      Shields := UniMainModule.StatsTable.FieldByName('streak_shields')
        .AsInteger;

      TotPlayed := TotPlayed + 1;
      TotWins := TotWins + 1;
      CurrStreak := CurrStreak + 1;

      if CurrStreak > MaxStreak then
        MaxStreak := CurrStreak;

      // Özel Kalkan Ödülleri
      if CurrStreak >= 100 then
        Shields := 3
      else if CurrStreak >= 30 then
        Shields := 2;

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
      UniMainModule.StatsExec.ParamByName('uid').AsInteger :=
        UniMainModule.logged_user_id;
      UniMainModule.StatsExec.ParamByName('gt').AsString := LGameType;
      UniMainModule.StatsExec.ExecSQL;
    end;

    // ALTIN VURUŞ: Rozeti Güncelle
    if Prefix <> '' then
      MainForm.UpdateStreakBadge(Prefix, CurrStreak);
  end;

end;

end.
