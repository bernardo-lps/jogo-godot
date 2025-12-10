# DeathZone.gd
extends Area2D

func _ready():
	# Conecta o sinal de colisão
	body_entered.connect(_ao_cair_no_buraco)

func _ao_cair_no_buraco(body):
	# Verifica se foi o Guts que caiu
	if body.name == "Guts":
		print("Guts caiu! Reiniciando a fase...")
		
		# Esta função recarrega a cena atual do zero (Reset)
		get_tree().reload_current_scene()
