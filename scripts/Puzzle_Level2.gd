extends Control

signal puzzle_resolvido

# --- CAMINHOS DOS NÓS (Grimório) ---
@onready var label_enunciado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var input_resposta = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit
@onready var botao_verificar = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Button
@onready var label_resultado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label2

# --- ENIGMA CORRETO DA FASE 2 (CHAVE +5) ---
# Se a senha é "RUMO A TORRE", o enigma deve ser "WZTRF XJQQJ" (com espaços para leitura)
# Nota: Remova os espaços da senha correta para evitar erros no .strip_edges()
const TEXTO_CRIPTOGRAFADO = "WZTRF XJQQJ" 
const RESPOSTA_CORRETA = "RUMOATORRE" # Sem espaços é mais seguro para comparação

func _ready():
	# Configuração do visual
	# Título correto para a Chave 5: A Mão do Mago
	label_enunciado.text = "A MÃO DO MAGO (CHAVE +5):\n\n" + TEXTO_CRIPTOGRAFADO
	label_enunciado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	input_resposta.placeholder_text = "5 dedos, 5 passos..."
	input_resposta.alignment = HORIZONTAL_ALIGNMENT_CENTER
	input_resposta.grab_focus() 
	
	label_resultado.text = "" 
	
	if botao_verificar:
		botao_verificar.pressed.connect(_ao_clicar_verificar)

func _ao_clicar_verificar():
	# Retira espaços e transforma em MAIÚSCULAS para comparar com RESPOSTA_CORRETA
	var texto_jogador = input_resposta.text.to_upper().replace(" ", "").strip_edges()
	
	# Compara sem espaços, pois definimos RESPOSTA_CORRETA como "RUMOATORRE"
	if texto_jogador == RESPOSTA_CORRETA:
		label_resultado.text = "CORRETO! Portões da Torre abertos."
		label_resultado.modulate = Color.GREEN
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		puzzle_resolvido.emit()
		botao_verificar.disabled = true
		
		await get_tree().create_timer(1.0).timeout
		queue_free()
	else:
		label_resultado.text = "ERRADO. Lembre-se: Chave +5. Volte 5 letras."
		label_resultado.modulate = Color.RED
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER

# ATENÇÃO: Se este é o script SOMENTE da Fase 2, ele NÃO deve ter a função configurar_puzzle.
# A função configurar_puzzle é usada apenas pela Fase 3.
# Se você a tem aqui, remova-a, pois ela não tem utilidade neste script.
