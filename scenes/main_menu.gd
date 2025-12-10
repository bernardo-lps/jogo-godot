# MainMenu.gd
extends Control

# Caminho para a sua primeira fase (World)
const FASE_1 = "res://World.tscn" 
# Se estiver na pasta scenes: "res://scenes/World.tscn"

func _ready():
	# Vamos conectar os botões via código usando os nomes dos nós
	# Certifique-se que seus botões se chamam "ButtonJogar" e "ButtonSair" na cena
	# OU ajuste os nomes aqui embaixo para Button e Button2:
	
	# Exemplo se você não renomeou os botões:
	# $Button = Botão de Jogar
	# $Button2 = Botão de Sair
	
	$Button.pressed.connect(_ao_clicar_jogar)
	$Button2.pressed.connect(_ao_clicar_sair)

func _ao_clicar_jogar():
	print("Iniciando o jogo...")
	get_tree().change_scene_to_file(FASE_1)

func _ao_clicar_sair():
	print("Saindo do jogo...")
	get_tree().quit()
