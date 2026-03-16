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
      'portant; margin: 10px auto !important; }";'
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
    'window.initNerdleWithServer = function(serverId) {'
    '    window.nerdleGameOver = false;'
    '    window.nerdleRow = 0;'
    '    window.nerdleCol = 0;'
    '    window.nerdleElapsedTime = 0;'
    '    window.nerdleIsWin = false;'
    '    window.finalGrade = "";'
    ''
    '    if (serverId && serverId !== "") {'
    '        window.currentPuzzleId = serverId;'
    '    } else {'
    '        window.currentPuzzleId = window.getTodayStr();'
    '    }'
    '    window.initNerdleBoard();'
    '};'
    ''
    'window.startNerdleTimer = function() {'
    
      '    if (window.nerdleTimerInterval) clearInterval(window.nerdleT' +
      'imerInterval);'
    '    if (window.nerdleGameOver) return;'
    
      '    var startTime = Date.now() - (window.nerdleElapsedTime * 100' +
      '0);'
    '    var timerEl = window.nerdleEl('#39'#nerdleTimer'#39');'
    '    window.nerdleTimerInterval = setInterval(function() {'
    
      '        window.nerdleElapsedTime = Math.floor((Date.now() - star' +
      'tTime) / 1000);'
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
    '    if (!window.getVisibleViewport()) return; '
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
    'window.initNerdleBoard = function() {'
    '    window.injectOctailyStyles();'
    
      '    var boardEl = window.nerdleEl('#39'#nerdleBoard'#39') || document.ge' +
      'tElementById('#39'nerdleBoard'#39');'
    
      '    if (!boardEl) { setTimeout(window.initNerdleBoard, 100); ret' +
      'urn; }'
    '    '
    '    boardEl.innerHTML = '#39#39'; '
    '    '
    
      '    for (var i = 0; i < (window.nerdleMaxGuesses * window.nerdle' +
      'Length); i++) {'
    '        var cell = document.createElement('#39'div'#39');'
    '        cell.className = '#39'nerdle-cell'#39';'
    '        boardEl.appendChild(cell);'
    '    }'
    '    window.loadNerdleState();'
    '};'
    ''
    'window.loadNerdleState = function() {'
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
    'window.showNerdleGameOver = function(isReplay) {'
    
      '    if (window.nerdleTimerInterval) clearInterval(window.nerdleT' +
      'imerInterval);'
    ''
    '    var time = window.nerdleElapsedTime;'
    '    var tries = window.nerdleRow;'
    '    var isWin = window.nerdleIsWin;'
    
      '    var grade = isReplay ? window.finalGrade : window.calculateG' +
      'rade(tries, isWin);'
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
    '        '
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
    
      '    var subText = isReplay ? '#39'<div style="color:#818384; font-si' +
      'ze:0.95rem; margin-bottom:20px;">Bug'#252'n'#252'n denklemini zaten '#231#246'zd'#252'n' +
      '!</div>'#39' : '#39#39';'
    
      '    var modalIcon = isReplay ? '#39'info'#39' : (isWin ? '#39'success'#39' : '#39'er' +
      'ror'#39');'
    '    var triesStr = isWin ? tries + '#39'/6'#39' : '#39'X/6'#39';'
    ''
    '    var htmlContent = subText +'
    
      '        '#39'<div style="display:flex; justify-content:space-around;' +
      ' align-items:center; margin-top:10px;">'#39' +'
    '            '#39'<div style="text-align:center;">'#39' +'
    
      '                '#39'<div style="font-size:3rem; font-weight:900; co' +
      'lor:'#39' + gradeColor + '#39';">'#39' + grade + '#39'</div>'#39' +'
    
      '                '#39'<div style="font-size:0.9rem; color:#818384; le' +
      'tter-spacing:1px;">DERECE</div>'#39' +'
    '            '#39'</div>'#39' +'
    '            '#39'<div style="text-align:center;">'#39' +'
    
      '                '#39'<div style="font-size:2rem; font-weight:bold; c' +
      'olor:#fff; line-height:3rem;">'#39' + timeStr + '#39'</div>'#39' +'
    
      '                '#39'<div style="font-size:0.9rem; color:#818384; le' +
      'tter-spacing:1px;">S'#220'RE</div>'#39' +'
    '            '#39'</div>'#39' +'
    '            '#39'<div style="text-align:center;">'#39' +'
    
      '                '#39'<div style="font-size:2rem; font-weight:bold; c' +
      'olor:#fff; line-height:3rem;">'#39' + triesStr + '#39'</div>'#39' +'
    
      '                '#39'<div style="font-size:0.9rem; color:#818384; le' +
      'tter-spacing:1px;">DENEME</div>'#39' +'
    '            '#39'</div>'#39' +'
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
    '        }); '
    '    }'
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
    '    if (window.nerdleGameOver) return;'
    
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
    '    if (window.nerdleGameOver) return;'
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
    '    if (window.nerdleGameOver) return;'
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
    '    if (window.nerdleGameOver) return;'
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
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal && errorMsg) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ', title: '#39'HATA!'#39', text: errorMsg, icon: '#39'warning'#39', toast: true, ' +
      'position: '#39'top'#39', showConfirmButton: false, timer: 2500, backgrou' +
      'nd: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39', customClass: { popup: '#39'oct-popu' +
      'p'#39' }'
    '        });'
    '    }'
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
      '    /* ========================================='
      '       S'#304'STEM RESET & SCROLL K'#304'L'#304'D'#304' (iOS & Android)'
      '       ========================================= */'
      '    html, body {'
      '        margin: 0 !important;'
      '        padding: 0 !important;'
      '        width: 100% !important;'
      '        height: 100% !important;'
      '        background-color: #121213 !important;'
      '        overflow: hidden !important;'
      '        overscroll-behavior: none !important;'
      '        touch-action: none !important;'
      '        -webkit-border-radius: 0 !important;'
      '        border-radius: 0 !important;'
      '        -webkit-appearance: none !important;'
      '        appearance: none !important;'
      '    }'
      ''
      '    /* ========================================='
      '       GENEL TASARIM VE V'#304'EWPORT'
      '       ========================================= */'
      '    .nerdle-viewport {'
      '        position: fixed;'
      
        '        top: 0; left: 0; right: 0; bottom: 0; /* iOS iframe soru' +
        'nlar'#305'n'#305' '#231#246'zer */'
      '        width: 100vw; height: 100vh; height: 100dvh;'
      '        background-color: #121213 !important;'
      
        '        display: flex; flex-direction: column; align-items: cent' +
        'er;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif;'
      '        color: #ffffff;'
      '        z-index: 9999;'
      '        overflow: hidden;'
      '        padding-top: env(safe-area-inset-top);'
      '        padding-bottom: env(safe-area-inset-bottom);'
      '        box-sizing: border-box;'
      '        overscroll-behavior: none;'
      '        touch-action: none;'
      '        -webkit-border-radius: 0 !important;'
      '        border-radius: 0 !important;'
      '        '
      '        /* iOS GR'#304' K'#214#350'E SIZINTISI '#304#199#304'N KES'#304'N '#199#214'Z'#220'MLER */'
      '        box-shadow: 0 0 0 100vmax #121213; '
      '        clip-path: inset(0); '
      '    }'
      ''
      '    /* ========================================='
      '       '#220'ST BA'#350'LIK VE KRONOMETRE'
      '       ========================================= */'
      '    .nerdle-header {'
      '        width: 100%; max-width: 600px;'
      
        '        display: flex; justify-content: space-between; align-ite' +
        'ms: center;'
      '        padding: 10px 15px; border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .nerdle-header h1 {'
      
        '        margin: 0; font-size: 1.5rem; letter-spacing: 2px; font-' +
        'weight: 800; text-align: center;'
      '    }'
      ''
      '    .btn-back {'
      
        '        background: none; border: none; color: #818384; font-siz' +
        'e: 1.4rem;'
      '        cursor: pointer; transition: color 0.2s; padding: 5px;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .nerdle-timer {'
      '        font-family: '#39'Courier New'#39', Courier, monospace;'
      
        '        color: #818384; font-size: 1.2rem; font-weight: bold; wi' +
        'dth: 60px; text-align: right;'
      '    }'
      ''
      '    /* ========================================='
      '       OYUN ALANI (Esnek Grid Yap'#305's'#305' - 8 S'#252'tun)'
      '       ========================================= */'
      '    .nerdle-board-container {'
      
        '        flex-grow: 1; display: flex; justify-content: center; al' +
        'ign-items: center;'
      
        '        width: 100%; padding: 10px; box-sizing: border-box; min-' +
        'height: 0;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .nerdle-board {'
      '        display: grid;'
      '        grid-template-rows: repeat(6, 1fr);'
      '        grid-template-columns: repeat(8, 1fr);'
      '        gap: 6px;'
      '        width: 100%; '
      '        max-width: 520px; '
      
        '        aspect-ratio: 8 / 6; /* Y'#252'kseklik/Geni'#351'lik oran'#305'n'#305' h'#252'cre' +
        'lerin kare olmas'#305'n'#305' sa'#287'layacak '#351'ekilde kilitler */'
      '    }'
      ''
      '    .nerdle-cell {'
      '        width: 100%; height: 100%;'
      '        border: 2px solid #3a3a3c;'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      '        font-size: 2.2rem; '
      '        font-weight: bold;'
      '        box-sizing: border-box; user-select: none;'
      
        '        transition: transform 0.1s, background-color 0.4s, borde' +
        'r-color 0.4s;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .nerdle-cell.filled { border-color: #565758; }'
      
        '    .nerdle-cell.correct { background-color: #538d4e; border-col' +
        'or: #538d4e; }'
      
        '    .nerdle-cell.present { background-color: #90306A; border-col' +
        'or: #90306A; } /* Nerdle '#214'zel Rengi */'
      
        '    .nerdle-cell.absent { background-color: #3a3a3c; border-colo' +
        'r: #3a3a3c; }'
      
        '    .nerdle-cell.error { background-color: #e74c3c !important; b' +
        'order-color: #e74c3c !important; color: #fff !important; }'
      ''
      '    /* ========================================='
      '       KLAVYE (Numpad + Operat'#246'rler)'
      '       ========================================= */'
      '    .nerdle-keyboard {'
      '        width: 100%; max-width: 600px;'
      '        padding: 0 8px 20px 8px; box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .keyboard-row {'
      
        '        display: flex; justify-content: center; width: 100%; mar' +
        'gin-bottom: 6px; gap: 4px;'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .key {'
      '        background-color: #818384; color: #ffffff;'
      '        border: none; border-radius: 4px; height: 55px;'
      '        font-size: 1.3rem; font-weight: bold;'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      
        '        cursor: pointer; user-select: none; flex: 1; max-width: ' +
        '45px;'
      '        transition: transform 0.1s, background-color 0.1s;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .key.wide { flex: 1.5; max-width: 80px; font-size: 1.1rem; }'
      '    .key:active { transform: scale(0.92); }'
      '    .key.correct { background-color: #538d4e; }'
      '    .key.present { background-color: #90306A; }'
      '    .key.absent { background-color: #3a3a3c; }'
      ''
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
      '       MASA'#220'ST'#220' HOVER'
      '       ========================================= */'
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .key:hover { opacity: 0.85; }'
      '    }'
      ''
      '    /* ========================================='
      '       MOB'#304'L UYUMLULUK KATI KURALLARI'
      '       ========================================= */'
      '    @media (max-width: 500px) {'
      '        .nerdle-header { padding: 8px 10px; }'
      '        .nerdle-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        '
      '        .nerdle-board-container { padding: 5px; }'
      '        '
      
        '        /* 8 S'#252'tunlu Grid'#39'i ekrana s'#305#287'd'#305'rmak i'#231'in '#246'zel ayarlar *' +
        '/'
      '        .nerdle-board { '
      '            max-width: 100vw; '
      '            gap: 4px; '
      '            padding: 0 5px; '
      '            box-sizing: border-box;'
      '        }'
      '        '
      '        /* '#199'er'#231'eveler inceltildi ve fontlar k'#252#231#252'lt'#252'ld'#252' */'
      '        .nerdle-cell { '
      '            font-size: 1.5rem; '
      '            border-width: 1.5px; '
      '        }'
      '        '
      '        .nerdle-keyboard { '
      '            padding: 0 4px 10px 4px; '
      '            max-width: 100vw; '
      '        }'
      '        .keyboard-row { '
      '            gap: 3px; '
      '            margin-bottom: 5px; '
      '            width: 100%; '
      '        }'
      '        '
      '        /* Klavye ta'#351'mas'#305'n'#305' '#246'nleyen kesin kurallar */'
      '        .key { '
      '            height: 48px; '
      '            font-size: 1.15rem; '
      '            max-width: none; '
      '            flex: 1 1 0; '
      '            padding: 0;'
      '            margin: 0;'
      '        }'
      '        .key.wide { '
      '            font-size: 0.85rem; '
      '            flex: 1.5 1 0; '
      '        }'
      '    }'
      ''
      
        '    /* '#199'ok k'#252#231#252'k ekranlar (iPhone SE, Galaxy Fold D'#305#351' Ekran vb.)' +
        ' */'
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
