extends Area2D

# 1. Sinal que carrega os dados (Necessário para evitar o erro de argumentos)
signal pedir_puzzle(enigma, senha_correta)

# 2. Variáveis que aparecerão no Inspetor (Lado direito do Godot)
@export var enigma_cifrado: String = ""
@export var resposta_certa: String = ""

var pode_interagir = false

func _ready():
	# Conecta os sinais de entrada e saída da área de colisão
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	# Verifica se o Guts está perto e se a tecla de ação foi pressionada
	if pode_interagir:
		if Input.is_action_just_pressed("Interact") or Input.is_action_just_pressed("ui_accept"):
			print("Interagindo com livro: ", enigma_cifrado)
			# 3. Emite o sinal enviando os dados preenchidos no Inspetor
			emit_signal("pedir_puzzle", enigma_cifrado, resposta_certa)

# Detecta a entrada do jogador
func _on_body_entered(body):
	if body.name == "Guts":
		pode_interagir = true

# Detecta a saída do jogador
func _on_body_exited(body):
	if body.name == "Guts":
		pode_interagir = false
