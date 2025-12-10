# EndGame.gd
extends Control

# ARRASTE AQUI O SEU MENU PRINCIPAL
const MENU_PRINCIPAL = "res://scenes/MainMenu.tscn"

func _ready():
	# Vamos conectar os botões que estão dentro do VBoxContainer
	# Verifique se o nome do container é VBoxContainer mesmo
	var btn_menu = $VBoxContainer/Button
	var btn_sair = $VBoxContainer/Button2 # O segundo botão costuma chamar Button2
	
	# Conectando
	btn_menu.pressed.connect(_voltar_menu)
	btn_sair.pressed.connect(_sair_jogo)

func _voltar_menu():
	get_tree().change_scene_to_file(MENU_PRINCIPAL)

func _sair_jogo():
	get_tree().quit()
