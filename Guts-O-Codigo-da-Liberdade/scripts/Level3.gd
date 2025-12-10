# Level3.gd
extends Node2D

const PuzzleScene = preload("res://scenes/Puzzle_Level3.tscn")
const Dialogo1 = preload("res://scenes/Dialogo_L3_NPC1.tscn")
const Dialogo2 = preload("res://scenes/Dialogo_L3_NPC2.tscn")

var puzzle_ativo = null

@onready var Oracle = $Oracle
@onready var interface_layer = $InterfaceLayer
@onready var door = $Door

# Pegando os 2 NPCs
@onready var npc1 = $NPC      # Esquerda
@onready var npc2 = $NPC2     # Direita (Certifique-se de ter renomeado na cena!)

func _ready():
	if Oracle: Oracle.pedir_puzzle.connect(ativar_puzzle)
	
	# Conecta cada NPC a uma função diferente
	if npc1: npc1.iniciar_dialogo.connect(conversa_npc1)
	if npc2: npc2.iniciar_dialogo.connect(conversa_npc2)

# NPC 1 fala sobre a Inversão
func conversa_npc1():
	abrir_dialogo(Dialogo1)

# NPC 2 fala sobre A=Z
func conversa_npc2():
	abrir_dialogo(Dialogo2)

# Função genérica para abrir qualquer diálogo
func abrir_dialogo(cena_dialogo):
	$Guts.pode_mover = false
	var caixa = cena_dialogo.instantiate()
	interface_layer.add_child(caixa)
	caixa.tree_exited.connect(func(): $Guts.pode_mover = true)

func ativar_puzzle():
	# (Mesma lógica dos outros níveis...)
	if puzzle_ativo != null: return
	$Guts.pode_mover = false
	puzzle_ativo = PuzzleScene.instantiate()
	interface_layer.add_child(puzzle_ativo)
	puzzle_ativo.set_anchors_preset(Control.PRESET_FULL_RECT)
	puzzle_ativo.puzzle_resolvido.connect(desativar_puzzle)

func desativar_puzzle():
	if puzzle_ativo != null:
		puzzle_ativo.queue_free()
		puzzle_ativo = null
		$Guts.pode_mover = true
		if door: door.abrir()
