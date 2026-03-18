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
    'window.worldleStartTimeStamp = 0;'
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
    'window.injectOctailyStyles = function() {}; '
    ''
    'window.getTodayStr = function() {'
    '    var d = new Date();'
    '    var m = (d.getMonth() + 1).toString().padStart(2, '#39'0'#39');'
    '    var day = d.getDate().toString().padStart(2, '#39'0'#39');'
    '    return d.getFullYear() + '#39'-'#39' + m + '#39'-'#39' + day;'
    '};'
    ''
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
    
      'window.initWorldleWithServer = function(serverId, encryptedIso) ' +
      '{'
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
    '    '
    
      '    if (!window.worldleStartTimeStamp || window.worldleStartTime' +
      'Stamp === 0) {'
    
      '        window.worldleStartTimeStamp = Date.now() - (window.worl' +
      'dleElapsedTime * 1000);'
    '    }'
    '    '
    '    var timerEl = window.worldleEl('#39'#worldleTimer'#39');'
    '    window.worldleTimerInterval = setInterval(function() {'
    
      '        window.worldleElapsedTime = Math.floor((Date.now() - win' +
      'dow.worldleStartTimeStamp) / 1000);'
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
    '    if (window.worldleGameOver) return;'
    '    '
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
    
      'window.showWorldleGameOver = function(isReplay, savedTries, save' +
      'dTime, savedIsWin) {'
    
      '    if (window.worldleTimerInterval) clearInterval(window.worldl' +
      'eTimerInterval);'
    ''
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.worldleElapsedTime;'
    
      '    var tries = (isReplay && savedTries !== undefined) ? savedTr' +
      'ies : window.worldleGuesses.length;'
    
      '    var isWin = (isReplay && savedIsWin !== undefined) ? savedIs' +
      'Win : window.worldleIsWin; '
    '    '
    '    var grade = window.calculateGrade(time, isWin);'
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
    '                '#39'isWin='#39' + (isWin ? '#39'1'#39' : '#39'0'#39'),            '
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
    
      '    if (!isWin) modalTitle = isReplay ? '#39'G'#220'N'#220'N '#214'ZET'#304#39' : '#39'YARIN Y' +
      #304'NE DENE!'#39';'
    '    '
    '    document.getElementById('#39'crmTitle'#39').innerText = modalTitle;'
    
      '    document.getElementById('#39'crmTitle'#39').style.color = isWin ? '#39'#' +
      'fff'#39' : (isReplay ? '#39'#fff'#39' : '#39'#e74c3c'#39');'
    '    '
    '    var subTextEl = document.getElementById('#39'crmSubText'#39');'
    '    if (isReplay) {'
    
      '        subTextEl.innerHTML = '#39'Bug'#252'n'#252'n haritas'#305'n'#305' zaten '#231#246'zd'#252'n!'#39 +
      ';'
    '        subTextEl.style.display = '#39'block'#39';'
    '    } else {'
    '        subTextEl.style.display = '#39'none'#39';'
    '    }'
    ''
    '    var bigGrade = document.getElementById('#39'crmBigGrade'#39');'
    '    bigGrade.innerText = grade;'
    '    bigGrade.style.color = gradeColor;'
    '    bigGrade.style.textShadow = '#39'0 0 20px '#39' + gradeColor + '#39'60'#39';'
    '    '
    '    var divider = document.getElementById('#39'crmDivider'#39');'
    '    if (divider) {'
    '        divider.style.backgroundColor = gradeColor;'
    
      '        divider.style.boxShadow = '#39'0 0 12px '#39' + gradeColor + '#39'80' +
      #39';'
    '    }'
    ''
    '    document.getElementById('#39'crmTime'#39').innerText = timeStr;'
    
      '    document.getElementById('#39'crmTries'#39').innerText = isWin ? trie' +
      's.toString() : '#39'X'#39';'
    
      '    if (isReplay && tries === 0 && !isWin) document.getElementBy' +
      'Id('#39'crmTries'#39').innerText = '#39'-'#39';'
    ''
    
      '    document.getElementById('#39'crmAvgTime'#39').innerHTML = '#39'<i class=' +
      '"fa-solid fa-spinner fa-spin"></i>'#39';'
    
      '    document.getElementById('#39'crmPercentile'#39').innerHTML = '#39'<i cla' +
      'ss="fa-solid fa-spinner fa-spin"></i>'#39';'
    
      '    document.getElementById('#39'crmAnswerText'#39').innerHTML = '#39'<i cla' +
      'ss="fa-solid fa-spinner fa-spin"></i>'#39';'
    ''
    
      '    document.getElementById('#39'customResultModal'#39').classList.add('#39 +
      'active'#39');'
    ''
    '    setTimeout(function() {'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '            ajaxRequest(WORLDLE_FORM.WorldleHTML, '#39'GetPanelStats' +
      #39', ['#39'game_type=worldle'#39']);'
    '        }'
    '    }, isReplay ? 0 : 500);'
    '};'
    ''
    
      'window.updatePanelStats = function(avgTimeSec, percentile, answe' +
      'rText) {'
    
      '    var m = Math.floor(avgTimeSec / 60).toString().padStart(2, '#39 +
      '0'#39');'
    '    var s = (avgTimeSec % 60).toString().padStart(2, '#39'0'#39');'
    
      '    document.getElementById('#39'crmAvgTime'#39').innerText = (avgTimeSe' +
      'c > 0) ? (m + '#39':'#39' + s) : '#39'--:--'#39';'
    
      '    document.getElementById('#39'crmPercentile'#39').innerText = '#39'%'#39' + p' +
      'ercentile;'
    '    '
    '    if (answerText) {'
    
      '        document.getElementById('#39'crmAnswerText'#39').innerText = ans' +
      'werText;'
    '    } else {'
    
      '        document.getElementById('#39'crmAnswerText'#39').innerText = "G'#304 +
      'ZL'#304'";'
    '    }'
    '};'
    ''
    'window.closeResultModal = function() {'
    '    var modal = document.getElementById('#39'customResultModal'#39');'
    '    if(modal) modal.classList.remove('#39'active'#39');'
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(WORLDLE_' +
      'FORM.WorldleHTML, '#39'closePage'#39');'
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
    
      '        var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (win' +
      'dow.parent && window.parent.Swal ? window.parent.Swal : null);'
    '        if(mySwal){'
    '            mySwal.fire({'
    
      '                target: window.getVisibleViewport() || document.' +
      'body, title: '#39'HATA!'#39', text: "L'#252'tfen listeden ge'#231'erli bir '#252'lke se' +
      #231'in.", icon: '#39'warning'#39', toast: true, position: '#39'top'#39', showConfir' +
      'mButton: false, timer: 2000, background: '#39'#1a1a1b'#39', color: '#39'#fff' +
      'fff'#39', customClass: { popup: '#39'oct-popup'#39' }'
    '            });'
    '        }'
    '        return;'
    '    }'
    ''
    '    if (window.isAlreadyGuessed(selectedOriginalName)) {'
    
      '        var mySwal2 = (typeof Swal !== '#39'undefined'#39') ? Swal : (wi' +
      'ndow.parent && window.parent.Swal ? window.parent.Swal : null);'
    '        if(mySwal2){'
    '            mySwal2.fire({'
    
      '                target: window.getVisibleViewport() || document.' +
      'body, title: '#39'HATA!'#39', text: "Bu '#252'lkeyi zaten tahmin ettiniz!", i' +
      'con: '#39'warning'#39', toast: true, position: '#39'top'#39', showConfirmButton:' +
      ' false, timer: 2000, background: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39', cu' +
      'stomClass: { popup: '#39'oct-popup'#39' }'
    '            });'
    '        }'
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
    '        e.target.value = window.toTitleCase(e.target.value);'
    '        e.target.setSelectionRange(start, end);'
    '        window.handleInputAutocomplete();'
    '    }'
    '};'
    ''
    'window.worldleClickHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    '    var btn = e.target.closest('#39'#worldleSubmitBtn'#39');'
    '    if (btn) { '
    '        window.submitWorldleGuess(); '
    '        return;'
    '    }'
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
      '    html, body {'
      '        margin: 0 !important; padding: 0 !important;'
      '        width: 100% !important; height: 100% !important;'
      '        background-color: #121213 !important;'
      '        overflow: hidden !important;'
      '        overscroll-behavior: none !important;'
      '        touch-action: none !important; '
      
        '        -webkit-border-radius: 0 !important; border-radius: 0 !i' +
        'mportant;'
      
        '        -webkit-appearance: none !important; appearance: none !i' +
        'mportant;'
      '    }'
      ''
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
      '        box-shadow: 0 0 0 100vmax #121213; '
      '        clip-path: inset(0); '
      '    }'
      ''
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
      '    .worldle-map-container {'
      '        width: 100%; max-width: 400px; '
      '        height: 25vh; min-height: 120px; max-height: 200px; '
      
        '        margin: 15px 0; display: flex; justify-content: center; ' +
        'align-items: center;'
      '        flex-shrink: 0;'
      '    }'
      ''
      '    .worldle-map-container img {'
      '        max-width: 100%; max-height: 100%; object-fit: contain;'
      '        filter: invert(1) brightness(0.8); '
      '        animation: fadeIn 1s ease-in-out;'
      '        pointer-events: none; '
      '    }'
      ''
      '    .worldle-guesses {'
      '        flex-grow: 1; width: 100%; max-width: 600px;'
      '        display: flex; flex-direction: column; gap: 8px;'
      '        padding: 5px 15px; box-sizing: border-box; '
      '        overflow-y: auto;'
      '        touch-action: pan-y; '
      '        -webkit-overflow-scrolling: touch; '
      '        overscroll-behavior: contain; '
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
      '        font-size: 16px !important; '
      '    }'
      '    .worldle-input:focus { border-color: #818384; }'
      ''
      '    .autocomplete-items {'
      
        '        position: absolute; border: 1px solid #565758; border-bo' +
        'ttom: none;'
      '        z-index: 101; bottom: 100%; left: 0; right: 0; '
      '        max-height: 35vh; '
      '        overflow-y: auto;'
      '        background-color: #2a2a2c; border-radius: 8px 8px 0 0; '
      '        box-shadow: 0 -10px 20px rgba(0,0,0,0.5);'
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
      '    /* CUSTOM SONU'#199' PANEL'#304' CSS'#39'LER'#304' */'
      
        '    .oct-modal-overlay { position: fixed; top: 0; left: 0; width' +
        ': 100%; height: 100%; background: rgba(0, 0, 0, 0.85); backdrop-' +
        'filter: blur(8px); display: flex; justify-content: center; align' +
        '-items: center; z-index: 11000; opacity: 0; visibility: hidden; ' +
        'transition: opacity 0.3s ease, visibility 0.3s ease; padding: 15' +
        'px; box-sizing: border-box; }'
      
        '    .oct-modal-overlay.active { opacity: 1; visibility: visible;' +
        ' }'
      '    '
      
        '    .oct-modal-content { background: #161618; width: 100%; max-w' +
        'idth: 350px; border-radius: 16px; border: 1px solid #333; displa' +
        'y: flex; flex-direction: column; text-align: center; overflow: h' +
        'idden; opacity: 0; max-height: 92vh; }'
      
        '    .oct-modal-overlay.active .oct-modal-content { animation: sw' +
        'alPopIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) forwards; }'
      ''
      
        '    .modal-header { padding: 18px 20px; background: #1a1a1c; dis' +
        'play: flex; justify-content: center; align-items: center; border' +
        '-bottom: 1px solid #2a2a2c; position: relative; flex-shrink: 0; ' +
        '}'
      
        '    .modal-header h2 { margin: 0; font-size: 1.2rem; color: #fff' +
        '; font-weight: 800; letter-spacing: 1.5px; text-transform: upper' +
        'case; }'
      '    '
      
        '    .modal-body { padding: 15px 20px; display: flex; flex-direct' +
        'ion: column; align-items: center; overflow-y: auto; touch-action' +
        ': pan-y; -webkit-overflow-scrolling: touch; overscroll-behavior:' +
        ' contain; flex-grow: 1; }'
      
        '    .crm-subtext { color: #818384; font-size: 0.85rem; margin-bo' +
        'ttom: 12px; display: none; }'
      '    '
      
        '    .crm-grade-section { margin: 5px auto 10px auto; display: fl' +
        'ex; flex-direction: column; align-items: center; width: 100%; fl' +
        'ex-shrink: 0; opacity: 0; }'
      
        '    .oct-modal-overlay.active .crm-grade-section { animation: gr' +
        'adeSectionIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) 0.2s forward' +
        's; }'
      ''
      
        '    .crm-grade-label { font-size: 0.75rem; color: #818384; font-' +
        'weight: bold; letter-spacing: 2px; margin-bottom: 2px; text-tran' +
        'sform: uppercase; }'
      
        '    .crm-grade-value { font-size: 4.5rem; font-weight: 900; line' +
        '-height: 1.1; position: relative; margin-bottom: 12px; transitio' +
        'n: text-shadow 0.3s ease; }'
      '    '
      
        '    .crm-divider { width: 100%; height: 2px; border-radius: 2px;' +
        ' background-color: #3a3a3c; margin-bottom: 20px; opacity: 0; tra' +
        'nsition: background-color 0.3s ease, box-shadow 0.3s ease; }'
      
        '    .oct-modal-overlay.active .crm-divider { animation: fadeIn 0' +
        '.5s ease 0.4s forwards; }'
      '    '
      
        '    .crm-stats-grid { display: grid; grid-template-columns: 1fr ' +
        '1fr; gap: 12px; margin-bottom: 18px; width: 100%; }'
      
        '    .crm-stat-box { background: #1a1a1c; border: 1px solid #2a2a' +
        '2c; border-radius: 12px; padding: 12px 5px; display: flex; flex-' +
        'direction: column; align-items: center; justify-content: center;' +
        ' }'
      
        '    .crm-stat-val { font-size: 1.4rem; font-weight: bold; color:' +
        ' #fff; margin-bottom: 2px; font-variant-numeric: tabular-nums; l' +
        'ine-height: 1.2; }'
      
        '    .crm-stat-lbl { font-size: 0.7rem; color: #818384; font-weig' +
        'ht: bold; letter-spacing: 1px; text-transform: uppercase; }'
      '    '
      
        '    .crm-answer-box { background: rgba(83, 141, 78, 0.1); border' +
        ': 1px dashed #538d4e; border-radius: 12px; padding: 12px; margin' +
        '-bottom: 20px; width: 100%; box-sizing: border-box; }'
      
        '    .crm-answer-lbl { font-size: 0.75rem; color: #538d4e; font-w' +
        'eight: bold; letter-spacing: 1px; margin-bottom: 4px; }'
      
        '    .crm-answer-val { font-size: 1.3rem; color: #fff; font-weigh' +
        't: 800; text-transform: uppercase; letter-spacing: 1.5px; }'
      ''
      
        '    .modal-save-btn { width: 100%; background: #538d4e; color: #' +
        'fff; border: none; padding: 16px; border-radius: 12px; font-weig' +
        'ht: 800; font-size: 1rem; cursor: pointer; transition: 0.3s; fle' +
        'x-shrink: 0; text-transform: uppercase; letter-spacing: 1px; }'
      ''
      
        '    @keyframes popIn { 0% { opacity: 0; transform: scale(0.9); }' +
        ' 100% { opacity: 1; transform: scale(1); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      
        '    @keyframes shake { 10%, 90% { transform: translate3d(-2px, 0' +
        ', 0); } 20%, 80% { transform: translate3d(4px, 0, 0); } 30%, 50%' +
        ', 70% { transform: translate3d(-6px, 0, 0); } 40%, 60% { transfo' +
        'rm: translate3d(6px, 0, 0); } }'
      
        '    .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97)' +
        ' both; border-color: #e74c3c !important; }'
      
        '    @keyframes swalPopIn { 0% { opacity: 0; transform: scale(0.8' +
        '); } 80% { transform: scale(1.05); opacity: 1; } 100% { transfor' +
        'm: scale(1); opacity: 1; } }'
      
        '    @keyframes gradeSectionIn { 0% { opacity: 0; transform: scal' +
        'e(0.5) translateY(20px); } 100% { opacity: 1; transform: scale(1' +
        ') translateY(0); } }'
      ''
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .autocomplete-item:hover { background-color: #538d4e; }'
      
        '        .autocomplete-item:hover .hl-text { color: #ffffff; text' +
        '-decoration: underline; }'
      '        .worldle-btn:hover { background-color: #467a42; }'
      '        .modal-save-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    @media (max-width: 500px) {'
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 450px; }'
      '    }'
      ''
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
      
        '        <button class="btn-back" onclick="window.closeResultModa' +
        'l();"><i class="fa-solid fa-arrow-left"></i></button>'
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
      ''
      '    <div class="oct-modal-overlay" id="customResultModal">'
      '        <div class="oct-modal-content">'
      '            <div class="modal-header">'
      '                <h2 id="crmTitle">TEBR'#304'KLER!</h2>'
      '            </div>'
      '            <div class="modal-body">'
      '                <div id="crmSubText" class="crm-subtext"></div>'
      '                '
      '                <div class="crm-grade-section">'
      '                    <div class="crm-grade-label">DERECE</div>'
      
        '                    <div class="crm-grade-value" id="crmBigGrade' +
        '">S+</div>'
      
        '                    <div class="crm-divider" id="crmDivider"></d' +
        'iv>'
      '                </div>'
      ''
      '                <div class="crm-stats-grid">'
      '                    <div class="crm-stat-box">'
      
        '                        <div class="crm-stat-val" id="crmTime">-' +
        '-:--</div>'
      '                        <div class="crm-stat-lbl">S'#220'RE</div>'
      '                    </div>'
      '                    <div class="crm-stat-box">'
      
        '                        <div class="crm-stat-val" id="crmTries">' +
        '-</div>'
      '                        <div class="crm-stat-lbl">DENEME</div>'
      '                    </div>'
      '                    <div class="crm-stat-box">'
      
        '                        <div class="crm-stat-val" id="crmAvgTime' +
        '"><i class="fa-solid fa-spinner fa-spin"></i></div>'
      '                        <div class="crm-stat-lbl">ORTALAMA</div>'
      '                    </div>'
      '                    <div class="crm-stat-box">'
      
        '                        <div class="crm-stat-val" id="crmPercent' +
        'ile"><i class="fa-solid fa-spinner fa-spin"></i></div>'
      '                        <div class="crm-stat-lbl">Y'#220'ZDEL'#304'K</div>'
      '                    </div>'
      '                </div>'
      ''
      '                <div class="crm-answer-box">'
      
        '                    <div class="crm-answer-lbl">G'#220'N'#220'N CEVABI</di' +
        'v>'
      
        '                    <div class="crm-answer-val" id="crmAnswerTex' +
        't"><i class="fa-solid fa-spinner fa-spin"></i></div>'
      '                </div>'
      ''
      
        '                <button class="modal-save-btn" onclick="window.c' +
        'loseResultModal()">KAPAT</button>'
      '            </div>'
      '        </div>'
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
