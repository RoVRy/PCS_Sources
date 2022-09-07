#Region ;**** Directives created by AutoIt3Wrapper_GUI ****
#AutoIt3Wrapper_Icon=C:\Program Files (x86)\AutoIt3\Icons\MyAutoIt3_Green.ico
#AutoIt3Wrapper_Outfile=Interlocks.exe
#AutoIt3Wrapper_UseUpx=y
#AutoIt3Wrapper_Res_Fileversion=0.1.0.6
#AutoIt3Wrapper_Res_Fileversion_AutoIncrement=y
#AutoIt3Wrapper_Res_LegalCopyright=RoVRy
#AutoIt3Wrapper_Res_Language=1049
#AutoIt3Wrapper_Add_Constants=n
#EndRegion ;**** Directives created by AutoIt3Wrapper_GUI ****
#include <Constants.au3>
#include <MsgBoxConstants.au3>
#include <EventLog.au3>
#include <File.au3>
#include <TrayConstants.au3>
#include <Timers.au3>
#include <AutoItConstants.au3>
#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>
#include <UpDownConstants.au3>
#include <Debug.au3>

Global $aIntlks[17]

$aIntlks[2]  = "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0"
$aIntlks[4]  = "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0"
$aIntlks[8]  = "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0"
$aIntlks[16] = "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "1" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0" & @CRLF & "0"

Local $Version = FileGetVersion(@ScriptFullPath)

If WinExists("CFC") Then																							; Если вдруг редактор CFC уже открыт - закрываем во избежание конфликтов
	WinClose("CFC")
EndIf

$hWnd = WinGetHandle("[CLASS:s7tgtopx]")																			; получаем хэндл на окно Simatic Manager
WinActivate($hWnd)																									; делаем его активным (даём "фокус")

; !!! На данном этапе окно Simatic Manager должно находиться:
; * в режиме Process Object View
; * во вкладке Blocks
; * должен быть применён фильтр "Block type" с необходимым типом блоков

Send("^{HOME}")																										; Посылаем Ctrl+Home, чтобы поставить курсор на первую строку и первый столбец

ControlClick($hWnd, "", "[CLASSNN:AfxFrameOrView1002]", "primary", 1, 930, 10)										; сортируем по Block
ControlClick($hWnd, "", "[CLASSNN:AfxFrameOrView1002]", "primary", 1, 320, 10)										; сортируем по Chart
ControlClick($hWnd, "", "[CLASSNN:AfxFrameOrView1002]", "primary", 1, 140, 10)										; сортируем по Hierarchy

; Формируем окно для запроса у пользователя количества блоков для обработки с полем InputUpDown и кнопкой ОК
Local $hGUI = GUICreate("Обработка блоков (v" & $Version & ")", 250, 120, -1, -1, -1, $WS_EX_TOPMOST)
Local $idTxt1 = GUICtrlCreateLabel ( "Номер первого блока:", 20, 20)
Local $idInp11 = GUICtrlCreateInput("1", 175, 18, 55, 20)
Local $idInp12 = GUICtrlCreateUpdown($idInp11)
Local $idTxt2 = GUICtrlCreateLabel ( "Номер последнего блока:", 20, 50)
Local $idInp21 = GUICtrlCreateInput("2", 175, 48, 55, 20)
Local $idInp22 = GUICtrlCreateUpdown($idInp21)
Local $idBut = GUICtrlCreateButton("OK", 65, 85, 100, 25)
GUISetState(@SW_SHOW, $hGUI)																						; Показываем сформированное окно
While 1
    Switch GUIGetMsg()
		Case $idBut																									; Ждём пока пользователь не нажмёт кнопку OK
			ExitLoop
		Case $GUI_EVENT_CLOSE
			Exit(-1)
    EndSwitch
WEnd

$iBlocksStart = Number(GUICtrlRead($idInp11), 1)																	; Получаем значение из InputUpDown
$iBlocksEnd = Number(GUICtrlRead($idInp21), 1)

GUIDelete($hGUI)																									; Уничтожаем окно

ConsoleWrite($iBlocksStart & ", " & $iBlocksEnd & @CRLF)
If $iBlocksStart < 1 Or $iBlocksEnd < 1 Or $iBlocksEnd < $iBlocksStart Then											; Если пользователь ввёл 0 блоков или отрицательное число - показываем ошибку и выходим
	MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Начало или конец не может быть равно 0 или быть отрицательным!" & @CRLF & "Или начало не может быть больше конца!", 10)
	Exit(-1)
EndIf

$iBlocksAmount = $iBlocksEnd - $iBlocksStart + 1
$iIntermediateStop = $iBlocksEnd
If $iIntermediateStop > 48 Then
	$iIntermediateStop = 48
EndIf

If $iBlocksStart > 48 Then

	Send("{RIGHT}{RIGHT}")
 	For $i = 2 to $iBlocksStart - 1
		Send("{DOWN}")
		Sleep(50)
	Next

Else
	Global $i
	For $i = $iBlocksStart To $iIntermediateStop																	; 48 - столько умещается строк в таблице на полном экране

		TrayTip("Прогресс", "Блок №" & $i & " (" & ($i - $iBlocksStart + 1) & " из " & $iBlocksAmount & ")", 5, $TIP_ICONASTERISK)
		WinWaitActive($hWnd, "", 30)																				; Ждём 10 секунд, чтобы окно Simatic Manager стало активным
		ControlClick($hWnd, "", "[CLASSNN:AfxFrameOrView1002]", "secondary", 1, 640, ($i - 1) * 17 + 25)			; Вызываем контекстное меню для строки

		Open_CFC_Props()																							; Открываем CFC и окно свойств выделенного блока
		ProceedIntlk()																								; Обрабатываем свойства интерлока
		Close_Props_CFC()																							; Закрываем окно свойств и CFC

	Next

EndIf

If $iBlocksEnd > 48 Then
	Global $i
	For $i = $iIntermediateStop + 1 To $iBlocksEnd

		TrayTip("Прогресс", "Блок №" & $i & " (" & ($i - $iBlocksStart + 1) & " из " & $iBlocksAmount & ")", 5, $TIP_ICONASTERISK)
		Send("{DOWN}")
		ControlClick($hWnd, "", "[CLASSNN:AfxFrameOrView1002]", "secondary", 1, 640, 824)								; Вызываем контекстное меню для строки

		Open_CFC_Props()																								; Открываем CFC и окно свойств выделенного блока
		ProceedIntlk()																									; Обрабатываем свойства интерлока
		Close_Props_CFC()																								; Закрываем окно свойств и CFC

	Next

EndIf

MsgBox($MB_OK + $MB_ICONINFORMATION + $MB_TOPMOST, "Скрипт AutoIt", "Выполнение скрипта завершено")
Exit(0)

Func Open_CFC_Props()

		$hContext = WinWait("[CLASS:#32768]")																		; Ожидаем появления
		Local $aPos = WinGetPos($hContext)																			; Получаем координаты
		MouseClick($MOUSE_CLICK_PRIMARY, $aPos[0] + 100, $aPos[1] + 10, 1, 0)										; Кликаем по координатам пункта "Open Chart"

		Global $hCFC = WinWaitActive("CFC", "", 60)																	; Ждём 10 секунд появления редактора CFC с нужным выделенным блоком
		If $hCFC = 0 Then
			MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Возникла проблема с вызовом окна CFC-редактора" & @CRLF & "Текущий блок: " & $i)
			Exit(-1)
		EndIf

		Sleep(500)

		WinWait("Password", "", 5)
		If WinExists("[CLASS:#32770]", "") Then																		; Если появилось окно с запросом пароля доступа к F-программе
			ControlSetText("[CLASS:#32770]", "", "[ID:1017]", "SG", 1)												; в поле ввода вводим пароль "SG"
			ControlClick("[CLASS:#32770]", "", "[ID:1]", "primary", 1)												; и жмём на ОК
			Sleep(250)																								; Даём немного времени на обработку
		EndIf

		WinWait("Safety Chart", "", 5)
		If WinExists("[CLASS:#32770]", "") Then																		; Если появилось окно с предупреждением о F-программе
			ControlClick("[CLASS:#32770]", "", "[ID:1157", "primary", 1, 6, 18)										; Ставим галочку "Do not display..."
			ControlClick("[CLASS:#32770]", "", "[ID:1]", "primary", 1)												; и жмём на ОК
			Sleep(1000)																								; Даём время на возврат и активацию окна CFC
		EndIf

		Send("!{ENTER}")																							; Посылаем Alt+Enter - вызов окна свойств

		Global $hBlkProp = WinWaitActive("Properties", "", 60)														; Ждём 10 секунд появления окна свойств блока
		If $hBlkProp = 0 Then
			MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Возникла проблема с вызовом окна свойств блока" & @CRLF & "Текущий блок: " & $i)
			Exit(-1)
		EndIf

	WinActivate($hBlkProp)

EndFunc

Func ProceedIntlk()

	Local $sIntlkXX = ControlGetText($hBlkProp, "", "[ID:1012]")													; Получаем тип блока из окна его свойств
	Local $iIntlkXX = Number(StringRight($sIntlkXX, 2), 1)															; Отрезаем последние 2 символа из типа блока и преобразуем их в число

	If $iIntlkXX <> 2 And $iIntlkXX <> 4 And $iIntlkXX <> 8 And $iIntlkXX <> 16 Then
		MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Возникла проблема с определением типа блока" & @CRLF & "Текущий блок: " & $i)
		Exit(-1)
	EndIf

	Sleep(500)
	ControlClick($hBlkProp, "", "[ID:12320]", "primary", 1, 72, 12)													; "Кликаем по вкладке "I/Os"
	Sleep(500)

	For $j = 1 to 16
		Send("{RIGHT}")																								; Переходим на 16-й столбец - Parameter
		Sleep(75)
	Next

	ClipPut($aIntlks[$iIntlkXX])																					; Помещаем в буфер обмена информацию об установленных/снятых параметрах
	Sleep(200)
	Send("{CTRLDOWN}v{CTRLUP}")																						; Посылаем Ctrl+V для вставки в окно свойств

EndFunc

Func Close_Props_CFC()

	Sleep(2000)
	ControlClick($hBlkProp, "Properties", "[ID:1]", "primary", 1)													; Закрываем окно свойств, "щелчком" по кнопке ОК
	Local $Result = WinWaitClose($hBlkProp, "", 60)
	If $Result <> 1 Then
		MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Возникла проблема с закрытием окна свойств блока" & @CRLF & "Текущий блок: " & $i)
		Exit(-1)
	EndIf
	WinClose($hCFC)
	Local $Result = WinWaitClose($hCFC, "", 60)
	If $Result <> 1 Then																							; Закрываем CFC-редактор
		MsgBox($MB_OK + $MB_ICONERROR + $MB_TOPMOST, "Ошибка", "Возникла проблема с закрытием окна CFC-редактора" & @CRLF & "Текущий блок: " & $i)
		Exit(-1)
	EndIf

EndFunc
