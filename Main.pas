unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniPanel,
  uniHTMLFrame, DateUtils, SecretConsts, IdSMTP, IdMessage, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase, Math, System.Hash;

type
  TMainForm = class(TUniForm)
    AnaSayfaHTML: TUniHTMLFrame;
    procedure AnaSayfaHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniFormAfterShow(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
    WordleLang: String;
    procedure ShowSwal(const ATitle, AMessage, AIcon: string);
    procedure UpdateStreakBadge(Prefix: String; Qnty: Integer);
  end;

function MainForm: TMainForm;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication, WordleForm, SudokuForm, QueensForm,
  NerdleForm, ZipForm, HexleForm, WorldleForm;

function MainForm: TMainForm;
begin
  Result := TMainForm(UniMainModule.GetFormInstance(TMainForm));
end;

procedure TMainForm.ShowSwal(const ATitle, AMessage, AIcon: string);
begin
  UniSession.AddJS('Swal.fire({' + '  title: "' + ATitle + '",' + '  text: "' +
    AMessage + '",' + '  icon: "' + AIcon + '",' + '  didOpen: () => {' +
    '    document.querySelector(".swal2-container").style.zIndex = 9999999;' +
    '  }' + '});');
end;

// ==========================================
// 1. ZAMAN MAKİNESİ (TEMBEL DEĞERLENDİRME) VE BADGE GÜNCELLEME
// ==========================================
procedure TMainForm.UniFormAfterShow(Sender: TObject);
var
  GameType, Prefix, RawDate: string;
  CurrentStreak, Shields, DaysDiff, MissedDays: Integer;
  LastPlayed: TDateTime;
  NeedsUpdate: Boolean;
  LYear, LMonth, LDay: Word;
begin
  UniSession.AddJS('window.updateUsername("' +
    UniMainModule.logged_username + '");');

  UniMainModule.StatsTable.Close;
  UniMainModule.StatsTable.SQL.Text :=
    'SELECT game_type, current_streak, streak_shields, last_played_date FROM user_game_stats WHERE user_id = :uid';
  UniMainModule.StatsTable.ParamByName('uid').AsInteger :=
    UniMainModule.logged_user_id;
  UniMainModule.StatsTable.Open;

  while not UniMainModule.StatsTable.Eof do
  begin
    GameType := UniMainModule.StatsTable.FieldByName('game_type').AsString;
    CurrentStreak := UniMainModule.StatsTable.FieldByName('current_streak')
      .AsInteger;
    Shields := UniMainModule.StatsTable.FieldByName('streak_shields').AsInteger;
    NeedsUpdate := False;

    if not UniMainModule.StatsTable.FieldByName('last_played_date').IsNull then
    begin
      // VERİTABANI DATETIME OLDUĞU İÇİN
      LastPlayed := UniMainModule.StatsTable.FieldByName('last_played_date')
        .AsDateTime;

      // Gece 00:00 (Trunc) bazlı gün farkı
      DaysDiff := Trunc(Now) - Trunc(LastPlayed);

      if (DaysDiff > 1) and (CurrentStreak > 0) then
      begin
        MissedDays := DaysDiff - 1;

        if Shields >= MissedDays then
        begin
          Shields := Shields - MissedDays;
        end
        else
        begin
          CurrentStreak := 0;
          Shields := 0;
        end;
        NeedsUpdate := True;
      end;
    end;

    if NeedsUpdate then
    begin
      UniMainModule.QueryExec.SQL.Text :=
        'UPDATE user_game_stats SET current_streak = :cs, streak_shields = :sh '
        + 'WHERE user_id = :uid AND game_type = :gt';
      UniMainModule.QueryExec.ParamByName('cs').AsInteger := CurrentStreak;
      UniMainModule.QueryExec.ParamByName('sh').AsInteger := Shields;
      UniMainModule.QueryExec.ParamByName('uid').AsInteger :=
        UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ParamByName('gt').AsString := GameType;
      UniMainModule.QueryExec.ExecSQL;
    end;

    Prefix := '';
    if GameType = 'wordle_tr' then
      Prefix := 'wtr'
    else if GameType = 'wordle_en' then
      Prefix := 'wen'
    else if GameType = 'sudoku' then
      Prefix := 'sdk'
    else if GameType = 'queens' then
      Prefix := 'qns'
    else if GameType = 'nerdle' then
      Prefix := 'nrd'
    else if GameType = 'zip' then
      Prefix := 'zip'
    else if GameType = 'hexle' then
      Prefix := 'hxl'
    else if GameType = 'worldle' then
      Prefix := 'wld';

    if Prefix <> '' then
      UpdateStreakBadge(Prefix, CurrentStreak);

    UniMainModule.StatsTable.Next;
  end;
  UniMainModule.StatsTable.Close;
end;

// ==========================================
// 2. BADGE (ROZET) RENGİNİ CSS İLE TETİKLEME
// ==========================================
procedure TMainForm.UpdateStreakBadge(Prefix: String; Qnty: Integer);
begin
  UniSession.AddJS('document.getElementById("val_badge_' + Prefix +
    '").innerText = "' + IntToStr(Qnty) + '";');

  if Qnty >= 100 then
    UniSession.AddJS('document.getElementById("badge_' + Prefix +
      '").className = "streak-badge tier-god";')
  else if Qnty >= 30 then
    UniSession.AddJS('document.getElementById("badge_' + Prefix +
      '").className = "streak-badge tier-3";')
  else if Qnty >= 7 then
    UniSession.AddJS('document.getElementById("badge_' + Prefix +
      '").className = "streak-badge tier-1";')
  else if Qnty > 0 then
    UniSession.AddJS('document.getElementById("badge_' + Prefix +
      '").className = "streak-badge tier-2";')
  else
    UniSession.AddJS('document.getElementById("badge_' + Prefix +
      '").className = "streak-badge";');
end;

// ==========================================
// 3. JS İLE HABERLEŞME (MODAL AÇILMA VE OYUN BAŞLATMA)
// ==========================================
procedure TMainForm.AnaSayfaHTMLAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  SelectedGame, LType: string;
  GameType, Prefix, LastDate: string;
  CurrentStreak: Integer;
begin
  // --- OYUN SEÇİMİ ---
  if EventName = 'GameSelected' then
  begin
    SelectedGame := Params.Values['game'];

    if SelectedGame = 'wordle_tr' then
    begin
      WORDLE_FORM.ShowModal;
      WordleLang := 'tr';
    end
    else if SelectedGame = 'wordle_en' then
    begin
      WORDLE_FORM.ShowModal;
      WordleLang := 'en';
    end
    else if SelectedGame = 'sudoku' then
      SUDOKU_FORM.ShowModal
    else if SelectedGame = 'queens' then
      QUEENS_FORM.ShowModal
    else if SelectedGame = 'nerdle' then
      NERDLE_FORM.ShowModal
    else if SelectedGame = 'zip' then
      ZIP_FORM.ShowModal
    else if SelectedGame = 'hexle' then
      HEXLE_FORM.ShowModal
    else if SelectedGame = 'worldle' then
      WORLDLE_FORM.ShowModal;
  end;

  // Kullanıcı adı ve Şifre Değiştirme.
  if EventName = 'SaveAccount' then
  begin
    var
    NewUser := Params.Values['user'];
    var
    NewEmail := Params.Values['email'];

    UniMainModule.QueryExec.SQL.Text :=
      'UPDATE users SET username = :u, email = :e WHERE id = :uid';
    UniMainModule.QueryExec.ParamByName('u').AsString := NewUser;
    UniMainModule.QueryExec.ParamByName('e').AsString := NewEmail;
    UniMainModule.QueryExec.ParamByName('uid').AsInteger :=
      UniMainModule.logged_user_id;
    UniMainModule.QueryExec.ExecSQL;

    UniMainModule.logged_username := NewUser;
    UniMainModule.logged_email := NewEmail;

    UniSession.AddJS('window.updateUsername("' + NewUser + '");');
    UniSession.AddJS('window.setOriginalInfo("' + NewUser + '", "' +
      NewEmail + '");');
    UniSession.AddJS
      ('document.getElementById("updateInfoBtn").innerText = "BİLGİLERİ GÜNCELLE";');
    UniSession.AddJS
      ('Swal.fire({title: "Başarılı!", text: "Hesap bilgileriniz güncellendi.", icon: "success", background: "#1a1a1b", color: "#fff", customClass: {popup: "oct-popup"}});');
  end;

  // --- KULLANICI İŞLEMLERİ (Çıkış, OTP, Dashboard Verisi) ---
  if EventName = 'UserAction' then
  begin
    LType := Params.Values['type'];

    if LType = 'logout' then
    begin
      UniApplication.Cookies.SetCookie('oct_remember', '', Date - 1, False);
      UniMainModule.logged_user_id := 0;
      UniMainModule.logged_username := '';
      UniApplication.Restart;
    end

    // OTP (Şifre Değiştir) Butonuna Tıklandıysa
    else if LType = 'otp_request' then
    begin
      // 1. Rastgele 6 haneli OTP üret ve MainModule'de sakla
      Randomize;
      UniMainModule.ResetOTP := IntToStr(RandomRange(100000, 999999));

      // 2. Indy SMTP ile Mail Gönderme İşlemi
      var
        SMTP: TIdSMTP := TIdSMTP.Create(nil);
      var
        MailMessage: TIdMessage := TIdMessage.Create(nil);
      var
        SSLHandler: TIdSSLIOHandlerSocketOpenSSL :=
          TIdSSLIOHandlerSocketOpenSSL.Create(nil);
      try
        try
          SSLHandler.SSLOptions.Method := sslvTLSv1_2;
          SSLHandler.SSLOptions.Mode := sslmClient;

          SMTP.IOHandler := SSLHandler;
          SMTP.UseTLS := utUseExplicitTLS;
          SMTP.Host := 'smtp.gmail.com';
          SMTP.Port := 587;
          SMTP.AuthType := satDefault;
          SMTP.Username := 'info.octaily@gmail.com';
          SMTP.Password := APP_CODE; // SecretConsts'tan geliyor

          // TÜRKÇE KARAKTER DESTEĞİ İÇİN (UTF-8)
          MailMessage.CharSet := 'utf-8';
          MailMessage.ContentType := 'text/html; charset=utf-8';
          MailMessage.ContentTransferEncoding := 'base64';

          // Mesaj İçeriği
          MailMessage.From.Address := 'info.octaily@gmail.com';
          MailMessage.From.Name := 'Octaily Destek';
          MailMessage.Recipients.Add.Address := UniMainModule.logged_email;
          MailMessage.Subject := 'Octaily - Şifre Sıfırlama Kodunuz';

          MailMessage.Body.Text :=
            '<div style="background-color:#121213; color:#ffffff; padding:40px 20px; font-family:sans-serif; text-align:center;">'
            + '<h1 style="color:#ffffff; letter-spacing:4px; margin-bottom:10px;">OCT<span style="color:#538d4e;">AILY</span></h1>'
            + '<div style="background-color:#1a1a1b; border:1px solid #3a3a3c; border-radius:12px; padding:30px; max-width:500px; margin:0 auto;">'
            + '<h2 style="margin-top:0; font-size:1.4rem; color:#fff;">Şifre Sıfırlama Talebi</h2>'
            + '<p style="color:#818384; font-size:1rem; line-height:1.6;">Merhaba <strong>'
            + UniMainModule.logged_username +
            '</strong>,<br>şifrenizi sıfırlamak için gereken 6 haneli güvenlik kodunuz aşağıdadır. Bu kod <strong>3 dakika</strong> boyunca geçerlidir.</p>'
            + '<div style="background-color:#222224; border:2px dashed #538d4e; border-radius:8px; padding:15px; font-size:2.5rem; font-weight:bold; letter-spacing:8px; margin:25px 0; color:#fff;">'
            + UniMainModule.ResetOTP + '</div>' +
            '<p style="color:#818384; font-size:0.85rem;">Eğer bu işlemi siz yapmadıysanız, lütfen bu e-postayı dikkate almayın ve hesabınızın güvenliğini kontrol edin.</p>'
            + '</div>' + '</div>';

          // Gönder!
          SMTP.Connect;
          SMTP.Send(MailMessage);
          SMTP.Disconnect;

          // Mail başarıyla gitti, "Bekleyin" spinner'ı yerine OTP giriş ekranını göster!
          UniSession.AddJS('window.showOTPInput();');

        except
          on E: Exception do
          begin
            // Hata durumunda Custom Modalı kapat ve klasik SweetAlert hatası göster
            UniSession.AddJS
              ('window.closePwdModal(); Swal.fire({title: "Hata!", text: "Mail gönderilemedi: '
              + E.Message +
              '", icon: "error", background: "#1a1a1b", color: "#fff", customClass: {popup: "oct-popup"}});');
          end;
        end;
      finally
        SMTP.Free;
        MailMessage.Free;
        SSLHandler.Free;
      end;
    end

    // ===============================================
    // OTP DOĞRULAMA KONTROLÜ
    // ===============================================
    else if LType = 'verify_otp' then
    begin
      var
      UserEnteredOTP := Params.Values['otp'];

      // 1. Önce sürenin dolup dolmadığına bakıyoruz
      if Now < UniMainModule.OTPExpireTime then
      begin
        UniSession.AddJS
          ('window.showPwdError("Kodun geçerlilik süresi (3 dk) dolmuş.");');
      end
      // 2. Süre geçerliyse kodu kontrol et
      else if UserEnteredOTP = UniMainModule.ResetOTP then
      begin
        // JS tarafındaki sayacı durdur ve yeni şifre ekranını aç
        UniSession.AddJS
          ('if(window.otpTimerInterval) clearInterval(window.otpTimerInterval); window.showNewPasswordInput();');
      end
      else
      begin
        UniSession.AddJS
          ('window.showPwdError("Girdiğiniz 6 haneli kod yanlış.");');
      end;
    end

    // ===============================================
    // YENİ ŞİFREYİ VERİTABANINA KAYDETME
    // ===============================================
    else if LType = 'update_password' then
    begin
      var
      NewPass := Params.Values['pass'];

      var
      HashedPass := THashSHA2.GetHashString(NewPass);

      UniMainModule.QueryExec.SQL.Text :=
        'UPDATE users SET password_hash = :p WHERE id = :uid';
      UniMainModule.QueryExec.ParamByName('p').AsString := HashedPass;
      UniMainModule.QueryExec.ParamByName('uid').AsInteger :=
        UniMainModule.logged_user_id;
      UniMainModule.QueryExec.ExecSQL;

      UniMainModule.ResetOTP := '';

      // Başarılı bitti, yeşil tik çıkar ve kapat
      UniSession.AddJS('window.showPwdSuccessAndClose();');
    end

    // ===============================================
    // HESABIM MODALI AÇILDI (İSTATİSTİKLERİ DOLDUR)
    // ===============================================
    else if LType = 'get_account_details' then
    begin
      // Kullanıcı Bilgileri
      UniSession.AddJS('window.setOriginalInfo("' +
        UniMainModule.logged_username + '", "' +
        UniMainModule.logged_email + '");');

      // Oyun İstatistikleri
      UniMainModule.StatsTable.Close;
      UniMainModule.StatsTable.SQL.Text :=
        'SELECT game_type, current_streak, max_streak, total_played, total_wins, last_played_date '
        + 'FROM user_game_stats WHERE user_id = :uid';
      UniMainModule.StatsTable.ParamByName('uid').AsInteger :=
        UniMainModule.logged_user_id;
      UniMainModule.StatsTable.Open;

      while not UniMainModule.StatsTable.Eof do
      begin
        GameType := UniMainModule.StatsTable.FieldByName('game_type').AsString;
        CurrentStreak := UniMainModule.StatsTable.FieldByName('current_streak')
          .AsInteger;
        Prefix := '';

        if GameType = 'wordle_tr' then
          Prefix := 'wtr'
        else if GameType = 'wordle_en' then
          Prefix := 'wen'
        else if GameType = 'sudoku' then
          Prefix := 'sdk'
        else if GameType = 'queens' then
          Prefix := 'qns'
        else if GameType = 'nerdle' then
          Prefix := 'nrd'
        else if GameType = 'zip' then
          Prefix := 'zip'
        else if GameType = 'hexle' then
          Prefix := 'hxl'
        else if GameType = 'worldle' then
          Prefix := 'wld';

        if Prefix <> '' then
        begin
          UniSession.AddJS('document.getElementById("st_' + Prefix +
            '_cs").innerText = "' + IntToStr(CurrentStreak) + '";');
          UniSession.AddJS('document.getElementById("st_' + Prefix +
            '_hs").innerText = "' + UniMainModule.StatsTable.FieldByName
            ('max_streak').AsString + '";');
          UniSession.AddJS('document.getElementById("st_' + Prefix +
            '_tp").innerText = "' + UniMainModule.StatsTable.FieldByName
            ('total_played').AsString + '";');

          UniSession.AddJS('var tw_el = document.getElementById("st_' + Prefix +
            '_tw"); if(tw_el) tw_el.innerText = "' +
            UniMainModule.StatsTable.FieldByName('total_wins').AsString + '";');

          if not UniMainModule.StatsTable.FieldByName('last_played_date').IsNull
          then
          begin
            LastDate := FormatDateTime('dd.MM.yyyy HH:nn',
              UniMainModule.StatsTable.FieldByName('last_played_date')
              .AsDateTime);
            UniSession.AddJS('document.getElementById("st_' + Prefix +
              '_last").innerText = "' + LastDate + '";');
          end;
        end;

        UniMainModule.StatsTable.Next;
      end;
      UniMainModule.StatsTable.Close;
    end;
  end;

end;

initialization

RegisterAppFormClass(TMainForm);

end.
