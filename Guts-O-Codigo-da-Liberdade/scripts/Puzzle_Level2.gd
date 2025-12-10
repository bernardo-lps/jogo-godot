# Puzzle_Level2.gd
extends Control

signal puzzle_resolvido

@onready var label_enunciado = $Label
@onready var input_resposta = $LineEdit
@onready var botao_verificar = $Button
@onready var label_resultado = $Label2

# --- ENIGMA DA FASE 2 (CHAVE 5) ---
# Frase Original: ATAQUE A TORRE
# A (+5) = F
# T (+5) = Y
# ...
# Criptografia: F YFVZJ F YTWWJ
const TEXTO_CRIPTOGRAFADO = "WZRT F YTWWJ"
const RESPOSTA_CORRETA = "RUMO A TORRE"

func _ready():
	# Mudamos o texto para indicar o nível 2
	label_enunciado.text = "ONDE ELES ESTÃO? (CHAVE 5):\n\n" + TEXTO_CRIPTOGRAFADO
	label_enunciado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	input_resposta.placeholder_text = "Qual é a ordem?"
	input_resposta.alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	label_resultado.text = "" 
	
	botao_verificar.pressed.connect(_ao_clicar_verificar)

func _ao_clicar_verificar():
	var texto_jogador = input_resposta.text.to_upper().strip_edges()
	print("Tentativa Fase 2: ", texto_jogador)
	
	if texto_jogador == RESPOSTA_CORRETA:
		label_resultado.text = "CORRETO! Portões da Torre abertos."
		label_resultado.modulate = Color.GREEN
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		puzzle_resolvido.emit()
		botao_verificar.disabled = true
		
	else:
		label_resultado.text = "ERRADO. Lembre-se: Volte 5 letras."
		label_resultado.modulate = Color.RED
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
