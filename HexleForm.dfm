object HEXLE_FORM: THEXLE_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'HEXLE_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.hexleGameOver = false;'
    'window.hexleRow = 0;'
    'window.hexleCol = 0;'
    'window.hexleMaxGuesses = 6;'
    'window.hexleLength = 6;'
    'window.hexleElapsedTime = 0;'
    'window.hexleTimerInterval = null;'
    'window.finalGrade = "";'
    'window.hexleIsWin = false;'
    'window.currentPuzzleId = "";'
    'window.targetColorHex = "#000000";'
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.hexle-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    
      'window.hexleEl = function(selector) { var vp = window.getVisible' +
      'Viewport(); return vp ? vp.querySelector(selector) : null; };'
    
      'window.hexleEls = function(selector) { var vp = window.getVisibl' +
      'eViewport(); return vp ? vp.querySelectorAll(selector) : []; };'
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
    
      'window.initHexleWithServer = function(serverId, targetColorRGB) ' +
      '{'
    '    window.hexleGameOver = false;'
    '    window.hexleRow = 0;'
    '    window.hexleCol = 0;'
    '    window.hexleElapsedTime = 0;'
    '    window.hexleIsWin = false;'
    '    window.finalGrade = "";'
    ''
    
      '    if (serverId && serverId !== "") window.currentPuzzleId = se' +
      'rverId;'
    '    else window.currentPuzzleId = window.getTodayStr();'
    '    '
    '    var colorBox = window.hexleEl('#39'.hexle-target-color'#39');'
    '    if(colorBox) {'
    
      '        colorBox.style.backgroundColor = targetColorRGB || "rgb(' +
      '58, 140, 85)";'
    '        colorBox.textContent = ""; '
    '    }'
    '    window.initHexleBoard();'
    '};'
    ''
    'window.initHexleBoard = function() {'
    '    window.injectOctailyStyles();'
    '    var boardEl = window.hexleEl('#39'.hexle-board'#39');'
    
      '    if (!boardEl) { setTimeout(window.initHexleBoard, 100); retu' +
      'rn; }'
    '    '
    '    boardEl.innerHTML = '#39#39'; '
    '    '
    '    for (var r = 0; r < window.hexleMaxGuesses; r++) {'
    '        for (var c = 0; c < window.hexleLength; c++) {'
    '            var cell = document.createElement('#39'div'#39');'
    '            cell.className = '#39'hexle-cell'#39';'
    '            boardEl.appendChild(cell);'
    '        }'
    '        var swatch = document.createElement('#39'div'#39');'
    '        swatch.className = '#39'hexle-swatch'#39';'
    '        swatch.id = '#39'swatch-'#39' + r;'
    '        boardEl.appendChild(swatch);'
    '    }'
    '    '
    '    window.loadHexleState();'
    '};'
    ''
    'window.startHexleTimer = function() {'
    
      '    if (window.hexleTimerInterval) clearInterval(window.hexleTim' +
      'erInterval);'
    '    if (window.hexleGameOver) return;'
    
      '    var startTime = Date.now() - (window.hexleElapsedTime * 1000' +
      ');'
    '    var timerEl = window.hexleEl('#39'.hexle-timer'#39');'
    '    window.hexleTimerInterval = setInterval(function() {'
    
      '        window.hexleElapsedTime = Math.floor((Date.now() - start' +
      'Time) / 1000);'
    
      '        var m = Math.floor(window.hexleElapsedTime / 60).toStrin' +
      'g().padStart(2, '#39'0'#39');'
    
      '        var s = (window.hexleElapsedTime % 60).toString().padSta' +
      'rt(2, '#39'0'#39');'
    '        if (timerEl) timerEl.textContent = m + '#39':'#39' + s;'
    
      '        if (window.hexleElapsedTime % 5 === 0) window.saveHexleS' +
      'tate();'
    '    }, 1000);'
    '};'
    ''
    'window.saveHexleState = function() {'
    '    if (!window.getVisibleViewport()) return; '
    ''
    '    var state = {'
    
      '        puzzleId: window.currentPuzzleId, row: window.hexleRow, ' +
      'col: window.hexleCol,'
    
      '        time: window.hexleElapsedTime, completed: window.hexleGa' +
      'meOver, grade: window.finalGrade, isWin: window.hexleIsWin,'
    '        cells: [], swatches: []'
    '    };'
    '    var cells = window.hexleEls('#39'.hexle-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    '        var status = "";'
    
      '        if (cells[i].classList.contains('#39'correct'#39')) status = '#39'co' +
      'rrect'#39';'
    
      '        else if (cells[i].classList.contains('#39'higher'#39')) status =' +
      ' '#39'higher'#39';'
    
      '        else if (cells[i].classList.contains('#39'very_higher'#39')) sta' +
      'tus = '#39'very_higher'#39';'
    
      '        else if (cells[i].classList.contains('#39'lower'#39')) status = ' +
      #39'lower'#39';'
    
      '        else if (cells[i].classList.contains('#39'very_lower'#39')) stat' +
      'us = '#39'very_lower'#39';'
    
      '        state.cells.push({ html: cells[i].innerHTML, status: sta' +
      'tus });'
    '    }'
    '    for (var r = 0; r < window.hexleRow; r++) {'
    '        var swatch = window.hexleEl('#39'#swatch-'#39' + r);'
    
      '        state.swatches.push(swatch ? swatch.style.backgroundColo' +
      'r : '#39'transparent'#39');'
    '    }'
    
      '    localStorage.setItem('#39'octaily_hexle_state'#39', JSON.stringify(s' +
      'tate));'
    '};'
    ''
    'window.loadHexleState = function() {'
    '    var saved = localStorage.getItem('#39'octaily_hexle_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.puzzleId === window.currentPuzzleId) {'
    
      '                window.hexleRow = state.row || 0; window.hexleCo' +
      'l = state.col || 0;'
    
      '                window.hexleElapsedTime = state.time || 0; windo' +
      'w.hexleGameOver = state.completed || false;'
    
      '                window.finalGrade = state.grade || ""; window.he' +
      'xleIsWin = state.isWin || false;'
    ''
    '                var cells = window.hexleEls('#39'.hexle-cell'#39');'
    '                for (var i = 0; i < state.cells.length; i++) {'
    '                    if (cells[i] && state.cells[i]) {'
    
      '                        cells[i].innerHTML = state.cells[i].html' +
      ' || '#39#39';'
    
      '                        if (state.cells[i].html && state.cells[i' +
      '].html !== '#39#39') cells[i].classList.add('#39'filled'#39');'
    
      '                        if (state.cells[i].status && state.cells' +
      '[i].status !== '#39#39') cells[i].classList.add(state.cells[i].status)' +
      ';'
    '                    }'
    '                }'
    '                '
    '                if (state.swatches) {'
    
      '                    for (var r = 0; r < state.swatches.length; r' +
      '++) {'
    
      '                        var swatch = window.hexleEl('#39'#swatch-'#39' +' +
      ' r);'
    '                        if (swatch) {'
    
      '                            swatch.style.backgroundColor = state' +
      '.swatches[r];'
    
      '                            swatch.style.borderColor = '#39'#565758'#39 +
      ';'
    '                        }'
    '                    }'
    '                }'
    ''
    
      '                if (window.hexleGameOver) setTimeout(function() ' +
      '{ window.showHexleGameOver(true); }, 300);'
    '                else window.startHexleTimer();'
    '            } else {'
    
      '                localStorage.removeItem('#39'octaily_hexle_state'#39'); ' +
      'window.resetHexleUI(); '
    '            }'
    '        } catch (e) { window.resetHexleUI(); }'
    '    } else { window.resetHexleUI(); }'
    '};'
    ''
    'window.resetHexleUI = function() {'
    
      '    window.hexleElapsedTime = 0; window.hexleGameOver = false; w' +
      'indow.finalGrade = ""; window.hexleRow = 0; window.hexleCol = 0;' +
      ' window.hexleIsWin = false;'
    ''
    '    var cells = window.hexleEls('#39'.hexle-cell'#39');'
    
      '    for (var i = 0; i < cells.length; i++) { cells[i].innerHTML ' +
      '= '#39#39'; cells[i].className = '#39'hexle-cell'#39'; }'
    '    var swatches = window.hexleEls('#39'.hexle-swatch'#39');'
    
      '    for (var s = 0; s < swatches.length; s++) { swatches[s].styl' +
      'e.backgroundColor = '#39'transparent'#39'; swatches[s].style.borderColor' +
      ' = '#39'#3a3a3c'#39'; }'
    ''
    '    window.startHexleTimer();'
    '};'
    ''
    'window.calculateGrade = function(tries, isWin) {'
    '    if (!isWin) return '#39'F'#39';'
    
      '    if (tries === 1) return '#39'S+'#39'; if (tries === 2) return '#39'S'#39'; i' +
      'f (tries === 3) return '#39'A'#39';'
    
      '    if (tries === 4) return '#39'B'#39'; if (tries === 5) return '#39'C'#39'; re' +
      'turn '#39'D'#39';'
    '};'
    ''
    'window.showHexleGameOver = function(isReplay) {'
    
      '    if (window.hexleTimerInterval) clearInterval(window.hexleTim' +
      'erInterval);'
    '    var time = window.hexleElapsedTime; '
    '    var tries = window.hexleRow; '
    '    var isWin = window.hexleIsWin;'
    
      '    var grade = isReplay ? window.finalGrade : window.calculateG' +
      'rade(tries, isWin);'
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39'); '
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39'); '
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) { '
    '        window.hexleGameOver = true; '
    '        window.finalGrade = grade; '
    '        window.saveHexleState(); '
    '        '
    ''
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(HEXLE_FORM.HexleHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'tries='#39' + tries, '
    '                '#39'grade='#39' + grade, '
    '                '#39'isWin='#39' + (isWin ? '#39'1'#39' : '#39'0'#39'),'
    '                '#39'game_type=hexle'#39' '
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
      'ze:0.95rem; margin-bottom:20px;">Bug'#252'n'#252'n rengini zaten buldun!</' +
      'div>'#39' : '#39#39';'
    
      '    var modalIcon = isReplay ? '#39'info'#39' : (isWin ? '#39'success'#39' : '#39'er' +
      'ror'#39');'
    '    var triesStr = isWin ? tries + '#39'/6'#39' : '#39'X/6'#39';'
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
      ', title: modalTitle, html: htmlContent, icon: modalIcon, confirm' +
      'ButtonText: '#39#199'IK'#39', background: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39','
    
      '            customClass: { popup: '#39'oct-popup'#39', title: '#39'oct-title' +
      #39', confirmButton: '#39'oct-confirm'#39', icon: '#39'oct-icon'#39' },'
    
      '            didOpen: function() { var container = document.query' +
      'Selector('#39'.swal2-container'#39'); if (container) container.style.zIn' +
      'dex = "2147483647"; }'
    '        }); '
    '    }'
    '};'
    ''
    
      'window.isValidHexChar = function(str) { return str.length === 1 ' +
      '&& /[0-9A-Fa-f]/.test(str); };'
    
      'window.getCell = function(row, col) { var cells = window.hexleEl' +
      's('#39'.hexle-cell'#39'); if (cells.length === 0) return null; return ce' +
      'lls[(row * window.hexleLength) + col]; };'
    ''
    'window.addLetter = function(letter) {'
    '    if (window.hexleGameOver) return;'
    
      '    if (window.hexleCol < window.hexleLength && window.hexleRow ' +
      '< window.hexleMaxGuesses) {'
    
      '        var cell = window.getCell(window.hexleRow, window.hexleC' +
      'ol);'
    
      '        if (cell) { cell.textContent = letter; cell.classList.ad' +
      'd('#39'filled'#39'); window.hexleCol++; window.saveHexleState(); }'
    '    }'
    '};'
    ''
    'window.deleteLetter = function() {'
    '    if (window.hexleGameOver) return;'
    '    if (window.hexleCol > 0) {'
    '        window.hexleCol--;'
    
      '        var cell = window.getCell(window.hexleRow, window.hexleC' +
      'ol);'
    
      '        if (cell) { cell.textContent = '#39#39'; cell.classList.remove' +
      '('#39'filled'#39', '#39'error'#39', '#39'shake'#39'); window.saveHexleState(); }'
    '    }'
    '};'
    ''
    'window.submitGuess = function() {'
    '    if (window.hexleGameOver) return;'
    '    if (window.hexleCol !== window.hexleLength) {'
    '        for (var i = 0; i < window.hexleCol; i++) {'
    '            var cell = window.getCell(window.hexleRow, i);'
    
      '            if (cell) { cell.classList.remove('#39'shake'#39'); void cel' +
      'l.offsetWidth; cell.classList.add('#39'shake'#39'); }'
    '        }'
    '        return;'
    '    }'
    '    var guess = '#39#39';'
    '    for (var j = 0; j < window.hexleLength; j++) {'
    '        var c = window.getCell(window.hexleRow, j);'
    '        if (c) guess += c.textContent || c.innerText;'
    '    }'
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') { ajaxRequest(HEXLE_' +
      'FORM.HexleHTML, '#39'SubmitGuess'#39', ['#39'guess='#39' + guess]); }'
    '};'
    ''
    'window.handleInput = function(key) {'
    '    if (window.hexleGameOver) return;'
    '    if (key === '#39'BACKSPACE'#39') window.deleteLetter();'
    '    else if (key === '#39'ENTER'#39') window.submitGuess();'
    
      '    else if (window.isValidHexChar(key)) window.addLetter(key.to' +
      'UpperCase());'
    '};'
    ''
    'window.processHexleResult = function(resultArray) {'
    '    if (window.hexleGameOver) return;'
    '    var isWin = true; var guessedHex = '#39'#'#39'; '
    '    for (var i = 0; i < resultArray.length; i++) {'
    '        var cell = window.getCell(window.hexleRow, i);'
    
      '        var status = resultArray[i].status; var letter = resultA' +
      'rray[i].char;'
    '        guessedHex += letter; '
    '        if (status !== '#39'correct'#39') isWin = false;'
    '        if (cell) {'
    
      '            cell.classList.remove('#39'filled'#39'); cell.classList.add(' +
      'status);'
    '            var indicatorHtml = "";'
    
      '            if (status === '#39'very_higher'#39') indicatorHtml = '#39'<div ' +
      'class="hexle-indicator"><i class="fa-solid fa-angles-up"></i></d' +
      'iv>'#39';'
    
      '            else if (status === '#39'higher'#39') indicatorHtml = '#39'<div ' +
      'class="hexle-indicator"><i class="fa-solid fa-arrow-up"></i></di' +
      'v>'#39';'
    
      '            else if (status === '#39'very_lower'#39') indicatorHtml = '#39'<' +
      'div class="hexle-indicator"><i class="fa-solid fa-angles-down"><' +
      '/i></div>'#39';'
    
      '            else if (status === '#39'lower'#39') indicatorHtml = '#39'<div c' +
      'lass="hexle-indicator"><i class="fa-solid fa-arrow-down"></i></d' +
      'iv>'#39';'
    
      '            cell.innerHTML = '#39'<div>'#39' + letter + '#39'</div>'#39' + indic' +
      'atorHtml;'
    '        }'
    '    }'
    '    var swatch = window.hexleEl('#39'#swatch-'#39' + window.hexleRow);'
    
      '    if (swatch) { swatch.style.backgroundColor = guessedHex; swa' +
      'tch.style.borderColor = '#39'#565758'#39'; }'
    ''
    
      '    window.hexleRow++; window.hexleCol = 0; window.hexleIsWin = ' +
      'isWin; window.saveHexleState();'
    
      '    if (isWin || window.hexleRow >= window.hexleMaxGuesses) { se' +
      'tTimeout(function() { window.showHexleGameOver(false); }, 1500);' +
      ' }'
    '};'
    ''
    'window.showHexleError = function(errorMsg) {'
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ', title: '#39'HATA!'#39', text: errorMsg, icon: '#39'warning'#39', toast: true, ' +
      'position: '#39'top'#39', showConfirmButton: false, timer: 2500, backgrou' +
      'nd: '#39'#1a1a1b'#39', color: '#39'#ffffff'#39', customClass: { popup: '#39'oct-popu' +
      'p'#39' }'
    '        });'
    '    }'
    '    for (var i = 0; i < window.hexleLength; i++) {'
    '        var cell = window.getCell(window.hexleRow, i);'
    '        if (cell) {'
    
      '            cell.classList.remove('#39'shake'#39', '#39'error'#39'); void cell.o' +
      'ffsetWidth; cell.classList.add('#39'shake'#39', '#39'error'#39');'
    
      '            setTimeout((function(c) { return function() { c.clas' +
      'sList.remove('#39'error'#39'); }; })(cell), 800);'
    '        }'
    '    }'
    '};'
    ''
    
      'if (window.hexleKeyHandler) document.removeEventListener('#39'keydow' +
      'n'#39', window.hexleKeyHandler);'
    
      'if (window.hexleClickHandler) document.removeEventListener('#39'clic' +
      'k'#39', window.hexleClickHandler);'
    ''
    'window.hexleKeyHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    
      '    if (e.ctrlKey || e.metaKey || e.altKey || window.hexleGameOv' +
      'er) return;'
    '    var key = e.key.toUpperCase();'
    '    if (e.key === '#39'Backspace'#39') key = '#39'BACKSPACE'#39';'
    '    if (e.key === '#39'Enter'#39') key = '#39'ENTER'#39';'
    '    window.handleInput(key);'
    '};'
    ''
    'window.hexleClickHandler = function(e) {'
    '    if (!window.getVisibleViewport()) return; '
    '    if (window.hexleGameOver) return;'
    '    var keyElement = e.target.closest('#39'.key'#39');'
    '    if (keyElement) { '
    '        var keyValue = keyElement.getAttribute('#39'data-key'#39'); '
    '        if (keyValue) window.handleInput(keyValue); '
    '        keyElement.blur(); '
    '    }'
    '};'
    ''
    'document.addEventListener('#39'keydown'#39', window.hexleKeyHandler);'
    'document.addEventListener('#39'click'#39', window.hexleClickHandler);')
  TextHeight = 15
  object HexleHTML: TUniHTMLFrame
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
      '    .hexle-viewport {'
      '        position: fixed;'
      
        '        top: 0; left: 0; right: 0; bottom: 0; /* iOS iframe esne' +
        'mesini engeller */'
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
      '    .hexle-header {'
      '        width: 100%; max-width: 600px;'
      
        '        display: flex; justify-content: space-between; align-ite' +
        'ms: center;'
      '        padding: 10px 15px; border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .hexle-header h1 { '
      
        '        margin: 0; font-size: 1.5rem; letter-spacing: 2px; font-' +
        'weight: 800; text-align: center; '
      '    }'
      '    '
      '    .btn-back { '
      
        '        background: none; border: none; color: #818384; font-siz' +
        'e: 1.4rem; '
      '        cursor: pointer; transition: color 0.2s; padding: 5px; '
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      '    .btn-back:active { color: #ffffff; transform: scale(0.95); }'
      ''
      '    .hexle-timer { '
      
        '        font-family: '#39'Courier New'#39', Courier, monospace; color: #' +
        '818384; '
      
        '        font-size: 1.2rem; font-weight: bold; width: 60px; text-' +
        'align: right; '
      '    }'
      ''
      '    /* ========================================='
      '       OYUN ALANI VE HEDEF RENK'
      '       ========================================= */'
      '    .hexle-board-container {'
      
        '        flex-grow: 1; display: flex; flex-direction: column; ali' +
        'gn-items: center;'
      
        '        width: 100%; padding: 10px 15px; box-sizing: border-box;' +
        ' min-height: 0;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .hexle-target-color {'
      '        width: 100%; max-width: 420px; height: 60px;'
      '        border-radius: 12px; margin-bottom: 15px;'
      '        border: 2px solid #3a3a3c;'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      '        box-shadow: 0 4px 10px rgba(0,0,0,0.3);'
      '        transition: background-color 0.5s ease;'
      '    }'
      ''
      '    /* 6 H'#252'cre + 1 Renk Topu (Swatch) i'#231'in Grid Ayar'#305' */'
      '    .hexle-board {'
      '        display: grid;'
      '        grid-template-rows: repeat(6, 1fr);'
      '        grid-template-columns: repeat(6, 1fr) 45px; '
      '        gap: 6px; width: 100%; max-width: 440px; '
      '    }'
      ''
      '    .hexle-cell {'
      '        width: 100%; aspect-ratio: 1 / 1;'
      '        border: 2px solid #3a3a3c;'
      
        '        display: flex; flex-direction: column; justify-content: ' +
        'center; align-items: center;'
      
        '        font-size: 1.8rem; font-weight: bold; box-sizing: border' +
        '-box; user-select: none;'
      
        '        transition: transform 0.1s, background-color 0.4s, borde' +
        'r-color 0.4s;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    /* Sat'#305'r sonundaki tahmin edilen renk topu */'
      '    .hexle-swatch {'
      '        width: 100%; aspect-ratio: 1 / 1;'
      '        border-radius: 50%;'
      '        border: 2px solid #3a3a3c;'
      '        background-color: transparent;'
      '        box-sizing: border-box;'
      
        '        transition: background-color 0.5s ease, border-color 0.5' +
        's;'
      '        align-self: center; justify-self: center;'
      '    }'
      ''
      
        '    .hexle-indicator { font-size: 0.8rem; margin-top: -5px; colo' +
        'r: #ffffff; opacity: 0.8; }'
      ''
      '    .hexle-cell.filled { border-color: #565758; }'
      
        '    .hexle-cell.correct { background-color: #538d4e; border-colo' +
        'r: #538d4e; }'
      
        '    .hexle-cell.higher, .hexle-cell.very_higher { background-col' +
        'or: #b59f3b; border-color: #b59f3b; }'
      
        '    .hexle-cell.lower, .hexle-cell.very_lower { background-color' +
        ': #b59f3b; border-color: #b59f3b; }'
      
        '    .hexle-cell.error { background-color: #e74c3c !important; bo' +
        'rder-color: #e74c3c !important; color: #fff !important; }'
      ''
      '    /* ========================================='
      '       KLAVYE'
      '       ========================================= */'
      '    .hexle-keyboard { '
      '        width: 100%; max-width: 600px; '
      '        padding: 0 8px 20px 8px; box-sizing: border-box; '
      '        background-color: #121213;'
      '    }'
      '    '
      '    .keyboard-row { '
      
        '        display: flex; justify-content: center; width: 100%; mar' +
        'gin-bottom: 6px; gap: 4px; '
      '        box-sizing: border-box;'
      '    }'
      '    '
      '    .key {'
      
        '        background-color: #818384; color: #ffffff; border: none;' +
        ' border-radius: 4px; height: 55px;'
      
        '        font-size: 1.2rem; font-weight: bold; display: flex; jus' +
        'tify-content: center; align-items: center;'
      
        '        cursor: pointer; user-select: none; flex: 1; max-width: ' +
        '45px; transition: background-color 0.1s, transform 0.1s;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      '    .key.wide { flex: 1.5; max-width: 80px; font-size: 1rem; }'
      '    .key:active { transform: scale(0.92); }'
      '    .key.correct { background-color: #538d4e; }'
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
      '        .hexle-header { padding: 8px 10px; }'
      '        .hexle-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        '
      '        .hexle-board-container { padding: 5px; }'
      '        '
      '        /* Hedef renk topu mobilde az daha ince olabilir */'
      
        '        .hexle-target-color { height: 50px; margin-bottom: 10px;' +
        ' max-width: 360px; }'
      '        '
      
        '        /* 6 h'#252'cre + 1 top oran'#305' mobilde ta'#351'mas'#305'n diye ayarland'#305 +
        ' */'
      '        .hexle-board { '
      '            max-width: 100vw; '
      '            gap: 4px; '
      '            padding: 0 5px; '
      
        '            grid-template-columns: repeat(6, 1fr) 35px; /* Top '#231 +
        'ap'#305' mobilde 35px'#39'e d'#252#351#252'r'#252'ld'#252' */'
      '        }'
      '        '
      '        .hexle-cell { font-size: 1.5rem; border-width: 1.5px; }'
      '        .hexle-indicator { font-size: 0.7rem; }'
      '        '
      '        /* Klavye kesin kilitleri */'
      
        '        .hexle-keyboard { padding: 0 4px 10px 4px; max-width: 10' +
        '0vw; }'
      
        '        .keyboard-row { gap: 3px; margin-bottom: 5px; width: 100' +
        '%; }'
      '        .key { '
      '            height: 48px; font-size: 1.15rem; '
      '            max-width: none; flex: 1 1 0; '
      '            padding: 0; margin: 0;'
      '        }'
      '        .key.wide { font-size: 0.85rem; flex: 1.5 1 0; }'
      '    }'
      ''
      '    /* '#199'ok k'#252#231#252'k ekranlar (iPhone SE vb.) */'
      '    @media (max-width: 360px) {'
      
        '        .hexle-board { gap: 3px; grid-template-columns: repeat(6' +
        ', 1fr) 30px; }'
      '        .hexle-cell { font-size: 1.3rem; }'
      '        .keyboard-row { gap: 2px; }'
      '        .key { height: 44px; font-size: 1rem; }'
      '        .key.wide { font-size: 0.75rem; }'
      '    }'
      '</style>'
      ''
      '<div class="hexle-viewport">'
      '    <div class="hexle-header">'
      
        '        <button class="btn-back" onclick="ajaxRequest(HEXLE_FORM' +
        '.HexleHTML, '#39'closePage'#39');"><i class="fa-solid fa-arrow-left"></i' +
        '></button>'
      '        <h1>HEXLE</h1>'
      '        <div id="hexleTimer" class="hexle-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="hexle-board-container">'
      
        '        <div class="hexle-target-color" id="hexleTargetColor"></' +
        'div>'
      '        <div class="hexle-board" id="hexleBoard"></div>'
      '    </div>'
      ''
      '    <div class="hexle-keyboard" id="hexleKeyboard">'
      '        <div class="keyboard-row">'
      
        '            <div class="key" data-key="0">0</div><div class="key' +
        '" data-key="1">1</div><div class="key" data-key="2">2</div><div ' +
        'class="key" data-key="3">3</div><div class="key" data-key="4">4<' +
        '/div><div class="key" data-key="5">5</div><div class="key" data-' +
        'key="6">6</div><div class="key" data-key="7">7</div><div class="' +
        'key" data-key="8">8</div><div class="key" data-key="9">9</div>'
      '        </div>'
      '        <div class="keyboard-row">'
      
        '            <div class="key wide" id="keyEnter" data-key="ENTER"' +
        '>ENTER</div>'
      
        '            <div class="key" data-key="A">A</div><div class="key' +
        '" data-key="B">B</div><div class="key" data-key="C">C</div><div ' +
        'class="key" data-key="D">D</div><div class="key" data-key="E">E<' +
        '/div><div class="key" data-key="F">F</div>'
      
        '            <div class="key wide" id="keyBackspace" data-key="BA' +
        'CKSPACE"><i class="fa-solid fa-delete-left"></i></div>'
      '        </div>'
      '    </div>'
      '</div>')
    Align = alClient
    OnAjaxEvent = HexleHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 50
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 648
    Top = 128
  end
end
