object WORLDLE_FORM: TWORLDLE_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'WORLDLE_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.worldleGameOver = false;'
    'window.worldleElapsedTime = 0;'
    'window.worldleTimerInterval = null;'
    'window.worldleGuesses = [];'
    'window.finalGrade = "";'
    'window.worldleIsWin = false;'
    'window.currentPuzzleId = "";'
    'window.targetIso = "";'
    'window.worldleCountries = []; '
    'window.currentFocus = -1;'
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.worldle-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    ''
    'window.worldleEl = function(selector) { '
    '    var vp = window.getVisibleViewport(); '
    '    return vp ? vp.querySelector(selector) : null; '
    '};'
    ''
    'window.injectOctailyStyles = function() {'
    '    if (!document.getElementById("octailyGlobalStyle")) {'
    '        var style = document.createElement("style");'
    '        style.id = "octailyGlobalStyle";'
    '        style.innerHTML = '
    
      '            ".swal2-container { z-index: 2147483647 !important; ' +
      '} " +'
    
      '            ".oct-popup { background: #121213 !important; border' +
      ': 1px solid #3a3a3c !important; color: #fff !important; border-r' +
      'adius: 12px !important; } " +'
    
      '            ".oct-title { color: #fff !important; font-weight: 8' +
      '00 !important; font-size: 1.4rem !important; margin-top: 10px !i' +
      'mportant; letter-spacing: 1px !important; } " +'
    
      '            ".oct-content { color: #818384 !important; font-size' +
      ': 1.1rem !important; margin-top: 15px !important; line-height: 1' +
      '.6 !important; } " +'
    
      '            ".oct-confirm { background: #538d4e !important; colo' +
      'r: #fff !important; font-weight: bold !important; padding: 12px ' +
      '30px !important; border-radius: 6px !important; border: none !im' +
      'portant; margin: 15px !important; cursor: pointer; font-family: ' +
      'sans-serif; font-size: 1.1rem !important; } " +'
    
      '            ".oct-cancel { background: #3a3a3c !important; color' +
      ': #fff !important; padding: 12px 25px !important; border-radius:' +
      ' 6px !important; border: none !important; margin: 10px !importan' +
      't; cursor: pointer; font-family: sans-serif; } " +'
    
      '            ".oct-icon { border: none !important; color: #b59f3b' +
      ' !important; font-size: 2.5rem !important; display: flex !import' +
      'ant; align-items: center !important; justify-content: center !im' +
      'portant; margin: 10px auto !important; } ";'
    '        document.head.appendChild(style);'
    '    }'
    '};'
    ''
    'window.getTodayStr = function() {'
    '    var d = new Date();'
    '    var m = (d.getMonth() + 1).toString().padStart(2, '#39'0'#39');'
    '    var day = d.getDate().toString().padStart(2, '#39'0'#39');'
    '    return d.getFullYear() + '#39'-'#39' + m + '#39'-'#39' + day;'
    '};'
    ''
    
      '// G'#220'NCELLEND'#304': '#39'I'#39' -> '#39#305#39' zorlamas'#305' kald'#305'r'#305'ld'#305', b'#246'ylece AMERIKA' +
      ' -> Amer'#305'ka bozulmas'#305' '#246'nlendi.'
    'window.turkishToUpper = function(str) {'
    
      '    var letters = { "i": "'#304'", "'#351'": "'#350'", "'#287'": "'#286'", "'#252'": "'#220'", "'#246'":' +
      ' "'#214'", "'#231'": "'#199'", "'#305'": "I" };'
    
      '    return str.replace(/[i'#305#351#287#252#246#231#305']/g, function(l){ return letter' +
      's[l]; }).toUpperCase();'
    '};'
    ''
    'window.turkishToLower = function(str) {'
    
      '    var letters = { "'#304'": "i", "'#350'": "'#351'", "'#286'": "'#287'", "'#220'": "'#252'", "'#214'":' +
      ' "'#246'", "'#199'": "'#231'" };'
    
      '    return str.replace(/['#304#350#286#220#214#199']/g, function(l){ return letters[' +
      'l]; }).toLowerCase();'
    '};'
    ''
    
      '// G'#220'NCELLEND'#304': .trim() kald'#305'r'#305'ld'#305' ki arama esnas'#305'nda index (vur' +
      'gulama) kaymas'#305' ya'#351'anmas'#305'n.'
    'window.normalizeForWorldle = function(str) {'
    '    if (!str) return "";'
    '    return window.turkishToUpper(str)'
    
      '        .replace(/'#304'/g, '#39'I'#39').replace(/'#220'/g, '#39'U'#39').replace(/'#214'/g, '#39'O'#39 +
      ')'
    
      '        .replace(/'#286'/g, '#39'G'#39').replace(/'#350'/g, '#39'S'#39').replace(/'#199'/g, '#39'C'#39 +
      ')'
    
      '        .replace(/'#194'/g, '#39'A'#39').replace(/'#206'/g, '#39'I'#39').replace(/'#219'/g, '#39'U'#39 +
      '); '
    '};'
    ''
    'window.toTitleCase = function(str) {'
    '    if (!str) return "";'
    '    return str.split('#39' '#39').map(function(word) {'
    '        if (word.length === 0) return word;'
    
      '        return window.turkishToUpper(word.charAt(0)) + window.tu' +
      'rkishToLower(word.slice(1));'
    '    }).join('#39' '#39');'
    '};'
    ''
    '// TAHM'#304'N ED'#304'LEN '#220'LKEY'#304' KONTROL'
    'window.isAlreadyGuessed = function(cName) {'
    '    var normInput = window.normalizeForWorldle(cName).trim();'
    '    for (var i = 0; i < window.worldleGuesses.length; i++) {'
    
      '        var normGuess = window.normalizeForWorldle(window.worldl' +
      'eGuesses[i].name).trim();'
    '        if (normInput === normGuess) return true;'
    '    }'
    '    return false;'
    '};'
    ''
    'window.getDirectionIcon = function(dirStr) {'
    '    var rot = 0;'
    '    if(dirStr === '#39'N'#39') rot = 0;'
    '    else if(dirStr === '#39'NE'#39') rot = 45;'
    '    else if(dirStr === '#39'E'#39') rot = 90;'
    '    else if(dirStr === '#39'SE'#39') rot = 135;'
    '    else if(dirStr === '#39'S'#39') rot = 180;'
    '    else if(dirStr === '#39'SW'#39') rot = 225;'
    '    else if(dirStr === '#39'W'#39') rot = 270;'
    '    else if(dirStr === '#39'NW'#39') rot = 315;'
    
      '    else return '#39'<i class="fa-solid fa-check" style="color:#538d' +
      '4e;"></i>'#39';'
    
      '    return '#39'<i class="fa-solid fa-arrow-up" style="transform: ro' +
      'tate('#39' + rot + '#39'deg); display: inline-block;"></i>'#39';'
    '};'
    ''
    
      'window.initWorldleWithServer = function(serverId, encryptedIso, ' +
      'countryListStr) {'
    '    window.worldleGameOver = false;'
    '    window.worldleElapsedTime = 0;'
    '    window.worldleIsWin = false;'
    '    window.finalGrade = "";'
    '    window.worldleGuesses = [];'
    '    window.currentFocus = -1;'
    ''
    
      '    if (window.OCTAILY_WORLDLE_DATA && window.OCTAILY_WORLDLE_DA' +
      'TA.length > 0) {'
    '        window.worldleCountries = window.OCTAILY_WORLDLE_DATA;'
    '    } else {'
    '        window.worldleCountries = ['
    '            {en: "Turkey", tr: "T'#252'rkiye"},'
    
      '            {en: "United States", tr: "Amerika Birle'#351'ik Devletle' +
      'ri"}'
    '        ];'
    '    }'
    ''
    '    if (serverId && serverId !== "") {'
    '        window.currentPuzzleId = serverId;'
    '    } else {'
    '        window.currentPuzzleId = window.getTodayStr();'
    '    }'
    ''
    '    if (encryptedIso && encryptedIso !== "") {'
    '        try {'
    
      '            window.targetIso = atob(encryptedIso).replace('#39'octai' +
      'ly_'#39', '#39#39');'
    '            var mapEl = window.worldleEl('#39'#worldleMap'#39');'
    
      '            if(mapEl) mapEl.src = '#39'https://raw.githubusercontent' +
      '.com/djaiss/mapsicon/master/all/'#39' + window.targetIso + '#39'/vector.' +
      'svg'#39';'
    '        } catch(e) {}'
    '    }'
    '    '
    '    window.initWorldleBoard();'
    '};'
    ''
    'window.initWorldleBoard = function() {'
    '    window.injectOctailyStyles();'
    '    var guessesEl = window.worldleEl('#39'#worldleGuesses'#39');'
    
      '    if (!guessesEl) { setTimeout(window.initWorldleBoard, 100); ' +
      'return; }'
    '    '
    '    guessesEl.innerHTML = '#39#39';'
    '    var inputEl = window.worldleEl('#39'#worldleInput'#39');'
    
      '    if (inputEl) { inputEl.value = '#39#39'; inputEl.disabled = false;' +
      ' inputEl.focus(); }'
    '    window.closeAllLists();'
    '    '
    '    window.loadWorldleState();'
    '};'
    ''
    'window.startWorldleTimer = function() {'
    
      '    if (window.worldleTimerInterval) clearInterval(window.worldl' +
      'eTimerInterval);'
    '    if (window.worldleGameOver) return;'
    
      '    var startTime = Date.now() - (window.worldleElapsedTime * 10' +
      '00);'
    '    var timerEl = window.worldleEl('#39'#worldleTimer'#39');'
    '    window.worldleTimerInterval = setInterval(function() {'
    
      '        window.worldleElapsedTime = Math.floor((Date.now() - sta' +
      'rtTime) / 1000);'
    '        if (timerEl) {'
    
      '            var m = Math.floor(window.worldleElapsedTime / 60).t' +
      'oString().padStart(2, '#39'0'#39');'
    
      '            var s = (window.worldleElapsedTime % 60).toString().' +
      'padStart(2, '#39'0'#39');'
    '            timerEl.textContent = m + '#39':'#39' + s;'
    '        }'
    
      '        if (window.worldleElapsedTime % 5 === 0) window.saveWorl' +
      'dleState();'
    '    }, 1000);'
    '};'
    ''
    'window.saveWorldleState = function() {'
    '    if (!window.getVisibleViewport()) return; '
    '    var state = {'
    '        puzzleId: window.currentPuzzleId,'
    '        time: window.worldleElapsedTime,'
    '        completed: window.worldleGameOver,'
    '        grade: window.finalGrade,'
    '        isWin: window.worldleIsWin,'
    '        guesses: window.worldleGuesses'
    '    };'
    
      '    localStorage.setItem('#39'octaily_worldle_state'#39', JSON.stringify' +
      '(state));'
    '};'
    ''
    'window.renderGuesses = function() {'
    '    var container = window.worldleEl('#39'#worldleGuesses'#39');'
    '    if (!container) return;'
    '    container.innerHTML = '#39#39';'
    '    '
    '    for (var i = 0; i < window.worldleGuesses.length; i++) {'
    '        var g = window.worldleGuesses[i];'
    '        var row = document.createElement('#39'div'#39');'
    '        row.className = '#39'guess-row'#39';'
    '        var distStr = g.dist === 0 ? '#39'0km'#39' : g.dist + '#39'km'#39';'
    
      '        var iconHtml = g.dist === 0 ? window.getDirectionIcon('#39'W' +
      'IN'#39') : window.getDirectionIcon(g.dir);'
    
      '        var percColor = g.perc > 90 ? '#39'#538d4e'#39' : (g.perc > 70 ?' +
      ' '#39'#b59f3b'#39' : '#39'#e74c3c'#39');'
    '        '
    '        var displayName = window.toTitleCase(g.name);'
    '        '
    '        row.innerHTML = '
    
      '            '#39'<div class="guess-name">'#39' + displayName + '#39'</div>'#39' ' +
      '+'
    '            '#39'<div class="guess-dist">'#39' + distStr + '#39'</div>'#39' +'
    '            '#39'<div class="guess-dir">'#39' + iconHtml + '#39'</div>'#39' +'
    
      '            '#39'<div class="guess-perc" style="color:'#39' + percColor ' +
      '+ '#39';">%'#39' + g.perc + '#39'</div>'#39';'
    '        container.appendChild(row);'
    '    }'
    '    container.scrollTop = container.scrollHeight;'
    '};'
    ''
    'window.loadWorldleState = function() {'
    '    var saved = localStorage.getItem('#39'octaily_worldle_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.puzzleId === window.currentPuzzleId) {'
    '                window.worldleElapsedTime = state.time || 0;'
    
      '                window.worldleGameOver = state.completed || fals' +
      'e;'
    '                window.finalGrade = state.grade || "";'
    '                window.worldleIsWin = state.isWin || false;'
    '                window.worldleGuesses = state.guesses || [];'
    '                '
    '                window.renderGuesses();'
    ''
    '                if (window.worldleGameOver) {'
    
      '                    var inputEl = window.worldleEl('#39'#worldleInpu' +
      't'#39');'
    '                    if (inputEl) inputEl.disabled = true;'
    
      '                    setTimeout(function() { window.showWorldleGa' +
      'meOver(true); }, 300);'
    '                } else {'
    '                    window.startWorldleTimer();'
    '                }'
    '            } else {'
    
      '                localStorage.removeItem('#39'octaily_worldle_state'#39')' +
      ';'
    '                window.startWorldleTimer();'
    '            }'
    '        } catch (e) { window.startWorldleTimer(); }'
    '    } else {'
    '        window.startWorldleTimer();'
    '    }'
    '};'
    ''
    'window.calculateGrade = function(timeInSec, isWin) {'
    '    if (!isWin) return '#39'F'#39';'
    '    if (timeInSec <= 45) return '#39'S+'#39';'
    '    if (timeInSec <= 90) return '#39'S'#39';'
    '    if (timeInSec <= 180) return '#39'A'#39';'
    '    if (timeInSec <= 300) return '#39'B'#39';'
    '    if (timeInSec <= 600) return '#39'C'#39';'
    '    return '#39'D'#39';'
    '};'
    ''
    'window.showWorldleGameOver = function(isReplay) {'
    
      '    if (window.worldleTimerInterval) clearInterval(window.worldl' +
      'eTimerInterval);'
    ''
    '    var time = window.worldleElapsedTime;'
    '    var tries = window.worldleGuesses.length;'
    '    var isWin = true; '
    
      '    var grade = isReplay ? window.finalGrade : window.calculateG' +
      'rade(time, isWin);'
    ''
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) {'
    '        window.worldleGameOver = true;'
    '        window.finalGrade = grade;'
    '        var inputEl = window.worldleEl('#39'#worldleInput'#39');'
    '        if (inputEl) inputEl.disabled = true;'
    '        window.saveWorldleState();'
    ''
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(WORLDLE_FORM.WorldleHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'tries='#39' + tries, '
    '                '#39'grade='#39' + grade, '
    '                '#39'isWin=1'#39',            '
    '                '#39'game_type=worldle'#39' '
    '            ]);'
    '        }'
    '    }'
    ''
    '    var gradeColor = "#b59f3b";'
    '    if (grade === '#39'S+'#39' || grade === '#39'S'#39') gradeColor = "#ffd700";'
    '    if (grade === '#39'A'#39' || grade === '#39'B'#39') gradeColor = "#538d4e";'
    '    if (grade === '#39'F'#39') gradeColor = "#e74c3c"; '
    ''
    '    var modalTitle = isReplay ? '#39'G'#220'N'#220'N '#214'ZET'#304#39' : '#39'TEBR'#304'KLER!'#39'; '
    
      '    var subText = isReplay ? '#39'<div style="color:#818384; font-si' +
      'ze:0.95rem; margin-bottom:20px;">Bug'#252'n'#252'n haritas'#305'n'#305' zaten '#231#246'zd'#252'n' +
      '!</div>'#39' : '#39#39';'
    '    var modalIcon = isReplay ? '#39'info'#39' : '#39'success'#39';'
    '    var triesStr = tries.toString();'
    ''
    '    var htmlContent = subText +'
    
      '        '#39'<div style="display:flex; justify-content:space-around;' +
      ' align-items:center; margin-top:10px;">'#39' +'
    
      '            '#39'<div style="text-align:center;"><div style="font-si' +
      'ze:3rem; font-weight:900; color:'#39' + gradeColor + '#39';">'#39' + grade +' +
      ' '#39'</div><div style="font-size:0.9rem; color:#818384; letter-spac' +
      'ing:1px;">DERECE</div></div>'#39' +'
    
      '            '#39'<div style="text-align:center;"><div style="font-si' +
      'ze:2rem; font-weight:bold; color:#fff; line-height:3rem;">'#39' + ti' +
      'meStr + '#39'</div><div style="font-size:0.9rem; color:#818384; lett' +
      'er-spacing:1px;">S'#220'RE</div></div>'#39' +'
    
      '            '#39'<div style="text-align:center;"><div style="font-si' +
      'ze:2rem; font-weight:bold; color:#fff; line-height:3rem;">'#39' + tr' +
      'iesStr + '#39'</div><div style="font-size:0.9rem; color:#818384; let' +
      'ter-spacing:1px;">DENEME</div></div>'#39' +'
    '        '#39'</div>'#39';'
    ''
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ','
    
      '            title: modalTitle, html: htmlContent, icon: modalIco' +
      'n, confirmButtonText: '#39#199'IK'#39', background: '#39'#1a1a1b'#39', color: '#39'#fff' +
      'fff'#39','
    
      '            customClass: { popup: '#39'oct-popup'#39', title: '#39'oct-title' +
      #39', confirmButton: '#39'oct-confirm'#39', icon: '#39'oct-icon'#39' },'
    
      '            didOpen: function() { var container = document.query' +
      'Selector('#39'.swal2-container'#39'); if (container) container.style.zIn' +
      'dex = "2147483647"; }'
    '        });'
    '    }'
    '};'
    ''
    'window.closeAllLists = function(elmnt) {'
    '    var vp = window.getVisibleViewport();'
    '    if (!vp) return;'
    '    var x = vp.querySelectorAll(".autocomplete-items");'
    '    var inp = vp.querySelector("#worldleInput");'
    '    for (var i = 0; i < x.length; i++) {'
    '        if (elmnt != x[i] && elmnt != inp) {'
    '            x[i].innerHTML = "";'
    '        }'
    '    }'
    '};'
    ''
    'window.addActive = function(x) {'
    '    if (!x) return false;'
    '    window.removeActive(x);'
    
      '    if (window.currentFocus >= x.length) window.currentFocus = 0' +
      ';'
    
      '    if (window.currentFocus < 0) window.currentFocus = (x.length' +
      ' - 1);'
    '    x[window.currentFocus].classList.add("autocomplete-active");'
    '    x[window.currentFocus].scrollIntoView({ block: "nearest" });'
    '};'
    ''
    'window.removeActive = function(x) {'
    '    for (var i = 0; i < x.length; i++) {'
    '        x[i].classList.remove("autocomplete-active");'
    '    }'
    '};'
    ''
    'window.safeRegexString = function(str) {'
    '    var s = "";'
    '    for(var i=0; i<str.length; i++) {'
    '        var c = str.charAt(i);'
    '        if (".*+?^${}()|[]\\".indexOf(c) !== -1) { s += "\\"; }'
    '        s += c;'
    '    }'
    '    return s;'
    '};'
    ''
    'window.handleInputAutocomplete = function() {'
    '    var inp = window.worldleEl('#39'#worldleInput'#39');'
    '    var list = window.worldleEl('#39'#autocompleteList'#39');'
    
      '    if (!inp || !list || !window.worldleCountries || window.worl' +
      'dleCountries.length === 0) return;'
    '    '
    '    var val = inp.value;'
    '    list.innerHTML = '#39#39';'
    '    if (!val) return;'
    '    '
    '    window.currentFocus = -1;'
    '    var matchCount = 0;'
    '    var valNorm = window.normalizeForWorldle(val);'
    ''
    '    for (var i = 0; i < window.worldleCountries.length; i++) {'
    '        var cObj = window.worldleCountries[i];'
    
      '        var checkName = (cObj.tr && cObj.tr !== "") ? cObj.tr : ' +
      'cObj.en;'
    '        '
    '        if (window.isAlreadyGuessed(checkName)) continue;'
    ''
    
      '        var checkNameNorm = window.normalizeForWorldle(checkName' +
      ');'
    '        var matchIdx = checkNameNorm.indexOf(valNorm);'
    '        '
    '        if (matchIdx > -1) {'
    '            var item = document.createElement("div");'
    '            item.className = "autocomplete-item";'
    '            '
    '            var displayListStr = window.toTitleCase(checkName);'
    '            '
    
      '            var beforeMatch = displayListStr.substring(0, matchI' +
      'dx);'
    
      '            var matchStr = displayListStr.substring(matchIdx, ma' +
      'tchIdx + val.length);'
    
      '            var afterMatch = displayListStr.substring(matchIdx +' +
      ' val.length);'
    '            '
    
      '            item.innerHTML = beforeMatch + "<span class='#39'hl-text' +
      #39'>" + matchStr + "</span>" + afterMatch;'
    '            '
    '            var safeQuoteRegex = new RegExp("'#39'", "g");'
    
      '            item.innerHTML += "<input type='#39'hidden'#39' value='#39'" + c' +
      'heckName.replace(safeQuoteRegex, "&#39;") + "'#39'>";'
    '            '
    '            item.addEventListener("click", function(e) {'
    
      '                var selectedVal = this.getElementsByTagName("inp' +
      'ut")[0].value;'
    '                inp.value = window.toTitleCase(selectedVal); '
    '                window.closeAllLists();'
    '                inp.focus();'
    '            });'
    '            list.appendChild(item);'
    '            matchCount++;'
    '            if (matchCount >= 10) break;'
    '        }'
    '    }'
    '};'
    ''
    'window.submitWorldleGuess = function() {'
    '    if (window.worldleGameOver) return;'
    '    var inputEl = window.worldleEl('#39'#worldleInput'#39');'
    '    if (!inputEl) return;'
    '    '
    '    var guess = inputEl.value.trim();'
    '    if (guess === '#39#39') {'
    
      '        inputEl.classList.remove('#39'shake'#39'); void inputEl.offsetWi' +
      'dth; inputEl.classList.add('#39'shake'#39');'
    '        return;'
    '    }'
    '    '
    '    var guessNorm = window.normalizeForWorldle(guess).trim();'
    '    var isValid = false;'
    '    var selectedOriginalName = guess;'
    ''
    '    for (var i = 0; i < window.worldleCountries.length; i++) {'
    '        var c = window.worldleCountries[i];'
    
      '        if (window.normalizeForWorldle(c.en).trim() === guessNor' +
      'm || (c.tr && window.normalizeForWorldle(c.tr).trim() === guessN' +
      'orm)) {'
    '            isValid = true;'
    '            selectedOriginalName = c.tr || c.en;'
    '            break;'
    '        }'
    '    }'
    ''
    '    if (!isValid) {'
    
      '        window.showWorldleError("L'#252'tfen listeden ge'#231'erli bir '#252'lk' +
      'e se'#231'in.");'
    '        return;'
    '    }'
    ''
    '    if (window.isAlreadyGuessed(selectedOriginalName)) {'
    
      '        window.showWorldleError("Bu '#252'lkeyi zaten tahmin ettiniz!' +
      '");'
    '        return;'
    '    }'
    ''
    '    inputEl.value = '#39#39'; '
    '    window.closeAllLists();'
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(WORLDLE_FORM.WorldleHTML, '#39'SubmitGuess'#39', ['#39'g' +
      'uess='#39' + selectedOriginalName]);'
    '    }'
    '};'
    ''
    'window.processWorldleResult = function(resultObj) {'
    '    if (window.worldleGameOver) return;'
    '    '
    '    var isWin = false;'
    '    var cName = resultObj.country_name || '#39'Bilinmeyen'#39';'
    '    '
    '    if (window.worldleCountries) {'
    
      '        for (var k = 0; k < window.worldleCountries.length; k++)' +
      ' {'
    '            var c = window.worldleCountries[k];'
    
      '            if (c.en === cName || window.normalizeForWorldle(c.e' +
      'n).trim() === window.normalizeForWorldle(cName).trim()) {'
    '                if (c.tr && c.tr !== "") {'
    '                    cName = c.tr;'
    '                }'
    '                break;'
    '            }'
    '        }'
    '    }'
    ''
    '    var dist = parseInt(resultObj.distance) || 0;'
    '    var dir = resultObj.direction || '#39'N'#39';'
    '    var perc = parseInt(resultObj.proximity) || 0;'
    '    '
    '    if (dist === 0) isWin = true;'
    '    '
    
      '    window.worldleGuesses.push({ name: cName, dist: dist, dir: d' +
      'ir, perc: perc });'
    '    window.renderGuesses();'
    '    '
    '    window.worldleIsWin = isWin;'
    '    window.saveWorldleState();'
    ''
    '    if (isWin) {'
    
      '        setTimeout(function() { window.showWorldleGameOver(false' +
      '); }, 1000);'
    '    }'
    '};'
    ''
    'window.showWorldleError = function(errorMsg) {'
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal && errorMsg) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ', title: '#39'HATA!'#39', text: errorMsg, icon: '#39'warning'#39', toast: true, ' +
      'position: '#39'top'#39', showConfirmButton: false, timer: 2000, backgrou' +
      'nd: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39', customClass: { popup: '#39'oct-popu' +
      'p'#39' }'
    '        });'
    '    }'
    '    var inputEl = window.worldleEl('#39'#worldleInput'#39');'
    '    if (inputEl) {'
    
      '        inputEl.classList.remove('#39'shake'#39'); void inputEl.offsetWi' +
      'dth; inputEl.classList.add('#39'shake'#39');'
    '    }'
    '};'
    ''
    
      'if (window.worldleKeyHandler) document.removeEventListener('#39'keyd' +
      'own'#39', window.worldleKeyHandler);'
    
      'if (window.worldleInputHandler) document.removeEventListener('#39'in' +
      'put'#39', window.worldleInputHandler);'
    
      'if (window.worldleClickHandler) document.removeEventListener('#39'cl' +
      'ick'#39', window.worldleClickHandler);'
    ''
    'window.worldleKeyHandler = function(e) {'
    
      '    if (!window.getVisibleViewport() || window.worldleGameOver) ' +
      'return; '
    '    var list = window.worldleEl('#39'#autocompleteList'#39');'
    '    var items = list ? list.getElementsByTagName('#39'div'#39') : [];'
    ''
    '    if (e.key === '#39'ArrowDown'#39') {'
    '        window.currentFocus++;'
    '        window.addActive(items);'
    '        e.preventDefault();'
    '    } else if (e.key === '#39'ArrowUp'#39') {'
    '        window.currentFocus--;'
    '        window.addActive(items);'
    '        e.preventDefault();'
    '    } else if (e.key === '#39'Enter'#39') {'
    '        e.preventDefault();'
    '        if (window.currentFocus > -1 && items.length > 0) {'
    '            items[window.currentFocus].click();'
    '        } else {'
    '            var inputEl = window.worldleEl('#39'#worldleInput'#39');'
    '            if (document.activeElement === inputEl) {'
    '                window.submitWorldleGuess();'
    '            }'
    '        }'
    '    }'
    '};'
    ''
    'window.worldleInputHandler = function(e) {'
    '    if (e.target && e.target.id === '#39'worldleInput'#39') {'
    '        var start = e.target.selectionStart;'
    '        var end = e.target.selectionEnd;'
    '        '
    '        e.target.value = window.toTitleCase(e.target.value);'
    '        '
    '        e.target.setSelectionRange(start, end);'
    '        '
    '        window.handleInputAutocomplete();'
    '    }'
    '};'
    ''
    'window.worldleClickHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    '    '
    '    var btn = e.target.closest('#39'#worldleSubmitBtn'#39');'
    '    if (btn) { '
    '        window.submitWorldleGuess(); '
    '        return;'
    '    }'
    '    '
    '    var inp = window.worldleEl('#39'#worldleInput'#39');'
    '    if (e.target !== inp) {'
    '        window.closeAllLists(e.target);'
    '    }'
    '};'
    ''
    'document.addEventListener('#39'keydown'#39', window.worldleKeyHandler);'
    'document.addEventListener('#39'input'#39', window.worldleInputHandler);'
    'document.addEventListener('#39'click'#39', window.worldleClickHandler);')
  TextHeight = 15
  object WorldleHTML: TUniHTMLFrame
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Hint = ''
    HTML.Strings = (
      '<style>'
      '    /* ========================================='
      '       S'#304'STEM RESET & K'#304'L'#304'TLER'
      '       ========================================= */'
      '    html, body {'
      '        margin: 0 !important; padding: 0 !important;'
      '        width: 100% !important; height: 100% !important;'
      '        background-color: #121213 !important;'
      '        overflow: hidden !important;'
      '        overscroll-behavior: none !important;'
      
        '        /* Ana ekran kaymas'#305'n'#305' kilitler (Ama scroll alanlara a'#351'a' +
        #287#305'da pan-y izni verdik) */'
      '        touch-action: none !important; '
      
        '        -webkit-border-radius: 0 !important; border-radius: 0 !i' +
        'mportant;'
      
        '        -webkit-appearance: none !important; appearance: none !i' +
        'mportant;'
      '    }'
      ''
      '    /* ========================================='
      '       GENEL TASARIM VE V'#304'EWPORT'
      '       ========================================= */'
      '    .worldle-viewport {'
      '        position: fixed;'
      '        top: 0; left: 0; right: 0; bottom: 0;'
      '        width: 100vw; height: 100vh; height: 100dvh;'
      '        background-color: #121213 !important;'
      
        '        display: flex; flex-direction: column; align-items: cent' +
        'er;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif;'
      '        color: #ffffff; z-index: 9999; overflow: hidden;'
      '        padding-top: env(safe-area-inset-top);'
      '        padding-bottom: env(safe-area-inset-bottom);'
      '        box-sizing: border-box;'
      '        '
      '        /* iOS GR'#304' K'#214#350'E SIZINTISI '#304#199#304'N KES'#304'N '#199#214'Z'#220'MLER */'
      '        box-shadow: 0 0 0 100vmax #121213; '
      '        clip-path: inset(0); '
      '    }'
      ''
      '    /* ========================================='
      '       '#220'ST BA'#350'LIK VE KRONOMETRE'
      '       ========================================= */'
      '    .worldle-header {'
      '        width: 100%; max-width: 600px;'
      
        '        display: flex; justify-content: space-between; align-ite' +
        'ms: center;'
      '        padding: 10px 15px; border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box; flex-shrink: 0;'
      '    }'
      ''
      
        '    .worldle-header h1 { margin: 0; font-size: 1.5rem; letter-sp' +
        'acing: 2px; font-weight: 800; text-align: center; }'
      '    '
      '    .btn-back { '
      
        '        background: none; border: none; color: #818384; font-siz' +
        'e: 1.4rem; '
      '        cursor: pointer; transition: color 0.2s; padding: 5px; '
      '        -webkit-tap-highlight-color: transparent; '
      '    }'
      '    .btn-back:active { color: #ffffff; transform: scale(0.95); }'
      ''
      
        '    .worldle-timer { font-family: '#39'Courier New'#39', Courier, monosp' +
        'ace; color: #818384; font-size: 1.2rem; font-weight: bold; width' +
        ': 60px; text-align: right; }'
      ''
      '    /* ========================================='
      '       HAR'#304'TA / '#220'LKE S'#304'L'#220'ET'#304
      '       ========================================= */'
      '    .worldle-map-container {'
      '        width: 100%; max-width: 400px; '
      
        '        height: 25vh; min-height: 120px; max-height: 200px; /* K' +
        'lavyede daralabilmesi i'#231'in esnetildi */'
      
        '        margin: 15px 0; display: flex; justify-content: center; ' +
        'align-items: center;'
      '        flex-shrink: 0;'
      '    }'
      ''
      '    .worldle-map-container img {'
      '        max-width: 100%; max-height: 100%; object-fit: contain;'
      '        filter: invert(1) brightness(0.8); '
      '        animation: fadeIn 1s ease-in-out;'
      
        '        pointer-events: none; /* Haritan'#305'n yanl'#305#351'l'#305'kla s'#252'r'#252'klenm' +
        'esini '#246'nler */'
      '    }'
      ''
      '    /* ========================================='
      '       TAHM'#304'N L'#304'STES'#304' (Kayd'#305'r'#305'labilir / Scrollable)'
      '       ========================================= */'
      '    .worldle-guesses {'
      '        flex-grow: 1; width: 100%; max-width: 600px;'
      '        display: flex; flex-direction: column; gap: 8px;'
      '        padding: 5px 15px; box-sizing: border-box; '
      '        overflow-y: auto;'
      '        '
      '        /* MOB'#304'L SCROLL K'#304'L'#304'D'#304' A'#199'ICILARI */'
      
        '        touch-action: pan-y; /* Yukar'#305'-A'#351'a'#287#305' kayd'#305'rmaya izin ver' +
        ' */'
      
        '        -webkit-overflow-scrolling: touch; /* iOS Ya'#287' gibi kayd'#305 +
        'rma efekti */'
      
        '        overscroll-behavior: contain; /* Sayfa sonuna gelince an' +
        'a g'#246'vdeyi esnetmez */'
      '    }'
      ''
      '    .guess-row {'
      
        '        display: flex; justify-content: space-between; align-ite' +
        'ms: center;'
      
        '        background-color: #3a3a3c; border-radius: 6px; padding: ' +
        '12px 15px;'
      
        '        font-size: 1.1rem; font-weight: bold; animation: popIn 0' +
        '.3s ease-out;'
      '        flex-shrink: 0;'
      '    }'
      ''
      
        '    .guess-name { flex-grow: 1; text-align: left; overflow: hidd' +
        'en; text-overflow: ellipsis; white-space: nowrap; padding-right:' +
        ' 10px; }'
      
        '    .guess-dist { width: 70px; text-align: right; color: #818384' +
        '; font-size: 0.95rem; }'
      
        '    .guess-dir { width: 40px; text-align: center; font-size: 1.2' +
        'rem; }'
      
        '    .guess-perc { width: 45px; text-align: right; color: #538d4e' +
        '; }'
      ''
      '    /* ========================================='
      '       G'#304'RD'#304' (INPUT) VE AUTOCOMPLETE (DROPBOX)'
      '       ========================================= */'
      '    .worldle-input-area {'
      
        '        width: 100%; max-width: 600px; padding: 12px 15px; box-s' +
        'izing: border-box;'
      
        '        display: flex; gap: 10px; border-top: 1px solid #3a3a3c;' +
        ' '
      
        '        background-color: #121213; align-items: flex-end; flex-s' +
        'hrink: 0;'
      '        z-index: 100;'
      '    }'
      ''
      '    .autocomplete-wrapper {'
      
        '        position: relative; flex-grow: 1; display: flex; flex-di' +
        'rection: column;'
      '    }'
      ''
      '    .worldle-input {'
      
        '        width: 100%; background-color: #3a3a3c; border: 2px soli' +
        'd #565758;'
      
        '        color: #ffffff; padding: 14px 15px; border-radius: 8px; ' +
        'font-weight: bold;'
      
        '        outline: none; transition: border-color 0.2s; text-trans' +
        'form: uppercase; box-sizing: border-box;'
      '        -webkit-appearance: none; appearance: none;'
      '        '
      
        '        /* '#199'OK '#214'NEML'#304': Safari'#39'de inputa t'#305'klay'#305'nca sayfan'#305'n otom' +
        'atik zoom yapmas'#305'n'#305' engeller */'
      '        font-size: 16px !important; '
      '    }'
      '    .worldle-input:focus { border-color: #818384; }'
      ''
      '    .autocomplete-items {'
      
        '        position: absolute; border: 1px solid #565758; border-bo' +
        'ttom: none;'
      '        z-index: 101; bottom: 100%; left: 0; right: 0; '
      
        '        max-height: 35vh; /* Liste '#231'ok uzay'#305'p klavye arkas'#305'nda k' +
        'aybolmas'#305'n diye dinamik y'#252'kseklik */'
      '        overflow-y: auto;'
      '        background-color: #2a2a2c; border-radius: 8px 8px 0 0; '
      '        box-shadow: 0 -10px 20px rgba(0,0,0,0.5);'
      '        '
      '        /* MOB'#304'L SCROLL K'#304'L'#304'D'#304' A'#199'ICILARI */'
      '        touch-action: pan-y; '
      '        -webkit-overflow-scrolling: touch;'
      '        overscroll-behavior: contain;'
      '    }'
      '    '
      '    .autocomplete-item {'
      
        '        padding: 12px 15px; cursor: pointer; background-color: #' +
        '2a2a2c; border-bottom: 1px solid #3a3a3c; color: #fff; font-weig' +
        'ht: bold;'
      '        font-size: 1.05rem;'
      '    }'
      
        '    .autocomplete-item:active, .autocomplete-active { background' +
        '-color: #538d4e; }'
      ''
      '    .hl-text { color: #b59f3b; }'
      
        '    .autocomplete-item:active .hl-text, .autocomplete-active .hl' +
        '-text { color: #ffffff; text-decoration: underline; }'
      ''
      '    .worldle-btn {'
      
        '        background-color: #538d4e; color: #fff; border: none; pa' +
        'dding: 0 20px; height: 52px;'
      
        '        border-radius: 8px; font-size: 1.2rem; font-weight: bold' +
        '; cursor: pointer;'
      
        '        transition: transform 0.1s, background-color 0.2s; displ' +
        'ay: flex; align-items: center; justify-content: center;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      '    .worldle-btn:active { transform: scale(0.92); }'
      ''
      '    /* AN'#304'MASYONLAR */'
      
        '    @keyframes popIn { 0% { opacity: 0; transform: scale(0.9); }' +
        ' 100% { opacity: 1; transform: scale(1); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      '    @keyframes shake {'
      '        10%, 90% { transform: translate3d(-2px, 0, 0); }'
      '        20%, 80% { transform: translate3d(4px, 0, 0); }'
      '        30%, 50%, 70% { transform: translate3d(-6px, 0, 0); }'
      '        40%, 60% { transform: translate3d(6px, 0, 0); }'
      '    }'
      
        '    .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97)' +
        ' both; border-color: #e74c3c !important; }'
      ''
      '    /* ========================================='
      '       MASA'#220'ST'#220' HOVER'
      '       ========================================= */'
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .autocomplete-item:hover { background-color: #538d4e; }'
      
        '        .autocomplete-item:hover .hl-text { color: #ffffff; text' +
        '-decoration: underline; }'
      '        .worldle-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    /* ========================================='
      '       MOB'#304'L UYUMLULUK ('#199'ok k'#252#231#252'k ekranlar)'
      '       ========================================= */'
      '    @media (max-width: 360px) {'
      '        .worldle-header h1 { font-size: 1.3rem; }'
      '        .worldle-map-container { margin: 10px 0; height: 20vh; }'
      '        .guess-row { font-size: 1rem; padding: 10px; }'
      '        .worldle-input { padding: 12px 10px; }'
      '        .worldle-btn { padding: 0 15px; }'
      '    }'
      '</style>'
      ''
      '<div class="worldle-viewport">'
      '    <div class="worldle-header">'
      
        '        <button class="btn-back" onclick="ajaxRequest(WORLDLE_FO' +
        'RM.WorldleHTML, '#39'closePage'#39');"><i class="fa-solid fa-arrow-left"' +
        '></i></button>'
      '        <h1>WORLDLE</h1>'
      '        <div id="worldleTimer" class="worldle-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="worldle-map-container">'
      '        <img id="worldleMap" src="" alt="Country Map">'
      '    </div>'
      ''
      '    <div class="worldle-guesses" id="worldleGuesses"></div>'
      ''
      '    <div class="worldle-input-area">'
      '        <div class="autocomplete-wrapper">'
      
        '            <div id="autocompleteList" class="autocomplete-items' +
        '"></div>'
      '            '
      
        '            <input type="text" id="worldleInput" class="worldle-' +
        'input" placeholder="'#220'LKE ADI G'#304'R'#304'N..." autocomplete="off" autoco' +
        'rrect="off" spellcheck="false">'
      '        </div>'
      
        '        <button id="worldleSubmitBtn" class="worldle-btn"><i cla' +
        'ss="fa-solid fa-paper-plane"></i></button>'
      '    </div>'
      '</div>')
    Align = alClient
    OnAjaxEvent = WorldleHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 50
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 520
    Top = 160
  end
end
