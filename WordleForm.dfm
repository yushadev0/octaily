object WORDLE_FORM: TWORDLE_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'WORDLE_FORM'
  OnShow = UniFormShow
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.wordleGameOver = false;'
    'window.wordleRow = 0;'
    'window.wordleCol = 0;'
    'window.wordleMaxGuesses = 6;'
    'window.wordleLength = 5;'
    'window.wordleElapsedTime = 0;'
    'window.wordleTimerInterval = null;'
    'window.finalGrade = "";'
    'window.wordleIsWin = false;'
    'window.wordleLang = "tr";'
    'window.currentPuzzleId = "";'
    'window.isWordleInitialized = false;'
    'window.currentUserId = 0;'
    'window.wordleStartTimeStamp = 0;'
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.wordle-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    
      'window.wordleEl = function(selector) { var vp = window.getVisibl' +
      'eViewport(); return vp ? vp.querySelector(selector) : null; };'
    
      'window.wordleEls = function(selector) { var vp = window.getVisib' +
      'leViewport(); return vp ? vp.querySelectorAll(selector) : []; };'
    ''
    'window.renderKeyboard = function(lang) {'
    
      '    var kbEl = window.wordleEl('#39'#wordleKeyboard'#39') || document.ge' +
      'tElementById('#39'wordleKeyboard'#39'); '
    '    if (!kbEl) return;'
    '    '
    '    var kbHTML = '#39#39';'
    '    if (lang === '#39'tr'#39') {'
    '        kbHTML = '
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key" data-key="E">E</div><div class="ke' +
      'y" data-key="R">R</div><div class="key" data-key="T">T</div><div' +
      ' class="key" data-key="Y">Y</div><div class="key" data-key="U">U' +
      '</div><div class="key" data-key="I">I</div><div class="key" data' +
      '-key="O">O</div><div class="key" data-key="P">P</div><div class=' +
      '"key" data-key="'#286'">'#286'</div><div class="key" data-key="'#220'">'#220'</div>'#39 +
      ' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key" data-key="A">A</div><div class="ke' +
      'y" data-key="S">S</div><div class="key" data-key="D">D</div><div' +
      ' class="key" data-key="F">F</div><div class="key" data-key="G">G' +
      '</div><div class="key" data-key="H">H</div><div class="key" data' +
      '-key="J">J</div><div class="key" data-key="K">K</div><div class=' +
      '"key" data-key="L">L</div><div class="key" data-key="'#350'">'#350'</div><' +
      'div class="key" data-key="'#304'">'#304'</div>'#39' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key wide" id="keyEnter" data-key="ENTER' +
      '">ENTER</div>'#39' +'
    
      '            '#39'<div class="key" data-key="Z">Z</div><div class="ke' +
      'y" data-key="C">C</div><div class="key" data-key="V">V</div><div' +
      ' class="key" data-key="B">B</div><div class="key" data-key="N">N' +
      '</div><div class="key" data-key="M">M</div><div class="key" data' +
      '-key="'#214'">'#214'</div><div class="key" data-key="'#199'">'#199'</div>'#39' +'
    
      '            '#39'<div class="key wide" id="keyBackspace" data-key="B' +
      'ACKSPACE"><i class="fa-solid fa-delete-left"></i></div>'#39' +'
    '        '#39'</div>'#39';'
    '    } else {'
    '        kbHTML = '
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key" data-key="Q">Q</div><div class="ke' +
      'y" data-key="W">W</div><div class="key" data-key="E">E</div><div' +
      ' class="key" data-key="R">R</div><div class="key" data-key="T">T' +
      '</div><div class="key" data-key="Y">Y</div><div class="key" data' +
      '-key="U">U</div><div class="key" data-key="I">I</div><div class=' +
      '"key" data-key="O">O</div><div class="key" data-key="P">P</div>'#39 +
      ' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key" data-key="A">A</div><div class="ke' +
      'y" data-key="S">S</div><div class="key" data-key="D">D</div><div' +
      ' class="key" data-key="F">F</div><div class="key" data-key="G">G' +
      '</div><div class="key" data-key="H">H</div><div class="key" data' +
      '-key="J">J</div><div class="key" data-key="K">K</div><div class=' +
      '"key" data-key="L">L</div>'#39' +'
    '        '#39'</div>'#39' +'
    '        '#39'<div class="keyboard-row">'#39' +'
    
      '            '#39'<div class="key wide" id="keyEnter" data-key="ENTER' +
      '">ENTER</div>'#39' +'
    
      '            '#39'<div class="key" data-key="Z">Z</div><div class="ke' +
      'y" data-key="X">X</div><div class="key" data-key="C">C</div><div' +
      ' class="key" data-key="V">V</div><div class="key" data-key="B">B' +
      '</div><div class="key" data-key="N">N</div><div class="key" data' +
      '-key="M">M</div>'#39' +'
    
      '            '#39'<div class="key wide" id="keyBackspace" data-key="B' +
      'ACKSPACE"><i class="fa-solid fa-delete-left"></i></div>'#39' +'
    '        '#39'</div>'#39';'
    '    }'
    '    kbEl.innerHTML = kbHTML;'
    '};'
    ''
    'window.getTodayStr = function() {'
    '    var d = new Date();'
    '    var m = (d.getMonth() + 1).toString().padStart(2, '#39'0'#39');'
    '    var day = d.getDate().toString().padStart(2, '#39'0'#39');'
    '    return d.getFullYear() + '#39'-'#39' + m + '#39'-'#39' + day;'
    '};'
    ''
    'window.initWordleWithServer = function(serverId) {'
    '    if (!window.wordleGameOver) {'
    '        window.wordleRow = 0;'
    '        window.wordleCol = 0;'
    '        window.wordleElapsedTime = 0;'
    '        window.wordleIsWin = false;'
    '        window.finalGrade = "";'
    '    }'
    ''
    '    if (serverId && serverId !== "") {'
    '        window.currentPuzzleId = serverId;'
    '    } else {'
    '        window.currentPuzzleId = window.getTodayStr();'
    '    }'
    '    '
    '    window.isWordleInitialized = true;'
    '    window.initWordleBoard();'
    '};'
    ''
    'window.initWordleBoard = function() {'
    
      '    var boardEl = window.wordleEl('#39'#wordleBoard'#39') || document.ge' +
      'tElementById('#39'wordleBoard'#39');'
    '    '
    '    if (!boardEl) { '
    '        setTimeout(window.initWordleBoard, 100); '
    '        return; '
    '    }'
    '    '
    '    boardEl.innerHTML = '#39#39'; '
    
      '    for (var i = 0; i < (window.wordleMaxGuesses * window.wordle' +
      'Length); i++) {'
    '        var cell = document.createElement('#39'div'#39');'
    '        cell.className = '#39'wordle-cell'#39';'
    '        boardEl.appendChild(cell);'
    '    }'
    '    '
    '    window.setWordleLang(window.wordleLang);'
    ''
    '    if (window.wordleGameOver) {'
    
      '        setTimeout(function() { window.showWordleGameOver(true);' +
      ' }, 500);'
    '    } else {'
    '        window.startWordleTimer(); '
    '    }'
    '};'
    ''
    'window.setWordleLang = function(lang) {'
    '    window.wordleLang = lang;'
    
      '    var titleEl = window.wordleEl('#39'#wordleTitle'#39') || document.ge' +
      'tElementById('#39'wordleTitle'#39');'
    '    if (titleEl) {'
    
      '        titleEl.textContent = (lang === '#39'tr'#39') ? '#39'WORDLE (TR)'#39' : ' +
      #39'WORDLE (EN)'#39';'
    '    }'
    '    window.renderKeyboard(lang);'
    '};'
    ''
    'window.startWordleTimer = function() {'
    
      '    if (window.wordleTimerInterval) clearInterval(window.wordleT' +
      'imerInterval);'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    ''
    
      '    if (!window.wordleStartTimeStamp || window.wordleStartTimeSt' +
      'amp === 0) {'
    
      '        window.wordleStartTimeStamp = Date.now() - (window.wordl' +
      'eElapsedTime * 1000);'
    '    }'
    ''
    '    var timerEl = window.wordleEl('#39'#wordleTimer'#39'); '
    '    window.wordleTimerInterval = setInterval(function() {'
    
      '        window.wordleElapsedTime = Math.floor((Date.now() - wind' +
      'ow.wordleStartTimeStamp) / 1000);'
    ''
    '        if (timerEl) {'
    
      '            var m = Math.floor(window.wordleElapsedTime / 60).to' +
      'String().padStart(2, '#39'0'#39');'
    
      '            var s = (window.wordleElapsedTime % 60).toString().p' +
      'adStart(2, '#39'0'#39');'
    '            timerEl.textContent = m + '#39':'#39' + s;'
    '        }'
    '    }, 1000); '
    '};'
    ''
    'window.calculateGrade = function(tries, isWin) {'
    '    if (!isWin) return '#39'F'#39';'
    '    if (tries === 1) return '#39'S+'#39';'
    '    if (tries === 2) return '#39'S'#39';'
    '    if (tries === 3) return '#39'A'#39';'
    '    if (tries === 4) return '#39'B'#39';'
    '    if (tries === 5) return '#39'C'#39';'
    '    return '#39'D'#39';'
    '};'
    ''
    
      'window.showWordleGameOver = function(isReplay, savedTries, saved' +
      'Time, savedIsWin) {'
    
      '    if (window.wordleTimerInterval) clearInterval(window.wordleT' +
      'imerInterval);'
    '    '
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.wordleElapsedTime;'
    
      '    var tries = (isReplay && savedTries !== undefined) ? savedTr' +
      'ies : window.wordleRow;'
    
      '    var isWin = (isReplay && savedIsWin !== undefined) ? savedIs' +
      'Win : window.wordleIsWin; '
    '    '
    '    var grade = window.calculateGrade(tries, isWin);'
    ''
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) {'
    '        window.wordleGameOver = true;'
    '        window.finalGrade = grade;'
    ''
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(WORDLE_FORM.WordleHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'tries='#39' + tries, '
    '                '#39'grade='#39' + grade, '
    '                '#39'isWin='#39' + (isWin ? '#39'1'#39' : '#39'0'#39'),'
    '                '#39'game_type=wordle_'#39' + window.wordleLang'
    '            ]);'
    '        }'
    '    }'
    ''
    '    var gradeColor = "#b59f3b";'
    '    if (grade === '#39'S+'#39' || grade === '#39'S'#39') gradeColor = "#ffd700";'
    '    if (grade === '#39'A'#39' || grade === '#39'B'#39') gradeColor = "#538d4e";'
    '    if (grade === '#39'F'#39') gradeColor = "#e74c3c";'
    ''
    
      '    var modalTitle = isReplay ? '#39'G'#220'N'#220'N '#214'ZET'#304#39' : (isWin ? '#39'TEBR'#304'K' +
      'LER!'#39' : '#39'YARIN Y'#304'NE DENE!'#39');'
    '    '
    '    document.getElementById('#39'crmTitle'#39').innerText = modalTitle;'
    
      '    document.getElementById('#39'crmTitle'#39').style.color = isWin ? '#39'#' +
      'fff'#39' : (isReplay ? '#39'#fff'#39' : '#39'#e74c3c'#39');'
    '    '
    '    var subTextEl = document.getElementById('#39'crmSubText'#39');'
    '    if (isReplay) {'
    
      '        subTextEl.innerHTML = '#39'Bug'#252'n'#252'n kelimesini zaten '#231#246'zd'#252'n!'#39 +
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
      's + '#39'/6'#39' : '#39'X/6'#39';'
    
      '    if (isReplay && tries === 0 && !isWin) document.getElementBy' +
      'Id('#39'crmTries'#39').innerText = '#39'-/6'#39';'
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
    
      '            ajaxRequest(WORDLE_FORM.WordleHTML, '#39'GetPanelStats'#39',' +
      ' ['#39'game_type=wordle_'#39' + window.wordleLang]);'
    '        }'
    '    }, isReplay ? 0 : 400);'
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
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(WORDLE_F' +
      'ORM.WordleHTML, '#39'closePage'#39');'
    '};'
    ''
    'window.isLetter = function(str) { '
    '    if (window.wordleLang === '#39'tr'#39') {'
    
      '        return str.length === 1 && /[A-Z'#286#220#350#304#214#199'a-z'#287#252#351'i'#246#231']/.test(s' +
      'tr); '
    '    } else {'
    '        return str.length === 1 && /[A-Za-z]/.test(str); '
    '    }'
    '};'
    ''
    'window.getCell = function(row, col) {'
    '    var cells = window.wordleEls('#39'.wordle-cell'#39');'
    '    if (cells.length === 0) return null;'
    '    return cells[(row * window.wordleLength) + col];'
    '};'
    ''
    'window.addLetter = function(letter) {'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    
      '    if (window.wordleCol < window.wordleLength && window.wordleR' +
      'ow < window.wordleMaxGuesses) {'
    
      '        var cell = window.getCell(window.wordleRow, window.wordl' +
      'eCol);'
    '        if (cell) {'
    '            cell.textContent = letter.toUpperCase();'
    '            cell.classList.add('#39'filled'#39');'
    '            window.wordleCol++;'
    '        }'
    '    }'
    '};'
    ''
    'window.deleteLetter = function() {'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    '    if (window.wordleCol > 0) {'
    '        window.wordleCol--;'
    
      '        var cell = window.getCell(window.wordleRow, window.wordl' +
      'eCol);'
    '        if (cell) {'
    '            cell.textContent = '#39#39';'
    '            cell.classList.remove('#39'filled'#39', '#39'error'#39', '#39'shake'#39');'
    '        }'
    '    }'
    '};'
    ''
    'window.submitGuess = function() {'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    '    if (window.wordleCol !== window.wordleLength) {'
    '        for (var i = 0; i < window.wordleCol; i++) {'
    '            var cell = window.getCell(window.wordleRow, i);'
    '            if (cell) {'
    '                cell.classList.remove('#39'shake'#39', '#39'error'#39');'
    '                void cell.offsetWidth;'
    '                cell.classList.add('#39'shake'#39');'
    '            }'
    '        }'
    '        return;'
    '    }'
    ''
    '    var guess = '#39#39';'
    '    for (var j = 0; j < window.wordleLength; j++) {'
    '        var c = window.getCell(window.wordleRow, j);'
    '        if (c) guess += c.textContent || c.innerText;'
    '    }'
    '   '
    '   if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '      ajaxRequest(WORDLE_FORM.WordleHTML, '#39'SubmitGuess'#39', ['#39'guess' +
      '='#39' + guess]);'
    '   }'
    '};'
    ''
    'window.handleInput = function(key) {'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    '    if (key === '#39'BACKSPACE'#39') window.deleteLetter();'
    '    else if (key === '#39'ENTER'#39') window.submitGuess();'
    '    else if (window.isLetter(key)) {'
    
      '        if (window.wordleLang === '#39'tr'#39' && key === '#39'i'#39') key = '#39#304#39 +
      ';'
    '        window.addLetter(key.toUpperCase());'
    '    }'
    '};'
    ''
    'window.processWordleResult = function(resultArray) {'
    '    if (window.wordleGameOver) return;'
    '    var isWin = true;'
    ''
    '    for (var i = 0; i < resultArray.length; i++) {'
    '        var cell = window.getCell(window.wordleRow, i);'
    '        var status = resultArray[i].status;'
    '        var letter = resultArray[i].letter;'
    ''
    '        if (status !== '#39'correct'#39') isWin = false;'
    ''
    '        if (cell) {'
    '            cell.classList.remove('#39'filled'#39');'
    '            cell.classList.add(status);'
    '        }'
    ''
    
      '        var keyBtn = window.wordleEl('#39'.key[data-key="'#39' + letter ' +
      '+ '#39'"]'#39');'
    '        if (keyBtn) {'
    '            if (status === '#39'correct'#39') {'
    '                keyBtn.classList.remove('#39'present'#39', '#39'absent'#39');'
    '                keyBtn.classList.add('#39'correct'#39');'
    
      '            } else if (status === '#39'present'#39' && !keyBtn.classList' +
      '.contains('#39'correct'#39')) {'
    '                keyBtn.classList.remove('#39'absent'#39');'
    '                keyBtn.classList.add('#39'present'#39');'
    
      '            } else if (status === '#39'absent'#39' && !keyBtn.classList.' +
      'contains('#39'correct'#39') && !keyBtn.classList.contains('#39'present'#39')) {'
    '                keyBtn.classList.add('#39'absent'#39');'
    '            }'
    '        }'
    '    }'
    ''
    '    window.wordleRow++;'
    '    window.wordleCol = 0;'
    '    window.wordleIsWin = isWin;'
    ''
    '    if (isWin || window.wordleRow >= window.wordleMaxGuesses) {'
    
      '        setTimeout(function() { window.showWordleGameOver(false)' +
      '; }, 1500);'
    '    }'
    '};'
    ''
    'window.showWordleError = function(errorMsg) {'
    '    for (var i = 0; i < window.wordleLength; i++) {'
    '        var cell = window.getCell(window.wordleRow, i);'
    '        if (cell) {'
    '            cell.classList.remove('#39'shake'#39', '#39'error'#39');'
    '            void cell.offsetWidth;'
    '            cell.classList.add('#39'shake'#39', '#39'error'#39');'
    '            '
    '            setTimeout((function(c) {'
    '                return function() {'
    '                    c.classList.remove('#39'error'#39');'
    '                };'
    '            })(cell), 800);'
    '        }'
    '    }'
    '};'
    ''
    
      'if (window.wordleKeyHandler) document.removeEventListener('#39'keydo' +
      'wn'#39', window.wordleKeyHandler);'
    
      'if (window.wordleClickHandler) document.removeEventListener('#39'cli' +
      'ck'#39', window.wordleClickHandler);'
    ''
    'window.wordleKeyHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    
      '    if (e.ctrlKey || e.metaKey || e.altKey || window.wordleGameO' +
      'ver) return;'
    '    var key = e.key.toUpperCase();'
    '    if (e.key === '#39'Backspace'#39') key = '#39'BACKSPACE'#39';'
    '    if (e.key === '#39'Enter'#39') key = '#39'ENTER'#39';'
    '    if (window.wordleLang === '#39'tr'#39' && e.key === '#39'i'#39') key = '#39#304#39';'
    '    window.handleInput(key);'
    '};'
    ''
    'window.wordleClickHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    '    if (window.wordleGameOver) return;'
    '    var keyElement = e.target.closest('#39'.key'#39');'
    '    if (keyElement) {'
    '        var keyValue = keyElement.getAttribute('#39'data-key'#39');'
    '        if (keyValue) window.handleInput(keyValue);'
    '        keyElement.blur();'
    '    }'
    '};'
    ''
    'document.addEventListener('#39'keydown'#39', window.wordleKeyHandler);'
    'document.addEventListener('#39'click'#39', window.wordleClickHandler);')
  TextHeight = 15
  object WordleHTML: TUniHTMLFrame
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
      
        '        margin: 0 !important; padding: 0 !important; width: 100%' +
        ' !important; height: 100% !important;'
      
        '        background-color: #121213 !important; overflow: hidden !' +
        'important; overscroll-behavior: none !important; touch-action: n' +
        'one !important;'
      
        '        -webkit-border-radius: 0 !important; border-radius: 0 !i' +
        'mportant; -webkit-appearance: none !important; appearance: none ' +
        '!important;'
      '    }'
      ''
      '    .wordle-viewport {'
      
        '        position: fixed; top: 0; left: 0; right: 0; bottom: 0; w' +
        'idth: 100vw; height: 100vh; height: 100dvh;'
      
        '        background-color: #121213 !important; display: flex; fle' +
        'x-direction: column; align-items: center;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif; color: #ffffff; z-index: 9999; overflow: hidden;'
      
        '        padding-top: env(safe-area-inset-top); padding-bottom: e' +
        'nv(safe-area-inset-bottom); box-sizing: border-box;'
      '        box-shadow: 0 0 0 100vmax #121213; clip-path: inset(0);'
      '    }'
      ''
      '    /* ========================================='
      '       OYUN EKRANI CSS'#39'LER'#304
      '       ========================================= */'
      
        '    .wordle-header { width: 100%; max-width: 500px; display: fle' +
        'x; justify-content: space-between; align-items: center; padding:' +
        ' 10px 15px; border-bottom: 1px solid #3a3a3c; box-sizing: border' +
        '-box; background-color: #121213; }'
      
        '    .wordle-header h1 { margin: 0; font-size: 1.5rem; letter-spa' +
        'cing: 2px; font-weight: 800; text-align: center; }'
      
        '    .btn-back { background: none; border: none; color: #818384; ' +
        'font-size: 1.3rem; cursor: pointer; transition: color 0.2s; padd' +
        'ing: 5px; }'
      ''
      
        '    .wordle-timer { font-family: '#39'Courier New'#39', Courier, monospa' +
        'ce; color: #818384; font-size: 1.2rem; font-weight: bold; width:' +
        ' 60px; text-align: right; }'
      ''
      
        '    .wordle-board-container { flex-grow: 1; display: flex; justi' +
        'fy-content: center; align-items: center; width: 100%; padding: 1' +
        '0px; box-sizing: border-box; min-height: 0; background-color: #1' +
        '21213; }'
      
        '    .wordle-board { display: grid; grid-template-rows: repeat(6,' +
        ' 1fr); grid-template-columns: repeat(5, 1fr); gap: 6px; width: 1' +
        '00%; max-width: 340px; aspect-ratio: 5 / 6; }'
      '    '
      
        '    .wordle-cell { width: 100%; height: 100%; border: 2px solid ' +
        '#3a3a3c; display: flex; justify-content: center; align-items: ce' +
        'nter; font-size: 2rem; font-weight: bold; text-transform: upperc' +
        'ase; box-sizing: border-box; user-select: none; transition: tran' +
        'sform 0.1s, background-color 0.4s, border-color 0.4s; }'
      '    .wordle-cell.filled { border-color: #565758; }'
      
        '    .wordle-cell.correct { background-color: #538d4e; border-col' +
        'or: #538d4e; }'
      
        '    .wordle-cell.present { background-color: #b59f3b; border-col' +
        'or: #b59f3b; }'
      
        '    .wordle-cell.absent { background-color: #3a3a3c; border-colo' +
        'r: #3a3a3c; }'
      ''
      
        '    .wordle-keyboard { width: 100%; max-width: 500px; padding: 0' +
        ' 8px 15px 8px; box-sizing: border-box; background-color: #121213' +
        '; }'
      
        '    .keyboard-row { display: flex; justify-content: center; widt' +
        'h: 100%; margin-bottom: 6px; gap: 4px; box-sizing: border-box; }'
      '    '
      
        '    .key { background-color: #818384; color: #ffffff; border: no' +
        'ne; border-radius: 4px; height: 48px; font-size: 1rem; font-weig' +
        'ht: bold; display: flex; justify-content: center; align-items: c' +
        'enter; cursor: pointer; text-transform: uppercase; user-select: ' +
        'none; flex: 1; max-width: 40px; transition: background-color 0.1' +
        's, transform 0.1s, opacity 0.2s; -webkit-tap-highlight-color: tr' +
        'ansparent; }'
      
        '    .key.wide { flex: 1.5; max-width: 60px; font-size: 0.85rem; ' +
        '}'
      '    .key:active { transform: scale(0.95); }'
      '    .key.correct { background-color: #538d4e; }'
      '    .key.present { background-color: #b59f3b; }'
      '    .key.absent { background-color: #3a3a3c; }'
      ''
      '    /* ========================================='
      '       CUSTOM SONU'#199' PANEL'#304' CSS'#39'LER'#304
      '       ========================================= */'
      
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
      '    '
      
        '    .crm-subtext { color: #818384; font-size: 0.85rem; margin-bo' +
        'ttom: 12px; display: none; }'
      '    '
      '    /* YEN'#304': DA'#304'RES'#304'Z, '#199#304'ZG'#304'L'#304' DERECE ALANI */'
      
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
      '    /* NOTA G'#214'RE RENK ALAN AYIRICI '#199#304'ZG'#304' */'
      
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
      '    /* ========================================='
      '       AN'#304'MASYONLAR'
      '       ========================================= */'
      
        '    @keyframes swalPopIn { 0% { opacity: 0; transform: scale(0.8' +
        '); } 80% { transform: scale(1.05); opacity: 1; } 100% { transfor' +
        'm: scale(1); opacity: 1; } }'
      
        '    @keyframes gradeSectionIn { 0% { opacity: 0; transform: scal' +
        'e(0.5) translateY(20px); } 100% { opacity: 1; transform: scale(1' +
        ') translateY(0); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      '    @keyframes shake {'
      '        10%, 90% { transform: translate3d(-2px, 0, 0); }'
      '        20%, 80% { transform: translate3d(4px, 0, 0); }'
      '        30%, 50%, 70% { transform: translate3d(-6px, 0, 0); }'
      '        40%, 60% { transform: translate3d(6px, 0, 0); }'
      '    }'
      
        '    .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97)' +
        ' both; }'
      ''
      '    /* ========================================='
      '       MEDIA QUERIES'
      '       ========================================= */'
      '    @media (hover: hover) and (pointer: fine) { '
      '        .btn-back:hover { color: #ffffff; } '
      '        .key:hover { opacity: 0.85; } '
      '        .modal-save-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    @media (max-width: 500px) {'
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 450px; }'
      '        '
      '        .wordle-header { padding: 8px 10px; }'
      '        .wordle-header h1 { font-size: 1.3rem; }'
      '        .wordle-board { max-width: 310px; gap: 5px; }'
      '        .wordle-cell { font-size: 1.7rem; }'
      '        .key { height: 44px; font-size: 0.8rem; }'
      '    }'
      '    '
      '    @media (max-width: 360px) {'
      '        .wordle-board { max-width: 300px; gap: 4px; }'
      '        .wordle-cell { font-size: 1.6rem; }'
      '        .key { height: 42px; font-size: 0.75rem; }'
      '    }'
      '</style>'
      ''
      '<div class="wordle-viewport">'
      '    <div class="wordle-header">'
      
        '        <button class="btn-back" onclick="window.closeResultModa' +
        'l()"><i class="fa-solid fa-arrow-left"></i></button>'
      '        <h1 id="wordleTitle">WORDLE</h1>'
      '        <div id="wordleTimer" class="wordle-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="wordle-board-container">'
      '        <div class="wordle-board" id="wordleBoard"></div>'
      '    </div>'
      ''
      '    <div class="wordle-keyboard" id="wordleKeyboard"></div>'
      ''
      '    <div class="oct-modal-overlay" id="customResultModal">'
      '        <div class="oct-modal-content">'
      '            <div class="modal-header">'
      '                <h2 id="crmTitle">TEBR'#304'KLER!</h2>'
      '            </div>'
      '            '
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
    OnAjaxEvent = WordleHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 1
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 584
    Top = 184
  end
end
