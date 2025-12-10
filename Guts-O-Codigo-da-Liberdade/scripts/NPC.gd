# NPC.gd
extends Area2D

# Sinal que avisa: "O jogador quer conversar!"
signal iniciar_dialogo

var jogador_na_area = false

func _ready():
	# Conecta os sinais de entrada e saída da área
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _input(event):
	# Verifica se apertou a tecla de interação ("E")
	if jogador_na_area and event.is_action_pressed("Interact"):
		print("Falando com o NPC...")
		iniciar_dialogo.emit()
		# Aqui, no futuro, vamos travar o movimento do Guts também

func _on_body_entered(body):
	if body.name == "Guts":
		jogador_na_area = true
		# (Opcional) Aqui você poderia fazer aparecer um balãozinho "E" sobre a cabeça dele

func _on_body_exited(body):
	if body.name == "Guts":
		jogador_na_area = false
