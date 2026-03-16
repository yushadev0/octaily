unit LoginForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics,
  Controls, Forms, uniGUITypes, uniGUIAbstractClasses,
  uniGUIClasses, uniGUIRegClasses, uniGUIForm, uniGUIBaseClasses, uniButton,
  uniPanel, uniHTMLFrame, System.Hash, System.NetEncoding,
  DateUtils, SecretConsts, IdSMTP, IdMessage, IdSSLOpenSSL,
  IdExplicitTLSClientServerBase, Math; // Indy ve Utils eklendi!

type
  TLOGIN_FORM = class(TUniLoginForm)
    LoginHTML: TUniHTMLFrame;
    procedure UniButton1Click(Sender: TObject);
    procedure LoginHTMLAjaxEvent(Sender: TComponent; EventName: string;
      Params: TUniStrings);
    procedure UniLoginFormAfterShow(Sender: TObject);
  private
    { Private declarations }
  var
    LCookie, LSelector, LValidator, LTokenHash: string;
    LParts: TArray<string>;
  public
    { Public declarations }
  end;

function LOGIN_FORM: TLOGIN_FORM;

implementation

{$R *.dfm}

uses
  uniGUIVars, MainModule, uniGUIApplication;

function LOGIN_FORM: TLOGIN_FORM;
begin
  Result := TLOGIN_FORM(UniMainModule.GetFormInstance(TLOGIN_FORM));
end;

procedure TLOGIN_FORM.LoginHTMLAjaxEvent(Sender: TComponent; EventName: string;
  Params: TUniStrings);
var
  LMode, LUser, LPass, LEmail, LHash: string;
begin
  if EventName = 'AuthSubmit' then
  begin
    LMode := Params.Values['mode'];
    LUser := TNetEncoding.URL.Decode(Trim(Params.Values['user']));
    LEmail := TNetEncoding.URL.Decode(Trim(Params.Values['email']));
    LPass := TNetEncoding.URL.Decode(Params.Values['pass']);

    LHash := THashSHA2.GetHashString(LPass);

    // ... MEVCUT LOGIN VE REGISTER KODLARI ...
    if LMode = 'login' then
    begin
      UniMainModule.LoginTable.Close;
      UniMainModule.LoginTable.SQL.Text := 'SELECT id, username, email FROM users ' +
        'WHERE username = :user AND password_hash = :pass AND is_active = 1';
      UniMainModule.LoginTable.ParamByName('user').AsString := LUser;
      UniMainModule.LoginTable.ParamByName('pass').AsString := LHash;
      UniMainModule.LoginTable.Open;

      if not UniMainModule.LoginTable.IsEmpty then
      begin
        UniMainModule.logged_user_id := UniMainModule.LoginTable.FieldByName
          ('id').AsInteger;
        UniMainModule.logged_username := UniMainModule.LoginTable.FieldByName
          ('username').AsString;
          UniMainModule.logged_email := UniMainModule.LoginTable.FieldByName
          ('email').AsString;

        if Params.Values['remember'] = '1' then
        begin
          LSelector := THashSHA2.GetHashString(TGuid.NewGuid.ToString)
            .Substring(0, 12);
          LValidator := THashSHA2.GetHashString(TGuid.NewGuid.ToString);
          LTokenHash := THashSHA2.GetHashString(LValidator);

          UniMainModule.RegisterTable.SQL.Text :=
            'INSERT INTO user_tokens (user_id, selector, token_hash, expiry_date) '
            + 'VALUES (:uid, :sel, :hash, DATEADD(day, 30, GETDATE()))';
          UniMainModule.RegisterTable.ParamByName('uid').AsInteger :=
            UniMainModule.logged_user_id;
          UniMainModule.RegisterTable.ParamByName('sel').AsString := LSelector;
          UniMainModule.RegisterTable.ParamByName('hash').AsString :=
            LTokenHash;
          UniMainModule.RegisterTable.Execute;

          UniApplication.Cookies.SetCookie('oct_remember',
            LSelector + ':' + LValidator, Date + 30);
        end;

        Self.ModalResult := mrOK;
      end
      else
        UniSession.AddJS
          ('window.showLoginError("Kullanıcı adı veya şifre hatalı!");');
    end
    else if LMode = 'register' then
    begin
      UniMainModule.LoginTable.Close;
      UniMainModule.LoginTable.SQL.Text :=
        'SELECT id FROM users WHERE username = :u OR email = :e';
      UniMainModule.LoginTable.ParamByName('u').AsString := LUser;
      UniMainModule.LoginTable.ParamByName('e').AsString := LEmail;
      UniMainModule.LoginTable.Open;

      if not UniMainModule.LoginTable.IsEmpty then
      begin
        UniSession.AddJS
          ('window.showLoginError("Bu kullanıcı adı veya e-posta zaten kullanımda!");');
        Exit;
      end;

      try
        UniMainModule.RegisterTable.SQL.Text :=
          'INSERT INTO users (username, email, password_hash, created_at, is_active) '
          + 'VALUES (:u, :e, :p, GETDATE(), 1)';
        UniMainModule.RegisterTable.ParamByName('u').AsString := LUser;
        UniMainModule.RegisterTable.ParamByName('e').AsString := LEmail;
        UniMainModule.RegisterTable.ParamByName('p').AsString := LHash;
        UniMainModule.RegisterTable.Execute;

        UniSession.AddJS
          ('Swal.fire({title:"Harika!", text:"Hesabın oluşturuldu, şimdi giriş yapabilirsin.", icon:"success"}).then(()=>{ window.rotateCard(false); });');
      except
        on E: Exception do
          UniSession.AddJS('window.showLoginError("Kayıt hatası: ' +
            E.Message + '");');
      end;
    end

    // ===============================================
    // YENİ EKLENEN: ŞİFREMİ UNUTTUM İŞLEMLERİ
    // ===============================================
    else if LMode = 'forgot_request' then
    begin
      // 1. E-Posta var mı kontrol et
      UniMainModule.LoginTable.Close;
      UniMainModule.LoginTable.SQL.Text :=
        'SELECT id, username FROM users WHERE email = :e';
      UniMainModule.LoginTable.ParamByName('e').AsString := LEmail;
      UniMainModule.LoginTable.Open;

      if UniMainModule.LoginTable.IsEmpty then
      begin
        UniSession.AddJS
          ('window.restoreForgotAndShowError("Bu e-posta adresi sistemde kayıtlı değil!");');
        Exit;
      end;

      var
      FoundUsername := UniMainModule.LoginTable.FieldByName('username')
        .AsString;

      // 2. OTP Üret ve Mail At
      Randomize;
      UniMainModule.ResetOTP := IntToStr(RandomRange(100000, 999999));
      UniMainModule.OTPExpireTime := IncMinute(Now, 3);

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
          SMTP.Password := APP_CODE;

          MailMessage.CharSet := 'utf-8';
          MailMessage.ContentType := 'text/html; charset=utf-8';
          MailMessage.ContentTransferEncoding := 'base64';

          MailMessage.From.Address := 'info.octaily@gmail.com';
          MailMessage.From.Name := 'Octaily Destek';
          MailMessage.Recipients.Add.Address := LEmail;
          MailMessage.Subject := 'Octaily - Şifre Sıfırlama Kodunuz';

          MailMessage.Body.Text :=
            '<div style="background-color:#121213; color:#ffffff; padding:40px 20px; font-family:sans-serif; text-align:center;">'
            + '<h1 style="color:#ffffff; letter-spacing:4px; margin-bottom:10px;">OCT<span style="color:#538d4e;">AILY</span></h1>'
            + '<div style="background-color:#1a1a1b; border:1px solid #3a3a3c; border-radius:12px; padding:30px; max-width:500px; margin:0 auto;">'
            + '<h2 style="margin-top:0; font-size:1.4rem; color:#fff;">Şifre Sıfırlama Talebi</h2>'
            + '<p style="color:#818384; font-size:1rem; line-height:1.6;">Merhaba <strong>'
            + FoundUsername +
            '</strong>,<br>şifrenizi sıfırlamak için gereken 6 haneli güvenlik kodunuz aşağıdadır. Bu kod <strong>3 dakika</strong> boyunca geçerlidir.</p>'
            + '<div style="background-color:#222224; border:2px dashed #538d4e; border-radius:8px; padding:15px; font-size:2.5rem; font-weight:bold; letter-spacing:8px; margin:25px 0; color:#fff;">'
            + UniMainModule.ResetOTP + '</div>' +
            '<p style="color:#818384; font-size:0.85rem;">Eğer bu işlemi siz yapmadıysanız, lütfen bu e-postayı dikkate almayın ve hesabınızın güvenliğini kontrol edin.</p>'
            + '</div>' + '</div>';

          SMTP.Connect;
          SMTP.Send(MailMessage);
          SMTP.Disconnect;

          UniSession.AddJS('window.showOTPInput();');

        except
          on E: Exception do
           UniSession.AddJS('window.restoreForgotAndShowError("Mail gönderilemedi: ' + E.Message + '");');
        end;
      finally
        SMTP.Free;
        MailMessage.Free;
        SSLHandler.Free;
      end;
    end
    else if LMode = 'forgot_verify_otp' then
    begin
      var
      UserEnteredOTP := Params.Values['otp'];
      if Now > UniMainModule.OTPExpireTime then
        UniSession.AddJS
          ('window.showPwdError("Kodun geçerlilik süresi (3 dk) dolmuş.");')
      else if UserEnteredOTP = UniMainModule.ResetOTP then
        UniSession.AddJS
          ('if(window.otpTimerInterval) clearInterval(window.otpTimerInterval); window.showNewPasswordInput();')
      else
        UniSession.AddJS
          ('window.showPwdError("Girdiğiniz 6 haneli kod yanlış.");');
    end
    else if LMode = 'forgot_update_password' then
    begin
      // Şifreyi Güncelle (Email'e göre yapıyoruz çünkü giriş yapmamış!)
      UniMainModule.QueryExec.SQL.Text :=
        'UPDATE users SET password_hash = :p WHERE email = :e';
      UniMainModule.QueryExec.ParamByName('p').AsString := LHash;
      UniMainModule.QueryExec.ParamByName('e').AsString := LEmail;
      UniMainModule.QueryExec.ExecSQL;

      UniMainModule.ResetOTP := '';
      UniSession.AddJS('window.showPwdSuccessAndClose();');
    end;
  end;
end;

procedure TLOGIN_FORM.UniButton1Click(Sender: TObject);
begin
  ShowMessage('merhaba dünya');
end;

procedure TLOGIN_FORM.UniLoginFormAfterShow(Sender: TObject);
begin
  // ... Mevcut çerez (cookie) kontrol kodların aynen kalıyor ...
  LCookie := UniApplication.Cookies.Values['oct_remember'];

  if LCookie = '' then
  begin
    UniSession.AddJS('console.log("Cookie bulunamadı!");');
    Exit;
  end;

  LParts := LCookie.Split([':']);
  if Length(LParts) = 2 then
  begin
    LSelector := LParts[0];
    LValidator := TNetEncoding.URL.Decode(LParts[1]);
    LTokenHash := THashSHA2.GetHashString(LValidator);

    UniMainModule.LoginTable.Close;
    UniMainModule.LoginTable.SQL.Text := 'SELECT id, username,email FROM users '
      + 'WHERE id IN (SELECT user_id FROM user_tokens ' +
      '            WHERE selector = :sel AND token_hash = :hash AND expiry_date > GETDATE())';
    UniMainModule.LoginTable.ParamByName('sel').AsString := LSelector;
    UniMainModule.LoginTable.ParamByName('hash').AsString := LTokenHash;
    UniMainModule.LoginTable.Open;

    if not UniMainModule.LoginTable.IsEmpty then
    begin
      UniMainModule.logged_user_id := UniMainModule.LoginTable.FieldByName('id')
        .AsInteger;
      UniMainModule.logged_username := UniMainModule.LoginTable.FieldByName
        ('username').AsString;
      UniMainModule.logged_email := UniMainModule.LoginTable.FieldByName
        ('email').AsString;

      Self.ModalResult := mrOK;
      Exit;
    end
    else
    begin
      UniSession.AddJS
        ('console.log("DB''de eslesen veya suresi gecmemis token bulunamadi.");');
    end;
  end;
end;

initialization

RegisterAppFormClass(TLOGIN_FORM);

end.
