#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Program Files (x86)\AutoIt3\Aut2Exe\Icons\AutoIt_Main_v11_256x256_RGB-A.ico
#AutoIt3Wrapper_Outfile=\\ASUTP-FOK-NAS1\distribs\MP_AutoBackup_x86.exe
#AutoIt3Wrapper_Outfile_x64=\\ASUTP-FOK-NAS1\distribs\MP_AutoBackup_x64.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Description=Автоматическое создание резервной копии мультипроектов
#AutoIt3Wrapper_Res_Fileversion=0.9.2.5
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_ProductName=Multiproject auto-backup
#AutoIt3Wrapper_Res_ProductVersion=1.0
#AutoIt3Wrapper_Res_CompanyName=Стойленский ГОК
#AutoIt3Wrapper_Res_LegalCopyright=© RoVRy
#AutoIt3Wrapper_Res_LegalTradeMarks=АСУТП ФОК, ЦАМ
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_AU3Check_Parameters=-d -q
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****

#include <Constants.au3>
#include <MsgBoxConstants.au3>
#include <EventLog.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <Timers.au3>

; Номера событий:
; 10-19 - проблемы с доступом к системным компонентам Windows
; 20-29 - вмешательство пользователя
; 30-39 - сообщения от AutoIt
; 40-49 - сообщение на этапе работы с Simatic Manager и его компонентами
; 50-59 - сообщение на этапе работы с WinCC и его компонентами

Local $hEventLog, $aData[4] = [0, 0, 0, 0]
Local $ArcPath = "\\asutp-fok-nas1\Projects\"                                                                           ; Место куда будет делаться бэкап
Local $Producer = ""
$hEventLog = _EventLog__Open("", "AutoIt backup")                                                                       ; Открываем журнал событий Windows с источником "AutoIt backup"
If Not $hEventLog Then                                                                                                  ; Если по каким-то непонятным причинам доступ к журналу событий Windows не получен
    MsgBox(BitOR($MB_OK, $MB_ICONERROR, $MB_TOPMOST, $MB_SYSTEMMODAL), "Ошибка", _
    "Невозможно получить доступ к журналу событий Windows", 10)                                                         ; Сообщаем об этом пользователю
    Exit(10)                                                                                                            ; Завершаем выполнение скрипта, возвращаем код ошибки
EndIf

Switch @ComputerName
    Case "ES541", "ES542"
        $Producer = "Primetals"
    Case "ES041"
        $Producer = "Outotec"
	Case Else
		$aData[0] = 1
		$aData[1] = @ComputerName
        _EventLog__Report($hEventLog, 1, 0, 32, "", "Данный ПК не является инженерной станцией", $aData)                ; Сообщение-ошибка, №32
        _EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
        Exit(32)                                                                                                        ; Завершаем выполнение скрипта, возвращаем код ошибки
EndSwitch

Local $hWndInfo, $WndExist, $result
Local $sDrive = "", $sDir = "", $sFileName = "", $sExtension = ""

Local $SMexeWP = RegRead("HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Siemens\AUTSW\STEP7", "MainFile")                     ; Пытаемся прочесть из реестра, куда у нас установлен STEP-7 и какое у него имя файла
_PathSplit($SMexeWP, $sDrive, $sDir, $sFileName, $sExtension)															; Делим путь до Simatic Manager на части
Local $SMexe = $sFileName & $sExtension																					; Собираем только имя файла с расширением
Local $SMWD = $sDrive & $sDir																							; Собираем рабочий каталог Simatic Manager

If @error = 1 Or @error = -1 Then                                                                                       ; Если вдруг нет такого ключа или ветки реестра
    $aData[0] = 1
	$aData[1] = @error
	_EventLog__Report($hEventLog, 1, 0, 11, "", _
        "В реестре отсутствует информация об установленном SIMATIC Manager", $aData)                                    ; Сообщение-ошибка, №11, в данных указываем, что именно не понравилось RegRead
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
    Exit(11)                                                                                                            ; Завершаем выполнение скрипта, возвращаем код ошибки
EndIf

; Проверяем, был ли пользователь активен последние полчаса (30м * 60с * 1000мс)
Local $iIdleTime = _Timer_GetIdleTime()
If $iIdleTime < 1800000 Then
    ; Т.к. пользователь был активен недавно - спрашиваем разрешение начать автобэкап. У пользователя есть 10 секунд, чтобы отказаться, если он работает с проектом.
    Local $iAnswer = MsgBox(BitOR($MB_YESNO, $MB_SYSTEMMODAL, $MB_DEFBUTTON1, $MB_ICONQUESTION, $MB_TOPMOST), _
        "Создание резервной копии", "Запустить создание резервной копии мультипроекта?", 10)
    If $iAnswer = $IDNO Then                                                                                            ; Если пользователь занят и ему не до создания бэкапа, то молча выходим.
        _EventLog__Report($hEventLog, 4, 0, 20, "", "Пользователь отменил создание архива", $aData)                     ; Сообщение-информация, №20
        _EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
        Exit(20)                                                                                                        ; Завершаем выполнение скрипта, без ошибки, потому что отменено пользователем
    EndIf
EndIf

_EventLog__Report($hEventLog, 4, 0, 30, "", "Начата процедура создания архива мультипроекта", $aData)                   ; Сообщение-информация, №30

Opt("PixelCoordMode", 0)                                                                                                ; Координаты будем считать относительно активного окна, а не экрана

If WinExists("Graphics Designer") Then                                                                                  ; Сначала проверяем, запущен ли Graphics Designer
	WinActivate("Graphics Designer")
	Send("!{F4}")				                                                                                        ; Посылаем Alt+F4 для закрытия
    Sleep(1000)                                                                                                         ; Даём время на отработку команды
    Do                                                                                                                  ; Начинаем цикл отлова окон о сохранении PDL
        $WndExist = 0
        $hWndInfo = WinWait("[CLASS:#32770]", "Save changes to", 5)                                                     ; Ожидаем 5 сек информационное окно с предложением сохранить экран
        If $hWndInfo <> 0 Then                                                                                          ; Если появилось:
            ControlClick("[CLASS:#32770]", "Save changes to", "[CLASS:Button; INSTANCE:1]")                             ; - кликаем по кнопке Save;
            $WndExist = 1                                                                                               ; - устанавливаем признак, что окно было.
        EndIf
    Until $WndExist = 1                                                                                                 ; Если было - ждём следующее, иначе продолжаем
    Sleep(5000)                                                                                                         ; Даём 5 сек на завершение процесса
    If WinExists("Graphics Designer") Then                                                                              ; Если Graphics Designer всё ещё присутствует, то что-то выше пошло не так
		$aData[0] = 0
		_EventLog__Report($hEventLog, 1, 0, 51, "", "Не удалось закрыть Graphics Designer", $aData)                     ; Сообщение-ошибка, №51
        _EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
        Exit(51)                                                                                                        ; Завершаем выполнение скрипта, возвращаем код ошибки
    EndIf
EndIf

If WinExists("WinCC Explorer") Then                                                                                     ; Если вдруг запущен WinCC Explorer - надо закрыть
    WinActivate("WinCC Explorer")
	Send("!{F4}")				                                                                                        ; Посылаем Alt+F4 для закрытия
    Sleep(1000)                                                                                                         ; Даём время на отработку команды
	$hWndInfo = WinWait("Exit WinCC Explorer", "", 10)                                                                  ; Ожидаем появления окошка подтверждения закрытия WinCC
    If $hWndInfo <> 0 Then
        ControlCommand($hWndInfo, "", "Button3", "Check", "")                                                           ; Принудительно посылаем команду Check в флажок "Close project when exiting"
        ControlClick("Exit WinCC Explorer", "", "[CLASS:Button; INSTANCE:1]")                                           ; Кликаем по кнопке Exit
    EndIf
    $result = ProcessWaitClose("WinCCExplorer.exe", 300)                                                                ; Ждём закрытия процесса WinCC, даём 5 минут
EndIf
If $result <> 1 Then                                                                                                    ; Если по истечении 5 минут процесс остался висеть в памяти, значит есть проблема
	$aData[0] = 3
	$aData[1] = $result
	$aData[2] = @error
	$aData[3] = @extended
    _EventLog__Report($hEventLog, 1, 0, 50, "", "Не удалось закрыть WinCC Explorer в течение 5 минут", $aData)          ; Сообщение-ошибка, №50
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
    Exit(50)                                                                                                            ; Завершаем выполнение скрипта, возвращаем код ошибки
EndIf

; Проверяем, открыт ли редактор CFC
If ProcessExists("s7jcfcax.exe") Then                                                                                   ; Если CFC-редактор открыт -
	WinActivate("CFC")																									; Активируем окно CFC-редактора
	Send("!{F4}")																										; Посылаем Alt+F4 для закрытия
	$result = WinWaitClose("CFC", 30)
	If ProcessExists("s7jcfcax.exe") Then                                                                         		; Если по истечении 30 сек процесс остался висеть в памяти -
		$aData[0] = 3
		$aData[1] = $result
		$aData[2] = @error
		$aData[3] = @extended
		_EventLog__Report($hEventLog, 1, 0, 40, "", "Не удалось закрыть редактор CFC в течение 30 секунд", $aData)		; Сообщение-ошибка, №40
		_EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
		Exit(40)                                                                                                        ; завершаем скрипт, возвращаем код ошибки
	EndIf
EndIf

If @ComputerName = "ES541" Or @ComputerName = "ES041" Then                                                              ; На основных ES делаем бэкап проекта
    ; Если Simatic Manager не запущен, то запускаем
    If Not WinExists("SIMATIC Manager") Then
        Run($SMexeWP, $SMWD, @SW_MAXIMIZE)																				; Запускаем Simatic Manager развёрнутым на весь экран
        If @error Then                                                                                                  ; Если вдруг запуск неудался, то
			$aData[0] = 3
			$aData[1] = @error
			$aData[2] = @extended
			$aData[3] = $SMexe
			_EventLog__Report($hEventLog, 1, 0, 41, "", "Не удалось запустить SIMATIC Manager", $aData)                 ; Сообщение-ошибка, №41, в данные записываем код ошибки от Run
            _EventLog__Close($hEventLog)                                                                                ; Закрываем журнал событий
            Exit(41)                                                                                                    ; Завершаем выполнение скрипта, возвращаем код ошибки
        EndIf
        Sleep(30000)                                                                                                    ; Ждём 30 сек, пока Simatic Manager загрузится
        Do                                                                                                              ; Начинаем цикл отлова информационных окон
            $WndExist = 0
            $hWndInfo = WinWait("[CLASS:#32770]", "", 15)                                                               ; Ожидаем 15 сек какое-нибудь информационное окно
            If $hWndInfo <> 0 Then                                                                                      ; Если появилось:
                ControlClick("[CLASS:#32770]", "", "[CLASS:Button; INSTANCE:1]")                                        ; Кликаем по кнопке №1 (обычно ОК)
                $WndExist = 1                                                                                           ; Устанавливаем признак, что окно было
            EndIf
        Until $WndExist = 0                                                                                             ; Если было - ждём следующее, иначе продолжаем
        Sleep(5000)                                                                                                     ; Дадим Simatic Manager закончить инициализацию
    EndIf
EndIf

If @ComputerName = "ES542" Then                                                                                         ; На дополнительной ES всё надо закрыть, чтобы не мешало
    ; Проверяем, открыт ли Simatic Manager
    If WinExists("SIMATIC Manager") Then                                                                                ; Если Simatic Manager открыт -
		WinActivate("SIMATIC Manager")
		Send("!{F4}")																									; Посылаем Alt+F4 для закрытия
		$result = ProcessWaitClose($SMexe, 30) 						                                                    ; Ждём закрытия процесса Simatic Manager
		If $result <> 1 Then		                		                                                            ; Если по истечении 30 сек процесс остался висеть в памяти -
			$aData[0] = 5
			$aData[1] = $result
			$aData[2] = @error
			$aData[3] = @extended
			$aData[4] = @ComputerName
			$aData[5] = $SMexe
			_EventLog__Report($hEventLog, 1, 0, 46, "",_
				"Не удалось закрыть Simatic Manager в течение 30 секунд", $aData)  										; Сообщение-ошибка, №46, в данные добавим полный путь к exe-файлу Simatic Manager
			_EventLog__Close($hEventLog)                                                                                ; Закрываем журнал событий
			Exit(46)                                                                                                    ; завершаем скрипт
		EndIf
		_EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
		Exit(0)                                                                                                         ; Завершаем скрипт, больше на ES542 делать нечего
	EndIf
EndIf

; Раз мы здесь - мы на ES541 или ES041, Simatic Manager открыт, закончил загрузку проектов и готов к работе,
; WinCC закрыт, CFC-редактор закрыт.
WinActivate("SIMATIC Manager")                                                                                          ; Делаем окно Simatic Manager активным
Sleep(500)
Send("!f")                                                                                                              ; Посылаем 'Alt+F' - Открываем меню File
Sleep(500)
Send("h")                                                                                                               ; Посылаем 'h' - Открываем пункт Archiv
$hWndInfo = WinWait("Archiving", "", 10)                                                                                ; Ждём не более 10 сек открытия окна архивации
If $hWndInfo = 0 Then
    _EventLog__Report($hEventLog, 1, 0, 42, "", _
        "Не удалось инициализировать процедуру архивации, окно выбора проекта не появилось", $aData)                    ; Сообщение-ошибка, №42, без данных
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
    Exit(42)                                                                                                            ; Завершаем выполнение скрипта, есть ошибка
EndIf
ControlClick("Archiving", "", "SysTabControl32", "main", 1, 250, 10)                                                    ; Кликаем по вкладке Multiprojects с координатами 250х10, 1 раз
Sleep(500)
ControlClick("Archiving", "", "SysTabControl32", "main", 1, 55, 55)                                                     ; Кликаем по строке с мультипроектом
Sleep(500)
ControlClick("Archiving", "", "[CLASS:Button; INSTANCE:3]")                                                             ; Кликаем по ОК
$hWndInfo = WinWait("Archiving - Select an archive", "Save as &type:", 10)                                              ; Ждём не более 10 сек открытия окна сохранения архива
If $hWndInfo = 0 Then
    _EventLog__Report($hEventLog, 1, 0, 43, "", _
        "Не удалось задать имя архива, окно выбора не появилось", $aData)                                               ; Сообщение-ошибка, №43, в данные запишем hWnd последнего окна
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
    Exit(43)                                                                                                            ; Если окно не открылось - выходим, чтобы ничего не испортить, возвращаем ошибку
EndIf
Local $sArcFileName = $Producer & "_" & @YEAR & @MON & @MDAY & "_" & @HOUR & @MIN & ".AutoIt.zip"                       ; Формируем имя нового архива, как Фирма_ГГГГММДД_ччмм.zip
Local $bFileExist = FileExists($sArcFileName)                                                                           ; Если файл существует - устанавливаем флаг на будущее
Send($sArcFileName, 1)                                                                                                  ; Вводим итоговое имя файла архива (на всякий случай в RAW-режиме)
Sleep(500)
Send("!s")                                                                                                              ; Посылаем 'Alt+S' - нажимаем кнопку Save
If $bFileExist Then
    WinWait("Archive Multiproject (", "Do you want to delete the archive")                                              ; Если файл существовал - ждём появления окна с предложением перезаписать его
    ControlClick("Archive Multiproject (", "Do you want to delete the archive", "[CLASS:Button; INSTANCE:2]")           ; В диалоге кликаем Yes
EndIf
$hWndInfo = WinWait("Archive Multiproject", "&Details...", 10)                                                          ; Ждём не более 10 сек появления окна с ошибкой
If $hWndInfo <> 0 Then                                                                                                  ; Если есть окно c ошибкой -
    ControlClick("Archive Multiproject", "&Details...", "[CLASS:Button; INSTANCE:9]")                                   ; нажимаем кнопку Cancel,
    _EventLog__Report($hEventLog, 1, 0, 44, "", _
        "Процедура архивации была заблокирована открытым проектом на другой ES", $aData)                                ; Сообщение-ошибка, №44, в данные запишем hWnd последнего окна
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
    Exit(44)                                                                                                            ; и выходим, чтобы ничего не испортить, возвращаем ошибку
EndIf

TrayTip("Архивация", "Ожидаем начала процесса архивации", 10, $TIP_ICONASTERISK)
; В норме, подготовка к архивации у Simatic Manager занимает не более 2:40-2:45

$result = ProcessWait("S7ARCONX.EXE", 240)                                                                              ; Ожидаем появления процесса модуля архивации Simatic, максимум 4 минуты
If $result = 0 Then
    _EventLog__Report($hEventLog, 1, 0, 45, "", "Процесс архивации не начался за 4 минуты", $aData)                     ; Сообщение-ошибка, №45, без данных (-1)
    _EventLog__Close($hEventLog)                                                                                        ; Закрываем журнал событий
	Exit(45)                                                                                                            ; Завершаем выполнение скрипта, есть ошибка
Else
    _EventLog__Report($hEventLog, 4, 0, 31, "", "Начато создание архива", $aData)                                       ; Сообщение-информация, №31, без данных (-1)
EndIf

; Процесс архивации начался
Do
    ProcessWaitClose("pkzipc.exe")                                                                                      ; Ждём закрытия консольного окна
    Sleep(5000)                                                                                                         ; Т.к. для каждого проекта в мультипроекте вызывается новое окно архиватора, то после закрытия ждём 5 сек - вдруг появится следующее
    If WinExists("Archive Multiproject (3020:38)") Then                                                                 ; Если вдруг появилось окно, что архивация отменена
        ControlClick("Archive Multiproject (3020:38)", "", "[CLASS:Button; INSTANCE:1]")                                ; Кликаем по ОК и закрываем окно
        FileDelete($ArcPath & $sArcFileName)                                                                            ; Удаляем неполный zip-архив
        _EventLog__Report($hEventLog, 4, 0, 21, "", "Пользователь прервал создание архива мультипроекта", $aData)       ; Сообщение-ошибка, №21
        _EventLog__Close($hEventLog)                                                                                    ; Закрываем журнал событий
        Exit(21)                                                                                                        ; Завершаем выполнение скрипта, есть ошибка
    EndIf
Until Not ProcessExists("pkzipc.exe")                                                                                   ; Если следующее окно появилось - значит архивации продолжается, повторяем цикл ожидания закрытия

; Резервная копия создана, хвастаемся, и через 6 секунды гордо уходим в закат.
MsgBox(BitOR($MB_OK, $MB_SYSTEMMODAL), "Создание резервной копии", "Создание резервной копии успешно завершено!", 6)
_EventLog__Report($hEventLog, 0, 0, 32, "", "Создание резервной копии успешно завершено", $aData)                       ; Успешное сообщение, №32, без данных
_EventLog__Close($hEventLog)                                                                                            ; Закрываем журнал событий
Exit(0)                                                                                                                 ; Завершаем работу скрипта, нет ошибки
