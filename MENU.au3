#include <GUIConstantsEx.au3>
#include <WindowsConstants.au3>

GUICreate("Fenox Intalador", 280, 200)

; Lista de Estados
$estado = GUICtrlCreateCombo("Selecione um Estado", 50, 30, 200, 20)
Local $estados[] = ["Bahia", "Distrito Federal", "Espírito Santo", "Goiás", "Mato Grosso do Sul", "Minas Gerais", "Pará", "Pernambuco", "São Paulo"]

For $i = 0 To UBound($estados) - 1
    GUICtrlSetData($estado, $estados[$i])
Next

; Checkboxes
$chkDigitacao = GUICtrlCreateCheckbox("Digitação", 50, 70, 100, 20)
$chkServidor = GUICtrlCreateCheckbox("Servidor", 150, 70, 100, 20)

; Ícone de interrogação ao lado do checkbox Servidor
$lblInterrogacao = GUICtrlCreateLabel("???", 170, 90, 30, 30)
GUICtrlSetColor($lblInterrogacao, 0x0000FF) ; Cor azul para o ícone
GUICtrlSetTip($lblInterrogacao, "Use apenas para atualizar o servidor") ; Dica de ferramenta

; Botões
$btnOK = GUICtrlCreateButton("OK", 50, 120, 80, 30)
$btnCancelar = GUICtrlCreateButton("Cancelar", 150, 120, 80, 30)

; Label para exibir a versão
$lblVersao = GUICtrlCreateLabel("Versão: N/A", 50, 160, 200, 20)

GUISetState()

; Função para garantir que apenas um checkbox seja selecionado por vez
Func AlternarCheckbox($source, $target)
    If GUICtrlRead($source) = $GUI_CHECKED Then
        GUICtrlSetState($target, $GUI_UNCHECKED)
    EndIf
EndFunc

; Função para buscar a versão do estado
Func ObterVersaoEstado($estado)
    Local $file = FileOpen("C:\\LISTA_ESTADO.txt", 0)
    If $file = -1 Then Return "N/A"

    While 1
        Local $line = FileReadLine($file)
        If @error Then ExitLoop

        If StringInStr($line, $estado & " Versão ") Then
            Local $partes = StringRegExp($line, $estado & " Versão ([0-9]+\.[0-9]+\.[0-9]+\.[0-9]+)", 1)
            If IsArray($partes) Then
                FileClose($file)
                Return $partes[0]
            EndIf
        EndIf
    WEnd
    FileClose($file)
    Return "N/A"
EndFunc

; Função para executar o programa baseado no estado e seleção
Func ExecutarPrograma($estado, $digitacao, $servidor)
    If Not ($digitacao Or $servidor) Then
        MsgBox(48, "Aviso", "Por favor, selecione uma opção: Digitação ou Servidor.")
        Return
    EndIf

    Switch $estado
        Case "Bahia"
            If $digitacao Then Run("taskmgr.exe")
            If $servidor Then Run("msinfo32.exe")
        Case "Distrito Federal"
            If $digitacao Then Run("control.exe")
            If $servidor Then Run("dxdiag.exe")
        Case "Espírito Santo"
            If $digitacao Then Run("cleanmgr.exe")
            If $servidor Then Run("compmgmt.msc")
        Case "Goiás"
            If $digitacao Then Run("notepad.exe")
            If $servidor Then Run("calc.exe")
        Case "Mato Grosso do Sul"
            If $digitacao Then Run("explorer.exe")
            If $servidor Then Run("regedit.exe")
        Case "Minas Gerais"
            If $digitacao Then Run("cmd.exe")
            If $servidor Then Run("mspaint.exe")
        Case "Pará"
            If $digitacao Then Run("taskmgr.exe")
            If $servidor Then Run("msinfo32.exe")
        Case "Pernambuco"
            If $digitacao Then Run("cleanmgr.exe")
            If $servidor Then Run("compmgmt.msc")
        Case "São Paulo"
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
                GUICtrlSetData($lblVersao, "Versão: " & $versao)
            Else
                GUICtrlSetData($lblVersao, "Versão: N/A")
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