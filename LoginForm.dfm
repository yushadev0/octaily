object LOGIN_FORM: TLOGIN_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'LOGIN_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.currentCaptcha = "";'
    'var LOGIN_TAB_IDS = ["l_user", "l_pass"];'
    
      'var REG_TAB_IDS   = ["r_user", "r_email", "r_pass", "r_pass2", "' +
      'r_captcha"];'
    ''
    'window.generateCaptcha = function() {'
    
      '    var code = Math.floor(100000 + Math.random() * 900000).toStr' +
      'ing();'
    '    window.currentCaptcha = code;'
    '    var d = document.getElementById("captchaDisplay");'
    '    if (d) d.innerText = code;'
    '};'
    ''
    'window.togglePassword = function(id) {'
    '    var input = document.getElementById(id);'
    '    var icon = document.getElementById(id + '#39'_icon'#39');'
    '    if (input.type === "password") {'
    '        input.type = "text";'
    '        icon.classList.replace('#39'fa-eye-slash'#39', '#39'fa-eye'#39');'
    '        icon.style.color = '#39'#538d4e'#39';'
    '    } else {'
    '        input.type = "password";'
    '        icon.classList.replace('#39'fa-eye'#39', '#39'fa-eye-slash'#39');'
    '        icon.style.color = '#39'#818384'#39';'
    '    }'
    '};'
    ''
    'window.handleKey = function(e, type) {'
    
      '    var ids    = (type === "login") ? LOGIN_TAB_IDS : REG_TAB_ID' +
      'S;'
    '    var active = document.activeElement;'
    ''
    '    if (e.key === "Tab") {'
    '        e.preventDefault();'
    '        e.stopPropagation();'
    '        var idx = ids.indexOf(active.id);'
    '        if (idx === -1) idx = 0;'
    
      '        var nextIdx = e.shiftKey ? (idx - 1 + ids.length) % ids.' +
      'length : (idx + 1) % ids.length;'
    '        var nextEl = document.getElementById(ids[nextIdx]);'
    '        if (nextEl) nextEl.focus();'
    '        return;'
    '    }'
    
      '    if (active.id === "chkLabel" && (e.key === " " || e.key === ' +
      '"Enter")) {'
    '        e.preventDefault();'
    '        var c = document.getElementById("chkRemember");'
    '        if (c) c.checked = !c.checked;'
    '        return;'
    '    }'
    '    if (e.key === "Enter") {'
    '        if (type === "login" || type === "register") {'
    '            window.submitAuth(type);'
    '        }'
    '    }'
    '};'
    ''
    'window.rotateCard = function(toRegister) {'
    '    var card     = document.getElementById("loginCard");'
    '    var front    = document.getElementById("faceFront");'
    '    var back     = document.getElementById("faceBack");'
    '    var cntFront = document.getElementById("cntFront");'
    '    var cntBack  = document.getElementById("cntBack");'
    ''
    '    if (toRegister) {'
    '        window.generateCaptcha();'
    '        cntFront.classList.remove("active-content");'
    '        window.manageTabOrder(true);'
    '        setTimeout(function() {'
    '            card.classList.add("flipped");'
    '            setTimeout(function() {'
    '                card.style.height = back.offsetHeight + "px";'
    '                setTimeout(function() {'
    '                    cntBack.classList.add("active-content");'
    '                    var f = document.getElementById("r_user");'
    '                    if (f) f.focus();'
    '                }, 500);'
    '            }, 600);'
    '        }, 400);'
    '    } else {'
    '        cntBack.classList.remove("active-content");'
    '        window.manageTabOrder(false);'
    '        setTimeout(function() {'
    '            card.style.height = front.offsetHeight + "px";'
    '            setTimeout(function() {'
    '                card.classList.remove("flipped");'
    '                setTimeout(function() {'
    '                    cntFront.classList.add("active-content");'
    '                    var f = document.getElementById("l_user");'
    '                    if (f) f.focus();'
    '                }, 600);'
    '            }, 500);'
    '        }, 400);'
    '    }'
    '};'
    ''
    'window.manageTabOrder = function(toRegister) {'
    '    var login = document.querySelectorAll(".login-item");'
    '    var reg = document.querySelectorAll(".reg-item");'
    '    login.forEach(function(el) {'
    
      '        if (toRegister) { el.dataset.tab = el.tabIndex; el.tabIn' +
      'dex = -1; } '
    
      '        else { if (el.dataset.tab) el.tabIndex = el.dataset.tab;' +
      ' }'
    '    });'
    '    reg.forEach(function(el) {'
    
      '        if (toRegister) { el.dataset.tab = el.tabIndex; el.tabIn' +
      'dex = 0; } '
    '        else { el.tabIndex = -1; }'
    '    });'
    '};'
    ''
    'window.clearInlineErrors = function() {'
    '    var errs = document.querySelectorAll('#39'.inline-error'#39');'
    
      '    errs.forEach(function(el) { el.style.display = '#39'none'#39'; el.in' +
      'nerText = '#39#39'; });'
    '};'
    ''
    'window.showInlineError = function(inputId, msg) {'
    '    var errEl = document.getElementById(inputId + '#39'_err'#39');'
    '    if (errEl) {'
    '        errEl.innerText = msg;'
    '        errEl.style.display = '#39'block'#39';'
    '    }'
    '    var inputEl = document.getElementById(inputId);'
    '    if (inputEl) window.shakeInputs([inputEl]);'
    '};'
    ''
    'window.submitAuth = function(mode) {'
    '    window.clearInlineErrors(); '
    '    '
    '    var u, p, p2, e, r, c;'
    '    if (mode === "login") {'
    '        u = document.getElementById("l_user");'
    '        p = document.getElementById("l_pass");'
    '        r = document.getElementById("chkRemember").checked;'
    
      '        if (!u.value || !p.value) { window.shakeInputs([u, p]); ' +
      'return; }'
    '    } else {'
    '        u  = document.getElementById("r_user");'
    '        e  = document.getElementById("r_email");'
    '        p  = document.getElementById("r_pass");'
    '        p2 = document.getElementById("r_pass2");'
    '        c  = document.getElementById("r_captcha");'
    '        '
    
      '        if (!u.value || !e.value || !p.value || !p2.value || !c.' +
      'value) { '
    '            window.shakeInputs([u, e, p, p2, c]); '
    '            return; '
    '        }'
    ''
    '        var usernameRegex = /^[a-zA-Z'#287#252#351#305#246#231#286#220#350#304#214#199'0-9_]{3,20}$/;'
    '        if (!usernameRegex.test(u.value.trim())) {'
    
      '            window.showInlineError("r_user", "En az 3 karakter. ' +
      'Harf, rakam veya _ kullan'#305'n. Bo'#351'luk olamaz.");'
    '            return;'
    '        }'
    ''
    '        var emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;'
    '        if (!emailRegex.test(e.value.trim())) {'
    
      '            window.showInlineError("r_email", "L'#252'tfen ge'#231'erli bi' +
      'r e-posta adresi girin.");'
    '            return;'
    '        }'
    ''
    '        if (p.value !== p2.value) { '
    
      '            window.showInlineError("r_pass2", "'#350'ifreler uyu'#351'muyo' +
      'r!"); '
    '            return; '
    '        }'
    '        '
    '        if (c.value !== window.currentCaptcha) { '
    
      '            window.showInlineError("r_captcha", "Do'#287'rulama kodu ' +
      'hatal'#305'!"); '
    '            window.generateCaptcha(); '
    '            c.value = ""; '
    '            return; '
    '        }'
    '    }'
    '    '
    '    if (typeof ajaxRequest !== "undefined") {'
    '        ajaxRequest(LOGIN_FORM.LoginHTML, "AuthSubmit", ['
    '            "mode="     + mode,'
    '            "user="     + encodeURIComponent(u.value),'
    '            "pass="     + encodeURIComponent(p.value),'
    
      '            "email="    + (e ? encodeURIComponent(e.value) : "")' +
      ','
    '            "remember=" + (r ? "1" : "0")'
    '        ]);'
    '    }'
    '};'
    ''
    'window.shakeInputs = function(arr) {'
    '    arr.forEach(function(el) {'
    '        if (el) {'
    '            el.classList.remove("shake");'
    '            void el.offsetWidth;'
    '            el.classList.add("shake");'
    '        }'
    '    });'
    '};'
    ''
    'window.showLoginError = function(msg) {'
    
      '    var swal = (typeof Swal !== "undefined") ? Swal : (window.pa' +
      'rent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (swal) {'
    
      '        swal.fire({ title: "HATA", text: msg, icon: "error", bac' +
      'kground: "#1a1a1b", color: "#fff", confirmButtonColor: "#538d4e"' +
      ', confirmButtonText: "TAMAM" });'
    '    } else { alert(msg); }'
    '};'
    ''
    'window.updateInitialHeight = function() {'
    '    var card  = document.getElementById("loginCard");'
    '    var front = document.getElementById("faceFront");'
    
      '    if (card && front) { card.style.height = front.offsetHeight ' +
      '+ "px"; }'
    '};'
    ''
    'window.addEventListener("load", function() {'
    '    window.updateInitialHeight();'
    '    var u = document.getElementById("l_user");'
    '    if (u) u.focus();'
    '});'
    'window.addEventListener("resize", window.updateInitialHeight);'
    ''
    '// ========================================='
    '// '#350#304'FREM'#304' UNUTTUM S'#220'REC'#304' EKLENT'#304'LER'#304
    '// ========================================='
    'window.closePwdModal = function() {'
    '    var modal = document.getElementById('#39'pwdResetModal'#39');'
    '    if (modal) modal.classList.remove('#39'active'#39');'
    
      '    if (window.otpTimerInterval) clearInterval(window.otpTimerIn' +
      'terval); '
    '};'
    ''
    'window.addEventListener('#39'click'#39', function(event) {'
    '    const pwdModal = document.getElementById('#39'pwdResetModal'#39');'
    
      '    if (pwdModal && event.target === pwdModal) { window.closePwd' +
      'Modal(); }'
    '});'
    'window.addEventListener('#39'keydown'#39', function(e) {'
    '    if (e.key === "Escape") { window.closePwdModal(); }'
    '});'
    ''
    'window.restoreForgotAndShowError = function(msg) {'
    '    window.handleForgot(); '
    '    '
    '    setTimeout(function() {'
    '        window.showPwdError(msg);'
    '        var inp = document.getElementById('#39'forgot_email_input'#39');'
    '        if(inp && window.resetEmail) {'
    '            inp.value = window.resetEmail;'
    '        }'
    '    }, 50);'
    '};'
    ''
    'window.handleForgot = function() {'
    '    var modal = document.getElementById('#39'pwdResetModal'#39');'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "'#350#304'FREM'#304' UNUTTUM";'
    '    body.innerHTML = '
    
      '        '#39'<p style="color:#a1a1aa; font-size:0.95rem; margin-bott' +
      'om:20px; line-height:1.5;">'#39' +'
    
      '        '#39'Kay'#305'tl'#305' e-posta adresinizi girin. Size bir <strong>OTP ' +
      'kodu</strong> g'#246'nderece'#287'iz.</p>'#39' +'
    
      '        '#39'<input id="forgot_email_input" class="modal-input" type' +
      '="email" placeholder="E-Posta Adresiniz" style="margin-bottom: 1' +
      '5px; text-align:center;">'#39' +'
    
      '        '#39'<p id="pwdModalError" style="color:#e74c3c; font-size:0' +
      '.85rem; margin-bottom:15px; display:none; font-weight:600;"></p>' +
      #39' +'
    
      '        '#39'<button class="modal-save-btn" onclick="window.requestP' +
      'asswordResetLogin()">KOD G'#214'NDER</button>'#39';'
    '    '
    '    modal.classList.add('#39'active'#39'); '
    
      '    setTimeout(function() { var inp = document.getElementById('#39'f' +
      'orgot_email_input'#39'); if(inp) inp.focus(); }, 300);'
    '};'
    ''
    'window.requestPasswordResetLogin = function() {'
    
      '    var email = document.getElementById('#39'forgot_email_input'#39').va' +
      'lue;'
    '    if (!email || email.trim() === '#39#39') {'
    '        window.showPwdError("L'#252'tfen e-posta adresinizi girin.");'
    '        return;'
    '    }'
    '    '
    '    // '#304#351'lemin devam'#305'nda kullanmak i'#231'in maili haf'#305'zaya al'#305'yoruz'
    '    window.resetEmail = email.trim();'
    ''
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "L'#220'TFEN BEKLEY'#304'N";'
    
      '    body.innerHTML = '#39'<div class="oct-spinner"></div><p style="c' +
      'olor:#818384; font-size:0.95rem; margin-top:15px;">E-posta adres' +
      'iniz kontrol ediliyor ve kod g'#246'nderiliyor...</p>'#39';'
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(LOGIN_FORM.LoginHTML, '#39'AuthSubmit'#39', ['#39'mode=f' +
      'orgot_request'#39', '#39'email='#39' + encodeURIComponent(window.resetEmail)' +
      ']);'
    '    }'
    '};'
    ''
    'window.showOTPInput = function() {'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "G'#220'VENL'#304'K KODU";'
    '    body.innerHTML = '
    
      '        '#39'<p style="color:#a1a1aa; font-size:0.9rem; margin-botto' +
      'm:15px; line-height:1.5;">E-posta adresinize g'#246'nderilen<br>6 han' +
      'eli do'#287'rulama kodunu girin:</p>'#39' +'
    
      '        '#39'<input id="custom-otp-input" class="modal-input" type="' +
      'text" maxlength="6" autocomplete="off" style="text-align: center' +
      '; font-size: 1.6rem; letter-spacing: 8px; font-weight: 800; marg' +
      'in-bottom: 10px;">'#39' +'
    
      '        '#39'<div id="otpTimerDisplay" style="color:#b59f3b; font-we' +
      'ight:bold; font-size:1.1rem; margin-bottom:15px; font-variant-nu' +
      'meric: tabular-nums;">03:00</div>'#39' +'
    
      '        '#39'<p id="pwdModalError" style="color:#e74c3c; font-size:0' +
      '.85rem; margin-bottom:15px; display:none; font-weight:600;"></p>' +
      #39' +'
    
      '        '#39'<button class="modal-save-btn" id="otpSubmitBtn" style=' +
      '"margin-top:5px;" onclick="window.submitOTP()">DO'#286'RULA</button>'#39 +
      ';'
    '    '
    
      '    setTimeout(function() { var inp = document.getElementById('#39'c' +
      'ustom-otp-input'#39'); if(inp) inp.focus(); }, 300);'
    '    window.startOTPTimer(180); '
    '};'
    ''
    'window.startOTPTimer = function(duration) {'
    
      '    if (window.otpTimerInterval) clearInterval(window.otpTimerIn' +
      'terval);'
    '    var timer = duration, minutes, seconds;'
    '    var display = document.getElementById('#39'otpTimerDisplay'#39');'
    '    var inp = document.getElementById('#39'custom-otp-input'#39');'
    '    var btn = document.getElementById('#39'otpSubmitBtn'#39');'
    ''
    '    window.otpTimerInterval = setInterval(function () {'
    '        minutes = parseInt(timer / 60, 10);'
    '        seconds = parseInt(timer % 60, 10);'
    ''
    '        minutes = minutes < 10 ? "0" + minutes : minutes;'
    '        seconds = seconds < 10 ? "0" + seconds : seconds;'
    ''
    
      '        if(display) display.textContent = minutes + ":" + second' +
      's;'
    ''
    '        if (--timer < 0) {'
    '            clearInterval(window.otpTimerInterval);'
    
      '            if(display) { display.textContent = "S'#220'RE DOLDU"; di' +
      'splay.style.color = "#e74c3c"; }'
    '            if(inp) inp.disabled = true;'
    '            if(btn) {'
    '                btn.innerText = "TEKRAR G'#214'NDER";'
    '                btn.style.backgroundColor = "#3a3a3c";'
    '                btn.onclick = window.requestPasswordResetLogin; '
    '            }'
    
      '            window.showPwdError("Kodun ge'#231'erlilik s'#252'resi doldu."' +
      ');'
    '        }'
    '    }, 1000);'
    '};'
    ''
    'window.submitOTP = function() {'
    '    var otp = document.getElementById('#39'custom-otp-input'#39').value;'
    
      '    if (!otp || otp.length !== 6) { window.showPwdError("L'#252'tfen ' +
      '6 haneli kodu eksiksiz girin."); return; }'
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        document.querySelector('#39'#pwdResetModal .modal-save-btn'#39')' +
      '.innerText = "KONTROL ED'#304'L'#304'YOR...";'
    
      '        ajaxRequest(LOGIN_FORM.LoginHTML, '#39'AuthSubmit'#39', ['#39'mode=f' +
      'orgot_verify_otp'#39', '#39'otp='#39' + otp]);'
    '    }'
    '};'
    ''
    'window.showPwdError = function(msg) {'
    '    var err = document.getElementById('#39'pwdModalError'#39');'
    
      '    if(err) { err.innerText = msg; err.style.display = "block"; ' +
      '}'
    '    '
    
      '    var modalContent = document.querySelector('#39'#pwdResetModal .o' +
      'ct-modal-content'#39');'
    
      '    if(modalContent) { modalContent.classList.remove('#39'shake'#39'); v' +
      'oid modalContent.offsetWidth; modalContent.classList.add('#39'shake'#39 +
      '); }'
    '    '
    
      '    var btn = document.querySelector('#39'#pwdResetModal .modal-save' +
      '-btn'#39');'
    
      '    if(btn && btn.innerText === "KONTROL ED'#304'L'#304'YOR...") btn.inner' +
      'Text = "DO'#286'RULA";'
    
      '    if(btn && btn.innerText === "G'#220'NCELLEN'#304'YOR...") btn.innerTex' +
      't = "'#350#304'FREY'#304' G'#220'NCELLE";'
    
      '    if(btn && btn.innerText === "KOD G'#214'NDER'#304'L'#304'YOR...") btn.inner' +
      'Text = "KOD G'#214'NDER";'
    '};'
    ''
    'window.showNewPasswordInput = function() {'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "YEN'#304' '#350#304'FRE";'
    '    body.innerHTML = '
    
      '        '#39'<p style="color:#a1a1aa; font-size:0.9rem; margin-botto' +
      'm:20px;">L'#252'tfen yeni '#351'ifrenizi belirleyin<br>(En az 6 karakter):' +
      '</p>'#39' +'
    '        '#39'<div style="position:relative; margin-bottom:15px;">'#39' +'
    
      '            '#39'<input id="new-pass1" class="modal-input" type="pas' +
      'sword" placeholder="Yeni '#350'ifre" style="padding-right:40px;">'#39' +'
    
      '            '#39'<i id="new-pass1_icon" class="fa-solid fa-eye-slash' +
      ' toggle-password" style="bottom:12px;" onclick="window.togglePas' +
      'sword(\'#39'new-pass1\'#39')"></i>'#39' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div style="position:relative; margin-bottom:10px;">'#39' +'
    
      '            '#39'<input id="new-pass2" class="modal-input" type="pas' +
      'sword" placeholder="Yeni '#350'ifreyi Onayla" style="padding-right:40' +
      'px;">'#39' +'
    
      '            '#39'<i id="new-pass2_icon" class="fa-solid fa-eye-slash' +
      ' toggle-password" style="bottom:12px;" onclick="window.togglePas' +
      'sword(\'#39'new-pass2\'#39')"></i>'#39' +'
    '        '#39'</div>'#39' +'
    
      '        '#39'<p id="pwdModalError" style="color:#e74c3c; font-size:0' +
      '.85rem; margin-bottom:15px; display:none; font-weight:600;"></p>' +
      #39' +'
    
      '        '#39'<button class="modal-save-btn" onclick="window.submitNe' +
      'wPassword()">'#350#304'FREY'#304' G'#220'NCELLE</button>'#39';'
    '};'
    ''
    'window.submitNewPassword = function() {'
    '    var p1 = document.getElementById('#39'new-pass1'#39').value;'
    '    var p2 = document.getElementById('#39'new-pass2'#39').value;'
    '    '
    
      '    if (!p1 || p1.length < 6) { window.showPwdError("'#350'ifreniz en' +
      ' az 6 karakter olmal'#305'!"); return; }'
    
      '    if (p1 !== p2) { window.showPwdError("'#350'ifreler birbiriyle uy' +
      'u'#351'muyor!"); return; }'
    '    '
    
      '    document.getElementById('#39'pwdModalError'#39').style.display = "no' +
      'ne";'
    
      '    document.querySelector('#39'#pwdResetModal .modal-save-btn'#39').inn' +
      'erText = "G'#220'NCELLEN'#304'YOR...";'
    ''
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(LOGIN_FORM.LoginHTML, '#39'AuthSubmit'#39', ['#39'mode=f' +
      'orgot_update_password'#39', '#39'email='#39' + encodeURIComponent(window.res' +
      'etEmail), '#39'pass='#39' + encodeURIComponent(p1)]);'
    '    }'
    '};'
    ''
    'window.showPwdSuccessAndClose = function() {'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "BA'#350'ARILI";'
    
      '    body.innerHTML = '#39'<i class="fa-solid fa-circle-check" style=' +
      '"font-size:3.5rem; color:var(--classic-accent-color); margin: 20' +
      'px 0;"></i>'#39' +'
    
      '                     '#39'<p style="color:#ffffff; font-size:1.1rem;' +
      ' font-weight:600;">'#350'ifreniz ba'#351'ar'#305'yla g'#252'ncellendi!<br>'#350'imdi giri' +
      #351' yapabilirsiniz.</p>'#39';'
    '    '
    '    setTimeout(function() { window.closePwdModal(); }, 2500);'
    '};')
  OnAfterShow = UniLoginFormAfterShow
  TextHeight = 15
  object LoginHTML: TUniHTMLFrame
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Hint = ''
    HTML.Strings = (
      '<style>'
      '   /* ========================================='
      '      MASA'#220'ST'#220' VE GENEL CSS (KES'#304'NL'#304'KLE DOKUNULMADI)'
      '      ========================================= */'
      
        '   input { font-size: 16px !important; } /* Safari Auto-Zoom Eng' +
        'eli */'
      '   * { -webkit-tap-highlight-color: transparent; }'
      ''
      
        '   .login-viewport { position:fixed; top:0; left:0; width:100vw;' +
        ' height:100vh; background:#121213; display:flex; justify-content' +
        ':center; align-items:center; font-family:'#39'Segoe UI'#39',Tahoma,Genev' +
        'a,Verdana,sans-serif; color:#fff; z-index:9999; perspective:1500' +
        'px; padding: 20px; box-sizing: border-box; }'
      
        '   .login-card-inner { position:relative; width: 420px; transiti' +
        'on:transform .6s cubic-bezier(.4,0,.2,1),height .5s cubic-bezier' +
        '(.4,0,.2,1); transform-style:preserve-3d; }'
      '   .flipped { transform:rotateY(180deg) }'
      
        '   .card-face { position:absolute; width:100%; background:#1a1a1' +
        'b; border:1px solid #3a3a3c; border-radius:16px; padding:35px 45' +
        'px; box-sizing:border-box; box-shadow:0 10px 40px rgba(0,0,0,.6)' +
        '; display:flex; flex-direction:column; top:0; left:0; backface-v' +
        'isibility:hidden; }'
      '   .card-back { transform:rotateY(180deg) }'
      
        '   .face-content { opacity:0; pointer-events:none; visibility:hi' +
        'dden; transition:opacity .4s; }'
      
        '   .active-content { opacity:1; pointer-events:auto; visibility:' +
        'visible; }'
      
        '   h1 { font-size:2.2rem; letter-spacing:4px; font-weight:900; m' +
        'argin-bottom:20px; text-align:center; }'
      '   h1 span { color:#538d4e }'
      
        '   .input-group { margin-bottom:15px; text-align:left; position:' +
        'relative; }'
      
        '   .input-group label { display:block; color:#818384; font-size:' +
        '.8rem; margin-bottom:5px; font-weight:600; text-transform:upperc' +
        'ase; }'
      
        '   .login-input { width:100%; background:#3a3a3c; border:2px sol' +
        'id #3a3a3c; color:#fff; padding:12px 15px; border-radius:8px; ou' +
        'tline:none; transition:border-color .2s; box-sizing:border-box; ' +
        '}'
      '   .pass-input { padding-right: 40px !important; }'
      
        '   .toggle-password { position: absolute; right: 15px; bottom: 1' +
        '2px; color: #818384; cursor: pointer; z-index: 10; transition: c' +
        'olor .2s; }'
      
        '   .login-input:focus { border-color:#b59f3b; box-shadow:0 0 0 2' +
        'px rgba(181,159,59,.2) }'
      
        '   .login-options { display:flex; justify-content:space-between;' +
        ' align-items:center; margin-bottom:20px; flex-wrap: wrap; gap: 1' +
        '0px; }'
      
        '   .custom-checkbox { display:flex; align-items:center; gap:10px' +
        '; cursor:pointer; color:#818384; font-size:.85rem; outline:none;' +
        ' }'
      '   .custom-checkbox input { display:none }'
      
        '   .checkmark { width:34px; height:18px; background:#3a3a3c; bor' +
        'der-radius:20px; position:relative; transition:.3s; }'
      
        '   .checkmark::after { content:""; position:absolute; width:14px' +
        '; height:14px; background:#818384; border-radius:50%; top:2px; l' +
        'eft:2px; transition:.3s; }'
      
        '   .custom-checkbox input:checked+.checkmark { background:#538d4' +
        'e }'
      
        '   .custom-checkbox input:checked+.checkmark::after { left:18px;' +
        ' background:#fff }'
      
        '   .forgot-link { color:#b59f3b; text-decoration:none; font-weig' +
        'ht:600; cursor:pointer; font-size:.85rem; outline:none; }'
      '   .captcha-row { display:flex; gap:10px; align-items:center; }'
      
        '   .captcha-display { background:repeating-linear-gradient(45deg' +
        ',#2a2a2b,#2a2a2b 10px,#323233 10px,#323233 20px); color:#538d4e;' +
        ' font-family:monospace; font-weight:900; font-size:1.3rem; width' +
        ':130px; height:42px; display:flex; align-items:center; justify-c' +
        'ontent:center; border-radius:8px; border:1px solid #3a3a3c; lett' +
        'er-spacing:2px; user-select:none; font-style:italic; }'
      
        '   .login-btn { width:100%; background:#538d4e; color:#fff; bord' +
        'er:none; padding:14px; border-radius:8px; font-size:1.1rem; font' +
        '-weight:bold; cursor:pointer; transition:.2s; }'
      
        '   .switch-mode { margin-top:20px; color:#818384; font-size:.9re' +
        'm; text-align:center; }'
      
        '   .switch-mode a { color:#fff; font-weight:bold; cursor:pointer' +
        '; text-decoration:underline; }'
      '   .shake { animation:shake .5s }'
      
        '   @keyframes shake { 10%,90%{transform:translateX(-1px)} 20%,80' +
        '%{transform:translateX(2px)} 40%,60%{transform:translateX(-4px)}' +
        ' }'
      ''
      '   /* SADECE MOUSE KULLANILAN C'#304'HAZLAR '#304#199#304'N HOVER */'
      '   @media (hover: hover) and (pointer: fine) {'
      '       .toggle-password:hover { color: #fff; }'
      '       .login-btn:hover { background:#467a42 }'
      '   }'
      ''
      '   /* --- '#350#304'FRE SIFIRLAMA MODALI '#304#199#304'N EKLENEN CSS'#39'LER --- */'
      
        '   .oct-modal-overlay { position: fixed; top: 0; left: 0; width:' +
        ' 100%; height: 100%; background: rgba(0, 0, 0, 0.85); backdrop-f' +
        'ilter: blur(8px); display: flex; justify-content: center; align-' +
        'items: center; z-index: 11000; opacity: 0; visibility: hidden; t' +
        'ransition: opacity 0.3s ease, visibility 0.3s ease; padding: 15p' +
        'x; box-sizing: border-box;}'
      
        '   .oct-modal-overlay.active { opacity: 1; visibility: visible; ' +
        '}'
      
        '   .oct-modal-content { background: #161618; width: 100%; max-wi' +
        'dth: 420px; border-radius: 20px; border: 1px solid #333; display' +
        ': flex; flex-direction: column; transform: scale(0.9); opacity: ' +
        '0; transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1),' +
        ' opacity 0.3s ease; text-align: center; }'
      
        '   .oct-modal-overlay.active .oct-modal-content { transform: sca' +
        'le(1); opacity: 1; }'
      
        '   .modal-header { padding: 18px 25px; background: #1a1a1c; disp' +
        'lay: flex; justify-content: center; align-items: center; border-' +
        'bottom: 1px solid #2a2a2c; border-top-left-radius: 19px; border-' +
        'top-right-radius: 19px; position: relative; }'
      
        '   .modal-header h2 { margin: 0; font-size: 1.25rem; color: #538' +
        'd4e; font-weight: 800; }'
      
        '   .close-modal { position: absolute; right: 20px; color: #666; ' +
        'cursor: pointer; font-size: 1.4rem; transition: 0.2s; }'
      
        '   @media (hover: hover) and (pointer: fine) { .close-modal:hove' +
        'r { color: #fff; } .modal-save-btn:hover { background: #467a42; ' +
        'transform: translateY(-2px); } }'
      
        '   .modal-body { padding: 30px; max-height: 80vh; overflow-y: au' +
        'to; }'
      
        '   .modal-input { width: 100%; background: #222224; border: 1px ' +
        'solid #3a3a3c; color: #fff; padding: 12px; border-radius: 8px; o' +
        'utline: none; transition: 0.2s; box-sizing: border-box; font-siz' +
        'e: 16px !important;}'
      
        '   .modal-input:focus { border-color: #538d4e; background: #1a1a' +
        '1c; }'
      
        '   .modal-save-btn { width: 100%; background: #538d4e; color: #f' +
        'ff; border: none; padding: 15px; border-radius: 10px; font-weigh' +
        't: 800; font-size: 0.95rem; cursor: pointer; transition: 0.3s; m' +
        'argin-top: 10px;}'
      
        '   .oct-spinner { border: 4px solid rgba(255, 255, 255, 0.1); bo' +
        'rder-left-color: #538d4e; border-radius: 50%; width: 45px; heigh' +
        't: 45px; animation: spin 1s linear infinite; margin: 20px auto; ' +
        '}'
      '   @keyframes spin { 100% { transform: rotate(360deg); } }'
      ''
      '   .inline-error { '
      '       color: #e74c3c; '
      '       font-size: 0.75rem; '
      '       position: absolute; '
      '       top: 100%; '
      '       left: 0; '
      '       margin-top: 2px; '
      '       display: none; '
      '       font-weight: 600; '
      '       text-align: left;'
      '       z-index: 10;'
      '   }'
      ''
      ''
      '   /* ========================================='
      '      MOB'#304'L: YUKARIDAN 45PX BO'#350'LUKLA SAB'#304'TLEME'
      '      ========================================= */'
      '   @media (max-width: 768px) {'
      '       body, html {'
      '           height: 100% !important;'
      '           width: 100% !important;'
      '           margin: 0 !important;'
      '           padding: 0 !important;'
      '           background-color: #121213 !important; '
      '       }'
      ''
      '       .login-viewport {'
      '           position: fixed !important;'
      '           top: 0 !important;'
      '           left: 0 !important;'
      '           width: 100vw !important;'
      '           height: 100vh !important;'
      '           display: flex !important;'
      
        '           justify-content: center !important; /* Yatayda ortala' +
        ' */'
      
        '           align-items: flex-start !important; /* D'#304'KEYDE YUKARI' +
        ' YASLA! */'
      
        '           padding: 45px 15px 20px 15px !important; /* '#220'stten 45' +
        'px, yanlardan 15px bo'#351'luk b'#305'rak */'
      '           margin: 0 !important;'
      
        '           overflow-y: auto !important; /* Ekran k'#252#231#252'l'#252'rse (klav' +
        'ye) kayd'#305'r'#305'labilsin */'
      '           background: #121213 !important;'
      '       }'
      ''
      '       .login-card-inner {'
      '           width: 100% !important;'
      '           max-width: 400px !important;'
      
        '           margin: 0 !important; /* Zaten flexbox yukar'#305'da ve or' +
        'tada tutuyor */'
      '       }'
      ''
      '       .card-face {'
      '           padding: 30px 25px !important;'
      
        '           max-height: none !important; /* K'#305's'#305'tlamay'#305' kald'#305'rd'#305'k' +
        ', form rahat'#231'a uzas'#305'n */'
      '       }'
      ''
      
        '       h1 { font-size: 1.8rem !important; margin-bottom: 15px !i' +
        'mportant; }'
      '       .input-group { margin-bottom: 12px !important; }'
      '       .captcha-display { width: 110px; font-size: 1.1rem; }'
      '   }'
      '</style>'
      ''
      '<div class="login-viewport">'
      '   <div id="loginCard" class="login-card-inner">'
      '      <div id="faceFront" class="card-face">'
      '         <div id="cntFront" class="face-content active-content">'
      '            <h1>OCT<span>AILY</span></h1>'
      '            <div class="input-group">'
      '               <label>Kullan'#305'c'#305' Ad'#305'</label>'
      
        '               <input id="l_user" class="login-input login-item"' +
        ' onkeydown="window.handleKey(event,'#39'login'#39')">'
      '            </div>'
      '            <div class="input-group">'
      '               <label>'#350'ifre</label>'
      
        '               <input type="password" id="l_pass" class="login-i' +
        'nput login-item pass-input" onkeydown="window.handleKey(event,'#39'l' +
        'ogin'#39')">'
      
        '               <i id="l_pass_icon" class="fa-solid fa-eye-slash ' +
        'toggle-password" onclick="window.togglePassword('#39'l_pass'#39')"></i>'
      '            </div>'
      '            <div class="login-options">'
      
        '               <label id="chkLabel" class="custom-checkbox login' +
        '-item" onkeydown="window.handleKey(event,'#39'login'#39')">'
      
        '                  <input type="checkbox" id="chkRemember"> <span' +
        ' class="checkmark"></span> Oturum a'#231#305'k kals'#305'n'
      '               </label>'
      
        '               <a id="l_forgot" class="forgot-link login-item" o' +
        'nclick="window.handleForgot()">'#350'ifremi unuttum</a>'
      '            </div>'
      
        '            <button id="l_submit" class="login-btn login-item" o' +
        'nclick="window.submitAuth('#39'login'#39')">G'#304'R'#304#350' YAP</button>'
      
        '            <div class="switch-mode">Hesab'#305'n yok mu? <a id="l_sw' +
        'itchReg" class="login-item" onclick="window.rotateCard(true)">He' +
        'men Kay'#305't Ol</a></div>'
      '         </div>'
      '      </div>'
      '      <div id="faceBack" class="card-face card-back">'
      '         <div id="cntBack" class="face-content">'
      '            <h1>KAYIT<span> OL</span></h1>'
      '            <div class="input-group">'
      '               <label>Kullan'#305'c'#305' Ad'#305'</label>'
      
        '               <input id="r_user" class="login-input reg-item" o' +
        'nkeydown="window.handleKey(event,'#39'register'#39')">'
      '               <div id="r_user_err" class="inline-error"></div>'
      '            </div>'
      '            <div class="input-group">'
      '               <label>E-Posta</label>'
      
        '               <input id="r_email" class="login-input reg-item" ' +
        'onkeydown="window.handleKey(event,'#39'register'#39')">'
      '               <div id="r_email_err" class="inline-error"></div>'
      '            </div>'
      '            <div class="input-group">'
      '               <label>'#350'ifre</label>'
      
        '               <input type="password" id="r_pass" class="login-i' +
        'nput reg-item pass-input" onkeydown="window.handleKey(event,'#39'reg' +
        'ister'#39')">'
      
        '               <i id="r_pass_icon" class="fa-solid fa-eye-slash ' +
        'toggle-password" onclick="window.togglePassword('#39'r_pass'#39')"></i>'
      '            </div>'
      '            <div class="input-group">'
      '               <label>'#350'ifre Tekrar</label>'
      
        '               <input type="password" id="r_pass2" class="login-' +
        'input reg-item pass-input" onkeydown="window.handleKey(event,'#39're' +
        'gister'#39')">'
      
        '               <i id="r_pass2_icon" class="fa-solid fa-eye-slash' +
        ' toggle-password" onclick="window.togglePassword('#39'r_pass2'#39')"></i' +
        '>'
      '               <div id="r_pass2_err" class="inline-error"></div>'
      '            </div>'
      '            <div class="input-group">'
      '               <label>Do'#287'rulama Kodu</label>'
      '               <div class="captcha-row">'
      
        '                  <input id="r_captcha" class="login-input reg-i' +
        'tem" maxlength="6" onkeydown="window.handleKey(event,'#39'register'#39')' +
        '">'
      
        '                  <div id="captchaDisplay" class="captcha-displa' +
        'y">000000</div>'
      '               </div>'
      
        '               <div id="r_captcha_err" class="inline-error"></di' +
        'v>'
      '            </div>'
      
        '            <button id="r_submit" class="login-btn reg-item" onc' +
        'lick="window.submitAuth('#39'register'#39')">HESABIMI OLU'#350'TUR</button>'
      
        '            <div class="switch-mode">Zaten '#252'ye misin? <a id="r_s' +
        'witchLog" class="reg-item" onclick="window.rotateCard(false)">Gi' +
        'ri'#351' Yap</a></div>'
      '         </div>'
      '      </div>'
      '   </div>'
      ''
      '   <div class="oct-modal-overlay" id="pwdResetModal">'
      '       <div class="oct-modal-content">'
      '           <div class="modal-header">'
      '               <h2 id="pwdModalTitle">'#350#304'FRE '#304#350'LEMLER'#304'</h2>'
      
        '               <i class="fa-solid fa-xmark close-modal" onclick=' +
        '"window.closePwdModal()"></i>'
      '           </div>'
      '           <div class="modal-body" id="pwdModalBody">'
      '           </div>'
      '       </div>'
      '   </div>'
      '</div>')
    Align = alClient
    OnAjaxEvent = LoginHTMLAjaxEvent
  end
end
