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
    'window.hexleStartTimeStamp = 0;'
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
    '    '
    
      '    if (!window.hexleStartTimeStamp || window.hexleStartTimeStam' +
      'p === 0) {'
    
      '        window.hexleStartTimeStamp = Date.now() - (window.hexleE' +
      'lapsedTime * 1000);'
    '    }'
    '    '
    '    var timerEl = window.hexleEl('#39'.hexle-timer'#39');'
    '    window.hexleTimerInterval = setInterval(function() {'
    
      '        window.hexleElapsedTime = Math.floor((Date.now() - windo' +
      'w.hexleStartTimeStamp) / 1000);'
    
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
    '    if (window.hexleGameOver) return; '
    ''
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
    
      'window.showHexleGameOver = function(isReplay, savedTries, savedT' +
      'ime, savedIsWin) {'
    
      '    if (window.hexleTimerInterval) clearInterval(window.hexleTim' +
      'erInterval);'
    ''
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.hexleElapsedTime; '
    
      '    var tries = (isReplay && savedTries !== undefined) ? savedTr' +
      'ies : window.hexleRow; '
    
      '    var isWin = (isReplay && savedIsWin !== undefined) ? savedIs' +
      'Win : window.hexleIsWin;'
    ''
    '    var grade = window.calculateGrade(tries, isWin);'
    ''
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39'); '
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39'); '
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) { '
    '        window.hexleGameOver = true; '
    '        window.finalGrade = grade; '
    '        window.saveHexleState(); '
    '        '
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
    '    '
    '    document.getElementById('#39'crmTitle'#39').innerText = modalTitle;'
    
      '    document.getElementById('#39'crmTitle'#39').style.color = isWin ? '#39'#' +
      'fff'#39' : (isReplay ? '#39'#fff'#39' : '#39'#e74c3c'#39');'
    '    '
    '    var subTextEl = document.getElementById('#39'crmSubText'#39');'
    '    if (isReplay) {'
    '        subTextEl.innerHTML = '#39'Bug'#252'n'#252'n rengini zaten buldun!'#39';'
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
    
      '    document.getElementById('#39'crmAnswerSwatch'#39').style.backgroundC' +
      'olor = "transparent";'
    ''
    
      '    document.getElementById('#39'customResultModal'#39').classList.add('#39 +
      'active'#39');'
    ''
    '    setTimeout(function() {'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '            ajaxRequest(HEXLE_FORM.HexleHTML, '#39'GetPanelStats'#39', [' +
      #39'game_type=hexle'#39']);'
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
    
      '    if (answerText && answerText !== "HATA" && answerText !== "G' +
      #304'ZL'#304'") {'
    
      '        var hexCode = answerText.startsWith('#39'#'#39') ? answerText : ' +
      #39'#'#39' + answerText;'
    
      '        document.getElementById('#39'crmAnswerText'#39').innerText = hex' +
      'Code;'
    
      '        document.getElementById('#39'crmAnswerSwatch'#39').style.backgro' +
      'undColor = hexCode;'
    '    } else {'
    
      '        document.getElementById('#39'crmAnswerText'#39').innerText = "G'#304 +
      'ZL'#304'";'
    
      '        document.getElementById('#39'crmAnswerSwatch'#39').style.backgro' +
      'undColor = "transparent";'
    '    }'
    '};'
    ''
    'window.closeResultModal = function() {'
    '    var modal = document.getElementById('#39'customResultModal'#39');'
    '    if(modal) modal.classList.remove('#39'active'#39');'
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(HEXLE_FO' +
      'RM.HexleHTML, '#39'closePage'#39');'
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
    '    var boardEl = window.hexleEl('#39'.hexle-board'#39');'
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
      '    .hexle-viewport {'
      '        position: fixed;'
      '        top: 0; left: 0; right: 0; bottom: 0; '
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
      '        box-shadow: 0 0 0 100vmax #121213; '
      '        clip-path: inset(0); '
      '    }'
      ''
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
        'eight: bold; letter-spacing: 1px; margin-bottom: 6px; }'
      
        '    .crm-answer-val { font-size: 1.5rem; color: #fff; font-weigh' +
        't: 800; letter-spacing: 3px; word-break: break-all; line-height:' +
        ' 1.4; margin: 0; }'
      ''
      
        '    .modal-save-btn { width: 100%; background: #538d4e; color: #' +
        'fff; border: none; padding: 16px; border-radius: 12px; font-weig' +
        'ht: 800; font-size: 1rem; cursor: pointer; transition: 0.3s; fle' +
        'x-shrink: 0; text-transform: uppercase; letter-spacing: 1px; }'
      ''
      '    @keyframes shake {'
      '        10%, 90% { transform: translate3d(-2px, 0, 0); }'
      '        20%, 80% { transform: translate3d(4px, 0, 0); }'
      '        30%, 50%, 70% { transform: translate3d(-6px, 0, 0); }'
      '        40%, 60% { transform: translate3d(6px, 0, 0); }'
      '    }'
      
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
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .key:hover { opacity: 0.85; }'
      '        .modal-save-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    @media (max-width: 500px) {'
      '        .hexle-header { padding: 8px 10px; }'
      '        .hexle-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        '
      '        .hexle-board-container { padding: 5px; }'
      
        '        .hexle-target-color { height: 50px; margin-bottom: 10px;' +
        ' max-width: 360px; }'
      '        '
      '        .hexle-board { '
      '            max-width: 100vw; '
      '            gap: 4px; '
      '            padding: 0 5px; '
      '            grid-template-columns: repeat(6, 1fr) 35px; '
      '        }'
      '        '
      '        .hexle-cell { font-size: 1.5rem; border-width: 1.5px; }'
      '        .hexle-indicator { font-size: 0.7rem; }'
      '        '
      
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
      ''
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 450px; }'
      '    }'
      ''
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
      
        '        <button class="btn-back" onclick="window.closeResultModa' +
        'l();"><i class="fa-solid fa-arrow-left"></i></button>'
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
      
        '                    <div class="crm-answer-lbl">G'#220'N'#220'N RENG'#304'</div' +
        '>'
      
        '                    <div style="display:flex; justify-content:ce' +
        'nter; align-items:center; gap:8px;">'
      
        '                        <div id="crmAnswerSwatch" style="width:2' +
        '5px; height:25px; border-radius:50%; border:2px solid #565758; b' +
        'ackground:transparent; transition: background-color 0.4s;"></div' +
        '>'
      
        '                        <div class="crm-answer-val" id="crmAnswe' +
        'rText" style="margin:0;"><i class="fa-solid fa-spinner fa-spin">' +
        '</i></div>'
      '                    </div>'
      '                </div>'
      ''
      
        '                <button class="modal-save-btn" onclick="window.c' +
        'loseResultModal()">KAPAT</button>'
      '            </div>'
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
