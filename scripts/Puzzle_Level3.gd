extends Control

signal puzzle_resolvido

@onready var label_enunciado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var input_resposta = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit
@onready var botao_verificar = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Button
@onready var label_resultado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label2

var RESPOSTA_CORRETA = "" 

func _ready():
	input_resposta.grab_focus()
	label_resultado.text = ""
	if botao_verificar:
		botao_verificar.pressed.connect(_ao_clicar_verificar)

# 1. FUNÇÃO QUE RECEBE O ENIGMA DO LIVRO
func configurar_puzzle(enigma, senha):
	if label_enunciado:
		label_enunciado.text = "FRAGMENTO DO SELO (A=Z):\n\n" + enigma
	
	# LIMPEZA CRÍTICA: Remove espaços da senha que veio do livro e deixa em maiúsculo
	# Se vier "A LUZ", vira "ALUZ"
	RESPOSTA_CORRETA = senha.to_upper().replace(" ", "").strip_edges()

# 2. FUNÇÃO QUE VERIFICA O QUE O JOGADOR DIGITOU
func _ao_clicar_verificar():
	# LIMPEZA CRÍTICA: Remove espaços do que o Guts digitou e deixa em maiúsculo
	# Se ele digitar "A LUZ", vira "ALUZ"
	var texto_jogador = input_resposta.text.to_upper().replace(" ", "").strip_edges()
	
	# Agora comparamos "ALUZ" com "ALUZ" -> SUCESSO!
	if texto_jogador == RESPOSTA_CORRETA:
		label_resultado.text = "CORRETO! O fragmento foi purificado."
		label_resultado.modulate = Color.GREEN
		
		puzzle_resolvido.emit()
		botao_verificar.disabled = true
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
	else:
		label_resultado.text = "INCORRETO. Tente novamente."
		label_resultado.modulate = Color.RED
