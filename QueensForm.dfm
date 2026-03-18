object QUEENS_FORM: TQUEENS_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'QUEENS_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  Position = poDesigned
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.queensGrid = [];'
    'window.queensSize = 0;'
    'window.queensState = [];'
    'window.queensHistory = [];'
    'window.queensTimerInterval = null;'
    'window.queensElapsedTime = 0;'
    'window.queensMoves = 0;'
    'window.isQueensCompleted = false;'
    'window.queensGrade = "";'
    'window.queensValidationTimer = null; '
    ''
    'window.getVisibleViewport = function() {'
    '    var vps = document.querySelectorAll('#39'.queens-viewport'#39');'
    '    for (var i = vps.length - 1; i >= 0; i--) {'
    
      '        if (vps[i].clientWidth > 0 || vps[i].clientHeight > 0) r' +
      'eturn vps[i];'
    '    }'
    '    return null;'
    '};'
    
      'window.queensEl = function(selector) { var vp = window.getVisibl' +
      'eViewport(); return vp ? vp.querySelector(selector) : null; };'
    
      'window.queensEls = function(selector) { var vp = window.getVisib' +
      'leViewport(); return vp ? vp.querySelectorAll(selector) : []; };'
    ''
    'window.injectOctailyStyles = function() {}; '
    ''
    'window.saveQueensState = function() {'
    '    if (!window.getVisibleViewport()) return; '
    ''
    '    var state = {'
    '        gridStr: JSON.stringify(window.queensGrid),'
    '        state: window.queensState,'
    '        history: window.queensHistory,'
    '        time: window.queensElapsedTime,'
    '        moves: window.queensMoves,'
    '        completed: window.isQueensCompleted,'
    '        grade: window.queensGrade'
    '    };'
    
      '    localStorage.setItem('#39'octaily_queens'#39', JSON.stringify(state)' +
      ');'
    '};'
    ''
    'window.recalculateAutoCrosses = function() {'
    '    for (var r = 0; r < window.queensSize; r++) {'
    '        for (var c = 0; c < window.queensSize; c++) {'
    
      '            if (window.queensState[r][c] === 3) window.queensSta' +
      'te[r][c] = 0;'
    '        }'
    '    }'
    '    for (var r = 0; r < window.queensSize; r++) {'
    '        for (var c = 0; c < window.queensSize; c++) {'
    '            if (window.queensState[r][c] === 2) {'
    '                var regionId = window.queensGrid[r][c];'
    '                for (var i = 0; i < window.queensSize; i++) {'
    
      '                    for (var j = 0; j < window.queensSize; j++) ' +
      '{'
    '                        if (i === r && j === c) continue;'
    '                        var isInvalid = false;'
    
      '                        if (i === r || j === c || window.queensG' +
      'rid[i][j] === regionId || (Math.abs(i-r) <= 1 && Math.abs(j-c) <' +
      '= 1)) isInvalid = true;'
    
      '                        if (isInvalid && window.queensState[i][j' +
      '] === 0) window.queensState[i][j] = 3;'
    '                    }'
    '                }'
    '            }'
    '        }'
    '    }'
    '};'
    ''
    'window.loadQueensState = function() {'
    '    var saved = localStorage.getItem('#39'octaily_queens'#39');'
    '    if (saved) {'
    '        try {'
    '            var data = JSON.parse(saved);'
    
      '            if (data.gridStr === JSON.stringify(window.queensGri' +
      'd)) {'
    '                window.queensState = data.state;'
    '                window.queensHistory = data.history || [];'
    '                window.queensElapsedTime = data.time || 0;'
    '                window.queensMoves = data.moves || 0;'
    
      '                window.isQueensCompleted = data.completed || fal' +
      'se;'
    '                window.queensGrade = data.grade || "";'
    '                window.recalculateAutoCrosses();'
    '                window.updateQueensUI();'
    '                '
    '                var oldTimer = window.queensValidationTimer;'
    '                window.validateQueens(true);'
    '                clearTimeout(oldTimer); '
    '                '
    '                if (window.isQueensCompleted) {'
    
      '                    setTimeout(function() { window.showQueensGam' +
      'eOver(true); }, 300);'
    '                } else {'
    '                    window.startQueensTimer();'
    '                }'
    '                return true;'
    '            } else {'
    '                localStorage.removeItem('#39'octaily_queens'#39');'
    '            }'
    '        } catch (e) {}'
    '    }'
    '    return false;'
    '};'
    ''
    'window.startQueensTimer = function() {'
    
      '    if (window.queensTimerInterval) clearInterval(window.queensT' +
      'imerInterval);'
    '    if (window.isQueensCompleted) return;'
    
      '    var startTime = Date.now() - (window.queensElapsedTime * 100' +
      '0);'
    '    var timerEl = window.queensEl('#39'#queensTimer'#39');'
    '    window.queensTimerInterval = setInterval(function() {'
    
      '        window.queensElapsedTime = Math.floor((Date.now() - star' +
      'tTime) / 1000);'
    
      '        var m = Math.floor(window.queensElapsedTime / 60).toStri' +
      'ng().padStart(2, '#39'0'#39');'
    
      '        var s = (window.queensElapsedTime % 60).toString().padSt' +
      'art(2, '#39'0'#39');'
    '        if (timerEl) timerEl.textContent = m + '#39':'#39' + s;'
    
      '        if (window.queensElapsedTime % 5 === 0) window.saveQueen' +
      'sState();'
    '    }, 1000);'
    '};'
    ''
    'window.receiveQueensData = function(response) {'
    
      '    if (!response || !response.success || !response.regions) ret' +
      'urn;'
    '    '
    '    window.isQueensCompleted = false;'
    '    window.queensElapsedTime = 0;'
    '    window.queensMoves = 0;'
    '    window.queensGrade = "";'
    
      '    if (window.queensValidationTimer) clearTimeout(window.queens' +
      'ValidationTimer);'
    ''
    '    window.queensGrid = response.regions;'
    '    window.queensSize = response.regions.length;'
    '    window.initQueensBoard();'
    '};'
    ''
    'window.initQueensBoard = function() {'
    '    var boardEl = window.queensEl('#39'#queensBoard'#39');'
    
      '    if (!boardEl) { setTimeout(window.initQueensBoard, 100); ret' +
      'urn; }'
    '    '
    '    boardEl.innerHTML = '#39#39';'
    
      '    boardEl.style.gridTemplateColumns = '#39'repeat('#39' + window.queen' +
      'sSize + '#39', 1fr)'#39';'
    
      '    boardEl.style.gridTemplateRows = '#39'repeat('#39' + window.queensSi' +
      'ze + '#39', 1fr)'#39';'
    ''
    '    for (var r = 0; r < window.queensSize; r++) {'
    '        for (var c = 0; c < window.queensSize; c++) {'
    '            var cell = document.createElement('#39'div'#39');'
    '            var regionId = window.queensGrid[r][c];'
    '            cell.className = '#39'q-cell q-color-'#39' + (regionId % 9);'
    '            cell.setAttribute('#39'data-r'#39', r);'
    '            cell.setAttribute('#39'data-c'#39', c);'
    
      '            cell.setAttribute('#39'onclick'#39', '#39'window.handleQueenClic' +
      'k('#39' + r + '#39', '#39' + c + '#39')'#39');'
    
      '            if (r === 0 || window.queensGrid[r-1][c] !== regionI' +
      'd) cell.classList.add('#39'b-top'#39');'
    
      '            if (r === window.queensSize - 1 || window.queensGrid' +
      '[r+1][c] !== regionId) cell.classList.add('#39'b-bottom'#39');'
    
      '            if (c === 0 || window.queensGrid[r][c-1] !== regionI' +
      'd) cell.classList.add('#39'b-left'#39');'
    
      '            if (c === window.queensSize - 1 || window.queensGrid' +
      '[r][c+1] !== regionId) cell.classList.add('#39'b-right'#39');'
    '            boardEl.appendChild(cell);'
    '        }'
    '    }'
    ''
    '    if (!window.loadQueensState()) {'
    
      '        window.queensState = []; window.queensHistory = []; wind' +
      'ow.isQueensCompleted = false;'
    
      '        window.queensElapsedTime = 0; window.queensMoves = 0; wi' +
      'ndow.queensGrade = "";'
    '        for (var r2 = 0; r2 < window.queensSize; r2++) {'
    
      '            var rowState = []; for (var c2 = 0; c2 < window.quee' +
      'nsSize; c2++) rowState.push(0);'
    '            window.queensState.push(rowState);'
    '        }'
    '        window.saveQueensState();'
    '        window.startQueensTimer();'
    '    }'
    '};'
    ''
    'window.handleQueenClick = function(r, c) {'
    
      '    if (window.isQueensCompleted || !window.getVisibleViewport()' +
      ') return;'
    '    var currentState = window.queensState[r][c];'
    
      '    var newState = ((currentState === 3 ? 0 : currentState) + 1)' +
      ' % 3;'
    '    window.queensMoves++;'
    
      '    window.queensHistory.push({ r: r, c: c, oldState: currentSta' +
      'te });'
    '    window.queensState[r][c] = newState;'
    '    window.recalculateAutoCrosses();'
    '    window.updateQueensUI();'
    '    window.validateQueens(false);'
    '    window.saveQueensState();'
    '};'
    ''
    'window.undoQueenMove = function() {'
    
      '    if (window.isQueensCompleted || window.queensHistory.length ' +
      '=== 0 || !window.getVisibleViewport()) return;'
    '    var last = window.queensHistory.pop();'
    '    window.queensState[last.r][last.c] = last.oldState;'
    '    window.recalculateAutoCrosses();'
    '    window.updateQueensUI();'
    '    window.validateQueens(false);'
    '    window.saveQueensState();'
    '};'
    ''
    'window.handleEraseStart = function() {'
    
      '    if (window.isQueensCompleted || !window.getVisibleViewport()' +
      ') return;'
    
      '    var mySwal = (typeof Swal !== '#39'undefined'#39') ? Swal : (window.' +
      'parent && window.parent.Swal ? window.parent.Swal : null);'
    '    if (mySwal) {'
    '        mySwal.fire({'
    
      '            target: window.getVisibleViewport() || document.body' +
      ','
    '            title: '#39'EM'#304'N M'#304'S'#304'N?'#39','
    '            text: '#39'T'#252'm tahta temizlenecek!'#39','
    '            icon: '#39'warning'#39','
    '            showCancelButton: true,'
    '            confirmButtonText: '#39'EVET'#39','
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
    '            if (result.isConfirmed) {'
    '                for (var r = 0; r < window.queensSize; r++) {'
    
      '                    for (var c = 0; c < window.queensSize; c++) ' +
      'window.queensState[r][c] = 0;'
    '                }'
    
      '                window.queensHistory = []; window.queensMoves = ' +
      '0; window.queensElapsedTime = 0;'
    
      '                if(window.queensValidationTimer) clearTimeout(wi' +
      'ndow.queensValidationTimer);'
    
      '                window.updateQueensUI(); window.validateQueens(f' +
      'alse); window.saveQueensState();'
    '            }'
    '        });'
    '    }'
    '};'
    ''
    'window.updateQueensUI = function() {'
    '    var cells = window.queensEls('#39'.q-cell'#39');'
    '    for (var i = 0; i < cells.length; i++) {'
    
      '        var r = parseInt(cells[i].getAttribute('#39'data-r'#39')), c = p' +
      'arseInt(cells[i].getAttribute('#39'data-c'#39')), st = window.queensStat' +
      'e[r][c];'
    
      '        cells[i].classList.remove('#39'cross'#39', '#39'queen'#39', '#39'error'#39'); ce' +
      'lls[i].innerHTML = '#39#39';'
    '        if (st === 1) {'
    
      '            cells[i].classList.add('#39'cross'#39'); cells[i].innerHTML ' +
      '= '#39'<i class="fa-solid fa-xmark" style="pointer-events:none; font' +
      '-size:1.5rem; color:rgba(0,0,0,0.8);"></i>'#39';'
    '        } else if (st === 3) {'
    
      '            cells[i].classList.add('#39'cross'#39'); cells[i].innerHTML ' +
      '= '#39'<i class="fa-solid fa-xmark" style="pointer-events:none; font' +
      '-size:1.5rem; color:rgba(0,0,0,0.4);"></i>'#39';'
    '        } else if (st === 2) {'
    
      '            cells[i].classList.add('#39'queen'#39'); cells[i].innerHTML ' +
      '= '#39'<i class="fa-solid fa-crown" style="pointer-events:none; font' +
      '-size:1.8rem; color:#fff; text-shadow:0 0 10px rgba(255,255,255,' +
      '0.8);"></i>'#39';'
    '        }'
    '    }'
    '};'
    ''
    'window.validateQueens = function(isLoad) {'
    
      '    if (window.queensValidationTimer) clearTimeout(window.queens' +
      'ValidationTimer);'
    '    '
    
      '    var hasError = false, queenCount = 0, emptyCount = 0, cells ' +
      '= window.queensEls('#39'.q-cell'#39'), errorMatrix = [];'
    '    for(var i = 0; i < window.queensSize; i++) {'
    
      '        var rowErr = []; for(var j = 0; j < window.queensSize; j' +
      '++) rowErr.push(false);'
    '        errorMatrix.push(rowErr);'
    '    }'
    '    var queensList = [];'
    '    for (var r = 0; r < window.queensSize; r++) {'
    '        for (var c = 0; c < window.queensSize; c++) {'
    '            if (window.queensState[r][c] === 0) emptyCount++;'
    
      '            if (window.queensState[r][c] === 2) { queensList.pus' +
      'h({ r: r, c: c, reg: window.queensGrid[r][c] }); queenCount++; }'
    '        }'
    '    }'
    '    for (var i = 0; i < queensList.length; i++) {'
    '        for (var j = i + 1; j < queensList.length; j++) {'
    
      '            var q1 = queensList[i], q2 = queensList[j], isErr = ' +
      'false;'
    
      '            if (q1.r === q2.r || q1.c === q2.c || q1.reg === q2.' +
      'reg || (Math.abs(q1.r - q2.r) <= 1 && Math.abs(q1.c - q2.c) <= 1' +
      ')) isErr = true;'
    
      '            if (isErr) { errorMatrix[q1.r][q1.c] = true; errorMa' +
      'trix[q2.r][q2.c] = true; hasError = true; }'
    '        }'
    '    }'
    '    for (var r = 0; r < window.queensSize; r++) {'
    '        for (var c = 0; c < window.queensSize; c++) {'
    
      '            if (errorMatrix[r][c]) { var idx = (r * window.queen' +
      'sSize) + c; if (cells[idx]) cells[idx].classList.add('#39'error'#39'); }'
    '        }'
    '    }'
    '    '
    '    var isWin = (queenCount === window.queensSize && !hasError);'
    '    if (isWin && !isLoad && !window.isQueensCompleted) {'
    '        window.showQueensGameOver(false);'
    
      '    } else if (emptyCount === 0 && !isWin && !isLoad && !window.' +
      'isQueensCompleted) {'
    '        window.queensValidationTimer = setTimeout(function() {'
    '            var boardEl = window.queensEl('#39'#queensBoard'#39');'
    
      '            if (boardEl) { boardEl.classList.remove('#39'shake'#39'); vo' +
      'id boardEl.offsetWidth; boardEl.classList.add('#39'shake'#39'); }'
    '        }, 1200); '
    '    }'
    '};'
    ''
    'window.calculateQueensGrade = function(timeInSec) {'
    
      '    if (timeInSec <= 90) return '#39'S+'#39'; if (timeInSec <= 180) retu' +
      'rn '#39'S'#39'; if (timeInSec <= 300) return '#39'A'#39'; if (timeInSec <= 600) ' +
      'return '#39'B'#39'; return '#39'C'#39';'
    '};'
    ''
    
      'window.showQueensGameOver = function(isReplay, savedMoves, saved' +
      'Time) {'
    '    window.isQueensCompleted = true; '
    
      '    if (window.queensTimerInterval) clearInterval(window.queensT' +
      'imerInterval);'
    
      '    if (window.queensValidationTimer) clearTimeout(window.queens' +
      'ValidationTimer);'
    '    '
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.queensElapsedTime;'
    
      '    var moves = (isReplay && savedMoves !== undefined) ? savedMo' +
      'ves : window.queensMoves;'
    '    '
    '    var grade = window.calculateQueensGrade(time);'
    '    '
    '    if (!isReplay) { '
    '        window.queensGrade = grade; '
    '        window.saveQueensState(); '
    '        '
    '        if (typeof ajaxRequest !== '#39'undefined'#39') {'
    '            ajaxRequest(QUEENS_FORM.QueensHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'moves='#39' + moves, '
    '                '#39'grade='#39' + grade,'
    '                '#39'isWin=1'#39',             '
    '                '#39'game_type=queens'#39'    '
    '            ]);'
    '        }'
    '    }'
    '    '
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39');'
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39');'
    '    var timeStr = m + '#39':'#39' + s;'
    ''
    '    var gradeColor = "#b59f3b"; '
    
      '    if (grade === '#39'S+'#39' || grade === '#39'S'#39') gradeColor = "#ffd700";' +
      ' '
    '    if (grade === '#39'A'#39' || grade === '#39'B'#39') gradeColor = "#538d4e"; '
    '    if (grade === '#39'C'#39') gradeColor = "#e74c3c";'
    '    '
    '    var modalTitle = isReplay ? '#39'G'#220'N'#220'N '#214'ZET'#304#39' : '#39'TEBR'#304'KLER!'#39';'
    '    '
    '    document.getElementById('#39'crmTitle'#39').innerText = modalTitle;'
    '    document.getElementById('#39'crmTitle'#39').style.color = '#39'#fff'#39';'
    '    '
    '    var subTextEl = document.getElementById('#39'crmSubText'#39');'
    '    if (isReplay) {'
    '        subTextEl.innerHTML = '#39'Bu haritay'#305' '#231'oktan fethettin!'#39';'
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
    
      '            ajaxRequest(QUEENS_FORM.QueensHTML, '#39'GetPanelStats'#39',' +
      ' ['#39'game_type=queens'#39']);'
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
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(QUEENS_F' +
      'ORM.QueensHTML, '#39'closePage'#39');'
    '};')
  TextHeight = 15
  object QueensHTML: TUniHTMLFrame
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
      '    .queens-viewport {'
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
      '        box-shadow: 0 0 0 100vmax #121213; '
      '        clip-path: inset(0); '
      '    }'
      ''
      '    .queens-header {'
      '        width: 100%; max-width: 500px;'
      '        display: flex; justify-content: space-between;'
      '        align-items: center; padding: 10px 15px;'
      '        border-bottom: 1px solid #3a3a3c;'
      '        box-sizing: border-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .queens-header h1 {'
      '        margin: 0; font-size: 1.5rem;'
      '        letter-spacing: 2px; font-weight: 800;'
      '        text-align: center;'
      '    }'
      ''
      '    .queens-timer {'
      '        font-family: '#39'Courier New'#39', Courier, monospace;'
      '        color: #818384; font-size: 1.2rem;'
      '        font-weight: bold; width: 60px; text-align: right;'
      '    }'
      ''
      '    .btn-back {'
      '        background: none; border: none;'
      '        color: #818384; font-size: 1.4rem;'
      '        cursor: pointer; transition: color 0.2s; padding: 5px;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      ''
      '    .queens-board-container {'
      '        flex-grow: 1; '
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      '        width: 100%; padding: 15px; box-sizing: border-box;'
      '        min-height: 0;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .queens-board {'
      '        display: grid;'
      '        grid-template-columns: repeat(8, 1fr);'
      '        grid-template-rows: repeat(8, 1fr);'
      '        width: 100%; max-width: 380px;'
      '        aspect-ratio: 1 / 1;'
      '        background-color: #121213; '
      '        border: 3px solid #121213; '
      '        border-radius: 8px;'
      '        box-shadow: 0 10px 30px rgba(0,0,0,0.8);'
      '        overflow: hidden;'
      '        box-sizing: border-box;'
      '    }'
      ''
      '    .q-cell {'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter;'
      '        font-size: 1.8rem;'
      '        cursor: pointer;'
      '        user-select: none;'
      '        box-sizing: border-box;'
      '        border: 1px solid rgba(255, 255, 255, 0.1); '
      '        transition: transform 0.1s, background-color 0.3s;'
      '        -webkit-tap-highlight-color: transparent;'
      '    }'
      '    .q-cell:active { transform: scale(0.90); }'
      ''
      '    .q-cell.queen {'
      '        color: #f1c40f; '
      '        text-shadow: 0 0 15px rgba(241, 196, 15, 0.6);'
      
        '        animation: popIn 0.2s cubic-bezier(0.175, 0.885, 0.32, 1' +
        '.275);'
      '    }'
      '    .q-cell.cross {'
      '        color: #3a3a3c; '
      '        font-size: 1rem;'
      '    }'
      ''
      '    .q-cell.error { background-color: #c0392b !important; }'
      
        '    .q-cell.error i { color: #fff; text-shadow: none; animation:' +
        ' shake 0.3s; }'
      ''
      '    .b-top { border-top: 3px solid #121213 !important; }'
      '    .b-right { border-right: 3px solid #121213 !important; }'
      '    .b-bottom { border-bottom: 3px solid #121213 !important; }'
      '    .b-left { border-left: 3px solid #121213 !important; }'
      ''
      '    .q-color-0 { background-color: #4B6584; } '
      '    .q-color-1 { background-color: #6D214F; } '
      '    .q-color-2 { background-color: #218C74; } '
      '    .q-color-3 { background-color: #A3CB38; } '
      '    .q-color-4 { background-color: #B33939; } '
      '    .q-color-5 { background-color: #CC8E35; } '
      '    .q-color-6 { background-color: #D980FA; } '
      '    .q-color-7 { background-color: #006266; } '
      '    .q-color-8 { background-color: #596275; } '
      ''
      '    .queens-controls {'
      '        width: 100%; max-width: 400px;'
      '        display: flex; justify-content: space-between;'
      
        '        padding: 10px 15px 30px 15px; gap: 10px; box-sizing: bor' +
        'der-box;'
      '        background-color: #121213;'
      '    }'
      ''
      '    .q-btn {'
      '        flex: 1; height: 55px; border: none; border-radius: 8px;'
      '        font-size: 1.1rem; font-weight: bold; color: #fff;'
      '        background-color: #3a3a3c; cursor: pointer;'
      
        '        display: flex; justify-content: center; align-items: cen' +
        'ter; gap: 8px;'
      '        transition: background-color 0.2s, transform 0.1s;'
      '        -webkit-tap-highlight-color: transparent;'
      '        user-select: none;'
      '    }'
      '    .q-btn:active { transform: scale(0.95); }'
      '    .q-btn.danger i { color: #e74c3c; }'
      '    .q-btn.undo i { color: #3498db; }'
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
      '    /* AN'#304'MASYONLAR */'
      
        '    @keyframes popIn { 0% { transform: scale(0.5); opacity: 0; }' +
        ' 100% { transform: scale(1); opacity: 1; } }'
      
        '    @keyframes shake { 10%, 90% { transform: translate3d(-1px, 0' +
        ', 0); } 20%, 80% { transform: translate3d(2px, 0, 0); } 30%, 50%' +
        ', 70% { transform: translate3d(-4px, 0, 0); } 40%, 60% { transfo' +
        'rm: translate3d(4px, 0, 0); } }'
      
        '    @keyframes swalPopIn { 0% { opacity: 0; transform: scale(0.8' +
        '); } 80% { transform: scale(1.05); opacity: 1; } 100% { transfor' +
        'm: scale(1); opacity: 1; } }'
      
        '    @keyframes gradeSectionIn { 0% { opacity: 0; transform: scal' +
        'e(0.5) translateY(20px); } 100% { opacity: 1; transform: scale(1' +
        ') translateY(0); } }'
      
        '    @keyframes fadeIn { 0% { opacity: 0; } 100% { opacity: 1; } ' +
        '}'
      ''
      '    /* MASA'#220'ST'#220' HOVER */'
      '    @media (hover: hover) and (pointer: fine) {'
      '        .btn-back:hover { color: #ffffff; }'
      '        .q-btn:hover { background-color: #565758; }'
      '        .modal-save-btn:hover { background-color: #467a42; }'
      '    }'
      ''
      '    /* MOB'#304'L UYUMLULUK */'
      '    @media (max-width: 500px) {'
      '        .queens-header { padding: 8px 10px; }'
      '        .queens-header h1 { font-size: 1.25rem; }'
      '        .queens-timer { font-size: 1.1rem; }'
      '        .btn-back { font-size: 1.25rem; }'
      '        .queens-board-container { padding: 5px; }'
      '        .queens-board { max-width: 360px; border-width: 2px; }'
      '        .q-cell { font-size: 1.6rem; }'
      '        .q-cell.cross { font-size: 0.9rem; }'
      
        '        .queens-controls { padding: 10px 10px 20px 10px; gap: 10' +
        'px; }'
      '        .q-btn { height: 60px; font-size: 1rem; }'
      ''
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 400px; }'
      '    }'
      ''
      '    @media (max-width: 360px) {'
      '        .queens-board { max-width: 300px; }'
      '        .q-cell { font-size: 1.4rem; }'
      '        .q-cell.cross { font-size: 0.8rem; }'
      
        '        .queens-controls { padding: 5px 5px 15px 5px; gap: 8px; ' +
        '}'
      '        .q-btn { height: 50px; font-size: 0.9rem; }'
      '    }'
      '</style>'
      ''
      '<div class="queens-viewport">'
      '    <div class="queens-header">'
      
        '        <button class="btn-back" onclick="ajaxRequest(QUEENS_FOR' +
        'M.QueensHTML, '#39'closePage'#39');">'
      '            <i class="fa-solid fa-arrow-left"></i>'
      '        </button>'
      '        <h1>QUEENS</h1>'
      '        <div id="queensTimer" class="queens-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="queens-board-container">'
      '        <div class="queens-board" id="queensBoard"></div>'
      '    </div>'
      ''
      '    <div class="queens-controls">'
      
        '        <button class="q-btn undo" onclick="window.undoQueenMove' +
        '()">'
      '            <i class="fa-solid fa-rotate-left"></i> GER'#304' AL'
      '        </button>'
      
        '        <button class="q-btn danger" onclick="window.handleErase' +
        'Start()">'
      '            <i class="fa-solid fa-trash-can"></i> SIFIRLA'
      '        </button>'
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
    OnAjaxEvent = QueensHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 1
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 552
    Top = 128
  end
end
