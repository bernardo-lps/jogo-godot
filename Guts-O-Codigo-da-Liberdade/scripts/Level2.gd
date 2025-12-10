# Level2.gd
extends Node2D

# --- REFERÊNCIAS AOS ARQUIVOS ---
# Arraste o arquivo res://scenes/Puzzle_Level2.tscn para as aspas abaixo:
const PuzzleScene = preload("res://scenes/Puzzle_Level2.tscn")

# Arraste o arquivo res://scenes/DialogueBox.tscn para as aspas abaixo:
const DialogoScene = preload("res://scenes/DialogueBox_Level2.tscn")

var puzzle_ativo = null

# Referências aos nós na cena
@onready var Oracle = $Oracle
@onready var interface_layer = $InterfaceLayer
@onready var door = $Door
@onready var npc = $NPC

func _ready():
	if Oracle:
		Oracle.pedir_puzzle.connect(ativar_puzzle)
	if npc:
		npc.iniciar_dialogo.connect(comecar_conversa)

func comecar_conversa():
	print("NPC Fase 2: Falando...")
	$Guts.pode_mover = false
	var caixa = DialogoScene.instantiate()
	interface_layer.add_child(caixa)
	# Aqui você poderia mudar o texto do NPC para algo novo se quisesse
	caixa.tree_exited.connect(func(): $Guts.pode_mover = true)

func ativar_puzzle():
	if puzzle_ativo != null: return

	print("Abrindo Puzzle da Fase 2...")
	$Guts.pode_mover = false
	
	# Instancia o PUZZLE NOVO (Level 2)
	puzzle_ativo = PuzzleScene.instantiate()
	interface_layer.add_child(puzzle_ativo)
	
	# Centraliza (Full Rect)
	puzzle_ativo.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	puzzle_ativo.puzzle_resolvido.connect(desativar_puzzle)

func desativar_puzzle():
	if puzzle_ativo != null:
		puzzle_ativo.queue_free()
		puzzle_ativo = null
		$Guts.pode_mover = true
		if door: door.abrir()
