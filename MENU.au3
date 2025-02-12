#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

GUICreate("Fenox Intalador", 280, 200)

; Lista de Estados
$estado = GUICtrlCreateCombo("Selecione um Estado", 50, 30, 200, 20)
Local $estados[] = ["Bahia", "Distrito Federal", "Esp�rito Santo", "Goi�s", "Mato Grosso do Sul", "Minas Gerais", "Par�", "Pernambuco", "S�o Paulo"]

For $i = 0 To UBound($estados) - 1
    GUICtrlSetData($estado, $estados[$i])
Next

; Checkboxes
$chkDigitacao = GUICtrlCreateCheckbox("Digita��o", 50, 70, 100, 20)
$chkServidor = GUICtrlCreateCheckbox("Servidor", 150, 70, 100, 20)

; �cone de interroga��o ao lado do checkbox Servidor
$lblInterrogacao = GUICtrlCreateLabel("???", 170, 90, 30, 30)
GUICtrlSetColor($lblInterrogacao, 0x0000FF) ; Cor azul para o �cone
GUICtrlSetTip($lblInterrogacao, "Use apenas para atualizar o servidor") ; Dica de ferramenta

; Bot�es
$btnOK = GUICtrlCreateButton("OK", 50, 120, 80, 30)
$btnCancelar = GUICtrlCreateButton("Cancelar", 150, 120, 80, 30)

; Label para exibir a vers�o
$lblVersao = GUICtrlCreateLabel("Vers�o: N/A", 50, 160, 200, 20)

GUISetState()

; Fun��o para garantir que apenas um checkbox seja selecionado por vez
Func AlternarCheckbox($source, $target)
    If GUICtrlRead($source) = $GUI_CHECKED Then
        GUICtrlSetState($target, $GUI_UNCHECKED)
    EndIf
EndFunc

; Fun��o para buscar a vers�o do estado
Func ObterVersaoEstado($estado)
    Local $file = FileOpen("C:\\LISTA_ESTADO.txt", 0)
    If $file = -1 Then Return "N/A"

    While 1
        Local $line = FileReadLine($file)
        If @error Then ExitLoop

        If StringInStr($line, $estado & " Vers�o ") Then
            Local $partes = StringRegExp($line, $estado & " Vers�o ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)", 1)
            If IsArray($partes) Then
                FileClose($file)
                Return $partes[0]
            EndIf
        EndIf
    WEnd
    FileClose($file)
    Return "N/A"
EndFunc

; Fun��o para executar o programa baseado no estado e sele��o
Func ExecutarPrograma($estado, $digitacao, $servidor)
    If Not ($digitacao Or $servidor) Then
        MsgBox(48, "Aviso", "Por favor, selecione uma op��o: Digita��o ou Servidor.")
        Return
    EndIf

    Switch $estado
        Case "Bahia"
            If $digitacao Then Run("taskmgr.exe")
            If $servidor Then Run("msinfo32.exe")
        Case "Distrito Federal"
            If $digitacao Then Run("control.exe")
            If $servidor Then Run("dxdiag.exe")
        Case "Esp�rito Santo"
            If $digitacao Then Run("cleanmgr.exe")
            If $servidor Then Run("compmgmt.msc")
        Case "Goi�s"
            If $digitacao Then Run("notepad.exe")
            If $servidor Then Run("calc.exe")
        Case "Mato Grosso do Sul"
            If $digitacao Then Run("explorer.exe")
            If $servidor Then Run("regedit.exe")
        Case "Minas Gerais"
            If $digitacao Then Run("cmd.exe")
            If $servidor Then Run("mspaint.exe")
        Case "Par�"
            If $digitacao Then Run("taskmgr.exe")
            If $servidor Then Run("msinfo32.exe")
        Case "Pernambuco"
            If $digitacao Then Run("cleanmgr.exe")
            If $servidor Then Run("compmgmt.msc")
        Case "S�o Paulo"
            If $digitacao Then Run("notepad.exe")
            If $servidor Then Run("calc.exe")
    EndSwitch
EndFunc

While 1
    $msg = GUIGetMsg()
    Switch $msg
        Case $GUI_EVENT_CLOSE, $btnCancelar
            ExitLoop

        Case $chkDigitacao
            AlternarCheckbox($chkDigitacao, $chkServidor)

        Case $chkServidor
            AlternarCheckbox($chkServidor, $chkDigitacao)

        Case $estado
            $estadoSelecionado = GUICtrlRead($estado)
            If $estadoSelecionado <> "Selecione um Estado" Then
                $versao = ObterVersaoEstado($estadoSelecionado)
                GUICtrlSetData($lblVersao, "Vers�o: " & $versao)
            Else
                GUICtrlSetData($lblVersao, "Vers�o: N/A")
            EndIf

        Case $btnOK
            $estadoSelecionado = GUICtrlRead($estado)
            $digitacaoMarcado = GUICtrlRead($chkDigitacao) = $GUI_CHECKED
            $servidorMarcado = GUICtrlRead($chkServidor) = $GUI_CHECKED

            If $estadoSelecionado <> "Selecione um Estado" Then
                ExecutarPrograma($estadoSelecionado, $digitacaoMarcado, $servidorMarcado)
            Else
                MsgBox(48, "Aviso", "Por favor, selecione um estado.")
            EndIf
    EndSwitch
WEnd

GUIDelete()