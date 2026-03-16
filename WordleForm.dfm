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
    '    window.wordleGameOver = false;'
    '    window.wordleRow = 0;'
    '    window.wordleCol = 0;'
    '    window.wordleElapsedTime = 0;'
    '    window.wordleIsWin = false;'
    '    window.finalGrade = "";'
    ''
    '    if (serverId && serverId !== "") {'
    '        window.currentPuzzleId = serverId;'
    '    } else {'
    '        window.currentPuzzleId = window.getTodayStr();'
    '    }'
    '    window.isWordleInitialized = true;'
    '    window.initWordleBoard();'
    '};'
    ''
    'window.initWordleBoard = function() {'
    '    window.injectOctailyStyles();'
    
      '    var boardEl = window.wordleEl('#39'#wordleBoard'#39') || document.ge' +
      'tElementById('#39'wordleBoard'#39');'
    '    if (!boardEl) { '
    '        setTimeout(window.initWordleBoard, 100); '
    '        return; '
    '    }'
    '    '
    '    boardEl.innerHTML = '#39#39'; '
    '    '
    
      '    for (var i = 0; i < (window.wordleMaxGuesses * window.wordle' +
      'Length); i++) {'
    '        var cell = document.createElement('#39'div'#39');'
    '        cell.className = '#39'wordle-cell'#39';'
    '        boardEl.appendChild(cell);'
    '    }'
    '    '
    '    window.renderKeyboard(window.wordleLang);'
    '    window.loadWordleState();'
    '};'
    ''
    'window.setWordleLang = function(lang) {'
    '    window.wordleLang = lang;'
    '    var titleEl = window.wordleEl('#39'#wordleTitle'#39');'
    '    if (titleEl) {'
    
      '        titleEl.textContent = (lang === '#39'tr'#39') ? '#39'WORDLE (TR)'#39' : ' +
      #39'WORDLE (EN)'#39';'
    '    }'
    '    window.renderKeyboard(lang);'
    '    if (window.isWordleInitialized) {'
    '        window.loadWordleState();'
    '    }'
    '};'
    ''
    'window.startWordleTimer = function() {'
    
      '    if (window.wordleTimerInterval) clearInterval(window.wordleT' +
      'imerInterval);'
    
      '    if (window.wordleGameOver || !window.isWordleInitialized) re' +
      'turn;'
    
      '    var startTime = Date.now() - (window.wordleElapsedTime * 100' +
      '0);'
    '    var timerEl = window.wordleEl('#39'#wordleTimer'#39'); '
    '    window.wordleTimerInterval = setInterval(function() {'
    
      '        window.wordleElapsedTime = Math.floor((Date.now() - star' +
      'tTime) / 1000);'
    '        '
    '        if (timerEl) {'
    
      '            var m = Math.floor(window.wordleElapsedTime / 60).to' +
      'String().padStart(2, '#39'0'#39');'
    
      '            var s = (window.wordleElapsedTime % 60).toString().p' +
      'adStart(2, '#39'0'#39');'
    '            timerEl.textContent = m + '#39':'#39' + s;'
    '        }'
    ''
    
      '        if (window.wordleElapsedTime % 5 === 0) window.saveWordl' +
      'eState();'
    '    }, 1000);'
    '};'
    ''
    'window.saveWordleState = function() {'
    
      '    if (!window.isWordleInitialized || !window.getVisibleViewpor' +
      't()) return; '
    '    '
    '    var state = {'
    '        puzzleId: window.currentPuzzleId,'
    '        row: window.wordleRow,'
    '        col: window.wordleCol,'
    '        time: window.wordleElapsedTime,'
    '        completed: window.wordleGameOver,'
    '        grade: window.finalGrade,'
    '        isWin: window.wordleIsWin,'
    '        cells: [],'
    '        keys: {}'
    '    };'
    '    var cells = window.wordleEls('#39'.wordle-cell'#39');'
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
    '    var keys = window.wordleEls('#39'.key'#39');'
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
    
      '    localStorage.setItem('#39'octaily_wordle_state_'#39' + window.wordle' +
      'Lang, JSON.stringify(state));'
    '};'
    ''
    'window.loadWordleState = function() {'
    '    if (!window.isWordleInitialized) return;'
    
      '    var saved = localStorage.getItem('#39'octaily_wordle_state_'#39' + w' +
      'indow.wordleLang);'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.puzzleId === window.currentPuzzleId) {'
    
      '                window.wordleRow = (state.row !== undefined) ? p' +
      'arseInt(state.row, 10) : 0;'
    
      '                window.wordleCol = (state.col !== undefined) ? p' +
      'arseInt(state.col, 10) : 0;'
    
      '                window.wordleElapsedTime = (state.time !== undef' +
      'ined) ? parseInt(state.time, 10) : 0;'
    
      '                window.wordleGameOver = state.completed || false' +
      ';'
    '                window.finalGrade = state.grade || "";'
    '                window.wordleIsWin = state.isWin || false;'
    ''
    '                var cells = window.wordleEls('#39'.wordle-cell'#39');'
    '                for (var i = 0; i < state.cells.length; i++) {'
    '                    if (cells[i] && state.cells[i]) {'
    
      '                        cells[i].textContent = state.cells[i].te' +
      'xt;'
    '                        cells[i].className = '#39'wordle-cell'#39';'
    
      '                        if (state.cells[i].text !== '#39#39') cells[i]' +
      '.classList.add('#39'filled'#39');'
    
      '                        if (state.cells[i].status !== '#39#39') cells[' +
      'i].classList.add(state.cells[i].status);'
    '                    }'
    '                }'
    ''
    '                var keys = window.wordleEls('#39'.key'#39');'
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
    '                if (window.wordleGameOver) {'
    
      '                    setTimeout(function() { window.showWordleGam' +
      'eOver(true); }, 300);'
    '                } else {'
    '                    window.startWordleTimer();'
    '                }'
    '            } else {'
    
      '                localStorage.removeItem('#39'octaily_wordle_state_'#39' ' +
      '+ window.wordleLang);'
    '                window.resetWordleUI();'
    '            }'
    '        } catch (e) { window.resetWordleUI(); }'
    '    } else {'
    '        window.resetWordleUI();'
    '    }'
    '};'
    ''
    'window.resetWordleUI = function() {'
    '    window.wordleRow = 0;'
    '    window.wordleCol = 0;'
    '    window.wordleElapsedTime = 0;'
    '    window.wordleGameOver = false;'
    '    window.finalGrade = "";'
    '    window.wordleIsWin = false;'
    '    '
    '    var cells = window.wordleEls('#39'.wordle-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    '        cells[i].textContent = '#39#39';'
    '        cells[i].className = '#39'wordle-cell'#39';'
    '    }'
    '    var keys = window.wordleEls('#39'.key'#39');'
    '    for (var k = 0; k < keys.length; k++) {'
    
      '        keys[k].classList.remove('#39'correct'#39', '#39'present'#39', '#39'absent'#39')' +
      ';'
    '    }'
    '    window.startWordleTimer();'
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
    'window.showWordleGameOver = function(isReplay) {'
    
      '    if (window.wordleTimerInterval) clearInterval(window.wordleT' +
      'imerInterval);'
    '    var time = window.wordleElapsedTime;'
    '    var tries = window.wordleRow;'
    '    var isWin = window.wordleIsWin;'
    
      '    var grade = isReplay ? window.finalGrade : window.calculateG' +
      'rade(tries, isWin);'
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) {'
    '        window.wordleGameOver = true;'
    '        window.finalGrade = grade;'
    '        window.saveWordleState();'
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
    
      '    var subText = isReplay ? '#39'<div style="color:#818384; font-si' +
      'ze:0.95rem; margin-bottom:20px;">Bug'#252'n'#252'n kelimesini zaten '#231#246'zd'#252'n' +
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
    '            title: modalTitle,'
    '            html: htmlContent,'
    '            icon: modalIcon,'
    '            confirmButtonText: '#39#199'IK'#39','
    '            background: '#39'#1a1a1b'#39','
    '            color: '#39'#ffffff'#39','
    
      '            customClass: { popup: '#39'oct-popup'#39', title: '#39'oct-title' +
      #39', confirmButton: '#39'oct-confirm'#39', icon: '#39'oct-icon'#39' },'
    '            didOpen: function() {'
    
      '                var container = document.querySelector('#39'.swal2-c' +
      'ontainer'#39');'
    
      '                if (container) container.style.zIndex = "2147483' +
      '647";'
    '            }'
    '        }); '
    '    }'
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
    '            window.saveWordleState();'
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
    '            window.saveWordleState();'
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
    '    '
    '    if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '        ajaxRequest(WORDLE_FORM.WordleHTML, '#39'SubmitGuess'#39', ['#39'gue' +
      'ss='#39' + guess]);'
    '    }'
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
    '    window.saveWordleState();'
    ''
    '    if (isWin || window.wordleRow >= window.wordleMaxGuesses) {'
    
      '        setTimeout(function() { window.showWordleGameOver(false)' +
      '; }, 1500);'
    '    }'
    '};'
    ''
    'window.showWordleError = function(errorMsg) {'
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal && errorMsg && errorMsg !== '#39#39') {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ', title: '#39'HATA!'#39', text: errorMsg, icon: '#39'warning'#39', toast: true, ' +
      'position: '#39'top'#39', showConfirmButton: false, timer: 2500, backgrou' +
      'nd: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39', customClass: { popup: '#39'oct-popu' +
      'p'#39' }'
    '        });'
    '    }'
    ''
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
      '    .wordle-viewport {'
      '        position: fixed;'
      '        top: 0;'
      '        left: 0;'
      '        right: 0; '
      '        bottom: 0;'
      '        width: 100vw;'
      '        height: 100vh;'
      '        height: 100dvh;'
      '        background-color: #121213 !important;'
      '        display: flex;'
      '        flex-direction: column;'
      '        align-items: center;'
      
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
      '    .wordle-header {'
      '        width: 100%;'
      '        max-width: 500px;'
      '        display: flex;'
      '        justify-content: space-between;'
      '        align-items: center;'
      '        padding: 10px 15px;'
      '        border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box;'
      
        '        background-color: #121213; /* '#350'effafl'#305'k s'#305'z'#305'nt'#305's'#305'n'#305' '#246'nle' +
        'r */'
      '    }'
      ''
      '    .wordle-header h1 {'
      '        margin: 0;'
      '        font-size: 1.5rem;'
      '        letter-spacing: 2px;'
      '        font-weight: 800;'
      '        text-align: center;'
      '    }'
      ''
      '    .btn-back {'
      '        background: none;'
      '        border: none;'
      '        color: #818384;'
      '        font-size: 1.3rem;'
      '        cursor: pointer;'
      '        transition: color 0.2s;'
      '        padding: 5px;'
      '    }'
      ''
      '    .header-spacer {'
      '        width: 30px;'
      '    }'
      ''
      '    .wordle-board-container {'
      '        flex-grow: 1; '
      '        display: flex;'
      '        justify-content: center;'
      '        align-items: center;'
      '        width: 100%;'
      '        padding: 10px; '
      '        box-sizing: border-box;'
      '        min-height: 0;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .wordle-board {'
      '        display: grid;'
      '        grid-template-rows: repeat(6, 1fr);'
      '        grid-template-columns: repeat(5, 1fr);'
      '        gap: 6px;'
      '        width: 100%;'
      '        max-width: 340px; '
      '        aspect-ratio: 5 / 6; '
      '    }'
      ''
      '    .wordle-cell {'
      '        width: 100%;'
      '        height: 100%;'
      '        border: 2px solid #3a3a3c;'
      '        display: flex;'
      '        justify-content: center;'
      '        align-items: center;'
      '        font-size: 2rem;'
      '        font-weight: bold;'
      '        text-transform: uppercase;'
      '        box-sizing: border-box;'
      '        user-select: none;'
      
        '        transition: transform 0.1s, background-color 0.4s, borde' +
        'r-color 0.4s;'
      '    }'
      ''
      '    .wordle-cell.filled { border-color: #565758; }'
      
        '    .wordle-cell.correct { background-color: #538d4e; border-col' +
        'or: #538d4e; }'
      
        '    .wordle-cell.present { background-color: #b59f3b; border-col' +
        'or: #b59f3b; }'
      
        '    .wordle-cell.absent { background-color: #3a3a3c; border-colo' +
        'r: #3a3a3c; }'
      ''
      '    .wordle-keyboard {'
      '        width: 100%;'
      '        max-width: 500px;'
      '        padding: 0 8px 15px 8px;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .keyboard-row {'
      '        display: flex;'
      '        justify-content: center;'
      '        width: 100%;'
      '        margin-bottom: 6px;'
      '        gap: 4px;'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .key {'
      '        background-color: #818384;'
      '        color: #ffffff;'
      '        border: none;'
      '        border-radius: 4px;'
      '        height: 48px;'
      '        font-size: 1rem;'
      '        font-weight: bold;'
      '        display: flex;'
      '        justify-content: center;'
      '        align-items: center;'
      '        cursor: pointer;'
      '        text-transform: uppercase;'
      '        user-select: none;'
      '        flex: 1;'
      '        max-width: 40px;'
      
        '        transition: background-color 0.1s, transform 0.1s, opaci' +
        'ty 0.2s;'
      
        '        -webkit-tap-highlight-color: transparent; /* iOS tu'#351' t'#305'k' +
        'lama grili'#287'ini gizler */'
      '    }'
      ''
      '    .key.wide {'
      '        flex: 1.5;'
      '        max-width: 60px;'
      '        font-size: 0.85rem;'
      '    }'
      ''
      '    .key:active { transform: scale(0.95); }'
      '    .key.correct { background-color: #538d4e; }'
      '    .key.present { background-color: #b59f3b; }'
      '    .key.absent { background-color: #3a3a3c; }'
      ''
      '    @keyframes shake {'
      '        10%, 90% { transform: translate3d(-2px, 0, 0); }'
      '        20%, 80% { transform: translate3d(4px, 0, 0); }'
      '        30%, 50%, 70% { transform: translate3d(-6px, 0, 0); }'
      '        40%, 60% { transform: translate3d(6px, 0, 0); }'
      '    }'
      '    .shake {'
      
        '        animation: shake 0.5s cubic-bezier(.36,.07,.19,.97) both' +
        ';'
      '    }'
      ''
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .key:hover { opacity: 0.85; }'
      '    }'
      ''
      '    /* ========================================='
      '       MOB'#304'L UYUMLULUK KATI KURALLARI'
      '       ========================================= */'
      '    @media (max-width: 500px) {'
      '        .wordle-header { padding: 8px 10px; }'
      '        .wordle-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.15rem; }'
      '        '
      '        .wordle-board-container { padding: 5px; }'
      '        .wordle-board { '
      '            max-width: 340px; '
      '            gap: 6px; '
      '            padding: 0 5px; '
      '            box-sizing: border-box;'
      '        }'
      '        .wordle-cell { font-size: 1.9rem; }'
      '        '
      '        .wordle-keyboard { '
      '            padding: 0 4px 10px 4px; '
      '            max-width: 100vw; '
      '        }'
      '        .keyboard-row { '
      '            gap: 3px; '
      '            margin-bottom: 5px; '
      '            width: 100%; '
      '        }'
      '        .key { '
      '            height: 46px; '
      '            font-size: 0.85rem; '
      '            max-width: none; '
      '            flex: 1 1 0; '
      '            padding: 0;'
      '            margin: 0;'
      '        }'
      '        .key.wide { '
      '            font-size: 0.75rem; '
      '            flex: 1.5 1 0; '
      '        }'
      '    }'
      ''
      '    @media (max-width: 360px) {'
      '        .wordle-board { max-width: 300px; gap: 4px; }'
      '        .wordle-cell { font-size: 1.6rem; }'
      '        '
      '        .keyboard-row { gap: 2px; }'
      '        .key { height: 42px; font-size: 0.75rem; }'
      '        .key.wide { font-size: 0.65rem; }'
      '    }'
      '</style>'
      ''
      '<div class="wordle-viewport">'
      '    <div class="wordle-header">'
      
        '        <button class="btn-back" onclick="ajaxRequest(WORDLE_FOR' +
        'M.WordleHTML, '#39'closePage'#39');"><i class="fa-solid fa-arrow-left"><' +
        '/i></button>'
      '        <h1 id="wordleTitle">WORDLE</h1>'
      '        <div class="header-spacer"></div>'
      '    </div>'
      ''
      '    <div class="wordle-board-container">'
      '        <div class="wordle-board" id="wordleBoard">'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      
        '            <div class="wordle-cell"></div><div class="wordle-ce' +
        'll"></div><div class="wordle-cell"></div><div class="wordle-cell' +
        '"></div><div class="wordle-cell"></div>'
      '        </div>'
      '    </div>'
      ''
      '    <div class="wordle-keyboard" id="wordleKeyboard">'
      '        <div class="keyboard-row">'
      
        '            <div class="key" data-key="E">E</div><div class="key' +
        '" data-key="R">R</div><div class="key" data-key="T">T</div><div ' +
        'class="key" data-key="Y">Y</div><div class="key" data-key="U">U<' +
        '/div><div class="key" data-key="I">I</div><div class="key" data-' +
        'key="O">O</div><div class="key" data-key="P">P</div><div class="' +
        'key" data-key="'#286'">'#286'</div><div class="key" data-key="'#220'">'#220'</div>'
      '        </div>'
      '        <div class="keyboard-row">'
      
        '            <div class="key" data-key="A">A</div><div class="key' +
        '" data-key="S">S</div><div class="key" data-key="D">D</div><div ' +
        'class="key" data-key="F">F</div><div class="key" data-key="G">G<' +
        '/div><div class="key" data-key="H">H</div><div class="key" data-' +
        'key="J">J</div><div class="key" data-key="K">K</div><div class="' +
        'key" data-key="L">L</div><div class="key" data-key="'#350'">'#350'</div><d' +
        'iv class="key" data-key="'#304'">'#304'</div>'
      '        </div>'
      '        <div class="keyboard-row">'
      
        '            <div class="key wide" id="keyEnter" data-key="ENTER"' +
        '>ENTER</div>'
      
        '            <div class="key" data-key="Z">Z</div><div class="key' +
        '" data-key="C">C</div><div class="key" data-key="V">V</div><div ' +
        'class="key" data-key="B">B</div><div class="key" data-key="N">N<' +
        '/div><div class="key" data-key="M">M</div><div class="key" data-' +
        'key="'#214'">'#214'</div><div class="key" data-key="'#199'">'#199'</div>'
      
        '            <div class="key wide" id="keyBackspace" data-key="BA' +
        'CKSPACE"><i class="fa-solid fa-delete-left"></i></div>'
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
