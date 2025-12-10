# Oracle.gd
extends Area2D

# Sinal para avisar ao World que o jogador quer abrir o puzzle
signal pedir_puzzle

var jogador_na_area = false

func _ready():
	# Conecta os sinais nativos do Area2D (body_entered e body_exited)
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(delta):
	# Se o jogador está perto E aperta a tecla de interação (vamos usar Enter/Espaço por enquanto)
	if jogador_na_area and Input.is_action_just_pressed("Interact"):
		print("Interagindo com o Oráculo!")
		pedir_puzzle.emit() # Manda o sinal para o World

# Detecta quando Guts entra na área
func _on_body_entered(body):
	if body.name == "Guts": # Verifica se foi o Guts que entrou
		jogador_na_area = true
		# Opcional: Mostrar um ícone "Pressione E" acima da cabeça dele aqui

# Detecta quando Guts sai da área
func _on_body_exited(body):
	if body.name == "Guts":
		jogador_na_area = false
		# Opcional: Esconder o ícone
