object NERDLE_FORM: TNERDLE_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'NERDLE_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.nerdleGameOver = false;'
    'window.nerdleRow = 0;'
    'window.nerdleCol = 0;'
    'window.nerdleMaxGuesses = 6;'
    'window.nerdleLength = 8;'
    'window.nerdleElapsedTime = 0;'
    'window.nerdleTimerInterval = null;'
    'window.finalGrade = "";'
    'window.nerdleIsWin = false;'
    'window.currentPuzzleId = "";'
    'window.isNerdleInitialized = false;'
    'window.nerdleStartTimeStamp = 0;'
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.nerdle-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    
      'window.nerdleEl = function(selector) { var vp = window.getVisibl' +
      'eViewport(); return vp ? vp.querySelector(selector) : null; };'
    
      'window.nerdleEls = function(selector) { var vp = window.getVisib' +
      'leViewport(); return vp ? vp.querySelectorAll(selector) : []; };'
    ''
    'window.getTodayStr = function() {'
    '    var d = new Date();'
    '    var m = (d.getMonth() + 1).toString().padStart(2, '#39'0'#39');'
    '    var day = d.getDate().toString().padStart(2, '#39'0'#39');'
    '    return d.getFullYear() + '#39'-'#39' + m + '#39'-'#39' + day;'
    '};'
    ''
    'window.initNerdleWithServer = function(serverId) {'
    '    if (!window.nerdleGameOver) {'
    '        window.nerdleRow = 0;'
    '        window.nerdleCol = 0;'
    '        window.nerdleElapsedTime = 0;'
    '        window.nerdleIsWin = false;'
    '        window.finalGrade = "";'
    '    }'
    '    if (serverId && serverId !== "") {'
    '        window.currentPuzzleId = serverId;'
    '    } else {'
    '        window.currentPuzzleId = window.getTodayStr();'
    '    }'
    '    window.isNerdleInitialized = true;'
    '    window.initNerdleBoard();'
    '};'
    ''
    'window.initNerdleBoard = function() {'
    
      '    var boardEl = window.nerdleEl('#39'#nerdleBoard'#39') || document.ge' +
      'tElementById('#39'nerdleBoard'#39');'
    
      '    if (!boardEl) { setTimeout(window.initNerdleBoard, 100); ret' +
      'urn; }'
    '    '
    '    boardEl.innerHTML = '#39#39'; '
    
      '    for (var i = 0; i < (window.nerdleMaxGuesses * window.nerdle' +
      'Length); i++) {'
    '        var cell = document.createElement('#39'div'#39');'
    '        cell.className = '#39'nerdle-cell'#39';'
    '        boardEl.appendChild(cell);'
    '    }'
    '    if (!window.nerdleGameOver) {'
    '        window.loadNerdleState();'
    '    }'
    '};'
    ''
    'window.startNerdleTimer = function() {'
    
      '    if (window.nerdleTimerInterval) clearInterval(window.nerdleT' +
      'imerInterval);'
    
      '    if (window.nerdleGameOver || !window.isNerdleInitialized) re' +
      'turn;'
    '    '
    
      '    if (!window.nerdleStartTimeStamp || window.nerdleStartTimeSt' +
      'amp === 0) {'
    
      '        window.nerdleStartTimeStamp = Date.now() - (window.nerdl' +
      'eElapsedTime * 1000);'
    '    }'
    '    var timerEl = window.nerdleEl('#39'#nerdleTimer'#39');'
    '    window.nerdleTimerInterval = setInterval(function() {'
    
      '        window.nerdleElapsedTime = Math.floor((Date.now() - wind' +
      'ow.nerdleStartTimeStamp) / 1000);'
    '        if (timerEl) {'
    
      '            var m = Math.floor(window.nerdleElapsedTime / 60).to' +
      'String().padStart(2, '#39'0'#39');'
    
      '            var s = (window.nerdleElapsedTime % 60).toString().p' +
      'adStart(2, '#39'0'#39');'
    '            timerEl.textContent = m + '#39':'#39' + s;'
    '        }'
    
      '        if (window.nerdleElapsedTime % 5 === 0) window.saveNerdl' +
      'eState();'
    '    }, 1000);'
    '};'
    ''
    'window.saveNerdleState = function() {'
    
      '    if (!window.isNerdleInitialized || !window.getVisibleViewpor' +
      't()) return; '
    ''
    '    var state = {'
    '        puzzleId: window.currentPuzzleId,'
    '        row: window.nerdleRow,'
    '        col: window.nerdleCol,'
    '        time: window.nerdleElapsedTime,'
    '        completed: window.nerdleGameOver,'
    '        grade: window.finalGrade,'
    '        isWin: window.nerdleIsWin,'
    '        cells: [],'
    '        keys: {}'
    '    };'
    '    var cells = window.nerdleEls('#39'.nerdle-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    '        var status = "";'
    
      '        if (cells[i].classList.contains('#39'correct'#39')) status = '#39'co' +
      'rrect'#39';'
    
      '        else if (cells[i].classList.contains('#39'present'#39')) status ' +
      '= '#39'present'#39';'
    
      '        else if (cells[i].classList.contains('#39'absent'#39')) status =' +
      ' '#39'absent'#39';'
    
      '        state.cells.push({ text: cells[i].innerText || cells[i].' +
      'textContent, status: status });'
    '    }'
    '    var keys = window.nerdleEls('#39'.key'#39');'
    '    for (var k = 0; k < keys.length; k++) {'
    '        var keyChar = keys[k].getAttribute('#39'data-key'#39');'
    '        if (keyChar) {'
    '            var kStatus = "";'
    
      '            if (keys[k].classList.contains('#39'correct'#39')) kStatus =' +
      ' '#39'correct'#39';'
    
      '            else if (keys[k].classList.contains('#39'present'#39')) kSta' +
      'tus = '#39'present'#39';'
    
      '            else if (keys[k].classList.contains('#39'absent'#39')) kStat' +
      'us = '#39'absent'#39';'
    '            if (kStatus !== "") state.keys[keyChar] = kStatus;'
    '        }'
    '    }'
    
      '    localStorage.setItem('#39'octaily_nerdle_state'#39', JSON.stringify(' +
      'state));'
    '};'
    ''
    'window.loadNerdleState = function() {'
    '    if (!window.isNerdleInitialized) return;'
    '    var saved = localStorage.getItem('#39'octaily_nerdle_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.puzzleId === window.currentPuzzleId) {'
    '                window.nerdleRow = state.row || 0;'
    '                window.nerdleCol = state.col || 0;'
    '                window.nerdleElapsedTime = state.time || 0;'
    
      '                window.nerdleGameOver = state.completed || false' +
      ';'
    '                window.finalGrade = state.grade || "";'
    '                window.nerdleIsWin = state.isWin || false;'
    ''
    '                var cells = window.nerdleEls('#39'.nerdle-cell'#39');'
    '                for (var i = 0; i < state.cells.length; i++) {'
    '                    if (cells[i] && state.cells[i]) {'
    
      '                        cells[i].textContent = state.cells[i].te' +
      'xt;'
    '                        cells[i].className = '#39'nerdle-cell'#39';'
    
      '                        if (state.cells[i].text !== '#39#39') cells[i]' +
      '.classList.add('#39'filled'#39');'
    
      '                        if (state.cells[i].status !== '#39#39') cells[' +
      'i].classList.add(state.cells[i].status);'
    '                    }'
    '                }'
    ''
    '                var keys = window.nerdleEls('#39'.key'#39');'
    '                for (var k = 0; k < keys.length; k++) {'
    
      '                    keys[k].classList.remove('#39'correct'#39', '#39'present' +
      #39', '#39'absent'#39');'
    
      '                    var keyChar = keys[k].getAttribute('#39'data-key' +
      #39');'
    '                    if (keyChar && state.keys[keyChar]) {'
    
      '                        keys[k].classList.add(state.keys[keyChar' +
      ']);'
    '                    }'
    '                }'
    ''
    '                if (window.nerdleGameOver) {'
    
      '                    setTimeout(function() { window.showNerdleGam' +
      'eOver(true); }, 300);'
    '                } else {'
    '                    window.startNerdleTimer();'
    '                }'
    '            } else {'
    '                localStorage.removeItem('#39'octaily_nerdle_state'#39');'
    '                window.resetNerdleUI();'
    '            }'
    '        } catch (e) { window.resetNerdleUI(); }'
    '    } else {'
    '        window.resetNerdleUI();'
    '    }'
    '};'
    ''
    'window.resetNerdleUI = function() {'
    '    window.nerdleRow = 0;'
    '    window.nerdleCol = 0;'
    '    window.nerdleElapsedTime = 0;'
    '    window.nerdleGameOver = false;'
    '    window.finalGrade = "";'
    '    window.nerdleIsWin = false;'
    '    '
    '    var cells = window.nerdleEls('#39'.nerdle-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    '        cells[i].textContent = '#39#39';'
    '        cells[i].className = '#39'nerdle-cell'#39';'
    '    }'
    '    var keys = window.nerdleEls('#39'.key'#39');'
    '    for (var k = 0; k < keys.length; k++) {'
    
      '        keys[k].classList.remove('#39'correct'#39', '#39'present'#39', '#39'absent'#39')' +
      ';'
    '    }'
    '    window.startNerdleTimer();'
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
    
      'window.showNerdleGameOver = function(isReplay, savedTries, saved' +
      'Time, savedIsWin) {'
    
      '    if (window.nerdleTimerInterval) clearInterval(window.nerdleT' +
      'imerInterval);'
    ''
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.nerdleElapsedTime;'
    
      '    var tries = (isReplay && savedTries !== undefined) ? savedTr' +
      'ies : window.nerdleRow;'
    
      '    var isWin = (isReplay && savedIsWin !== undefined) ? savedIs' +
      'Win : window.nerdleIsWin;'
    ''
    '    var grade = window.calculateGrade(tries, isWin);'
    ''
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) {'
    '        window.nerdleGameOver = true;'
    '        window.finalGrade = grade;'
    '        window.saveNerdleState();'
    ''
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(NERDLE_FORM.NerdleHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'tries='#39' + tries, '
    '                '#39'grade='#39' + grade, '
    '                '#39'isWin='#39' + (isWin ? '#39'1'#39' : '#39'0'#39'),'
    '                '#39'game_type=nerdle'#39' '
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
    
      '        subTextEl.innerHTML = '#39'Bug'#252'n'#252'n denklemini zaten '#231#246'zd'#252'n!'#39 +
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
    '    var triesStr = isWin ? tries + '#39'/6'#39' : '#39'X/6'#39';'
    '    if (isReplay && tries === 0 && !isWin) { triesStr = '#39'-/6'#39'; }'
    '    document.getElementById('#39'crmTries'#39').innerText = triesStr;'
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
    
      '            ajaxRequest(NERDLE_FORM.NerdleHTML, '#39'GetPanelStats'#39',' +
      ' ['#39'game_type=nerdle'#39']);'
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
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(NERDLE_F' +
      'ORM.NerdleHTML, '#39'closePage'#39');'
    '};'
    ''
    
      'window.isValidNerdleChar = function(str) { return str.length ===' +
      ' 1 && /[0-9+\-*/=]/.test(str); };'
    ''
    'window.getCell = function(row, col) {'
    '    var cells = window.nerdleEls('#39'.nerdle-cell'#39');'
    '    if (cells.length === 0) return null;'
    '    return cells[(row * window.nerdleLength) + col];'
    '};'
    ''
    'window.addLetter = function(letter) {'
    
      '    if (window.nerdleGameOver || !window.isNerdleInitialized) re' +
      'turn;'
    
      '    if (window.nerdleCol < window.nerdleLength && window.nerdleR' +
      'ow < window.nerdleMaxGuesses) {'
    
      '        var cell = window.getCell(window.nerdleRow, window.nerdl' +
      'eCol);'
    '        if (cell) {'
    
      '            cell.textContent = letter; cell.classList.add('#39'fille' +
      'd'#39'); window.nerdleCol++; window.saveNerdleState();'
    '        }'
    '    }'
    '};'
    ''
    'window.deleteLetter = function() {'
    
      '    if (window.nerdleGameOver || !window.isNerdleInitialized) re' +
      'turn;'
    '    if (window.nerdleCol > 0) {'
    '        window.nerdleCol--;'
    
      '        var cell = window.getCell(window.nerdleRow, window.nerdl' +
      'eCol);'
    '        if (cell) {'
    
      '            cell.textContent = '#39#39'; cell.classList.remove('#39'filled' +
      #39', '#39'error'#39', '#39'shake'#39'); window.saveNerdleState();'
    '        }'
    '    }'
    '};'
    ''
    'window.submitGuess = function() {'
    
      '    if (window.nerdleGameOver || !window.isNerdleInitialized) re' +
      'turn;'
    '    if (window.nerdleCol !== window.nerdleLength) {'
    '        for (var i = 0; i < window.nerdleCol; i++) {'
    '            var cell = window.getCell(window.nerdleRow, i);'
    
      '            if (cell) { cell.classList.remove('#39'shake'#39'); void cel' +
      'l.offsetWidth; cell.classList.add('#39'shake'#39'); }'
    '        }'
    '        return;'
    '    }'
    '    var guess = '#39#39';'
    '    for (var j = 0; j < window.nerdleLength; j++) {'
    '        var c = window.getCell(window.nerdleRow, j);'
    '        if (c) guess += c.textContent || c.innerText;'
    '    }'
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(NERDLE_FORM.NerdleHTML, '#39'SubmitGuess'#39', ['#39'gue' +
      'ss='#39' + guess]);'
    '    }'
    '};'
    ''
    'window.handleInput = function(key) {'
    
      '    if (window.nerdleGameOver || !window.isNerdleInitialized) re' +
      'turn;'
    '    if (key === '#39'BACKSPACE'#39') window.deleteLetter();'
    '    else if (key === '#39'ENTER'#39') window.submitGuess();'
    
      '    else if (window.isValidNerdleChar(key)) window.addLetter(key' +
      ');'
    '};'
    ''
    'window.processNerdleResult = function(resultArray) {'
    '    if (window.nerdleGameOver) return;'
    '    var isWin = true;'
    '    for (var i = 0; i < resultArray.length; i++) {'
    '        var cell = window.getCell(window.nerdleRow, i);'
    '        var status = resultArray[i].status;'
    '        var letter = "";'
    '        if (status !== '#39'correct'#39') isWin = false;'
    '        if (cell) {'
    '            letter = cell.textContent || cell.innerText;'
    '            cell.classList.remove('#39'filled'#39');'
    '            cell.classList.add(status);'
    '        }'
    '        if (letter) {'
    
      '            var keyBtn = window.nerdleEl('#39'.key[data-key="'#39' + let' +
      'ter + '#39'"]'#39');'
    '            if (keyBtn) {'
    '                if (status === '#39'correct'#39') {'
    
      '                    keyBtn.classList.remove('#39'present'#39', '#39'absent'#39')' +
      '; keyBtn.classList.add('#39'correct'#39');'
    
      '                } else if (status === '#39'present'#39' && !keyBtn.class' +
      'List.contains('#39'correct'#39')) {'
    
      '                    keyBtn.classList.remove('#39'absent'#39'); keyBtn.cl' +
      'assList.add('#39'present'#39');'
    
      '                } else if (status === '#39'absent'#39' && !keyBtn.classL' +
      'ist.contains('#39'correct'#39') && !keyBtn.classList.contains('#39'present'#39')' +
      ') {'
    '                    keyBtn.classList.add('#39'absent'#39');'
    '                }'
    '            }'
    '        }'
    '    }'
    
      '    window.nerdleRow++; window.nerdleCol = 0; window.nerdleIsWin' +
      ' = isWin; window.saveNerdleState();'
    '    if (isWin || window.nerdleRow >= window.nerdleMaxGuesses) {'
    
      '        setTimeout(function() { window.showNerdleGameOver(false)' +
      '; }, 1500);'
    '    }'
    '};'
    ''
    'window.showNerdleError = function(errorMsg) {'
    '    for (var i = 0; i < window.nerdleLength; i++) {'
    '        var cell = window.getCell(window.nerdleRow, i);'
    '        if (cell) {'
    '            cell.classList.remove('#39'shake'#39', '#39'error'#39');'
    '            void cell.offsetWidth;'
    '            cell.classList.add('#39'shake'#39', '#39'error'#39');'
    
      '            setTimeout((function(c) { return function() { c.clas' +
      'sList.remove('#39'error'#39'); }; })(cell), 800);'
    '        }'
    '    }'
    '};'
    ''
    
      'if (window.nerdleKeyHandler) document.removeEventListener('#39'keydo' +
      'wn'#39', window.nerdleKeyHandler);'
    
      'if (window.nerdleClickHandler) document.removeEventListener('#39'cli' +
      'ck'#39', window.nerdleClickHandler);'
    ''
    'window.nerdleKeyHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    
      '    if (e.ctrlKey || e.metaKey || e.altKey || window.nerdleGameO' +
      'ver) return;'
    '    var key = e.key.toUpperCase();'
    '    if (e.key === '#39'Backspace'#39') key = '#39'BACKSPACE'#39';'
    '    if (e.key === '#39'Enter'#39') key = '#39'ENTER'#39';'
    '    window.handleInput(key);'
    '};'
    ''
    'window.nerdleClickHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    '    if (window.nerdleGameOver) return;'
    '    var keyElement = e.target.closest('#39'.key'#39');'
    '    if (keyElement) {'
    '        var keyValue = keyElement.getAttribute('#39'data-key'#39');'
    '        if (keyValue) window.handleInput(keyValue);'
    '        keyElement.blur();'
    '    }'
    '};'
    ''
    'document.addEventListener('#39'keydown'#39', window.nerdleKeyHandler);'
    'document.addEventListener('#39'click'#39', window.nerdleClickHandler);')
  TextHeight = 15
  object NerdleHTML: TUniHTMLFrame
    Left = 0
    Top = 0
    Width = 800
    Height = 600
    Hint = ''
    HTML.Strings = (
      '<style>'
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
      '    .nerdle-viewport {'
      '        position: fixed; top: 0; left: 0; right: 0; bottom: 0; '
      '        width: 100vw; height: 100vh; height: 100dvh;'
      
        '        background-color: #121213 !important; display: flex; fle' +
        'x-direction: column; align-items: center;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif; color: #ffffff; z-index: 9999; overflow: hidden;'
      
        '        padding-top: env(safe-area-inset-top); padding-bottom: e' +
        'nv(safe-area-inset-bottom); box-sizing: border-box;'
      '        box-shadow: 0 0 0 100vmax #121213; clip-path: inset(0); '
      '    }'
      ''
      
        '    .nerdle-header { width: 100%; max-width: 600px; display: fle' +
        'x; justify-content: space-between; align-items: center; padding:' +
        ' 10px 15px; border-bottom: 1px solid #3a3a3c; box-sizing: border' +
        '-box; background-color: #121213; }'
      
        '    .nerdle-header h1 { margin: 0; font-size: 1.5rem; letter-spa' +
        'cing: 2px; font-weight: 800; text-align: center; }'
      
        '    .btn-back { background: none; border: none; color: #818384; ' +
        'font-size: 1.4rem; cursor: pointer; transition: color 0.2s; padd' +
        'ing: 5px; -webkit-tap-highlight-color: transparent; }'
      
        '    .nerdle-timer { font-family: '#39'Courier New'#39', Courier, monospa' +
        'ce; color: #818384; font-size: 1.2rem; font-weight: bold; width:' +
        ' 60px; text-align: right; }'
      ''
      
        '    .nerdle-board-container { flex-grow: 1; display: flex; justi' +
        'fy-content: center; align-items: center; width: 100%; padding: 1' +
        '0px; box-sizing: border-box; min-height: 0; background-color: #1' +
        '21213; }'
      
        '    .nerdle-board { display: grid; grid-template-rows: repeat(6,' +
        ' 1fr); grid-template-columns: repeat(8, 1fr); gap: 6px; width: 1' +
        '00%; max-width: 520px; aspect-ratio: 8 / 6; }'
      
        '    .nerdle-cell { width: 100%; height: 100%; border: 2px solid ' +
        '#3a3a3c; display: flex; justify-content: center; align-items: ce' +
        'nter; font-size: 2.2rem; font-weight: bold; box-sizing: border-b' +
        'ox; user-select: none; transition: transform 0.1s, background-co' +
        'lor 0.4s, border-color 0.4s; -webkit-tap-highlight-color: transp' +
        'arent; }'
      '    .nerdle-cell.filled { border-color: #565758; }'
      
        '    .nerdle-cell.correct { background-color: #538d4e; border-col' +
        'or: #538d4e; }'
      
        '    .nerdle-cell.present { background-color: #90306A; border-col' +
        'or: #90306A; } '
      
        '    .nerdle-cell.absent { background-color: #3a3a3c; border-colo' +
        'r: #3a3a3c; }'
      
        '    .nerdle-cell.error { background-color: #e74c3c !important; b' +
        'order-color: #e74c3c !important; color: #fff !important; }'
      ''
      
        '    .nerdle-keyboard { width: 100%; max-width: 600px; padding: 0' +
        ' 8px 20px 8px; box-sizing: border-box; background-color: #121213' +
        '; }'
      
        '    .keyboard-row { display: flex; justify-content: center; widt' +
        'h: 100%; margin-bottom: 6px; gap: 4px; box-sizing: border-box; }'
      
        '    .key { background-color: #818384; color: #ffffff; border: no' +
        'ne; border-radius: 4px; height: 55px; font-size: 1.3rem; font-we' +
        'ight: bold; display: flex; justify-content: center; align-items:' +
        ' center; cursor: pointer; user-select: none; flex: 1; max-width:' +
        ' 45px; transition: transform 0.1s, background-color 0.1s; -webki' +
        't-tap-highlight-color: transparent; }'
      '    .key.wide { flex: 1.5; max-width: 80px; font-size: 1.1rem; }'
      '    .key:active { transform: scale(0.92); }'
      '    .key.correct { background-color: #538d4e; }'
      '    .key.present { background-color: #90306A; }'
      '    .key.absent { background-color: #3a3a3c; }'
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
      
        '    .oct-modal-content { background: #161618; width: 100%; max-w' +
        'idth: 350px; border-radius: 16px; border: 1px solid #333; displa' +
        'y: flex; flex-direction: column; text-align: center; overflow: h' +
        'idden; opacity: 0; max-height: 92vh; }'
      
        '    .oct-modal-overlay.active .oct-modal-content { animation: sw' +
        'alPopIn 0.4s cubic-bezier(0.34, 1.56, 0.64, 1) forwards; }'
      
        '    .modal-header { padding: 18px 20px; background: #1a1a1c; dis' +
        'play: flex; justify-content: center; align-items: center; border' +
        '-bottom: 1px solid #2a2a2c; position: relative; flex-shrink: 0; ' +
        '}'
      
        '    .modal-header h2 { margin: 0; font-size: 1.2rem; color: #fff' +
        '; font-weight: 800; letter-spacing: 1.5px; text-transform: upper' +
        'case; }'
      
        '    .modal-body { padding: 15px 20px; display: flex; flex-direct' +
        'ion: column; align-items: center; overflow-y: auto; touch-action' +
        ': pan-y; -webkit-overflow-scrolling: touch; overscroll-behavior:' +
        ' contain; flex-grow: 1; }'
      
        '    .crm-subtext { color: #818384; font-size: 0.85rem; margin-bo' +
        'ttom: 12px; display: none; }'
      
        '    .crm-grade-section { margin: 5px auto 10px auto; display: fl' +
        'ex; flex-direction: column; align-items: center; width: 100%; fl' +
        'ex-shrink: 0; opacity: 0; }'
      
        '    .oct-modal-overlay.active .crm-grade-section { animation: gr' +
        'adeSectionIn 0.5s cubic-bezier(0.34, 1.56, 0.64, 1) 0.2s forward' +
        's; }'
      
        '    .crm-grade-label { font-size: 0.75rem; color: #818384; font-' +
        'weight: bold; letter-spacing: 2px; margin-bottom: 2px; text-tran' +
        'sform: uppercase; }'
      
        '    .crm-grade-value { font-size: 4.5rem; font-weight: 900; line' +
        '-height: 1.1; position: relative; margin-bottom: 12px; transitio' +
        'n: text-shadow 0.3s ease; }'
      
        '    .crm-divider { width: 100%; height: 2px; border-radius: 2px;' +
        ' background-color: #3a3a3c; margin-bottom: 20px; opacity: 0; tra' +
        'nsition: background-color 0.3s ease, box-shadow 0.3s ease; }'
      
        '    .oct-modal-overlay.active .crm-divider { animation: fadeIn 0' +
        '.5s ease 0.4s forwards; }'
      
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
      
        '    .crm-answer-val { font-size: 1.5rem; color: #fff; font-weigh' +
        't: 800; letter-spacing: 3px; word-break: break-all; line-height:' +
        ' 1.4; }'
      ''
      
        '    .modal-save-btn { width: 100%; background: #538d4e; color: #' +
        'fff; border: none; padding: 16px; border-radius: 12px; font-weig' +
        'ht: 800; font-size: 1rem; cursor: pointer; transition: 0.3s; fle' +
        'x-shrink: 0; text-transform: uppercase; letter-spacing: 1px; }'
      ''
      
        '    @keyframes shake { 10%, 90% { transform: translate3d(-2px, 0' +
        ', 0); } 20%, 80% { transform: translate3d(4px, 0, 0); } 30%, 50%' +
        ', 70% { transform: translate3d(-6px, 0, 0); } 40%, 60% { transfo' +
        'rm: translate3d(6px, 0, 0); } }'
      
        '    .shake { animation: shake 0.5s cubic-bezier(.36,.07,.19,.97)' +
        ' both; }'
      
        '    @keyframes swalPopIn { 0% { opacity: 0; transform: scale(0.8' +
        '); } 80% { transform: scale(1.05); opacity: 1; } 100% { transfor' +
        'm: scale(1); opacity: 1; } }'
      
        '    @keyframes gradeSectionIn { 0% { opacity: 0; transform: scal' +
        'e(0.5) translateY(20px); } 100% { opacity: 1; transform: scale(1' +
        ') translateY(0); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      ''
      
        '    @media (hover: hover) and (pointer: fine) { .btn-back:hover ' +
        '{ color: #ffffff; } .key:hover { opacity: 0.85; } .modal-save-bt' +
        'n:hover { background-color: #467a42; } }'
      ''
      '    @media (max-width: 500px) {'
      '        .nerdle-header { padding: 8px 10px; }'
      '        .nerdle-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        .nerdle-board-container { padding: 5px; }'
      
        '        .nerdle-board { max-width: 100vw; gap: 4px; padding: 0 5' +
        'px; box-sizing: border-box; }'
      '        .nerdle-cell { font-size: 1.5rem; border-width: 1.5px; }'
      
        '        .nerdle-keyboard { padding: 0 4px 10px 4px; max-width: 1' +
        '00vw; }'
      
        '        .keyboard-row { gap: 3px; margin-bottom: 5px; width: 100' +
        '%; }'
      
        '        .key { height: 48px; font-size: 1.15rem; max-width: none' +
        '; flex: 1 1 0; padding: 0; margin: 0; }'
      '        .key.wide { font-size: 0.85rem; flex: 1.5 1 0; }'
      '        '
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 450px; }'
      '    }'
      ''
      '    @media (max-width: 360px) {'
      '        .nerdle-board { gap: 3px; }'
      '        .nerdle-cell { font-size: 1.25rem; }'
      '        .keyboard-row { gap: 2px; }'
      '        .key { height: 44px; font-size: 1rem; }'
      '        .key.wide { font-size: 0.75rem; }'
      '    }'
      '</style>'
      ''
      '<div class="nerdle-viewport">'
      '    <div class="nerdle-header">'
      
        '        <button class="btn-back" onclick="ajaxRequest(NERDLE_FOR' +
        'M.NerdleHTML, '#39'closePage'#39');"><i class="fa-solid fa-arrow-left"><' +
        '/i></button>'
      '        <h1>NERDLE</h1>'
      '        <div id="nerdleTimer" class="nerdle-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="nerdle-board-container">'
      '        <div class="nerdle-board" id="nerdleBoard"></div>'
      '    </div>'
      ''
      '    <div class="nerdle-keyboard" id="nerdleKeyboard">'
      '        <div class="keyboard-row">'
      
        '            <div class="key" data-key="1">1</div><div class="key' +
        '" data-key="2">2</div><div class="key" data-key="3">3</div><div ' +
        'class="key" data-key="4">4</div><div class="key" data-key="5">5<' +
        '/div><div class="key" data-key="6">6</div><div class="key" data-' +
        'key="7">7</div><div class="key" data-key="8">8</div><div class="' +
        'key" data-key="9">9</div><div class="key" data-key="0">0</div>'
      '        </div>'
      '        <div class="keyboard-row">'
      
        '            <div class="key wide" id="keyEnter" data-key="ENTER"' +
        '>ENTER</div>'
      
        '            <div class="key" data-key="+">+</div><div class="key' +
        '" data-key="-">-</div><div class="key" data-key="*">*</div><div ' +
        'class="key" data-key="/">/</div><div class="key" data-key="=">=<' +
        '/div>'
      
        '            <div class="key wide" id="keyBackspace" data-key="BA' +
        'CKSPACE"><i class="fa-solid fa-delete-left"></i></div>'
      '        </div>'
      '    </div>'
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
    OnAjaxEvent = NerdleHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 1
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 624
    Top = 136
  end
end
