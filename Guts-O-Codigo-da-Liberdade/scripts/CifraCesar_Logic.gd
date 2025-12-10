# CifraCesar_Logic.gd
extends Control

# Sinal para avisar o World que ganhamos
signal puzzle_resolvido

# Pegando os nós diretos (Filhos do CifraCesar)
@onready var label_enunciado = $Label
@onready var input_resposta = $LineEdit
@onready var botao_verificar = $Button
@onready var label_resultado = $Label2

# --- ATUALIZAÇÃO DA HISTÓRIA (FASE 1) ---
# Contexto: O Necromante bloqueou a passagem com um selo.
# Frase Original: O SELO ESTA FECHADO
# Cifra (Chave 3): R VHOR HVWD IHFKDGR
const TEXTO_CRIPTOGRAFADO = "R VHOR\nHVWD IHFKDGR"
const RESPOSTA_CORRETA = "O SELO ESTA FECHADO"

func _ready():
	# Mudamos o título para ficar mais imersivo
	label_enunciado.text = "QUEBRE O SELO MÁGICO (CHAVE 3):\n\n" + TEXTO_CRIPTOGRAFADO
	label_enunciado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	input_resposta.placeholder_text = "Digite a tradução..."
	input_resposta.alignment = HORIZONTAL_ALIGNMENT_CENTER
	
	label_resultado.text = "" # Começa vazio
	
	# Conecta o clique do botão à função de verificar
	botao_verificar.pressed.connect(_ao_clicar_verificar)

func _ao_clicar_verificar():
	# Pega o texto, transforma em Maiúsculas e tira espaços das pontas
	var texto_jogador = input_resposta.text.to_upper().strip_edges()
	
	print("Tentativa do jogador: ", texto_jogador)
	
	if texto_jogador == RESPOSTA_CORRETA:
		# ACERTOU
		label_resultado.text = "CORRETO! O selo se rompeu."
		label_resultado.modulate = Color.GREEN
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
		
		# Avisa o mundo e trava o botão
		puzzle_resolvido.emit()
		botao_verificar.disabled = true
		
	else:
		# ERROU
		label_resultado.text = "INCORRETO. A magia falhou."
		label_resultado.modulate = Color.RED
		label_resultado.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
