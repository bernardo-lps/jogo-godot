# IntroStory.gd
extends Control

# Caminho para a Fase 1 (Ajuste arrastando o arquivo se precisar)
const PRIMEIRA_FASE = "res://scenes/World.tscn"

func _ready():
	# Conecta o botão (verifique se o nome é Button mesmo)
	$ColorRect/Button.pressed.connect(_iniciar_missao)

func _iniciar_missao():
	# Carrega o jogo de verdade
	get_tree().change_scene_to_file(PRIMEIRA_FASE)
