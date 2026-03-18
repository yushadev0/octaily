object ZIP_FORM: TZIP_FORM
  Left = 0
  Top = 0
  ClientHeight = 600
  ClientWidth = 800
  Caption = 'ZIP_FORM'
  BorderStyle = bsNone
  WindowState = wsMaximized
  OldCreateOrder = False
  MonitoredKeys.Keys = <>
  Script.Strings = (
    'window.zipGameOver = false;'
    'window.zipElapsedTime = 0;'
    'window.zipTimerInterval = null;'
    'window.finalGrade = "";'
    'window.currentPuzzleId = "";'
    'window.isZipInitialized = false;'
    'window.zipGridSize = 0;'
    'window.zipGridNumbers = [];'
    'window.zipPath = [];'
    'window.isZipDragging = false;'
    'window.zipIsError = false;'
    'window.zipStartTimeStamp = 0;'
    'window.zipHandlersDefined = false;'
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
    'window.getGradientColor = function(ratio) {'
    '    var c1 = [108, 92, 231]; '
    '    var c2 = [83, 141, 78];  '
    '    var r = Math.round(c1[0] + ratio * (c2[0] - c1[0]));'
    '    var g = Math.round(c1[1] + ratio * (c2[1] - c1[1]));'
    '    var b = Math.round(c1[2] + ratio * (c2[2] - c1[2]));'
    '    return "rgb(" + r + "," + g + "," + b + ")";'
    '};'
    ''
    'window.getTodayStr = function() {'
    '    var d = new Date();'
    '    var m = (d.getMonth() + 1).toString().padStart(2, '#39'0'#39');'
    '    var day = d.getDate().toString().padStart(2, '#39'0'#39');'
    '    return d.getFullYear() + '#39'-'#39' + m + '#39'-'#39' + day;'
    '};'
    ''
    'window.initZipWithServer = function(serverId, payloadStr) {'
    '    window.zipGameOver = false;'
    '    window.isZipDragging = false;'
    '    window.zipIsError = false;'
    ''
    
      '    if (serverId && serverId !== "") window.currentPuzzleId = se' +
      'rverId;'
    '    else window.currentPuzzleId = window.getTodayStr();'
    '    '
    '    try {'
    '        var payload = JSON.parse(payloadStr);'
    '        window.zipGridSize = payload.grid_size;'
    '        window.zipGridNumbers = payload.grid;'
    '        window.isZipInitialized = true;'
    '        window.initZipBoard();'
    
      '    } catch(e) { document.getElementById('#39'zipLoading'#39').textConte' +
      'nt = "Ba'#287'lant'#305' Hatas'#305'!"; }'
    '};'
    ''
    'window.initZipBoard = function() {'
    '    window.injectOctailyStyles();'
    '    var bgEl = document.getElementById('#39'zipGridBg'#39');'
    '    var boardEl = document.getElementById('#39'zipBoard'#39');'
    '    var wrapperEl = document.getElementById('#39'boardWrapper'#39');'
    '    var loadEl = document.getElementById('#39'zipLoading'#39');'
    '    '
    
      '    if (!boardEl || !window.isZipInitialized) { setTimeout(windo' +
      'w.initZipBoard, 100); return; }'
    '    '
    '    loadEl.style.display = '#39'none'#39';'
    '    wrapperEl.style.display = '#39'block'#39';'
    '    '
    '    bgEl.innerHTML = '#39#39';'
    '    boardEl.innerHTML = '#39#39';'
    '    '
    
      '    bgEl.style.gridTemplateColumns = '#39'repeat('#39' + window.zipGridS' +
      'ize + '#39', 1fr)'#39';'
    
      '    bgEl.style.gridTemplateRows = '#39'repeat('#39' + window.zipGridSize' +
      ' + '#39', 1fr)'#39';'
    
      '    boardEl.style.gridTemplateColumns = '#39'repeat('#39' + window.zipGr' +
      'idSize + '#39', 1fr)'#39';'
    
      '    boardEl.style.gridTemplateRows = '#39'repeat('#39' + window.zipGridS' +
      'ize + '#39', 1fr)'#39';'
    '    '
    '    for (var r = 0; r < window.zipGridSize; r++) {'
    '        for (var c = 0; c < window.zipGridSize; c++) {'
    '            var bgCell = document.createElement('#39'div'#39');'
    '            bgCell.className = '#39'zip-grid-cell'#39';'
    
      '            if (c === window.zipGridSize - 1) bgCell.classList.a' +
      'dd('#39'b-right'#39');'
    
      '            if (r === window.zipGridSize - 1) bgCell.classList.a' +
      'dd('#39'b-bottom'#39');'
    
      '            if (window.zipGridNumbers[r][c] === 1) bgCell.classL' +
      'ist.add('#39'start-cell'#39');'
    '            bgEl.appendChild(bgCell);'
    ''
    '            var cell = document.createElement('#39'div'#39');'
    '            cell.className = '#39'zip-cell'#39';'
    '            cell.setAttribute('#39'data-r'#39', r);'
    '            cell.setAttribute('#39'data-c'#39', c);'
    '            var val = window.zipGridNumbers[r][c];'
    '            if(val > 0) {'
    
      '                cell.innerHTML = '#39'<div class="waypoint-circle">'#39 +
      ' + val + '#39'</div>'#39';'
    '            }'
    '            boardEl.appendChild(cell);'
    '        }'
    '    }'
    '    '
    '    window.attachZipEvents();'
    '    window.loadZipState();'
    '};'
    ''
    'window.attachZipEvents = function() {'
    '    var wrapper = document.getElementById('#39'boardWrapper'#39');'
    '    if (!wrapper) return;'
    ''
    '    if (!window.zipHandlersDefined) {'
    '        window.handleZipStartEvent = function(e) {'
    '            if(window.zipGameOver) return;'
    
      '            var touch = (e.type === '#39'touchstart'#39') ? e.touches[0]' +
      ' : e;'
    
      '            var target = document.elementFromPoint(touch.clientX' +
      ', touch.clientY);'
    
      '            var cell = target ? target.closest('#39'.zip-cell'#39') : nu' +
      'll;'
    
      '            if(cell) window.startZipDrag(parseInt(cell.getAttrib' +
      'ute('#39'data-r'#39')), parseInt(cell.getAttribute('#39'data-c'#39')));'
    '        };'
    '        window.handleZipMoveEvent = function(e) {'
    
      '            if(!window.isZipDragging || window.zipGameOver) retu' +
      'rn;'
    '            if(e.cancelable) e.preventDefault(); '
    
      '            var touch = (e.type === '#39'touchmove'#39') ? e.touches[0] ' +
      ': e;'
    
      '            var target = document.elementFromPoint(touch.clientX' +
      ', touch.clientY);'
    
      '            var cell = target ? target.closest('#39'.zip-cell'#39') : nu' +
      'll;'
    
      '            if(cell) window.handleZipMove(parseInt(cell.getAttri' +
      'bute('#39'data-r'#39')), parseInt(cell.getAttribute('#39'data-c'#39')));'
    '        };'
    
      '        window.handleZipEndEvent = function() { window.endZipDra' +
      'g(); };'
    ''
    
      '        document.addEventListener('#39'mousemove'#39', window.handleZipM' +
      'oveEvent);'
    
      '        document.addEventListener('#39'touchmove'#39', window.handleZipM' +
      'oveEvent, {passive: false});'
    
      '        document.addEventListener('#39'mouseup'#39', window.handleZipEnd' +
      'Event);'
    
      '        document.addEventListener('#39'touchend'#39', window.handleZipEn' +
      'dEvent);'
    
      '        window.addEventListener('#39'resize'#39', function(){ if(window.' +
      'zipPath.length>0) window.updateZipUI(); });'
    '        '
    '        window.zipHandlersDefined = true;'
    '    }'
    ''
    '    if (!wrapper.hasAttribute('#39'data-events-attached'#39')) {'
    
      '        wrapper.addEventListener('#39'mousedown'#39', window.handleZipSt' +
      'artEvent);'
    
      '        wrapper.addEventListener('#39'touchstart'#39', window.handleZipS' +
      'tartEvent, {passive: false});'
    '        wrapper.setAttribute('#39'data-events-attached'#39', '#39'true'#39');'
    '    }'
    '};'
    ''
    'window.startZipDrag = function(r, c) {'
    '    if (window.zipPath.length === 0) {'
    '        if (window.zipGridNumbers[r][c] !== 1) {'
    
      '            window.showZipError("L'#252'tfen 1 numaral'#305' duraktan ba'#351'l' +
      'ay'#305'n!");'
    '            return;'
    '        }'
    '        window.zipPath.push({r: r, c: c});'
    '        window.isZipDragging = true;'
    '        window.updateZipUI();'
    '    } else {'
    '        var last = window.zipPath[window.zipPath.length - 1];'
    '        if (last.r === r && last.c === c) {'
    '            window.isZipDragging = true;'
    '        } else {'
    
      '            var idx = window.zipPath.findIndex(function(p){ retu' +
      'rn p.r === r && p.c === c; });'
    '            if (idx !== -1) {'
    
      '                window.zipPath = window.zipPath.slice(0, idx + 1' +
      ');'
    '                window.isZipDragging = true;'
    '                window.updateZipUI();'
    '            }'
    '        }'
    '    }'
    '};'
    ''
    'window.handleZipMove = function(r, c) {'
    '    var last = window.zipPath[window.zipPath.length - 1];'
    '    if (last.r === r && last.c === c) return;'
    '    if (window.zipPath.length > 1) {'
    '        var prev = window.zipPath[window.zipPath.length - 2];'
    '        if (prev.r === r && prev.c === c) {'
    '            window.zipPath.pop(); window.updateZipUI(); return;'
    '        }'
    '    }'
    
      '    if (Math.abs(last.r - r) + Math.abs(last.c - c) !== 1) retur' +
      'n;'
    
      '    var visited = window.zipPath.some(function(p){ return p.r ==' +
      '= r && p.c === c; });'
    '    if (visited) return;'
    '    var expected = 1;'
    '    for(var i=0; i<window.zipPath.length; i++) {'
    
      '        var wp = window.zipGridNumbers[window.zipPath[i].r][wind' +
      'ow.zipPath[i].c];'
    '        if(wp > 0) expected = wp + 1;'
    '    }'
    '    var cellWP = window.zipGridNumbers[r][c];'
    '    if(cellWP > 0 && cellWP !== expected) {'
    
      '        window.showZipError("S'#305'radaki durak " + expected + " olm' +
      'al'#305'!");'
    '        window.isZipDragging = false; return;'
    '    }'
    '    window.zipPath.push({r: r, c: c});'
    '    window.updateZipUI();'
    
      '    if (window.zipPath.length === window.zipGridSize * window.zi' +
      'pGridSize) {'
    '        window.isZipDragging = false; window.submitZipGuess();'
    '    }'
    '};'
    ''
    
      'window.endZipDrag = function() { window.isZipDragging = false; w' +
      'indow.saveZipState(); };'
    
      'window.clearZipPath = function() { if(window.zipGameOver) return' +
      '; window.zipPath = []; window.updateZipUI(); window.saveZipState' +
      '(); };'
    ''
    'window.updateZipUI = function() {'
    '    var wrapperEl = document.getElementById('#39'boardWrapper'#39');'
    '    if(!wrapperEl) return;'
    '    var wrapRect = wrapperEl.getBoundingClientRect();'
    
      '    var firstCell = document.querySelector('#39'.zip-cell[data-r="0"' +
      '][data-c="0"]'#39');'
    
      '    var cellWidth = firstCell ? firstCell.getBoundingClientRect(' +
      ').width : 40;'
    '    '
    '    var strokeW = cellWidth * 0.45; '
    '    var svgHtml = '#39#39';'
    '    '
    '    if (window.zipPath.length > 0) {'
    
      '        var totalCells = window.zipGridSize * window.zipGridSize' +
      ';'
    '        '
    '        if (window.zipPath.length === 1) {'
    '            var p0 = window.zipPath[0];'
    
      '            var c0 = document.querySelector('#39'.zip-cell[data-r="'#39 +
      '+p0.r+'#39'"][data-c="'#39'+p0.c+'#39'"]'#39');'
    '            if (c0) {'
    '                var rRect = c0.getBoundingClientRect();'
    
      '                var cx = rRect.left - wrapRect.left + (rRect.wid' +
      'th / 2);'
    
      '                var cy = rRect.top - wrapRect.top + (rRect.heigh' +
      't / 2);'
    
      '                var clr = window.zipIsError ? '#39'#e74c3c'#39' : window' +
      '.getGradientColor(0);'
    
      '                svgHtml += '#39'<circle cx="'#39'+cx+'#39'" cy="'#39'+cy+'#39'" r="'#39 +
      '+(strokeW/2)+'#39'" fill="'#39'+clr+'#39'" />'#39';'
    '            }'
    '        } else {'
    '            for (var i = 1; i < window.zipPath.length; i++) {'
    '                var prevP = window.zipPath[i-1];'
    '                var p = window.zipPath[i];'
    
      '                var prevEl = document.querySelector('#39'.zip-cell[d' +
      'ata-r="'#39'+prevP.r+'#39'"][data-c="'#39'+prevP.c+'#39'"]'#39');'
    
      '                var cellEl = document.querySelector('#39'.zip-cell[d' +
      'ata-r="'#39'+p.r+'#39'"][data-c="'#39'+p.c+'#39'"]'#39');'
    '                '
    '                if (prevEl && cellEl) {'
    '                    var r1 = prevEl.getBoundingClientRect();'
    '                    var r2 = cellEl.getBoundingClientRect();'
    
      '                    var x1 = r1.left - wrapRect.left + (r1.width' +
      ' / 2);'
    
      '                    var y1 = r1.top - wrapRect.top + (r1.height ' +
      '/ 2);'
    
      '                    var x2 = r2.left - wrapRect.left + (r2.width' +
      ' / 2);'
    
      '                    var y2 = r2.top - wrapRect.top + (r2.height ' +
      '/ 2);'
    '                    '
    '                    var ratio = i / (totalCells - 1);'
    
      '                    var strokeClr = window.zipIsError ? '#39'#e74c3c' +
      #39' : window.getGradientColor(ratio);'
    '                    '
    
      '                    svgHtml += '#39'<line x1="'#39'+x1+'#39'" y1="'#39'+y1+'#39'" x2' +
      '="'#39'+x2+'#39'" y2="'#39'+y2+'#39'" stroke="'#39'+strokeClr+'#39'" stroke-width="'#39'+str' +
      'okeW+'#39'" stroke-linecap="round" />'#39';'
    '                }'
    '            }'
    '        }'
    '    }'
    '    var svgLayer = document.getElementById('#39'zipSvgLayer'#39');'
    '    if(svgLayer) svgLayer.innerHTML = svgHtml;'
    '};'
    ''
    'window.submitZipGuess = function() {'
    '    var guessArr = [];'
    
      '    for(var i=0; i<window.zipPath.length; i++) guessArr.push({x:' +
      ' window.zipPath[i].r, y: window.zipPath[i].c});'
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(ZIP_FORM' +
      '.ZipHTML, '#39'SubmitGuess'#39', ['#39'guess='#39' + JSON.stringify(guessArr)]);'
    '};'
    ''
    'window.processZipResult = function(isSuccess, msg) {'
    '    if(isSuccess) window.showZipGameOver(false); '
    '    else window.showZipError(msg);'
    '};'
    ''
    'window.showZipError = function(errorMsg) {'
    '    window.zipIsError = true; '
    '    window.updateZipUI();'
    '    '
    '    var wrap = document.getElementById('#39'boardWrapper'#39');'
    '    if(wrap) { '
    '        wrap.classList.remove('#39'shake'#39'); '
    '        void wrap.offsetWidth; '
    '        wrap.classList.add('#39'shake'#39'); '
    '    }'
    ''
    '    setTimeout(function(){ '
    '        window.zipIsError = false; '
    '        window.updateZipUI(); '
    '        window.saveZipState(); '
    '    }, 800);'
    '};'
    ''
    'window.startZipTimer = function() {'
    
      '    if (window.zipTimerInterval) clearInterval(window.zipTimerIn' +
      'terval);'
    '    if (window.zipGameOver || !window.isZipInitialized) return;'
    ''
    
      '    if (!window.zipStartTimeStamp || window.zipStartTimeStamp ==' +
      '= 0) {'
    
      '        window.zipStartTimeStamp = Date.now() - (window.zipElaps' +
      'edTime * 1000);'
    '    }'
    '    '
    '    var timerEl = document.getElementById('#39'zipTimer'#39');'
    '    window.zipTimerInterval = setInterval(function() {'
    
      '        window.zipElapsedTime = Math.floor((Date.now() - window.' +
      'zipStartTimeStamp) / 1000);'
    
      '        var m = Math.floor(window.zipElapsedTime / 60).toString(' +
      ').padStart(2, '#39'0'#39');'
    
      '        var s = (window.zipElapsedTime % 60).toString().padStart' +
      '(2, '#39'0'#39');'
    '        if (timerEl) timerEl.textContent = m + '#39':'#39' + s;'
    
      '        if (window.zipElapsedTime % 5 === 0) window.saveZipState' +
      '();'
    '    }, 1000);'
    '};'
    ''
    'window.saveZipState = function() {'
    '    if (!window.isZipInitialized) return;'
    
      '    var state = { puzzleId: window.currentPuzzleId, time: window' +
      '.zipElapsedTime, completed: window.zipGameOver, grade: window.fi' +
      'nalGrade, path: window.zipPath };'
    
      '    localStorage.setItem('#39'octaily_zip_state'#39', JSON.stringify(sta' +
      'te));'
    '};'
    ''
    'window.loadZipState = function() {'
    '    if (!window.isZipInitialized) return;'
    '    var saved = localStorage.getItem('#39'octaily_zip_state'#39');'
    '    if (saved) {'
    '        try {'
    '            var state = JSON.parse(saved);'
    '            if (state.puzzleId === window.currentPuzzleId) {'
    
      '                window.zipElapsedTime = (state.time !== undefine' +
      'd) ? parseInt(state.time, 10) : 0;'
    '                window.zipGameOver = state.completed || false;'
    '                window.finalGrade = state.grade || "";'
    '                window.zipPath = state.path || [];'
    '                window.updateZipUI();'
    
      '                if (window.zipGameOver) setTimeout(function() { ' +
      'window.showZipGameOver(true); }, 300);'
    '                else window.startZipTimer();'
    
      '            } else { localStorage.removeItem('#39'octaily_zip_state'#39 +
      '); window.resetZipUI(); }'
    '        } catch (e) { window.resetZipUI(); }'
    '    } else { window.resetZipUI(); }'
    '};'
    ''
    'window.resetZipUI = function() {'
    
      '    window.zipElapsedTime = 0; window.zipGameOver = false; windo' +
      'w.finalGrade = ""; window.zipPath = []; window.updateZipUI(); wi' +
      'ndow.startZipTimer();'
    '};'
    ''
    'window.calculateGrade = function(timeInSec) {'
    
      '    if (timeInSec <= 60) return '#39'S+'#39'; if (timeInSec <= 120) retu' +
      'rn '#39'S'#39'; if (timeInSec <= 240) return '#39'A'#39'; if (timeInSec <= 480) ' +
      'return '#39'B'#39'; return '#39'C'#39';'
    '};'
    ''
    'window.showZipGameOver = function(isReplay, savedTime) {'
    
      '    if (window.zipTimerInterval) clearInterval(window.zipTimerIn' +
      'terval);'
    '    '
    
      '    var time = (isReplay && savedTime !== undefined) ? savedTime' +
      ' : window.zipElapsedTime; '
    '    var grade = window.calculateGrade(time);'
    '    '
    '    var m = Math.floor(time / 60).toString().padStart(2, '#39'0'#39'); '
    '    var s = (time % 60).toString().padStart(2, '#39'0'#39'); '
    '    var timeStr = m + '#39':'#39' + s;'
    '    '
    '    if (!isReplay) { '
    '        window.zipGameOver = true; '
    '        window.finalGrade = grade; '
    '        window.saveZipState(); '
    ''
    '        if (typeof ajaxRequest !== '#39'undefined'#39') { '
    '            ajaxRequest(ZIP_FORM.ZipHTML, '#39'GameOver'#39', ['
    '                '#39'time='#39' + time, '
    '                '#39'grade='#39' + grade,'
    '                '#39'isWin=1'#39',            '
    '                '#39'game_type=zip'#39'       '
    '            ]); '
    '        }'
    '    }'
    '    '
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
    '        subTextEl.innerHTML = '#39'Bu bulmacay'#305' '#231'oktan tamamlad'#305'n!'#39';'
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
    
      '            ajaxRequest(ZIP_FORM.ZipHTML, '#39'GetPanelStats'#39', ['#39'gam' +
      'e_type=zip'#39']);'
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
    
      '    if (typeof ajaxRequest !== '#39'undefined'#39') ajaxRequest(ZIP_FORM' +
      '.ZipHTML, '#39'closePage'#39');'
    '};')
  TextHeight = 15
  object ZipHTML: TUniHTMLFrame
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
      '    .zip-viewport {'
      '        position: fixed; top: 0; left: 0; right: 0; bottom: 0;'
      '        width: 100vw; height: 100vh; height: 100dvh;'
      
        '        background-color: #121213 !important; display: flex; fle' +
        'x-direction: column; align-items: center;'
      
        '        font-family: '#39'Segoe UI'#39', Tahoma, Geneva, Verdana, sans-s' +
        'erif; color: #ffffff; z-index: 9999; overflow: hidden;'
      
        '        padding-top: env(safe-area-inset-top); padding-bottom: e' +
        'nv(safe-area-inset-bottom); box-sizing: border-box;'
      '        overscroll-behavior: none; touch-action: none;'
      
        '        -webkit-border-radius: 0 !important; border-radius: 0 !i' +
        'mportant;'
      '        box-shadow: 0 0 0 100vmax #121213; clip-path: inset(0); '
      '    }'
      ''
      
        '    .zip-header { width: 100%; max-width: 600px; display: flex; ' +
        'justify-content: space-between; align-items: center; padding: 10' +
        'px 15px; border-bottom: 1px solid #3a3a3c; box-sizing: border-bo' +
        'x; background-color: #121213; }'
      
        '    .zip-header h1 { margin: 0; font-size: 1.5rem; letter-spacin' +
        'g: 2px; font-weight: 800; text-align: center; color: #ffffff; }'
      
        '    .zip-timer { font-family: '#39'Courier New'#39', Courier, monospace;' +
        ' color: #ffffff; font-size: 1.2rem; font-weight: bold; text-alig' +
        'n: right; width: 60px; }'
      
        '    .btn-back { background: none; border: none; color: #818384; ' +
        'font-size: 1.4rem; cursor: pointer; transition: color 0.2s; padd' +
        'ing: 5px; -webkit-tap-highlight-color: transparent; }'
      '    .btn-back:active { color: #ffffff; transform: scale(0.95); }'
      ''
      
        '    .zip-action-bar { width: 100%; max-width: 600px; display: fl' +
        'ex; justify-content: flex-end; align-items: center; padding: 8px' +
        ' 15px 0 15px; box-sizing: border-box; }'
      
        '    .btn-clear { background: none; border: none; color: #818384;' +
        ' font-size: 1.2rem; cursor: pointer; transition: color 0.2s; pad' +
        'ding: 5px; -webkit-tap-highlight-color: transparent; }'
      '    .btn-clear:active { color: #ffffff; }'
      ''
      
        '    .zip-board-container { flex-grow: 1; display: flex; flex-dir' +
        'ection: column; justify-content: center; align-items: center; wi' +
        'dth: 100%; padding: 10px; box-sizing: border-box; min-height: 0;' +
        ' position: relative; background-color: #121213; }'
      
        '    .zip-board-wrapper { position: relative; width: 100%; max-wi' +
        'dth: 480px; aspect-ratio: 1 / 1; background-color: #1a1a1b; bord' +
        'er: 1.5px solid #3a3a3c; border-radius: 12px; overflow: hidden; ' +
        'box-shadow: 0 4px 15px rgba(255, 255, 255, 0.05); }'
      ''
      
        '    .zip-grid-bg { position: absolute; top: 0; left: 0; width: 1' +
        '00%; height: 100%; display: grid; z-index: 1; pointer-events: no' +
        'ne; }'
      
        '    .zip-grid-cell { border-right: 1.5px solid #3a3a3c; border-b' +
        'ottom: 1.5px solid #3a3a3c; box-sizing: border-box; }'
      '    .zip-grid-cell.b-right { border-right: none; }'
      '    .zip-grid-cell.b-bottom { border-bottom: none; }'
      '    .zip-grid-cell.start-cell { background-color: #1d2a3a; }'
      ''
      
        '    #zipSvgLayer { position: absolute; top: 0; left: 0; width: 1' +
        '00%; height: 100%; z-index: 2; pointer-events: none; }'
      ''
      
        '    .zip-board { display: grid; position: relative; z-index: 3; ' +
        'width: 100%; height: 100%; }'
      
        '    .zip-cell { display: flex; justify-content: center; align-it' +
        'ems: center; user-select: none; cursor: pointer; box-sizing: bor' +
        'der-box; background-color: transparent; -webkit-tap-highlight-co' +
        'lor: transparent; }'
      
        '    .waypoint-circle { width: 32px; height: 32px; border-radius:' +
        ' 50%; background-color: #121213; color: #ffffff; font-size: 1.1r' +
        'em; font-weight: 900; display: flex; justify-content: center; al' +
        'ign-items: center; border: 2px solid #565758; box-shadow: 0 2px ' +
        '4px rgba(0,0,0,0.5); transition: transform 0.1s; }'
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
      '    /* Z'#304'P '#304#199#304'N 3'#39'L'#220' STATS GR'#304'D (CEVAP KUTUSU YOK) */'
      
        '    .crm-stats-grid { display: grid; grid-template-columns: 1fr ' +
        '1fr 1fr; gap: 10px; margin-bottom: 18px; width: 100%; }'
      
        '    .crm-stat-box { background: #1a1a1c; border: 1px solid #2a2a' +
        '2c; border-radius: 12px; padding: 12px 5px; display: flex; flex-' +
        'direction: column; align-items: center; justify-content: center;' +
        ' }'
      
        '    .crm-stat-val { font-size: 1.4rem; font-weight: bold; color:' +
        ' #fff; margin-bottom: 2px; font-variant-numeric: tabular-nums; l' +
        'ine-height: 1.2; }'
      
        '    .crm-stat-lbl { font-size: 0.65rem; color: #818384; font-wei' +
        'ght: bold; letter-spacing: 1px; text-transform: uppercase; }'
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
      
        '    @media (hover: hover) and (pointer: fine) { .btn-back:hover,' +
        ' .btn-clear:hover { color: #ffffff; } .modal-save-btn:hover { ba' +
        'ckground-color: #467a42; } }'
      ''
      '    @media (max-width: 500px) {'
      '        .zip-header { padding: 8px 10px; }'
      '        .zip-header h1 { font-size: 1.3rem; }'
      '        .btn-back { font-size: 1.3rem; }'
      '        .zip-timer { font-size: 1.1rem; }'
      '        .zip-action-bar { padding: 5px 10px 0 10px; }'
      '        .btn-clear { font-size: 1.1rem; }'
      '        .zip-board-container { padding: 5px; }'
      '        .zip-board-wrapper { max-width: 360px; }'
      
        '        .waypoint-circle { width: 28px; height: 28px; font-size:' +
        ' 0.95rem; border-width: 1.5px; }'
      ''
      
        '        .modal-body { justify-content: flex-start; padding-botto' +
        'm: 10px; }'
      '        .crm-stats-grid { margin-top: auto; } '
      '        .oct-modal-content { height: auto; min-height: 450px; }'
      '    }'
      ''
      '    @media (max-width: 360px) {'
      
        '        .zip-board-wrapper { max-width: 300px; border-width: 1px' +
        '; }'
      
        '        .waypoint-circle { width: 24px; height: 24px; font-size:' +
        ' 0.85rem; }'
      '    }'
      '</style>'
      ''
      '<div class="zip-viewport">'
      '    <div class="zip-header">'
      
        '        <button class="btn-back" onclick="window.closeResultModa' +
        'l()"><i class="fa-solid fa-arrow-left"></i></button>'
      '        <h1>ZIP</h1>'
      '        <div id="zipTimer" class="zip-timer">00:00</div>'
      '    </div>'
      ''
      '    <div class="zip-action-bar">'
      
        '        <button class="btn-clear" onclick="window.clearZipPath()' +
        ';" title="Temizle"><i class="fa-solid fa-rotate-right"></i></but' +
        'ton>'
      '    </div>'
      ''
      '    <div class="zip-board-container" id="mainContainer">'
      
        '        <div class="zip-board-wrapper" id="boardWrapper" style="' +
        'display:none; width: 100%;">'
      '            <div class="zip-grid-bg" id="zipGridBg"></div>'
      '            <svg id="zipSvgLayer"></svg>'
      '            <div class="zip-board" id="zipBoard"></div>'
      '        </div>'
      
        '        <div id="zipLoading" style="color:#818384; font-size:1.2' +
        'rem;">Y'#252'kleniyor...</div>'
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
    OnAjaxEvent = ZipHTMLAjaxEvent
  end
  object UniTimer1: TUniTimer
    Interval = 100
    ClientEvent.Strings = (
      'function(sender)'
      '{'
      ' '
      '}')
    OnTimer = UniTimer1Timer
    Left = 456
    Top = 80
  end
end
