object SUDOKU_FORM: TSUDOKU_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'SUDOKU_FORM'
  OnShow = UniFormShow
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.selectedCell = null;'
    'window.sudokuTimerInterval = null;'
    'window.sudokuElapsedTime = 0;'
    'window.sudokuMoves = 0;'
    'window.currentSudokuBoardStr = "";'
    'window.isGameCompleted = false;'
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.sudoku-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    
      'window.sudokuEl = function(selector) { var vp = window.getVisibl' +
      'eViewport(); return vp ? vp.querySelector(selector) : null; };'
    
      'window.sudokuEls = function(selector) { var vp = window.getVisib' +
      'leViewport(); return vp ? vp.querySelectorAll(selector) : []; };'
    ''
    'window.receiveSudokuData = function(response) {'
    
      '    if (!response || !response.success || !response.grid) return' +
      ';'
    '    var flatPuzzle = [];'
    '    for (var r = 0; r < response.grid.length; r++) {'
    '        for (var c = 0; c < response.grid[r].length; c++) {'
    '            flatPuzzle.push(response.grid[r][c]);'
    '        }'
    '    }'
    '    window.currentSudokuBoardStr = flatPuzzle.join('#39','#39');'
    '    window.initSudokuBoard(flatPuzzle);'
    '};'
    ''
    'window.initSudokuBoard = function(flatPuzzle) {'
    '    var gridEl = window.sudokuEl('#39'#sudokuGrid'#39');'
    '    if (!gridEl) { '
    
      '        setTimeout(function() { window.initSudokuBoard(flatPuzzl' +
      'e); }, 100); '
    '        return; '
    '    }'
    '    gridEl.innerHTML = '#39#39'; '
    '    for (var i = 0; i < 81; i++) {'
    '        var cell = document.createElement('#39'div'#39');'
    '        cell.className = '#39'sudoku-cell'#39';'
    '        cell.setAttribute('#39'data-index'#39', i);'
    '        var val = flatPuzzle[i];'
    '        if (val !== 0 && val !== null) {'
    '            cell.textContent = val;'
    '            cell.classList.add('#39'fixed'#39');'
    '        }'
    '        cell.onclick = (function(idx) {'
    '            return function() { '
    
      '                var target = window.sudokuEl('#39'.sudoku-cell[data-' +
      'index="'#39' + idx + '#39'"]'#39');'
    '                window.selectCell(target); '
    '            };'
    '        })(i);'
    '        gridEl.appendChild(cell);'
    '    }'
    '    window.loadSudokuState();'
    '};'
    ''
    'window.loadSudokuState = function() {'
    '    if (window.isGameCompleted) return;'
    ''
    '    var saved = localStorage.getItem('#39'octaily_sudoku_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.board === window.currentSudokuBoardStr) {'
    '                window.sudokuElapsedTime = state.time || 0;'
    '                window.sudokuMoves = state.moves || 0;'
    '                var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '                for (var key in state.answers) {'
    '                    if (state.answers.hasOwnProperty(key)) {'
    '                        var idx = parseInt(key, 10);'
    
      '                        if (cells[idx] && !cells[idx].classList.' +
      'contains('#39'fixed'#39')) {'
    
      '                            cells[idx].textContent = state.answe' +
      'rs[key];'
    '                        }'
    '                    }'
    '                }'
    '            } else {'
    '                localStorage.removeItem('#39'octaily_sudoku_state'#39');'
    '                window.sudokuElapsedTime = 0;'
    '                window.sudokuMoves = 0;'
    '            }'
    '        } catch (e) {'
    '            localStorage.removeItem('#39'octaily_sudoku_state'#39');'
    '        }'
    '    }'
    '    window.validateBoard();'
    '    window.startSudokuTimer();'
    '};'
    ''
    'window.saveSudokuState = function() {'
    
      '    if (!window.getVisibleViewport() || window.isGameCompleted) ' +
      'return; '
    '    var state = { '
    '        board: window.currentSudokuBoardStr, '
    '        time: window.sudokuElapsedTime, '
    '        moves: window.sudokuMoves,'
    '        answers: {} '
    '    };'
    '    var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    '        if (!cells[i].classList.contains('#39'fixed'#39')) {'
    
      '            var val = cells[i].textContent || cells[i].innerText' +
      ';'
    '            if (val && val !== '#39#39') {'
    '                state.answers[i] = val;'
    '            }'
    '        }'
    '    }'
    
      '    localStorage.setItem('#39'octaily_sudoku_state'#39', JSON.stringify(' +
      'state));'
    '};'
    ''
    'window.startSudokuTimer = function() {'
    
      '    if (window.sudokuTimerInterval) clearInterval(window.sudokuT' +
      'imerInterval);'
    '    if (window.isGameCompleted) return; '
    '    var timerEl = window.sudokuEl('#39'#sudokuTimer'#39');'
    '    window.sudokuTimerInterval = setInterval(function() {'
    '        window.sudokuElapsedTime++;'
    '        if (timerEl) {'
    
      '            var m = Math.floor(window.sudokuElapsedTime / 60).to' +
      'String().padStart(2, '#39'0'#39');'
    
      '            var s = (window.sudokuElapsedTime % 60).toString().p' +
      'adStart(2, '#39'0'#39');'
    '            timerEl.textContent = m + '#39':'#39' + s;'
    '        }'
    
      '        if (window.sudokuElapsedTime % 5 === 0) window.saveSudok' +
      'uState();'
    '    }, 1000);'
    '};'
    ''
    'window.selectCell = function(cell) {'
    '    if (!cell || window.isGameCompleted) return; '
    
      '    if (window.selectedCell) window.selectedCell.classList.remov' +
      'e('#39'selected'#39');'
    '    window.selectedCell = cell;'
    '    cell.classList.add('#39'selected'#39');'
    '};'
    ''
    'window.inputNumber = function(num) {'
    '    if (window.isGameCompleted) return; '
    
      '    if (!window.selectedCell || window.selectedCell.classList.co' +
      'ntains('#39'fixed'#39')) return;'
    '    var valStr = (num === 0) ? '#39#39' : num.toString();'
    
      '    var currentVal = window.selectedCell.textContent || window.s' +
      'electedCell.innerText;'
    '    if (valStr !== currentVal) {'
    '        window.sudokuMoves++;'
    '        window.selectedCell.textContent = valStr;'
    '        window.validateBoard();'
    '        window.saveSudokuState();'
    '        if (window.checkSudokuWin()) {'
    '            window.showGameOver(false);'
    '        }'
    '    }'
    '};'
    ''
    'window.validateBoard = function() {'
    '    var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '    if (cells.length !== 81) return false;'
    '    var board = [];'
    '    for (var i = 0; i < 81; i++) {'
    '        var valStr = cells[i].textContent || cells[i].innerText;'
    '        var val = parseInt(valStr, 10);'
    '        board.push(isNaN(val) ? 0 : val);'
    '        cells[i].classList.remove('#39'wrong'#39');'
    '    }'
    '    var hasError = false;'
    '    for (var i = 0; i < 81; i++) {'
    '        if (board[i] === 0) continue;'
    '        var r = Math.floor(i / 9);'
    '        var c = i % 9;'
    '        var val = board[i];'
    '        for (var c2 = 0; c2 < 9; c2++) {'
    '            var idx2 = r * 9 + c2;'
    '            if (c !== c2 && board[idx2] === val) {'
    '                cells[i].classList.add('#39'wrong'#39');'
    '                cells[idx2].classList.add('#39'wrong'#39');'
    '                hasError = true;'
    '            }'
    '        }'
    '        for (var r2 = 0; r2 < 9; r2++) {'
    '            var idx2 = r2 * 9 + c;'
    '            if (r !== r2 && board[idx2] === val) {'
    '                cells[i].classList.add('#39'wrong'#39');'
    '                cells[idx2].classList.add('#39'wrong'#39');'
    '                hasError = true;'
    '            }'
    '        }'
    '        var br0 = Math.floor(r / 3) * 3;'
    '        var bc0 = Math.floor(c / 3) * 3;'
    '        for (var r2 = br0; r2 < br0 + 3; r2++) {'
    '            for (var c2 = bc0; c2 < bc0 + 3; c2++) {'
    '                var idx2 = r2 * 9 + c2;'
    '                if (i !== idx2 && board[idx2] === val) {'
    '                    cells[i].classList.add('#39'wrong'#39');'
    '                    cells[idx2].classList.add('#39'wrong'#39');'
    '                    hasError = true;'
    '                }'
    '            }'
    '        }'
    '    }'
    '    return hasError;'
    '};'
    ''
    'window.checkSudokuWin = function() {'
    '    var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '    if (cells.length !== 81) return false;'
    '    var isFull = true;'
    '    for (var i = 0; i < 81; i++) {'
    '        var valStr = cells[i].textContent || cells[i].innerText;'
    '        if (!valStr || valStr === '#39#39') {'
    '            isFull = false;'
    '            break;'
    '        }'
    '    }'
    '    var hasErrors = window.validateBoard();'
    '    return isFull && !hasErrors;'
    '};'
    ''
    'window.clearAllInputs = function() {'
    '    if (window.isGameCompleted) return; '
    '    var coreClear = function() {'
    '        var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '        for (var i = 0; i < cells.length; i++) {'
    '            if (!cells[i].classList.contains('#39'fixed'#39')) {'
    '                cells[i].textContent = '#39#39';'
    '            }'
    '        }'
    '        window.validateBoard();'
    '        window.sudokuElapsedTime = 0; '
    '        window.sudokuMoves = 0;'
    '        localStorage.removeItem('#39'octaily_sudoku_state'#39'); '
    '    };'
    
      '    if (confirm('#39'T'#252'm ilerlemeniz temizlenecek. Emin misiniz?'#39')) ' +
      'coreClear();'
    '};'
    ''
    'window.calculateSudokuGrade = function(timeInSec, isWin) {'
    '    if (!isWin) return '#39'F'#39';'
    '    if (timeInSec <= 300) return '#39'S+'#39';'
    '    if (timeInSec <= 600) return '#39'S'#39';'
    '    if (timeInSec <= 900) return '#39'A'#39';'
    '    if (timeInSec <= 1200) return '#39'B'#39';'
    '    if (timeInSec <= 1800) return '#39'C'#39';'
    '    return '#39'D'#39';'
    '};'
    ''
    
      'window.showGameOver = function(isReplay, savedMoves, savedTime, ' +
      'savedIsWin) {'
    
      '    if (window.sudokuTimerInterval) clearInterval(window.sudokuT' +
      'imerInterval);'
    '    '
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.sudokuElapsedTime;'
    
      '    var moves = (isReplay && savedMoves !== undefined) ? savedMo' +
      'ves : window.sudokuMoves;'
    
      '    var isWin = (isReplay && savedIsWin !== undefined) ? savedIs' +
      'Win : true;'
    ''
    '    var grade = window.calculateSudokuGrade(time, isWin);'
    ''
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    if (!isReplay) {'
    '        window.isGameCompleted = true;'
    '        window.saveSudokuState();'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(SUDOKU_FORM.SudokuHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time,'
    '                '#39'moves='#39' + moves,'
    '                '#39'grade='#39' + grade,'
    '                '#39'isWin='#39' + (isWin ? '#39'1'#39' : '#39'0'#39'),'
    '                '#39'game_type=sudoku'#39
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
    ''
    '    document.getElementById('#39'crmTitle'#39').innerText = modalTitle;'
    
      '    document.getElementById('#39'crmTitle'#39').style.color = isWin ? '#39'#' +
      'fff'#39' : (isReplay ? '#39'#fff'#39' : '#39'#e74c3c'#39');'
    '    '
    '    var subTextEl = document.getElementById('#39'crmSubText'#39');'
    '    if (isReplay) {'
    
      '        subTextEl.innerHTML = '#39'Bug'#252'n'#252'n bulmacas'#305'n'#305' zaten '#231#246'zd'#252'n!' +
      #39';'
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
    
      '    document.getElementById('#39'crmTries'#39').innerText = moves.toStri' +
      'ng();'
    ''
    
      '    document.getElementById('#39'crmAvgTime'#39').innerHTML = '#39'<i class=' +
      '"fa-solid fa-spinner fa-spin"></i>'#39';'
    
      '    document.getElementById('#39'crmPercentile'#39').innerHTML = '#39'<i cla' +
      'ss="fa-solid fa-spinner fa-spin"></i>'#39';'
    ''
    
      '    document.getElementById('#39'customResultModal'#39').classList.add('#39 +
      'active'#39');'
    ''
    '    setTimeout(function() {'
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    
      '            ajaxRequest(SUDOKU_FORM.SudokuHTML, '#39'GetPanelStats'#39',' +
      ' ['#39'game_type=sudoku'#39']);'
    '        }'
    '    }, isReplay ? 0 : 400);'
    '};'
    ''
    'window.updatePanelStats = function(avgTimeSec, percentile) {'
    
      '    var m = Math.floor(avgTimeSec / 60).toString().padStart(2, '#39 +
      '0'#39');'
    '    var s = (avgTimeSec % 60).toString().padStart(2, '#39'0'#39');'
    
      '    document.getElementById('#39'crmAvgTime'#39').innerText = (avgTimeSe' +
      'c > 0) ? (m + '#39':'#39' + s) : '#39'--:--'#39';'
    
      '    document.getElementById('#39'crmPercentile'#39').innerText = '#39'%'#39' + p' +
      'ercentile;'
    '};'
    ''
    'window.closeResultModal = function() {'
    '    var modal = document.getElementById('#39'customResultModal'#39');'
    '    if(modal) modal.classList.remove('#39'active'#39');'
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(SUDOKU_F' +
      'ORM.SudokuHTML, '#39'closePage'#39');'
    '};'
    ''
    
      'if (window.sudokuKeyHandler) document.removeEventListener('#39'keydo' +
      'wn'#39', window.sudokuKeyHandler);'
    'window.sudokuKeyHandler = function(e) {'
    
      '    if (!window.getVisibleViewport() || window.isGameCompleted) ' +
      'return; '
    '    if (!window.selectedCell) {'
    
      '        if (e.key.indexOf('#39'Arrow'#39') !== -1) window.selectCell(win' +
      'dow.sudokuEl('#39'.sudoku-cell[data-index="0"]'#39'));'
    '        return;'
    '    }'
    
      '    var index = parseInt(window.selectedCell.getAttribute('#39'data-' +
      'index'#39'));'
    
      '    var row = Math.floor(index / 9), col = index % 9, newIndex =' +
      ' index;'
    
      '    if (e.key === '#39'ArrowUp'#39') { row = (row > 0) ? row - 1 : 8; ne' +
      'wIndex = (row * 9) + col; }'
    
      '    else if (e.key === '#39'ArrowDown'#39') { row = (row < 8) ? row + 1 ' +
      ': 0; newIndex = (row * 9) + col; }'
    
      '    else if (e.key === '#39'ArrowLeft'#39') { col = (col > 0) ? col - 1 ' +
      ': 8; newIndex = (row * 9) + col; }'
    
      '    else if (e.key === '#39'ArrowRight'#39') { col = (col < 8) ? col + 1' +
      ' : 0; newIndex = (row * 9) + col; }'
    '    '
    '    if (newIndex !== index) {'
    
      '        var nextCell = window.sudokuEl('#39'.sudoku-cell[data-index=' +
      '"'#39' + newIndex + '#39'"]'#39');'
    
      '        if (nextCell) { window.selectCell(nextCell); e.preventDe' +
      'fault(); }'
    '    }'
    
      '    if (e.key >= '#39'1'#39' && e.key <= '#39'9'#39') { window.inputNumber(parse' +
      'Int(e.key)); }'
    
      '    else if (e.key === '#39'Backspace'#39' || e.key === '#39'Delete'#39' || e.ke' +
      'y === '#39'0'#39') { window.inputNumber(0); }'
    '};'
    'document.addEventListener('#39'keydown'#39', window.sudokuKeyHandler);')
  TextHeight = 15
  object SudokuHTML: TUniHTMLFrame
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
      '    .sudoku-viewport {'
      
        '        position: fixed; top: 0; left: 0; right: 0; bottom: 0; w' +
        'idth: 100vw; height: 100vh; height: 100dvh;'
      
        '        background-color: #121213 !important; display: flex; fle' +
        'x-direction: column; align-items: center;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif; color: #ffffff; z-index: 9999; overflow: hidden;'
      
        '        padding-top: env(safe-area-inset-top); padding-bottom: e' +
        'nv(safe-area-inset-bottom); box-sizing: border-box;'
      '        box-shadow: 0 0 0 100vmax #121213; clip-path: inset(0); '
      '    }'
      ''
      
        '    .sudoku-header { width: 100%; max-width: 500px; display: fle' +
        'x; justify-content: space-between; align-items: center; padding:' +
        ' 10px 15px; border-bottom: 1px solid #3a3a3c; box-sizing: border' +
        '-box; background-color: #121213; }'
      
        '    .sudoku-header h1 { margin: 0; font-size: 1.4rem; letter-spa' +
        'cing: 2px; font-weight: 800; text-align: center; }'
      
        '    .btn-back { background: none; border: none; color: #818384; ' +
        'font-size: 1.5rem; cursor: pointer; transition: color 0.2s; padd' +
        'ing: 5px; -webkit-tap-highlight-color: transparent; }'
      
        '    .sudoku-timer { font-family: '#39'Courier New'#39', Courier, monospa' +
        'ce; color: #818384; font-size: 1.2rem; font-weight: bold; width:' +
        ' 60px; text-align: right; }'
      ''
      
        '    .sudoku-action-bar { width: 100%; max-width: 500px; display:' +
        ' flex; justify-content: flex-end; align-items: center; padding: ' +
        '8px 15px 0 15px; box-sizing: border-box; }'
      
        '    .btn-refresh { background: none; border: none; color: #81838' +
        '4; font-size: 1.2rem; cursor: pointer; transition: color 0.2s; p' +
        'adding: 5px; -webkit-tap-highlight-color: transparent; }'
      '    .btn-refresh:active { color: #ffffff; }'
      ''
      
        '    .sudoku-container { flex-grow: 1; display: flex; justify-con' +
        'tent: center; align-items: center; padding: 10px; width: 100%; m' +
        'in-height: 0; background-color: #121213; box-sizing: border-box;' +
        ' }'
      
        '    .sudoku-grid { display: grid; grid-template-columns: repeat(' +
        '9, 1fr); width: 100%; max-width: 400px; aspect-ratio: 1 / 1; bac' +
        'kground-color: #ffffff; border: 3px solid #ffffff; box-shadow: 0' +
        ' 0 30px rgba(0,0,0,0.6); box-sizing: border-box; }'
      '    '
      
        '    .sudoku-cell { background-color: #121213; display: flex; jus' +
        'tify-content: center; align-items: center; font-size: 1.8rem; fo' +
        'nt-weight: bold; cursor: pointer; user-select: none; border: 0.5' +
        'px solid #3a3a3c; box-sizing: border-box; aspect-ratio: 1 / 1; l' +
        'ine-height: 1; padding: 0; -webkit-tap-highlight-color: transpar' +
        'ent; }'
      
        '    .sudoku-cell:nth-child(3n) { border-right: 3px solid #ffffff' +
        '; }'
      '    .sudoku-cell:nth-child(9n) { border-right: none; }'
      
        '    .sudoku-cell:nth-child(n+19):nth-child(-n+27), .sudoku-cell:' +
        'nth-child(n+46):nth-child(-n+54) { border-bottom: 3px solid #fff' +
        'fff; }'
      
        '    .sudoku-cell.fixed { color: #818384; background-color: #1a1a' +
        '1b; cursor: default; }'
      
        '    .sudoku-cell.selected { background-color: #313a46; box-shado' +
        'w: inset 0 0 0 3px #538d4e; }'
      '    .sudoku-cell.wrong { color: #e74c3c; }'
      ''
      
        '    .sudoku-numpad { width: 100%; max-width: 500px; display: gri' +
        'd; grid-template-columns: repeat(5, 1fr); gap: 8px; padding: 15p' +
        'x 15px 25px 15px; box-sizing: border-box; background-color: #121' +
        '213; }'
      
        '    .num-key { background-color: #818384; height: 55px; border-r' +
        'adius: 6px; display: flex; justify-content: center; align-items:' +
        ' center; font-size: 1.3rem; font-weight: bold; cursor: pointer; ' +
        'transition: transform 0.1s, background-color 0.1s; -webkit-tap-h' +
        'ighlight-color: transparent; user-select: none; }'
      
        '    .num-key:active { transform: scale(0.92); background-color: ' +
        '#538d4e; }'
      
        '    .num-key.erase:active { background-color: #565758 !important' +
        '; }'
      ''
      
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
      ''
      
        '    .modal-save-btn { width: 100%; background: #538d4e; color: #' +
        'fff; border: none; padding: 16px; border-radius: 12px; font-weig' +
        'ht: 800; font-size: 1rem; cursor: pointer; transition: 0.3s; fle' +
        'x-shrink: 0; text-transform: uppercase; letter-spacing: 1px; }'
      ''
      
        '    @keyframes swalPopIn { 0% { opacity: 0; transform: scale(0.8' +
        '); } 80% { transform: scale(1.05); opacity: 1; } 100% { transfor' +
        'm: scale(1); opacity: 1; } }'
      
        '    @keyframes gradeSectionIn { 0% { opacity: 0; transform: scal' +
        'e(0.5) translateY(20px); } 100% { opacity: 1; transform: scale(1' +
        ') translateY(0); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      ''
      '    @media (hover: hover) and (pointer: fine) { '
      '        .btn-back:hover, .btn-refresh:hover { color: #ffffff; } '
      '        .num-key:hover { opacity: 0.85; }'
      '        .modal-save-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    @media (max-width: 500px) {'
      '        .sudoku-header { padding: 8px 10px; }'
      '        .sudoku-header h1 { font-size: 1.25rem; }'
      '        .sudoku-timer { font-size: 1.1rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        .sudoku-action-bar { padding: 5px 10px 0 10px; }'
      '        .btn-refresh { font-size: 1.1rem; }'
      '        .sudoku-container { padding: 0 5px; } '
      '        .sudoku-grid { max-width: 360px; }'
      '        .sudoku-cell { font-size: 1.5rem; }'
      
        '        .sudoku-numpad { padding: 10px 10px 20px 10px; gap: 8px;' +
        ' }'
      
        '        .num-key { height: 62px; font-size: 1.6rem; border-radiu' +
        's: 8px; }'
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 400px; }'
      '    }'
      ''
      '    @media (max-width: 360px) {'
      '        .sudoku-grid { max-width: 300px; }'
      '        .sudoku-cell { font-size: 1.3rem; }'
      '        .sudoku-numpad { gap: 6px; padding: 10px 5px 15px 5px; }'
      '        .num-key { height: 54px; font-size: 1.4rem; }'
      '    }'
      '</style>'
      ''
      '<div class="sudoku-viewport">'
      '    <div class="sudoku-header">'
      
        '        <button class="btn-back" onclick="window.closeResultModa' +
        'l();"><i class="fa-solid fa-arrow-left"></i></button>'
      '        <h1>SUDOKU</h1>'
      '        <div id="sudokuTimer" class="sudoku-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="sudoku-action-bar">'
      
        '        <button class="btn-refresh" onclick="window.clearAllInpu' +
        'ts()"><i class="fa-solid fa-rotate-right"></i></button>'
      '    </div>'
      ''
      '    <div class="sudoku-container">'
      '        <div class="sudoku-grid" id="sudokuGrid"></div>'
      '    </div>'
      ''
      '   <div class="sudoku-numpad">'
      
        '        <div class="num-key" onclick="window.inputNumber(1)">1</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(2)">2</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(3)">3</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(4)">4</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(5)">5</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(6)">6</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(7)">7</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(8)">8</' +
        'div>'
      
        '        <div class="num-key" onclick="window.inputNumber(9)">9</' +
        'div>'
      ''
      
        '        <div class="num-key erase" style="background-color:#3a3a' +
        '3c" onclick="window.inputNumber(0)">'
      '            <i class="fa-solid fa-eraser"></i>'
      '        </div>'
      '   </div>'
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
      '                        <div class="crm-stat-lbl">HAMLE</div>'
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
      
        '                <button class="modal-save-btn" onclick="window.c' +
        'loseResultModal()">KAPAT</button>'
      '            </div>'
      '        </div>'
      '    </div>'
      '</div>')
    Align = alClient
    OnAjaxEvent = SudokuHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 50
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 512
    Top = 152
  end
end
