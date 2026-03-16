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
    'window.sudokuPendingData = null;'
    'window.eraseTimer = null;'
    'window.isLongPress = false;'
    'window.sudokuElapsedTime = 0;'
    'window.sudokuMoves = 0;'
    'window.currentSudokuBoardStr = "";'
    'window.isGameCompleted = false;'
    'window.finalGrade = "";'
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
    'window.saveSudokuState = function() {'
    '    if (!window.getVisibleViewport()) return; '
    ''
    '    var state = { '
    '        board: window.currentSudokuBoardStr, '
    '        time: window.sudokuElapsedTime, '
    '        moves: window.sudokuMoves,'
    '        completed: window.isGameCompleted,'
    '        grade: window.finalGrade,'
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
    'window.validateBoard = function() {'
    '    var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '    if (cells.length !== 81) return false;'
    ''
    '    var board = [];'
    '    for (var i = 0; i < 81; i++) {'
    '        var valStr = cells[i].textContent || cells[i].innerText;'
    '        var val = parseInt(valStr, 10);'
    '        board.push(isNaN(val) ? 0 : val);'
    '        cells[i].classList.remove('#39'wrong'#39');'
    '    }'
    ''
    '    var hasError = false;'
    ''
    '    for (var i = 0; i < 81; i++) {'
    '        if (board[i] === 0) continue;'
    ''
    '        var r = Math.floor(i / 9);'
    '        var c = i % 9;'
    '        var val = board[i];'
    ''
    '        for (var c2 = 0; c2 < 9; c2++) {'
    '            var idx2 = r * 9 + c2;'
    '            if (c !== c2 && board[idx2] === val) {'
    '                cells[i].classList.add('#39'wrong'#39');'
    '                cells[idx2].classList.add('#39'wrong'#39');'
    '                hasError = true;'
    '            }'
    '        }'
    ''
    '        for (var r2 = 0; r2 < 9; r2++) {'
    '            var idx2 = r2 * 9 + c;'
    '            if (r !== r2 && board[idx2] === val) {'
    '                cells[i].classList.add('#39'wrong'#39');'
    '                cells[idx2].classList.add('#39'wrong'#39');'
    '                hasError = true;'
    '            }'
    '        }'
    ''
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
    'window.loadSudokuState = function(currentBoardStr) {'
    '    var saved = localStorage.getItem('#39'octaily_sudoku_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.board === currentBoardStr) {'
    '                window.sudokuElapsedTime = state.time || 0;'
    '                window.sudokuMoves = state.moves || 0;'
    
      '                window.isGameCompleted = state.completed || fals' +
      'e;'
    '                window.finalGrade = state.grade || "";'
    '                '
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
    ''
    '                if (window.isGameCompleted) {'
    
      '                    setTimeout(function() { window.showGameOver(' +
      'true); }, 300);'
    '                } else {'
    '                    window.startSudokuTimer();'
    '                }'
    '            } else {'
    '                window.sudokuElapsedTime = 0;'
    '                window.sudokuMoves = 0;'
    '                window.isGameCompleted = false;'
    '                window.finalGrade = "";'
    '                localStorage.removeItem('#39'octaily_sudoku_state'#39');'
    '                window.startSudokuTimer();'
    '            }'
    '        } catch (e) { window.startSudokuTimer(); }'
    '    } else {'
    '        window.sudokuElapsedTime = 0;'
    '        window.sudokuMoves = 0;'
    '        window.isGameCompleted = false;'
    '        window.finalGrade = "";'
    '        window.startSudokuTimer();'
    '    }'
    '    window.validateBoard();'
    '};'
    ''
    'window.initSudoku = function() {'
    '    window.injectOctailyStyles();'
    '    '
    '    window.sudokuElapsedTime = 0;'
    '    window.sudokuMoves = 0;'
    '    window.isGameCompleted = false;'
    '    window.finalGrade = "";'
    '    window.selectedCell = null;'
    ''
    '    try {'
    '        var gridEl = window.sudokuEl('#39'#sudokuGrid'#39');'
    
      '        if (!gridEl) { setTimeout(window.initSudoku, 100); retur' +
      'n; }'
    '        '
    '        gridEl.innerHTML = '#39#39';'
    '        '
    '        for (var i = 0; i < 81; i++) {'
    '            var cell = document.createElement('#39'div'#39');'
    '            cell.className = '#39'sudoku-cell'#39';'
    '            cell.setAttribute('#39'data-index'#39', i);'
    '            cell.onclick = (function(idx) {'
    '                return function() { '
    
      '                    var target = window.sudokuEl('#39'.sudoku-cell[d' +
      'ata-index="'#39' + idx + '#39'"]'#39');'
    '                    window.selectCell(target); '
    '                };'
    '            })(i);'
    '            gridEl.appendChild(cell);'
    '        }'
    '        if (window.sudokuPendingData) { '
    '            window.loadSudokuBoard(window.sudokuPendingData); '
    '            window.sudokuPendingData = null; '
    '        }'
    '    } catch (err) {}'
    '};'
    ''
    'window.startSudokuTimer = function() {'
    
      '    if (window.sudokuTimerInterval) clearInterval(window.sudokuT' +
      'imerInterval);'
    '    if (window.isGameCompleted) return; '
    '    '
    
      '    var startTime = Date.now() - (window.sudokuElapsedTime * 100' +
      '0);'
    '    var timerEl = window.sudokuEl('#39'#sudokuTimer'#39');'
    '    '
    '    window.sudokuTimerInterval = setInterval(function() {'
    '        var now = Date.now();'
    
      '        window.sudokuElapsedTime = Math.floor((now - startTime) ' +
      '/ 1000);'
    '        '
    
      '        var m = Math.floor(window.sudokuElapsedTime / 60).toStri' +
      'ng();'
    '        var s = (window.sudokuElapsedTime % 60).toString();'
    '        if (m.length < 2) m = '#39'0'#39' + m;'
    '        if (s.length < 2) s = '#39'0'#39' + s;'
    '        '
    '        if (timerEl) timerEl.textContent = m + '#39':'#39' + s;'
    
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
    'window.calculateGrade = function(timeInSeconds, moves) {'
    '    if (timeInSeconds <= 300) return '#39'S'#39';      '
    '    else if (timeInSeconds <= 600) return '#39'A'#39'; '
    '    else if (timeInSeconds <= 1200) return '#39'B'#39'; '
    '    else return '#39'C'#39';                                   '
    '};'
    ''
    'window.showGameOver = function(isReplay) {'
    '    clearInterval(window.sudokuTimerInterval); '
    '    '
    '    var time = window.sudokuElapsedTime;'
    '    var moves = window.sudokuMoves;'
    
      '    var grade = isReplay ? window.finalGrade : window.calculateG' +
      'rade(time, moves);'
    '    '
    '    var m = Math.floor(time / 60).toString();'
    '    var s = (time % 60).toString();'
    '    if (m.length < 2) m = '#39'0'#39' + m;'
    '    if (s.length < 2) s = '#39'0'#39' + s;'
    '    var timeStr = m + '#39':'#39' + s;'
    '    '
    '    if (!isReplay) {'
    '        window.isGameCompleted = true;'
    '        window.finalGrade = grade;'
    '        window.saveSudokuState();'
    ''
    
      '        // K'#304'L'#304'T DE'#286#304#350#304'KL'#304'K: Kullan'#305'c'#305' modaldan '#231#305'kmadan '#246'nce sk' +
      'oru hemen g'#246'nderiyoruz!'
    
      '        if (typeof ajaxRequest !== '#39'undefined'#39' && typeof SUDOKU_' +
      'FORM !== '#39'undefined'#39') {'
    '            ajaxRequest(SUDOKU_FORM.SudokuHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time,'
    '                '#39'moves='#39' + moves,'
    '                '#39'grade='#39' + grade,'
    '                '#39'isWin=1'#39', // Sudoku tamamsa hep kazan'#305'lm'#305#351't'#305'r'
    '                '#39'game_type=sudoku'#39
    '            ]);'
    '        }'
    '    }'
    ''
    '    var gradeColor = "#b59f3b"; '
    '    if (grade === '#39'B'#39') gradeColor = "#538d4e"; '
    '    if (grade === '#39'C'#39') gradeColor = "#e74c3c"; '
    ''
    '    var modalTitle = isReplay ? '#39'G'#220'N'#220'N '#214'ZET'#304#39' : '#39'TEBR'#304'KLER!'#39';'
    
      '    var subText = isReplay ? '#39'<div style="color:#818384; font-si' +
      'ze:0.95rem; margin-bottom:20px;">Bu bulmacay'#305' zaten '#231#246'zm'#252#351't'#252'n. '#304 +
      #351'te skorun:</div>'#39' : '#39#39';'
    '    var modalIcon = isReplay ? '#39'info'#39' : '#39'success'#39';'
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
      'olor:#fff; line-height:3rem;">'#39' + moves + '#39'</div>'#39' +'
    
      '                '#39'<div style="font-size:0.9rem; color:#818384; le' +
      'tter-spacing:1px;">HAMLE</div>'#39' +'
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
    '            customClass: {'
    '                popup: '#39'oct-popup'#39','
    '                title: '#39'oct-title'#39','
    '                confirmButton: '#39'oct-confirm'#39','
    '                icon: '#39'oct-icon'#39
    '            },'
    '            didOpen: function() {'
    
      '                var container = document.querySelector('#39'.swal2-c' +
      'ontainer'#39');'
    
      '                if (container) container.style.zIndex = "2147483' +
      '647";'
    '            }'
    '        }); // .then k'#305'sm'#305' silindi, Ajax zaten g'#246'nderildi!'
    '    } else {'
    
      '        alert(modalTitle + "\nDerece: " + grade + "\nS'#252're: " + t' +
      'imeStr + "\nHamle: " + moves);'
    '    }'
    '};'
    ''
    'window.inputNumber = function(num) {'
    '    if (window.isGameCompleted) return; '
    
      '    if (!window.selectedCell || window.selectedCell.classList.co' +
      'ntains('#39'fixed'#39')) return;'
    '    '
    '    var valStr = (num === 0) ? '#39#39' : num.toString();'
    
      '    var currentVal = window.selectedCell.textContent || window.s' +
      'electedCell.innerText;'
    '    '
    '    if (valStr !== currentVal) {'
    '        window.sudokuMoves++;'
    '        window.selectedCell.textContent = valStr;'
    '        '
    '        window.validateBoard();'
    '        window.saveSudokuState();'
    '        '
    
      '        if (typeof ajaxRequest !== '#39'undefined'#39' && typeof SUDOKU_' +
      'FORM !== '#39'undefined'#39') {'
    
      '            ajaxRequest(SUDOKU_FORM.SudokuHTML, '#39'CellValueChange' +
      #39', ['
    
      '                '#39'index='#39' + window.selectedCell.getAttribute('#39'dat' +
      'a-index'#39'),'
    '                '#39'value='#39' + num'
    '            ]);'
    '        }'
    '        '
    '        if (window.checkSudokuWin()) {'
    '            window.showGameOver(false);'
    '        }'
    '    }'
    '};'
    ''
    'window.handleEraseStart = function() {'
    '    if (window.isGameCompleted) return;'
    '    window.isLongPress = false;'
    '    window.eraseTimer = setTimeout(function() {'
    '        window.isLongPress = true;'
    '        window.clearAllInputs();'
    '    }, 800);'
    '};'
    ''
    'window.handleEraseEnd = function() {'
    '    clearTimeout(window.eraseTimer);'
    '    if (!window.isLongPress) { window.inputNumber(0); }'
    '};'
    ''
    'window.clearAllInputs = function() {'
    '    if (window.isGameCompleted) return; '
    ''
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
    '        window.startSudokuTimer(); '
    
      '        if (typeof ajaxRequest !== '#39'undefined'#39' && typeof SUDOKU_' +
      'FORM !== '#39'undefined'#39') {'
    
      '            ajaxRequest(SUDOKU_FORM.SudokuHTML, '#39'ClearBoard'#39', []' +
      ');'
    '        }'
    '    };'
    ''
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ','
    '            title: '#39'EM'#304'N M'#304'S'#304'N?'#39','
    '            text: '#39'T'#252'm ilerlemen s'#305'f'#305'rlanacak!'#39','
    '            icon: '#39'warning'#39','
    '            showCancelButton: true,'
    '            confirmButtonText: '#39'EVET, TEM'#304'ZLE'#39','
    '            cancelButtonText: '#39#304'PTAL'#39','
    '            background: '#39'#121213'#39','
    '            color: '#39'#fff'#39','
    
      '            customClass: { popup: '#39'oct-popup'#39', title: '#39'oct-title' +
      #39', confirmButton: '#39'oct-confirm'#39', cancelButton: '#39'oct-cancel'#39' },'
    '            didOpen: function() {'
    
      '                var container = document.querySelector('#39'.swal2-c' +
      'ontainer'#39');'
    
      '                if (container) container.style.zIndex = "2147483' +
      '647";'
    '            }'
    '        }).then(function(result) {'
    '            if (result.isConfirmed) coreClear();'
    '        });'
    '    } else {'
    
      '        if (confirm('#39'T'#252'm ilerlemeniz temizlenecek. Emin misiniz?' +
      #39')) coreClear();'
    '    }'
    '};'
    ''
    'window.receiveSudokuData = function(response) {'
    '    try {'
    
      '        if (!response || !response.success || !response.grid) re' +
      'turn;'
    '        var flatPuzzle = [];'
    '        for (var r = 0; r < response.grid.length; r++) {'
    '            for (var c = 0; c < response.grid[r].length; c++) {'
    '                flatPuzzle.push(response.grid[r][c]);'
    '            }'
    '        }'
    '        var gridEl = window.sudokuEl('#39'#sudokuGrid'#39');'
    '        if (!gridEl || gridEl.children.length === 0) {'
    '            window.sudokuPendingData = flatPuzzle;'
    '            window.initSudoku();'
    '        } else {'
    '            window.loadSudokuBoard(flatPuzzle);'
    '        }'
    '    } catch (err) {}'
    '};'
    ''
    'window.loadSudokuBoard = function(boardData) {'
    '    var cells = window.sudokuEls('#39'.sudoku-cell'#39');'
    '    if (cells.length !== 81) return;'
    '    '
    '    window.currentSudokuBoardStr = boardData.join('#39','#39');'
    ''
    '    for (var i = 0; i < boardData.length; i++) {'
    '        var val = boardData[i];'
    '        var cell = cells[i];'
    '        cell.classList.remove('#39'fixed'#39', '#39'wrong'#39', '#39'selected'#39');'
    '        if (val !== 0 && val !== null) {'
    '            cell.textContent = val;'
    '            cell.classList.add('#39'fixed'#39');'
    '        } else {'
    '            cell.textContent = '#39#39';'
    '        }'
    '    }'
    '    '
    '    window.loadSudokuState(window.currentSudokuBoardStr);'
    '};'
    ''
    
      'if (window.sudokuKeyHandler) document.removeEventListener('#39'keydo' +
      'wn'#39', window.sudokuKeyHandler);'
    ''
    'window.sudokuKeyHandler = function(e) {'
    
      '    if (!window.getVisibleViewport() || window.isGameCompleted) ' +
      'return; '
    ''
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
    '    '
    
      '    if (e.key >= '#39'1'#39' && e.key <= '#39'9'#39') { window.inputNumber(parse' +
      'Int(e.key)); }'
    
      '    else if (e.key === '#39'Backspace'#39' || e.key === '#39'Delete'#39' || e.ke' +
      'y === '#39'0'#39') { window.inputNumber(0); }'
    '};'
    ''
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
      '    .sudoku-viewport {'
      '        position: fixed;'
      '        top: 0; left: 0; right: 0; bottom: 0;'
      '        width: 100vw; height: 100vh; height: 100dvh;'
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
      '    .sudoku-header {'
      '        width: 100%; '
      '        max-width: 500px;'
      '        display: flex; justify-content: space-between;'
      '        align-items: center; padding: 10px 15px;'
      '        border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .sudoku-header h1 {'
      '        margin: 0; font-size: 1.4rem; '
      '        letter-spacing: 2px; font-weight: 800;'
      '        text-align: center;'
      '    }'
      ''
      '    .btn-back {'
      '        background: none; border: none; '
      '        color: #818384; font-size: 1.5rem; '
      '        cursor: pointer; transition: color 0.2s;'
      '        padding: 5px;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .sudoku-timer {'
      '        font-family: '#39'Courier New'#39', Courier, monospace;'
      '        color: #818384; font-size: 1.2rem;'
      '        font-weight: bold; width: 60px; text-align: right;'
      '    }'
      ''
      '    /* ========================================='
      '       YEN'#304' EKLENEN ARA'#199' '#199'UBU'#286'U (Refresh vb.)'
      '       ========================================= */'
      '    .sudoku-action-bar {'
      '        width: 100%; '
      '        max-width: 500px;'
      '        display: flex; '
      '        justify-content: flex-end; '
      '        align-items: center;'
      '        padding: 8px 15px 0 15px;'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .btn-refresh {'
      '        background: none; border: none;'
      '        color: #818384; font-size: 1.2rem;'
      '        cursor: pointer; transition: color 0.2s;'
      '        padding: 5px;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .btn-refresh:active {'
      '        color: #ffffff;'
      '    }'
      ''
      '    /* ========================================='
      '       SUDOKU OYUN ALANI'
      '       ========================================= */'
      '    .sudoku-container {'
      '        flex-grow: 1;'
      '        display: flex; justify-content: center;'
      '        align-items: center; padding: 10px;'
      '        width: 100%;'
      '        min-height: 0; '
      '        background-color: #121213;'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .sudoku-grid {'
      '        display: grid;'
      '        grid-template-columns: repeat(9, 1fr);'
      '        width: 100%;'
      '        max-width: 400px; '
      '        aspect-ratio: 1 / 1;'
      '        background-color: #ffffff; '
      '        border: 3px solid #ffffff; '
      '        box-shadow: 0 0 30px rgba(0,0,0,0.6);'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .sudoku-cell {'
      '        background-color: #121213;'
      '        display: flex;'
      '        justify-content: center;'
      '        align-items: center;'
      '        font-size: 1.8rem;'
      '        font-weight: bold;'
      '        cursor: pointer;'
      '        user-select: none;'
      '        border: 0.5px solid #3a3a3c; '
      '        box-sizing: border-box;'
      '        aspect-ratio: 1 / 1; '
      '        line-height: 1; '
      '        padding: 0;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      
        '    .sudoku-cell:nth-child(3n) { border-right: 3px solid #ffffff' +
        '; }'
      '    .sudoku-cell:nth-child(9n) { border-right: none; }'
      '    '
      '    .sudoku-cell:nth-child(n+19):nth-child(-n+27),'
      
        '    .sudoku-cell:nth-child(n+46):nth-child(-n+54) { border-botto' +
        'm: 3px solid #ffffff; }'
      ''
      
        '    .sudoku-cell.fixed { color: #818384; background-color: #1a1a' +
        '1b; cursor: default; }'
      
        '    .sudoku-cell.selected { background-color: #313a46; box-shado' +
        'w: inset 0 0 0 3px #538d4e; }'
      '    .sudoku-cell.wrong { color: #e74c3c; }'
      ''
      '    /* ========================================='
      '       SUDOKU NUMPAD'
      '       ========================================= */'
      '    .sudoku-numpad {'
      '        width: 100%; max-width: 500px;'
      '        display: grid;'
      '        grid-template-columns: repeat(5, 1fr);'
      '        gap: 8px; padding: 15px 15px 25px 15px;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .num-key {'
      '        background-color: #818384;'
      '        height: 55px;'
      '        border-radius: 6px;'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      '        font-size: 1.3rem; font-weight: bold;'
      '        cursor: pointer; '
      '        transition: transform 0.1s, background-color 0.1s;'
      '        -webkit-tap-highlight-color: transparent;'
      '        user-select: none;'
      '    }'
      '    '
      
        '    .num-key:active { transform: scale(0.92); background-color: ' +
        '#538d4e; }'
      
        '    .num-key.erase:active { background-color: #565758 !important' +
        '; }'
      ''
      '    .swal2-container {'
      '        z-index: 10000 !important;'
      '    }'
      ''
      '    /* ========================================='
      '       MASA'#220'ST'#220' HOVER '
      '       ========================================= */'
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover, .btn-refresh:hover { color: #ffffff; }'
      '        .num-key:hover { opacity: 0.85; }'
      '    }'
      ''
      '    /* ========================================='
      '       MOB'#304'L UYUMLULUK KATI KURALLARI'
      '       ========================================= */'
      '    @media (max-width: 500px) {'
      '        .sudoku-header { padding: 8px 10px; }'
      '        .sudoku-header h1 { font-size: 1.25rem; }'
      '        .sudoku-timer { font-size: 1.1rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      ''
      '        .sudoku-action-bar { padding: 5px 10px 0 10px; }'
      '        .btn-refresh { font-size: 1.1rem; }'
      ''
      '        .sudoku-container { padding: 0 5px; } '
      '        '
      '        .sudoku-grid { max-width: 360px; }'
      '        .sudoku-cell { font-size: 1.5rem; }'
      ''
      '        .sudoku-numpad {'
      '            padding: 10px 10px 20px 10px;'
      '            gap: 8px; '
      '        }'
      ''
      '        .num-key {'
      '            height: 62px; '
      '            font-size: 1.6rem; '
      '            border-radius: 8px; '
      '        }'
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
      
        '        <button class="btn-back" onclick="ajaxRequest(SUDOKU_FOR' +
        'M.SudokuHTML, '#39'closePage'#39');"><i class="fa-solid fa-arrow-left"><' +
        '/i></button>'
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
      '        <div class="num-key erase" '
      '             style="background-color:#3a3a3c" '
      '             onclick="window.inputNumber(0)">'
      '            <i class="fa-solid fa-eraser"></i>'
      '        </div>'
      '   </div>'
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
