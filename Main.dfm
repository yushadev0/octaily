object MainForm: TMainForm
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'MainForm'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.openGame = function(gameCode) {'
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(MainForm.AnaSayfaHTML, '#39'GameSelected'#39', ['#39'gam' +
      'e='#39' + gameCode]);'
    '    }'
    '};'
    ''
    'window.toggleUserMenu = function(e) {'
    '    if (e) e.stopPropagation();'
    '    const dropdown = document.getElementById('#39'userDropdown'#39');'
    '    const trigger = document.getElementById('#39'profileTrigger'#39');'
    '    '
    '    if (dropdown && trigger) {'
    '        dropdown.classList.toggle('#39'show'#39');'
    '        trigger.classList.toggle('#39'active'#39');'
    '    }'
    '};'
    ''
    'window.toggleGameRules = function(event, gameCode) {'
    '    if (event) event.stopPropagation();'
    ''
    
      '    const wrapper = document.getElementById('#39'wrapper_'#39' + gameCod' +
      'e);'
    '    const container = document.getElementById('#39'mainContainer'#39');'
    
      '    const viewport = document.querySelector('#39'.octaily-viewport'#39')' +
      ';'
    '    const isExpanding = !wrapper.classList.contains('#39'expanded'#39');'
    ''
    '    if (isExpanding) {'
    '        const rect = wrapper.getBoundingClientRect();'
    '        const centerX = window.innerWidth / 2;'
    '        const centerY = window.innerHeight / 2;'
    '        const cardCenterX = rect.left + rect.width / 2;'
    '        const cardCenterY = rect.top + rect.height / 2;'
    '        '
    
      '        wrapper.style.setProperty('#39'--tx'#39', (centerX - cardCenterX' +
      ') + '#39'px'#39');'
    
      '        wrapper.style.setProperty('#39'--ty'#39', (centerY - cardCenterY' +
      ') + '#39'px'#39');'
    ''
    '        container.classList.add('#39'card-active'#39');'
    '        wrapper.classList.add('#39'expanded'#39');'
    '        viewport.style.overflowY = '#39'hidden'#39'; '
    '        window.changeRulePage(gameCode, 1); '
    '    } else {'
    '        container.classList.remove('#39'card-active'#39');'
    '        wrapper.classList.remove('#39'expanded'#39');'
    '        viewport.style.overflowY = '#39'auto'#39';'
    '        '
    '        setTimeout(() => {'
    '            if(!wrapper.classList.contains('#39'expanded'#39')) {'
    '                wrapper.style.removeProperty('#39'--tx'#39');'
    '                wrapper.style.removeProperty('#39'--ty'#39');'
    '            }'
    '        }, 600);'
    '    }'
    '};'
    ''
    'window.changeRulePage = function(gameCode, action, event) {'
    '    if (event) event.stopPropagation(); '
    '    '
    
      '    const pages = document.querySelectorAll('#39'#wrapper_'#39' + gameCo' +
      'de + '#39' .rule-page'#39');'
    
      '    const dots = document.querySelectorAll('#39'#wrapper_'#39' + gameCod' +
      'e + '#39' .dot'#39');'
    ''
    '    if (pages.length > 0) {'
    '        let currentIndex = 0;'
    '        '
    '        pages.forEach((page, index) => {'
    '            if (page.classList.contains('#39'active'#39')) {'
    '                currentIndex = index;'
    '            }'
    '            page.classList.remove('#39'active'#39');'
    '            dots[index].classList.remove('#39'active'#39');'
    '        });'
    ''
    '        let newIndex = currentIndex;'
    '        if (action === '#39'prev'#39') {'
    
      '            newIndex = currentIndex > 0 ? currentIndex - 1 : pag' +
      'es.length - 1; '
    '        } else if (action === '#39'next'#39') {'
    
      '            newIndex = currentIndex < pages.length - 1 ? current' +
      'Index + 1 : 0; '
    '        } else {'
    '            newIndex = action - 1; '
    '        }'
    ''
    '        pages[newIndex].classList.add('#39'active'#39');'
    '        dots[newIndex].classList.add('#39'active'#39');'
    '    }'
    '};'
    ''
    'window.handleUserAction = function(action) {'
    '    const dropdown = document.getElementById('#39'userDropdown'#39');'
    '    const trigger = document.getElementById('#39'profileTrigger'#39');'
    '    if (dropdown) dropdown.classList.remove('#39'show'#39');'
    '    if (trigger) trigger.classList.remove('#39'active'#39');'
    '    '
    '    if (action === '#39'account'#39') {'
    '        window.openAccountPopup();'
    '    } else if (action === '#39'logout'#39') {'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '            ajaxRequest(MainForm.AnaSayfaHTML, '#39'UserAction'#39', ['#39't' +
      'ype=logout'#39']);'
    '        }'
    '    }'
    '};'
    ''
    'window.openAccountPopup = function() {'
    '    const modal = document.getElementById('#39'accountModal'#39');'
    '    if (modal) {'
    '        modal.classList.add('#39'active'#39');'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '            ajaxRequest(MainForm.AnaSayfaHTML, '#39'UserAction'#39', ['#39't' +
      'ype=get_account_details'#39']);'
    '        }'
    '    }'
    '};'
    ''
    'window.closeAccountPopup = function() {'
    '    const modal = document.getElementById('#39'accountModal'#39');'
    '    if (modal) modal.classList.remove('#39'active'#39');'
    '};'
    ''
    'window.setOriginalInfo = function(username, email) {'
    '    var u = document.getElementById('#39'acc_username'#39');'
    '    var e = document.getElementById('#39'acc_email'#39');'
    
      '    if(u) { u.value = username; u.setAttribute('#39'data-original'#39', ' +
      'username); }'
    
      '    if(e) { e.value = email; e.setAttribute('#39'data-original'#39', ema' +
      'il); }'
    '    '
    '    var btn = document.getElementById('#39'updateInfoBtn'#39');'
    
      '    if(btn) { btn.style.display = '#39'none'#39'; btn.classList.remove('#39 +
      'fade-slide-in'#39'); }'
    '};'
    ''
    'window.checkInfoChanges = function() {'
    '    var u = document.getElementById('#39'acc_username'#39');'
    '    var e = document.getElementById('#39'acc_email'#39');'
    '    var btn = document.getElementById('#39'updateInfoBtn'#39');'
    '    '
    '    if (u && e && btn) {'
    '        var origU = u.getAttribute('#39'data-original'#39') || '#39#39';'
    '        var origE = e.getAttribute('#39'data-original'#39') || '#39#39';'
    '        '
    
      '        if (u.value.trim() !== origU || e.value.trim() !== origE' +
      ') {'
    
      '            if(btn.style.display === '#39'none'#39' || btn.classList.con' +
      'tains('#39'fade-slide-out'#39')) {'
    '                btn.style.display = '#39'block'#39';'
    '                btn.classList.remove('#39'fade-slide-out'#39');'
    '                btn.classList.add('#39'fade-slide-in'#39'); '
    '            }'
    '        } else {'
    
      '            if(btn.style.display === '#39'block'#39' && !btn.classList.c' +
      'ontains('#39'fade-slide-out'#39')) {'
    '                btn.classList.remove('#39'fade-slide-in'#39');'
    '                btn.classList.add('#39'fade-slide-out'#39');'
    '                setTimeout(function() {'
    
      '                    if (btn.classList.contains('#39'fade-slide-out'#39')' +
      ') {'
    '                        btn.style.display = '#39'none'#39';'
    '                    }'
    '                }, 300);'
    '            }'
    '        }'
    '    }'
    '};'
    ''
    'window.saveAccountChanges = function() {'
    '    const u = document.getElementById('#39'acc_username'#39').value;'
    '    const e = document.getElementById('#39'acc_email'#39').value;'
    '    '
    '    if (!u.trim() || !e.trim()) {'
    
      '        Swal.fire({title: "Hata", text: "Kullan'#305'c'#305' ad'#305' ve e-post' +
      'a bo'#351' olamaz!", icon: "error", background: "#1a1a1b", color: "#f' +
      'ff", customClass: {popup: "oct-popup"}});'
    '        return;'
    '    }'
    '    '
    
      '    document.getElementById('#39'updateInfoBtn'#39').innerText = "G'#220'NCEL' +
      'LEN'#304'YOR...";'
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '        ajaxRequest(MainForm.AnaSayfaHTML, '#39'SaveAccount'#39', ['
    '            '#39'user='#39' + u,'
    '            '#39'email='#39' + e'
    '        ]);'
    '    }'
    '};'
    ''
    'window.updateUsername = function(newName) {'
    '    const el = document.getElementById('#39'displayUsername'#39');'
    '    if (el) el.innerText = newName;'
    '};'
    ''
    'window.addEventListener('#39'click'#39', function(event) {'
    '    const dropdown = document.getElementById('#39'userDropdown'#39');'
    '    const trigger = document.getElementById('#39'profileTrigger'#39');'
    '    const accModal = document.getElementById('#39'accountModal'#39');'
    '    const pwdModal = document.getElementById('#39'pwdResetModal'#39');'
    ''
    
      '    if (dropdown && trigger && !trigger.contains(event.target)) ' +
      '{'
    '        dropdown.classList.remove('#39'show'#39');'
    '        trigger.classList.remove('#39'active'#39');'
    '    }'
    '    if (accModal && event.target === accModal) {'
    '        window.closeAccountPopup();'
    '    }'
    '    if (pwdModal && event.target === pwdModal) {'
    '        window.closePwdModal();'
    '    }'
    '});'
    ''
    'window.addEventListener('#39'keydown'#39', function(e) {'
    '    if (e.key === "Escape") {'
    '        window.closeAccountPopup();'
    '        window.closePwdModal();'
    '    }'
    '});'
    ''
    'window.closePwdModal = function() {'
    '    var modal = document.getElementById('#39'pwdResetModal'#39');'
    '    if (modal) modal.classList.remove('#39'active'#39');'
    
      '    if (window.otpTimerInterval) clearInterval(window.otpTimerIn' +
      'terval); '
    '};'
    ''
    'window.requestPasswordReset = function() {'
    '    window.closeAccountPopup();'
    '    '
    '    var modal = document.getElementById('#39'pwdResetModal'#39');'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "ONAY BEKLEN'#304'YOR";'
    '    body.innerHTML = '
    
      '        '#39'<p style="color:#a1a1aa; font-size:0.95rem; margin-bott' +
      'om:25px; line-height:1.6;">'#39' +'
    
      '        '#39#350'ifrenizi de'#287'i'#351'tirmeniz i'#231'in mail adresinize bir <stron' +
      'g style="color:#fff;">OTP kodu</strong> g'#246'nderilecektir.<br>Onay' +
      'l'#305'yor musunuz?</p>'#39' +'
    
      '        '#39'<div style="display:flex; gap:15px; justify-content:cen' +
      'ter;">'#39' +'
    
      '            '#39'<button class="modal-save-btn" style="margin-top:0;' +
      ' width:50%; background:#3a3a3c; color:#fff;" onclick="window.clo' +
      'sePwdModal()">'#304'PTAL</button>'#39' +'
    
      '            '#39'<button class="modal-save-btn" style="margin-top:0;' +
      ' width:50%;" onclick="window.confirmOTPRequest()">EVET, G'#214'NDER</' +
      'button>'#39' +'
    '        '#39'</div>'#39';'
    '    '
    '    modal.classList.add('#39'active'#39'); '
    '};'
    ''
    'window.confirmOTPRequest = function() {'
    '    var title = document.getElementById('#39'pwdModalTitle'#39');'
    '    var body = document.getElementById('#39'pwdModalBody'#39');'
    ''
    '    title.innerText = "L'#220'TFEN BEKLEY'#304'N";'
    
      '    body.innerHTML = '#39'<div class="oct-spinner"></div><p style="c' +
      'olor:#818384; font-size:0.95rem; margin-top:15px;">G'#252'venlik kodu' +
      ' e-posta adresinize g'#246'nderiliyor...</p>'#39';'
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(MainForm.AnaSayfaHTML, '#39'UserAction'#39', ['#39'type=' +
      'otp_request'#39']);'
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
    '                btn.onclick = window.requestPasswordReset; '
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
    
      '        ajaxRequest(MainForm.AnaSayfaHTML, '#39'UserAction'#39', ['#39'type=' +
      'verify_otp'#39', '#39'otp='#39' + otp]);'
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
    '};'
    ''
    'window.togglePassVis = function(inputId, iconId) {'
    '    var inp = document.getElementById(inputId);'
    '    var icon = document.getElementById(iconId);'
    '    '
    '    if (inp.type === '#39'password'#39') { '
    '        inp.type = '#39'text'#39'; '
    '        icon.classList.replace('#39'fa-eye-slash'#39', '#39'fa-eye'#39'); '
    '        icon.style.color = '#39'var(--classic-accent-color)'#39'; '
    '    } else { '
    '        inp.type = '#39'password'#39'; '
    '        icon.classList.replace('#39'fa-eye'#39', '#39'fa-eye-slash'#39'); '
    '        icon.style.color = '#39'#818384'#39'; '
    '    }'
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
    
      '            '#39'<i id="eye1" class="fa-solid fa-eye-slash" style="p' +
      'osition:absolute; right:15px; top:50%; transform:translateY(-50%' +
      '); color:#818384; cursor:pointer; font-size:1.1rem; transition:0' +
      '.2s;" onclick="window.togglePassVis(\'#39'new-pass1\'#39', \'#39'eye1\'#39')"></' +
      'i>'#39' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div style="position:relative; margin-bottom:10px;">'#39' +'
    
      '            '#39'<input id="new-pass2" class="modal-input" type="pas' +
      'sword" placeholder="Yeni '#350'ifreyi Onayla" style="padding-right:40' +
      'px;">'#39' +'
    
      '            '#39'<i id="eye2" class="fa-solid fa-eye-slash" style="p' +
      'osition:absolute; right:15px; top:50%; transform:translateY(-50%' +
      '); color:#818384; cursor:pointer; font-size:1.1rem; transition:0' +
      '.2s;" onclick="window.togglePassVis(\'#39'new-pass2\'#39', \'#39'eye2\'#39')"></' +
      'i>'#39' +'
    '        '#39'</div>'#39' +'
    
      '        '#39'<p id="pwdModalError" style="color:#e74c3c; font-size:0' +
      '.85rem; margin-bottom:15px; display:none; font-weight:600;"></p>' +
      #39' +'
    
      '        '#39'<button class="modal-save-btn" style="margin-top:10px;"' +
      ' onclick="window.submitNewPassword()">'#350#304'FREY'#304' G'#220'NCELLE</button>'#39 +
      ';'
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
    
      '        ajaxRequest(MainForm.AnaSayfaHTML, '#39'UserAction'#39', ['#39'type=' +
      'update_password'#39', '#39'pass='#39' + p1]);'
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
      ' font-weight:600;">'#350'ifreniz g'#252'ncellendi!</p>'#39';'
    '    '
    '    setTimeout(function() { window.closePwdModal(); }, 2000);'
    '};'
    ''
    '(function() {'
    '    function updateTimer() {'
    '        var el = document.getElementById('#39'timeRemaining'#39');'
    '        if (!el) return false; '
    ''
    
      '        var now = new Date(new Date().toLocaleString("en-US", {t' +
      'imeZone: "Europe/Istanbul"}));'
    '        var midnight = new Date(now);'
    '        midnight.setHours(24, 0, 0, 0);'
    '        var diff = midnight - now;'
    ''
    
      '        var h = Math.floor((diff / (1000 * 60 * 60)) % 24).toStr' +
      'ing().padStart(2, '#39'0'#39');'
    
      '        var m = Math.floor((diff / (1000 * 60)) % 60).toString()' +
      '.padStart(2, '#39'0'#39');'
    
      '        var s = Math.floor((diff / 1000) % 60).toString().padSta' +
      'rt(2, '#39'0'#39');'
    '        '
    '        el.innerText = h + '#39':'#39' + m + '#39':'#39' + s;'
    '        return true; '
    '    }'
    ''
    '    if (!updateTimer()) {'
    '        var fastInterval = setInterval(function() {'
    '            if (updateTimer()) {'
    '                clearInterval(fastInterval);'
    '                setInterval(updateTimer, 1000);'
    '            }'
    '        }, 20); '
    '    } else {'
    '        setInterval(updateTimer, 1000);'
    '    }'
    '})();')
  OnAfterShow = UniFormAfterShow
  TextHeight = 15
  object AnaSayfaHTML: TUniHTMLFrame
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Hint = ''
    HTML.Strings = (
      '<style>   '
      '   /* ========================================='
      '      CSS DE'#286#304#350'KENLER'#304' (MOB'#304'L VE DESKTOP '#304#199#304'N)'
      '      ========================================= */'
      '   :root {'
      '       --card-expand-scale: 2.8;'
      '       --back-close-size: 0.6rem;'
      '       --arrow-size: 0.35rem;'
      '       --dot-size: 3px;'
      '       --nav-bottom: 6px;'
      '       --nav-padding: 3px 8px;'
      '       --nav-gap: 5px;'
      '       --classic-accent-color: #538d4e;'
      '   }'
      ''
      '   @media (max-width: 768px) {'
      '       :root {'
      '           --card-expand-scale: 1.05; '
      '           --back-close-size: 1.5rem;'
      '           --arrow-size: 1.1rem;'
      '           --dot-size: 8px;'
      '           --nav-bottom: 20px;'
      '           --nav-padding: 8px 16px;'
      '           --nav-gap: 15px;'
      '       }'
      '   }'
      ''
      '   /* ========================================='
      '      GLOBAL & MODAL SCROLLBAR'
      '      ========================================= */'
      '   * { -webkit-tap-highlight-color: transparent; }'
      
        '   input { font-size: 16px !important; } /* Safari Auto-Zoom Eng' +
        'eli */'
      ''
      '   ::-webkit-scrollbar { width: 8px; }'
      '   ::-webkit-scrollbar-track { background: #121213; }'
      
        '   ::-webkit-scrollbar-thumb { background-color: var(--classic-a' +
        'ccent-color); border-radius: 8px; border: 2px solid #121213; }'
      '   '
      '   .octaily-viewport {'
      
        '       position: fixed; top: 0; left: 0; width: 100vw; height: 1' +
        '00vh;'
      
        '       background-color: #121213; overflow-y: auto; overflow-x: ' +
        'hidden;'
      
        '       z-index: 9999; display: flex; justify-content: center; al' +
        'ign-items: flex-start; '
      '       font-family: '#39'Inter'#39', '#39'Segoe UI'#39', Tahoma, sans-serif;'
      '   }'
      ''
      
        '   .classic-color { color: var(--classic-accent-color) !importan' +
        't; }'
      ''
      '   /* Sol '#252'stteki credits b'#246'l'#252'm'#252' */'
      
        '   .top-left-credits { position: absolute; top: 20px; left: 30px' +
        '; z-index: 10000; font-size: 0.85rem; color: #a1a1aa; font-weigh' +
        't: 600; }'
      
        '   .top-left-credits a { text-decoration: none; transition: colo' +
        'r 0.3s ease; }'
      '   .top-left-credits i { margin: 0 4px; }'
      ''
      '   /* Octaily Container i'#231'in varsay'#305'lan katman ayar'#305' */'
      '   .octaily-container { '
      '       position: relative; '
      '       z-index: 1; '
      '   }'
      ''
      
        '   /* Bir oyun kart'#305' a'#231#305'ld'#305#287#305'nda t'#252'm container'#39#305' '#252'st men'#252'lerin (' +
        '10000) '#252'zerine '#231#305'kar'#305'yoruz */'
      '   .octaily-container.card-active {'
      '       z-index: 10500 !important;'
      '   }'
      '   '
      '   .game-card-wrapper.expanded .info-btn {'
      '       opacity: 0;'
      '       visibility: hidden;'
      '       pointer-events: none;'
      '   }'
      ''
      '   /* ========================================='
      '      USER PROFILE AREA'
      '      ========================================= */'
      
        '   .user-profile-area { position: absolute; top: 20px; right: 30' +
        'px; z-index: 10000; }'
      
        '   .profile-trigger { display: flex; align-items: center; gap: 1' +
        '0px; background: #1a1a1b; padding: 6px 14px; border-radius: 30px' +
        '; border: 1px solid #3a3a3c; cursor: pointer; transition: 0.3s; ' +
        '}'
      '   .profile-trigger i { color: #FFFFFF; }'
      
        '   .profile-name { font-weight: 600; font-size: 0.9rem; color: #' +
        'ffffff !important; }'
      
        '   .profile-img-wrapper { width: 28px; height: 28px; background:' +
        ' var(--classic-accent-color); border-radius: 50%; display: flex;' +
        ' justify-content: center; align-items: center; color: white; }'
      '   '
      
        '   .profile-dropdown { position: absolute; top: 110%; right: 0; ' +
        'width: 160px; background: #1a1a1b; border: 1px solid #3a3a3c; bo' +
        'rder-radius: 10px; opacity: 0; visibility: hidden; transform: tr' +
        'anslateY(-10px); transition: 0.3s; overflow: hidden; box-shadow:' +
        ' 0 10px 30px rgba(0,0,0,0.5); }'
      
        '   .profile-dropdown.show { opacity: 1; visibility: visible; tra' +
        'nsform: translateY(0); }'
      
        '   .dropdown-item { padding: 10px 15px; display: flex; align-ite' +
        'ms: center; gap: 10px; color: #a1a1aa; font-size: 0.85rem; curso' +
        'r: pointer; transition: 0.2s;}'
      ''
      '   /* ========================================='
      '      ANA '#304#199'ER'#304'K VE BA'#350'LIK'
      '      ========================================= */'
      
        '   .octaily-container { width: 100%; max-width: 1050px; padding:' +
        ' 80px 20px 40px 20px; display: flex; flex-direction: column; ali' +
        'gn-items: center; color: #ffffff; perspective: 1200px; }'
      
        '   .octaily-header { text-align: center; margin-bottom: 30px; wi' +
        'dth: 100%; transition: 0.5s ease; }'
      
        '   .octaily-header h1 { font-size: 2.8rem; margin: 0; letter-spa' +
        'cing: 4px; font-weight: 900; }'
      '   '
      
        '   /* SLOGAN D'#220'ZENLEMES'#304': E'#351'it kelime da'#287#305'l'#305'm'#305' (text-wrap: balan' +
        'ce) */'
      '   .octaily-header p { '
      '       color: #818384; '
      '       font-size: 1rem; '
      '       margin-top: 5px; '
      '       max-width: 320px; '
      '       margin-left: auto; '
      '       margin-right: auto;'
      '       text-wrap: balance; '
      '       line-height: 1.4;'
      '   }'
      ''
      
        '   .puzzle-timer { color: #818384; font-size: 0.9rem; margin-top' +
        ': 15px; background: #1a1a1b; padding: 8px 16px; border-radius: 3' +
        '0px; border: 1px solid #3a3a3c; display: inline-block; }'
      
        '   #timeRemaining { font-weight: 800; color: #ffffff; letter-spa' +
        'cing: 1px; }'
      ''
      
        '   .octaily-grid { display: grid; grid-template-columns: repeat(' +
        'auto-fit, minmax(220px, 1fr)); gap: 15px; width: 100%; }'
      ''
      '   /* ========================================='
      '      KARTLAR VE AN'#304'MASYONLAR'
      '      ========================================= */'
      
        '   .game-card-wrapper { position: relative; width: 100%; z-index' +
        ': 1; transition: transform 0.6s cubic-bezier(0.34, 1.56, 0.64, 1' +
        '), opacity 0.5s ease; transform-style: preserve-3d; }'
      
        '   .game-card { background-color: #1a1a1b; border-radius: 14px; ' +
        'padding: 25px 15px; text-align: center; cursor: pointer; border:' +
        ' 1px solid #272729; transition: all 0.3s ease; display: flex; fl' +
        'ex-direction: column; align-items: center; backface-visibility: ' +
        'hidden; width: 100%; height: 100%; box-sizing: border-box; }'
      
        '   .game-icon { font-size: 2.2rem; margin-bottom: 12px; color: v' +
        'ar(--classic-accent-color); transition: 0.3s; }'
      
        '   .game-title { font-size: 1.15rem; font-weight: 800; margin: 0' +
        ' 0 8px 0; }'
      
        '   .game-desc { color: #818384; font-size: 0.8rem; line-height: ' +
        '1.4; margin: 0; }'
      ''
      
        '   .streak-badge { position: absolute; top: 10px; right: 10px; b' +
        'ackground: #2a2a2c; color: #818384; font-size: 0.7rem; font-weig' +
        'ht: 700; padding: 3px 6px; border-radius: 10px; display: flex; a' +
        'lign-items: center; gap: 4px; border: 1px solid #3a3a3c; }'
      '   .streak-badge i { font-size: 0.7rem; }'
      
        '   .streak-badge.tier-1 { color: #b59f3b; border-color: #b59f3b;' +
        ' background: rgba(181, 159, 59, 0.15); } '
      
        '   .streak-badge.tier-2 { color: var(--classic-accent-color); bo' +
        'rder-color: var(--classic-accent-color); background: rgba(83, 14' +
        '1, 78, 0.15); } '
      
        '   .streak-badge.tier-3 { color: #ff5722; border-color: #ff5722;' +
        ' background: rgba(255, 87, 34, 0.15); box-shadow: 0 0 8px rgba(2' +
        '55,87,34,0.3); } '
      ''
      
        '   .streak-badge.tier-god { color: #ffffff; border: none; backgr' +
        'ound: linear-gradient(45deg, #ff007a, #7928ca, #ff007a); backgro' +
        'und-size: 200% 200%; box-shadow: 0 0 15px rgba(121, 40, 202, 0.6' +
        '); animation: godTierPulse 2s ease infinite; }'
      
        '   .streak-badge.tier-god i { color: #ffdf00; text-shadow: 0 0 5' +
        'px rgba(255, 223, 0, 0.8); }'
      
        '   @keyframes godTierPulse { 0% { background-position: 0% 50%; b' +
        'ox-shadow: 0 0 10px rgba(255, 0, 122, 0.5); } 50% { background-p' +
        'osition: 100% 50%; box-shadow: 0 0 20px rgba(121, 40, 202, 0.9);' +
        ' transform: scale(1.05); } 100% { background-position: 0% 50%; b' +
        'ox-shadow: 0 0 10px rgba(255, 0, 122, 0.5); } }'
      ''
      
        '   .info-btn { position: absolute; top: 10px; left: 10px; color:' +
        ' #818384; font-size: 1.1rem; cursor: pointer; transition: 0.3s; ' +
        'z-index: 10; padding: 5px; }'
      ''
      
        '   .game-card-back { position: absolute; top: 0; left: 0; width:' +
        ' 100%; height: 100%; background-color: #000; border-radius: 14px' +
        '; box-sizing: border-box; border: 1px solid #3a3a3c; backface-vi' +
        'sibility: hidden; transform: rotateY(180deg); overflow: hidden; ' +
        '}'
      
        '   .paginated-rules { width: 100%; height: 100%; position: relat' +
        'ive; }'
      '   .rule-page { display: none; width: 100%; height: 100%; }'
      '   .rule-page.active { display: block; }'
      
        '   .rule-page img { width: 100%; height: 100%; object-fit: cover' +
        '; }'
      ''
      
        '   .close-rules-btn { position: absolute; top: 8px; right: 10px;' +
        ' color: #b59f3b; cursor: pointer; font-size: var(--back-close-si' +
        'ze); transition: 0.3s; z-index: 10; background: rgba(26, 26, 27,' +
        ' 0.7); backdrop-filter: blur(5px); border-radius: 50%; padding: ' +
        '4px; border: 1px solid rgba(181, 159, 59, 0.3); display: flex; j' +
        'ustify-content: center; align-items: center; width: calc(var(--b' +
        'ack-close-size) * 1.5); height: calc(var(--back-close-size) * 1.' +
        '5); }'
      ''
      
        '   .pagination-container { position: absolute; bottom: var(--nav' +
        '-bottom); left: 50%; transform: translateX(-50%); background: rg' +
        'ba(26, 26, 27, 0.8); backdrop-filter: blur(5px); padding: var(--' +
        'nav-padding); border-radius: 30px; display: flex; align-items: c' +
        'enter; gap: var(--nav-gap); z-index: 10; border: 1px solid rgba(' +
        '181, 159, 59, 0.2); }'
      
        '   .arrow-btn { color: #a1a1aa; font-size: var(--arrow-size); cu' +
        'rsor: pointer; transition: 0.3s; padding: 2px; }'
      
        '   .pagination-dots { display: flex; gap: 4px; align-items: cent' +
        'er; }'
      
        '   .dot { width: var(--dot-size); height: var(--dot-size); backg' +
        'round: #444; border-radius: 50%; cursor: pointer; transition: 0.' +
        '3s; }'
      
        '   .dot.active { background: #b59f3b; transform: scale(1.3); box' +
        '-shadow: 0 0 5px rgba(181, 159, 59, 0.5); }'
      ''
      '   /* Masa'#252'st'#252' Kart B'#252'y'#252'me Animasyonu */'
      
        '   .octaily-container.card-active .game-card-wrapper:not(.expand' +
        'ed) { transform: scale(0.3); opacity: 0; pointer-events: none; }'
      
        '   .octaily-container.card-active .octaily-header { opacity: 0; ' +
        'transform: translateY(-20px); pointer-events: none; }'
      
        '   .octaily-container.card-active .game-card-wrapper.expanded { ' +
        'transform: translate(var(--tx, 0px), var(--ty, 0px)) rotateY(180' +
        'deg) scale(var(--card-expand-scale)); z-index: 10500; pointer-ev' +
        'ents: auto; box-shadow: 0 20px 50px rgba(0,0,0,0.8); }'
      ''
      '   /* ========================================='
      '      HESABIM MODAL VE YEN'#304' EKLENEN AN'#304'MASYONLAR'
      '      ========================================= */'
      
        '   .oct-modal-overlay { position: fixed; top: 0; left: 0; width:' +
        ' 100%; height: 100%; background: rgba(0, 0, 0, 0.85); backdrop-f' +
        'ilter: blur(8px); display: flex; justify-content: center; align-' +
        'items: center; z-index: 11000; opacity: 0; visibility: hidden; t' +
        'ransition: opacity 0.3s ease, visibility 0.3s ease; }'
      
        '   .oct-modal-overlay.active { opacity: 1; visibility: visible; ' +
        '}'
      
        '   .oct-modal-content { background: #161618; width: 95%; max-wid' +
        'th: 850px; border-radius: 20px; border: 1px solid #333; display:' +
        ' flex; flex-direction: column; transform: scale(0.9); opacity: 0' +
        '; transition: transform 0.4s cubic-bezier(0.34, 1.56, 0.64, 1), ' +
        'opacity 0.3s ease; overflow: hidden; }'
      
        '   .oct-modal-overlay.active .oct-modal-content { transform: sca' +
        'le(1); opacity: 1; }'
      ''
      
        '   .modal-header { padding: 18px 25px; background: #1a1a1c; disp' +
        'lay: flex; justify-content: space-between; align-items: center; ' +
        'border-bottom: 1px solid #2a2a2c; }'
      
        '   .modal-header h2 { margin: 0; font-size: 1.15rem; color: var(' +
        '--classic-accent-color); font-weight: 800; }'
      
        '   .close-modal { color: #666; cursor: pointer; font-size: 1.4re' +
        'm; transition: 0.2s; }'
      
        '   .modal-body { padding: 25px 30px; max-height: 80vh; overflow-' +
        'y: auto; }'
      '   '
      
        '   .account-top-grid { display: grid; grid-template-columns: rep' +
        'eat(auto-fit, minmax(200px, 1fr)); gap: 20px; margin-bottom: 35p' +
        'x; background: #1a1a1c; padding: 25px; border-radius: 14px; bord' +
        'er: 1px solid #2a2a2c; }'
      
        '   .modal-group label { display: block; color: #a1a1aa; font-siz' +
        'e: 0.75rem; font-weight: 700; margin-bottom: 8px; text-transform' +
        ': uppercase; }'
      
        '   .modal-input { width: 100%; background: #222224; border: 1px ' +
        'solid #3a3a3c; color: #fff; padding: 12px; border-radius: 8px; o' +
        'utline: none; transition: 0.2s; box-sizing: border-box;}'
      
        '   .modal-input:focus { border-color: var(--classic-accent-color' +
        '); background: #1a1a1c; }'
      
        '   .change-pass-btn { width: 100%; background: transparent; colo' +
        'r: #b59f3b; border: 1px solid #b59f3b; padding: 11px; border-rad' +
        'ius: 8px; font-weight: 700; font-size: 0.8rem; cursor: pointer; ' +
        'transition: 0.3s; box-sizing: border-box; }'
      '   '
      
        '   .game-stats-grid { display: grid; grid-template-columns: repe' +
        'at(auto-fit, minmax(260px, 1fr)); gap: 18px; }'
      
        '   .stat-card { background: #1a1a1c; border: 1px solid #2a2a2c; ' +
        'border-radius: 14px; padding: 18px; transition: 0.2s; }'
      
        '   .stat-card-header { display: flex; align-items: center; gap: ' +
        '10px; margin-bottom: 15px; padding-bottom: 10px; border-bottom: ' +
        '1px solid #2a2a2c; }'
      
        '   .stat-card-header i { color: var(--classic-accent-color); fon' +
        't-size: 1rem; }'
      
        '   .stat-card-header span { font-weight: 800; font-size: 0.85rem' +
        '; color: #fff; }'
      
        '   .stat-mini-grid { display: grid; grid-template-columns: 1fr 1' +
        'fr; gap: 8px; }'
      
        '   .mini-stat-box { background: #222224; padding: 10px; border-r' +
        'adius: 8px; display: flex; justify-content: space-between; align' +
        '-items: center; border: 1px solid transparent;}'
      
        '   .mini-stat-label { font-size: 0.65rem; color: #888; font-weig' +
        'ht: 700; text-transform: uppercase; }'
      
        '   .mini-stat-value { font-size: 0.8rem; color: #fff; font-weigh' +
        't: 800; }'
      '   .mini-stat-box.full-width { grid-column: span 2; }'
      '   .highlight { color: var(--classic-accent-color) !important; }'
      
        '   .last-played-row { margin-top: 10px; font-size: 0.7rem; color' +
        ': #777; text-align: center; background: #222224; padding: 6px; b' +
        'order-radius: 6px;}'
      '   '
      
        '   .modal-save-btn { width: 100%; background: var(--classic-acce' +
        'nt-color); color: #fff; border: none; padding: 15px; border-radi' +
        'us: 10px; font-weight: 800; font-size: 0.95rem; cursor: pointer;' +
        ' margin-top: 25px; transition: 0.3s; box-sizing: border-box;}'
      ''
      
        '   .fade-slide-in { animation: fadeSlide 0.4s cubic-bezier(0.34,' +
        ' 1.56, 0.64, 1) forwards; }'
      
        '   @keyframes fadeSlide { from { opacity: 0; transform: translat' +
        'eY(-10px); } to { opacity: 1; transform: translateY(0); } }'
      
        '   .fade-slide-out { animation: fadeSlideOut 0.3s cubic-bezier(0' +
        '.34, 1.56, 0.64, 1) forwards; }'
      
        '   @keyframes fadeSlideOut { from { opacity: 1; transform: trans' +
        'lateY(0); } to { opacity: 0; transform: translateY(-10px); } }'
      ''
      
        '   .oct-spinner { border: 4px solid rgba(255, 255, 255, 0.1); bo' +
        'rder-left-color: var(--classic-accent-color); border-radius: 50%' +
        '; width: 45px; height: 45px; animation: spin 1s linear infinite;' +
        ' margin: 20px auto; }'
      '   @keyframes spin { 100% { transform: rotate(360deg); } }'
      
        '   @keyframes shake { 0%, 100% { transform: translateX(0); } 25%' +
        ' { transform: translateX(-6px); } 50% { transform: translateX(6p' +
        'x); } 75% { transform: translateX(-6px); } }'
      '   .shake { animation: shake 0.4s ease-in-out; }'
      
        '   #pwdResetModal .oct-modal-content { max-width: 420px; text-al' +
        'ign: center; }'
      ''
      '   /* ========================================='
      '      MASA'#220'ST'#220' HOVER '#304'ZOLASYONU (MOB'#304'LDE TET'#304'KLENMEZ)'
      '      ========================================= */'
      '   @media (hover: hover) and (pointer: fine) {'
      
        '       ::-webkit-scrollbar-thumb:hover { background-color: #6aaa' +
        '64; }'
      '       .top-left-credits a:hover { color: #6aaa64 !important; }'
      
        '       .profile-trigger:hover { border-color: var(--classic-acce' +
        'nt-color); background: #222; }'
      
        '       .dropdown-item:hover { background: #272729; color: var(--' +
        'classic-accent-color); }'
      
        '       .game-card-wrapper:hover .game-card { transform: translat' +
        'eY(-6px); border-color: var(--classic-accent-color); background-' +
        'color: #222; box-shadow: 0 10px 20px rgba(0,0,0,0.3); }'
      
        '       .game-card-wrapper:hover .game-icon { transform: scale(1.' +
        '1); color: #6aaa64; }'
      '       .info-btn:hover { color: #fff; transform: scale(1.15); }'
      
        '       .close-rules-btn:hover { background: #b59f3b; color: #000' +
        '; border-color: #b59f3b; transform: rotate(90deg); }'
      
        '       .arrow-btn:hover { color: #b59f3b; transform: scale(1.2);' +
        ' }'
      '       .close-modal:hover { color: #fff; }'
      
        '       .change-pass-btn:hover { background: rgba(181, 159, 59, 0' +
        '.1); }'
      
        '       .stat-card:hover { border-color: #3a3a3c; background: #1e' +
        '1e20; }'
      
        '       .modal-save-btn:hover { background: #467a42; transform: t' +
        'ranslateY(-2px); }'
      '   }'
      ''
      '   /* ========================================='
      '      MOB'#304'L (RESPONSIVE) KATI KURALLARI'
      '      ========================================= */'
      '   @media (max-width: 768px) {'
      '       .octaily-container { perspective: none !important; }'
      '       .octaily-viewport {'
      '           padding-top: env(safe-area-inset-top);'
      '           padding-bottom: env(safe-area-inset-bottom);'
      '       }'
      
        '       .user-profile-area { top: max(15px, env(safe-area-inset-t' +
        'op)); right: 15px; }'
      
        '       .top-left-credits { top: max(20px, env(safe-area-inset-to' +
        'p)); left: 15px; }'
      '       .profile-name { display: none !important; }'
      '       .profile-trigger { padding: 6px; border-radius: 50%; }'
      '       .profile-trigger i.fa-chevron-down { display: none; }'
      '       .octaily-header h1 { font-size: 2.2rem; }'
      '       '
      '       .oct-modal-content { '
      '           width: 100vw !important; '
      '           height: 100dvh !important; '
      '           max-width: 100% !important; '
      '           border-radius: 0 !important; '
      '           border: none !important; '
      '           transform: translateY(100%); '
      '           opacity: 0; '
      
        '           transition: transform 0.3s ease-out, opacity 0.3s eas' +
        'e; '
      '       }'
      
        '       .oct-modal-overlay.active .oct-modal-content { transform:' +
        ' translateY(0); opacity: 1; }'
      '       .modal-header { border-radius: 0; padding: 15px 20px; }'
      
        '       .modal-body { max-height: none !important; height: calc(1' +
        '00dvh - 60px); padding: 20px 15px; overflow-y: auto; }'
      
        '       .account-top-grid { grid-template-columns: 1fr; gap: 12px' +
        '; padding: 15px; }'
      '       .game-stats-grid { grid-template-columns: 1fr; }'
      '       '
      '       /* Kural Kart'#305' Mobilde JS'#39'i Ezip Tam Ekran'#305' Kaplas'#305'n */'
      
        '       .octaily-container.card-active .game-card-wrapper.expande' +
        'd { '
      '           position: fixed !important; '
      
        '           top: calc(env(safe-area-inset-top) + 15px) !important' +
        '; '
      '           left: 5vw !important; '
      '           width: 90vw !important; '
      
        '           height: calc(100dvh - env(safe-area-inset-top) - env(' +
        'safe-area-inset-bottom) - 30px) !important; '
      '           max-height: none !important;'
      '           transform: rotateY(180deg) !important; '
      '           '
      '           /* A'#350'A'#286'IDAK'#304' SATIRDA z-index DE'#286'ER'#304'N'#304' 10500 YAPTIK */'
      '           z-index: 10500 !important; '
      '           '
      '           border-radius: 16px !important;'
      '           box-shadow: 0 20px 50px rgba(0,0,0,0.9) !important;'
      '       }'
      '       .pagination-dots { gap: 8px; }'
      '   }'
      '</style>'
      ''
      '<div class="octaily-viewport">'
      '    <div class="top-left-credits">'
      
        '        Made with <i class="fa-solid fa-heart classic-color"></i' +
        '> by <a href="https://hasup.net" target="_blank" class="classic-' +
        'color">Yu'#351'a G'#246'verdik</a>'
      '    </div>'
      ''
      '    <div class="user-profile-area">'
      
        '        <div class="profile-trigger" onclick="window.toggleUserM' +
        'enu(event)" id="profileTrigger">'
      
        '            <div class="profile-img-wrapper"><i class="fa-solid ' +
        'fa-user"></i></div>'
      
        '            <span class="profile-name" id="displayUsername">Kull' +
        'an'#305'c'#305'</span>'
      '            <i class="fa-solid fa-chevron-down"></i>'
      '        </div>'
      '        <div class="profile-dropdown" id="userDropdown">'
      
        '            <div class="dropdown-item" onclick="window.handleUse' +
        'rAction('#39'account'#39')"><i class="fa-solid fa-user-gear"></i> Hesab'#305 +
        'm</div>'
      
        '            <div class="dropdown-item" onclick="window.handleUse' +
        'rAction('#39'logout'#39')"><i class="fa-solid fa-right-from-bracket"></i' +
        '> '#199#305'k'#305#351' Yap</div>'
      '        </div>'
      '    </div>'
      ''
      '    <div class="octaily-container" id="mainContainer">'
      '        <div class="octaily-header">'
      '            <h1>OCT<span class="classic-color">AILY</span></h1>'
      
        '            <p>Zihnini her g'#252'n yeni bir meydan okumayla zinde tu' +
        't.</p>'
      '            <div id="puzzleTimer" class="puzzle-timer">'
      
        '                Sonraki bulmacalara kalan s'#252're: <span id="timeRe' +
        'maining"></span>'
      '            </div>'
      '        </div>'
      ''
      '        <div class="octaily-grid">'
      
        '            <div class="game-card-wrapper" id="wrapper_wtr"><div' +
        ' class="game-card" onclick="window.openGame('#39'wordle_tr'#39')"><i cla' +
        'ss="fa-solid fa-circle-info info-btn" onclick="window.toggleGame' +
        'Rules(event, '#39'wtr'#39')"></i><div class="streak-badge" id="badge_wtr' +
        '"><i class="fa-solid fa-fire"></i> <span id="val_badge_wtr">0</s' +
        'pan></div><i class="fa-solid fa-spell-check game-icon"></i><h2 c' +
        'lass="game-title">Wordle TR</h2><p class="game-desc">G'#252'n'#252'n T'#252'rk'#231 +
        'e kelimesi.</p></div><div class="game-card-back"><div class="clo' +
        'se-rules-btn" onclick="window.toggleGameRules(event, '#39'wtr'#39')"><i ' +
        'class="fa-solid fa-xmark"></i></div><div class="paginated-rules"' +
        '><div class="rule-page active"><img src="https://placehold.co/12' +
        '00x1600/121213/b59f3b?text=WordleTR+1" alt="Wordle TR 1"></div><' +
        'div class="rule-page"><img src="https://placehold.co/1200x1600/1' +
        '21213/b59f3b?text=WordleTR+2" alt="Wordle TR 2"></div></div><div' +
        ' class="pagination-container"><i class="fa-solid fa-chevron-left' +
        ' arrow-btn" onclick="window.changeRulePage('#39'wtr'#39', '#39'prev'#39', event)' +
        '"></i><div class="pagination-dots"><div class="dot active" oncli' +
        'ck="window.changeRulePage('#39'wtr'#39', 1, event)"></div><div class="do' +
        't" onclick="window.changeRulePage('#39'wtr'#39', 2, event)"></div></div>' +
        '<i class="fa-solid fa-chevron-right arrow-btn" onclick="window.c' +
        'hangeRulePage('#39'wtr'#39', '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_wen"><div' +
        ' class="game-card" onclick="window.openGame('#39'wordle_en'#39')"><i cla' +
        'ss="fa-solid fa-circle-info info-btn" onclick="window.toggleGame' +
        'Rules(event, '#39'wen'#39')"></i><div class="streak-badge" id="badge_wen' +
        '"><i class="fa-solid fa-fire"></i> <span id="val_badge_wen">0</s' +
        'pan></div><i class="fa-solid fa-language game-icon"></i><h2 clas' +
        's="game-title">Wordle EN</h2><p class="game-desc">G'#252'n'#252'n '#304'ngilizc' +
        'e kelimesi.</p></div><div class="game-card-back"><div class="clo' +
        'se-rules-btn" onclick="window.toggleGameRules(event, '#39'wen'#39')"><i ' +
        'class="fa-solid fa-xmark"></i></div><div class="paginated-rules"' +
        '><div class="rule-page active"><img src="https://placehold.co/12' +
        '00x1600/121213/b59f3b?text=WordleEN+1" alt="Wordle EN 1"></div><' +
        'div class="rule-page"><img src="https://placehold.co/1200x1600/1' +
        '21213/b59f3b?text=WordleEN+2" alt="Wordle EN 2"></div></div><div' +
        ' class="pagination-container"><i class="fa-solid fa-chevron-left' +
        ' arrow-btn" onclick="window.changeRulePage('#39'wen'#39', '#39'prev'#39', event)' +
        '"></i><div class="pagination-dots"><div class="dot active" oncli' +
        'ck="window.changeRulePage('#39'wen'#39', 1, event)"></div><div class="do' +
        't" onclick="window.changeRulePage('#39'wen'#39', 2, event)"></div></div>' +
        '<i class="fa-solid fa-chevron-right arrow-btn" onclick="window.c' +
        'hangeRulePage('#39'wen'#39', '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_sdk"><div' +
        ' class="game-card" onclick="window.openGame('#39'sudoku'#39')"><i class=' +
        '"fa-solid fa-circle-info info-btn" onclick="window.toggleGameRul' +
        'es(event, '#39'sdk'#39')"></i><div class="streak-badge" id="badge_sdk"><' +
        'i class="fa-solid fa-fire"></i> <span id="val_badge_sdk">0</span' +
        '></div><i class="fa-solid fa-table-cells game-icon"></i><h2 clas' +
        's="game-title">Sudoku</h2><p class="game-desc">Klasik mant'#305'k bul' +
        'macas'#305'.</p></div><div class="game-card-back"><div class="close-r' +
        'ules-btn" onclick="window.toggleGameRules(event, '#39'sdk'#39')"><i clas' +
        's="fa-solid fa-xmark"></i></div><div class="paginated-rules"><di' +
        'v class="rule-page active"><img src="https://placehold.co/1200x1' +
        '600/121213/b59f3b?text=Sudoku+1" alt="Sudoku 1"></div><div class' +
        '="rule-page"><img src="https://placehold.co/1200x1600/121213/b59' +
        'f3b?text=Sudoku+2" alt="Sudoku 2"></div></div><div class="pagina' +
        'tion-container"><i class="fa-solid fa-chevron-left arrow-btn" on' +
        'click="window.changeRulePage('#39'sdk'#39', '#39'prev'#39', event)"></i><div cla' +
        'ss="pagination-dots"><div class="dot active" onclick="window.cha' +
        'ngeRulePage('#39'sdk'#39', 1, event)"></div><div class="dot" onclick="wi' +
        'ndow.changeRulePage('#39'sdk'#39', 2, event)"></div></div><i class="fa-s' +
        'olid fa-chevron-right arrow-btn" onclick="window.changeRulePage(' +
        #39'sdk'#39', '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_qns"><div' +
        ' class="game-card" onclick="window.openGame('#39'queens'#39')"><i class=' +
        '"fa-solid fa-circle-info info-btn" onclick="window.toggleGameRul' +
        'es(event, '#39'qns'#39')"></i><div class="streak-badge" id="badge_qns"><' +
        'i class="fa-solid fa-fire"></i> <span id="val_badge_qns">0</span' +
        '></div><i class="fa-solid fa-chess-queen game-icon"></i><h2 clas' +
        's="game-title">Queens</h2><p class="game-desc">Vezirleri stratej' +
        'ik yerle'#351'tir.</p></div><div class="game-card-back"><div class="c' +
        'lose-rules-btn" onclick="window.toggleGameRules(event, '#39'qns'#39')"><' +
        'i class="fa-solid fa-xmark"></i></div><div class="paginated-rule' +
        's"><div class="rule-page active"><img src="https://placehold.co/' +
        '1200x1600/121213/b59f3b?text=Queens+1" alt="Queens 1"></div><div' +
        ' class="rule-page"><img src="https://placehold.co/1200x1600/1212' +
        '13/b59f3b?text=Queens+2" alt="Queens 2"></div></div><div class="' +
        'pagination-container"><i class="fa-solid fa-chevron-left arrow-b' +
        'tn" onclick="window.changeRulePage('#39'qns'#39', '#39'prev'#39', event)"></i><d' +
        'iv class="pagination-dots"><div class="dot active" onclick="wind' +
        'ow.changeRulePage('#39'qns'#39', 1, event)"></div><div class="dot" oncli' +
        'ck="window.changeRulePage('#39'qns'#39', 2, event)"></div></div><i class' +
        '="fa-solid fa-chevron-right arrow-btn" onclick="window.changeRul' +
        'ePage('#39'qns'#39', '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_nrd"><div' +
        ' class="game-card" onclick="window.openGame('#39'nerdle'#39')"><i class=' +
        '"fa-solid fa-circle-info info-btn" onclick="window.toggleGameRul' +
        'es(event, '#39'nrd'#39')"></i><div class="streak-badge" id="badge_nrd"><' +
        'i class="fa-solid fa-fire"></i> <span id="val_badge_nrd">0</span' +
        '></div><i class="fa-solid fa-calculator game-icon"></i><h2 class' +
        '="game-title">Nerdle</h2><p class="game-desc">Matematik denklemi' +
        'ni bul.</p></div><div class="game-card-back"><div class="close-r' +
        'ules-btn" onclick="window.toggleGameRules(event, '#39'nrd'#39')"><i clas' +
        's="fa-solid fa-xmark"></i></div><div class="paginated-rules"><di' +
        'v class="rule-page active"><img src="https://placehold.co/1200x1' +
        '600/121213/b59f3b?text=Nerdle+1" alt="Nerdle 1"></div><div class' +
        '="rule-page"><img src="https://placehold.co/1200x1600/121213/b59' +
        'f3b?text=Nerdle+2" alt="Nerdle 2"></div></div><div class="pagina' +
        'tion-container"><i class="fa-solid fa-chevron-left arrow-btn" on' +
        'click="window.changeRulePage('#39'nrd'#39', '#39'prev'#39', event)"></i><div cla' +
        'ss="pagination-dots"><div class="dot active" onclick="window.cha' +
        'ngeRulePage('#39'nrd'#39', 1, event)"></div><div class="dot" onclick="wi' +
        'ndow.changeRulePage('#39'nrd'#39', 2, event)"></div></div><i class="fa-s' +
        'olid fa-chevron-right arrow-btn" onclick="window.changeRulePage(' +
        #39'nrd'#39', '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_zip"><div' +
        ' class="game-card" onclick="window.openGame('#39'zip'#39')"><i class="fa' +
        '-solid fa-circle-info info-btn" onclick="window.toggleGameRules(' +
        'event, '#39'zip'#39')"></i><div class="streak-badge" id="badge_zip"><i c' +
        'lass="fa-solid fa-fire"></i> <span id="val_badge_zip">0</span></' +
        'div><i class="fa-solid fa-route game-icon"></i><h2 class="game-t' +
        'itle">Zip</h2><p class="game-desc">Noktalar'#305' tek seferde birle'#351't' +
        'ir.</p></div><div class="game-card-back"><div class="close-rules' +
        '-btn" onclick="window.toggleGameRules(event, '#39'zip'#39')"><i class="f' +
        'a-solid fa-xmark"></i></div><div class="paginated-rules"><div cl' +
        'ass="rule-page active"><img src="https://placehold.co/1200x1600/' +
        '121213/b59f3b?text=Zip+1" alt="Zip 1"></div><div class="rule-pag' +
        'e"><img src="https://placehold.co/1200x1600/121213/b59f3b?text=Z' +
        'ip+2" alt="Zip 2"></div></div><div class="pagination-container">' +
        '<i class="fa-solid fa-chevron-left arrow-btn" onclick="window.ch' +
        'angeRulePage('#39'zip'#39', '#39'prev'#39', event)"></i><div class="pagination-d' +
        'ots"><div class="dot active" onclick="window.changeRulePage('#39'zip' +
        #39', 1, event)"></div><div class="dot" onclick="window.changeRuleP' +
        'age('#39'zip'#39', 2, event)"></div></div><i class="fa-solid fa-chevron-' +
        'right arrow-btn" onclick="window.changeRulePage('#39'zip'#39', '#39'next'#39', e' +
        'vent)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_hxl"><div' +
        ' class="game-card" onclick="window.openGame('#39'hexle'#39')"><i class="' +
        'fa-solid fa-circle-info info-btn" onclick="window.toggleGameRule' +
        's(event, '#39'hxl'#39')"></i><div class="streak-badge" id="badge_hxl"><i' +
        ' class="fa-solid fa-fire"></i> <span id="val_badge_hxl">0</span>' +
        '</div><i class="fa-solid fa-palette game-icon"></i><h2 class="ga' +
        'me-title">Hexle</h2><p class="game-desc">G'#252'n'#252'n renk kodunu tahmi' +
        'n et.</p></div><div class="game-card-back"><div class="close-rul' +
        'es-btn" onclick="window.toggleGameRules(event, '#39'hxl'#39')"><i class=' +
        '"fa-solid fa-xmark"></i></div><div class="paginated-rules"><div ' +
        'class="rule-page active"><img src="https://placehold.co/1200x160' +
        '0/121213/b59f3b?text=Hexle+1" alt="Hexle 1"></div><div class="ru' +
        'le-page"><img src="https://placehold.co/1200x1600/121213/b59f3b?' +
        'text=Hexle+2" alt="Hexle 2"></div></div><div class="pagination-c' +
        'ontainer"><i class="fa-solid fa-chevron-left arrow-btn" onclick=' +
        '"window.changeRulePage('#39'hxl'#39', '#39'prev'#39', event)"></i><div class="pa' +
        'gination-dots"><div class="dot active" onclick="window.changeRul' +
        'ePage('#39'hxl'#39', 1, event)"></div><div class="dot" onclick="window.c' +
        'hangeRulePage('#39'hxl'#39', 2, event)"></div></div><i class="fa-solid f' +
        'a-chevron-right arrow-btn" onclick="window.changeRulePage('#39'hxl'#39',' +
        ' '#39'next'#39', event)"></i></div></div></div>'
      
        '            <div class="game-card-wrapper" id="wrapper_wld"><div' +
        ' class="game-card" onclick="window.openGame('#39'worldle'#39')"><i class' +
        '="fa-solid fa-circle-info info-btn" onclick="window.toggleGameRu' +
        'les(event, '#39'wld'#39')"></i><div class="streak-badge" id="badge_wld">' +
        '<i class="fa-solid fa-fire"></i> <span id="val_badge_wld">0</spa' +
        'n></div><i class="fa-solid fa-map-location-dot game-icon"></i><h' +
        '2 class="game-title">Worldle</h2><p class="game-desc">Sil'#252'etten ' +
        #252'lkeyi tahmin et.</p></div><div class="game-card-back"><div clas' +
        's="close-rules-btn" onclick="window.toggleGameRules(event, '#39'wld'#39 +
        ')"><i class="fa-solid fa-xmark"></i></div><div class="paginated-' +
        'rules"><div class="rule-page active"><img src="https://placehold' +
        '.co/1200x1600/121213/b59f3b?text=Worldle+1" alt="Worldle 1"></di' +
        'v><div class="rule-page"><img src="https://placehold.co/1200x160' +
        '0/121213/b59f3b?text=Worldle+2" alt="Worldle 2"></div></div><div' +
        ' class="pagination-container"><i class="fa-solid fa-chevron-left' +
        ' arrow-btn" onclick="window.changeRulePage('#39'wld'#39', '#39'prev'#39', event)' +
        '"></i><div class="pagination-dots"><div class="dot active" oncli' +
        'ck="window.changeRulePage('#39'wld'#39', 1, event)"></div><div class="do' +
        't" onclick="window.changeRulePage('#39'wld'#39', 2, event)"></div></div>' +
        '<i class="fa-solid fa-chevron-right arrow-btn" onclick="window.c' +
        'hangeRulePage('#39'wld'#39', '#39'next'#39', event)"></i></div></div></div>'
      '        </div>'
      '    </div>'
      ''
      '    <div class="oct-modal-overlay" id="accountModal">'
      '        <div class="oct-modal-content">'
      '            <div class="modal-header">'
      '                <h2>HESABIM & DASHBOARD</h2>'
      
        '                <i class="fa-solid fa-xmark close-modal" onclick' +
        '="window.closeAccountPopup()"></i>'
      '            </div>'
      '            <div class="modal-body">'
      '                <div class="account-top-grid">'
      
        '                    <div class="modal-group"><label>Kullan'#305'c'#305'</l' +
        'abel><input type="text" id="acc_username" class="modal-input" pl' +
        'aceholder="Y'#252'kleniyor..." oninput="window.checkInfoChanges()"></' +
        'div>'
      
        '                    <div class="modal-group"><label>E-Posta</lab' +
        'el><input type="email" id="acc_email" class="modal-input" placeh' +
        'older="Y'#252'kleniyor..." oninput="window.checkInfoChanges()"></div>'
      
        '                    <div class="modal-group"><label>G'#252'venlik</la' +
        'bel><button class="change-pass-btn" onclick="window.requestPassw' +
        'ordReset()">'#350#304'FREY'#304' DE'#286#304#350'T'#304'R</button></div>'
      '                    '
      
        '                    <button id="updateInfoBtn" class="modal-save' +
        '-btn" style="display:none; grid-column: 1 / -1; margin-top: 5px;' +
        ' padding: 10px;" onclick="window.saveAccountChanges()">B'#304'LG'#304'LER'#304 +
        ' G'#220'NCELLE</button>'
      '                </div>'
      ''
      '                <div class="game-stats-grid">'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-spell-check"></i><span>Wordle TR</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_wtr_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_wtr_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Oynanan</span><span id="st_wtr_tp" class="m' +
        'ini-stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Kazan'#305'lan</span><span id="st_wtr_tw" class=' +
        '"mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_wtr_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-language"></i><span>Wordle EN</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_wen_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_wen_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Oynanan</span><span id="st_wen_tp" class="m' +
        'ini-stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Kazan'#305'lan</span><span id="st_wen_tw" class=' +
        '"mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_wen_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-table-cells"></i><span>Sudoku</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_sdk_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_sdk_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box full-width' +
        '"><span class="mini-stat-label">Tamamlanan</span><span id="st_sd' +
        'k_tp" class="mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_sdk_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-chess-queen"></i><span>Queens</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_qns_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_qns_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box full-width' +
        '"><span class="mini-stat-label">Tamamlanan</span><span id="st_qn' +
        's_tp" class="mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_qns_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-calculator"></i><span>Nerdle</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_nrd_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_nrd_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Oynanan</span><span id="st_nrd_tp" class="m' +
        'ini-stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Kazan'#305'lan</span><span id="st_nrd_tw" class=' +
        '"mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_nrd_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-route"></i><span>Zip</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_zip_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_zip_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box full-width' +
        '"><span class="mini-stat-label">Tamamlanan</span><span id="st_zi' +
        'p_tp" class="mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_zip_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-palette"></i><span>Hexle</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_hxl_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_hxl_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Oynanan</span><span id="st_hxl_tp" class="m' +
        'ini-stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Kazan'#305'lan</span><span id="st_hxl_tw" class=' +
        '"mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_hxl_last">-</span></div>'
      '                    </div>'
      '                    <div class="stat-card">'
      
        '                        <div class="stat-card-header"><i class="' +
        'fa-solid fa-map-location-dot"></i><span>Worldle</span></div>'
      '                        <div class="stat-mini-grid">'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Seri</span><span id="st_wld_cs" class="mini' +
        '-stat-value highlight">0</span></div>'
      
        '                            <div class="mini-stat-box"><span cla' +
        'ss="mini-stat-label">Max</span><span id="st_wld_hs" class="mini-' +
        'stat-value">0</span></div>'
      
        '                            <div class="mini-stat-box full-width' +
        '"><span class="mini-stat-label">Tamamlanan</span><span id="st_wl' +
        'd_tp" class="mini-stat-value">0</span></div>'
      '                        </div>'
      
        '                        <div class="last-played-row">Son Oynama ' +
        'Tarihi: <span id="st_wld_last">-</span></div>'
      '                    </div>'
      '                </div>'
      '            </div>'
      '        </div>'
      '    </div>'
      ''
      '    <div class="oct-modal-overlay" id="pwdResetModal">'
      '        <div class="oct-modal-content">'
      
        '            <div class="modal-header" style="justify-content: ce' +
        'nter; position: relative;">'
      
        '                <h2 id="pwdModalTitle" style="font-size: 1.25rem' +
        ';">'#350#304'FRE '#304#350'LEMLER'#304'</h2>'
      
        '                <i class="fa-solid fa-xmark close-modal" onclick' +
        '="window.closePwdModal()" style="position: absolute; right: 20px' +
        ';"></i>'
      '            </div>'
      
        '            <div class="modal-body" id="pwdModalBody" style="pad' +
        'ding: 30px;">'
      '            </div>'
      '        </div>'
      '    </div>'
      '</div>')
    Align = alClient
    OnAjaxEvent = AnaSayfaHTMLAjaxEvent
  end
end
