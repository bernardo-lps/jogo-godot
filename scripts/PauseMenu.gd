# PauseMenu.gd
extends CanvasLayer

const MENU_PRINCIPAL = "res://scenes/MainMenu.tscn"

func _ready():
	# Começa invisível
	visible = false 
	
	# Conecta os botões (Ajuste os nomes se necessário!)
	# Supondo que você usou um VBoxContainer:
	var btn_continuar = $ColorRect/VBoxContainer/Button
	var btn_menu = $ColorRect/VBoxContainer/Button2
	
	btn_continuar.pressed.connect(_continuar_jogo)
	btn_menu.pressed.connect(_ir_para_menu)

func _input(event):
	# Se apertar ESC (ui_cancel é o padrão do Godot para ESC)
	if event.is_action_pressed("ui_cancel"):
		_alternar_pause()

func _alternar_pause():
	# Inverte a visibilidade (se tá visível, esconde. Se tá escondido, mostra)
	visible = not visible
	
	# PAUSA ou DESPAUSA o jogo inteiro
	get_tree().paused = visible

func _continuar_jogo():
	# Esconde o menu e solta o jogo
	visible = false
	get_tree().paused = false

func _ir_para_menu():
	# IMPORTANTE: Despausar antes de mudar de cena, senão o menu principal fica travado!
	get_tree().paused = false
	get_tree().change_scene_to_file(MENU_PRINCIPAL)
