# Puzzle_Level3.gd
extends Control
signal puzzle_resolvido
@onready var label_enunciado = $Label
@onready var input_resposta = $LineEdit
@onready var botao_verificar = $Button
@onready var label_resultado = $Label2

# Cifra Atbash (Invertida)
# FIM DA GUERRA -> URN WZ TFVIIZ
const TEXTO_CRIPTOGRAFADO = "URN WZ\nVHXFIRWZL"
const RESPOSTA_CORRETA = "FIM DA ESCURIDAO"

func _ready():
	label_enunciado.text = "DESTRUA ZORTHAR (INVERTIDO):\n\n" + TEXTO_CRIPTOGRAFADO
	label_enunciado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	input_resposta.placeholder_text = "Acabe com isso..."
	input_resposta.alignment = HORIZONTAL_ALIGNMENT_CENTER
	label_resultado.text = "" 
	botao_verificar.pressed.connect(_verificar)

func _verificar():
	var texto = input_resposta.text.to_upper().strip_edges()
	if texto == RESPOSTA_CORRETA:
		label_resultado.text = "CORRETO! O Necromante caiu."
		label_resultado.modulate = Color.GREEN
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		puzzle_resolvido.emit()
		botao_verificar.disabled = true
	else:
		label_resultado.text = "ERRADO. Lembre-se: A=Z, B=Y..."
		label_resultado.modulate = Color.RED
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
