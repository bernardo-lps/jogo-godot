extends Node2D

const PuzzleScene = preload("res://scenes/Puzzle_Level3.tscn")
const Dialogo1 = preload("res://scenes/Dialogo_L3_NPC1.tscn")

var puzzle_ativo = null

# --- NOVO: Lógica de Fragmentos ---
var fragmentos_coletados = 0
const TOTAL_LIVROS = 3

# Referências atualizadas para a nova estrutura
@onready var container_livros = $Livros # Referência para a pasta nova
@onready var interface_layer = $InterfaceLayer
@onready var door = $Door
@onready var npc1 = $NPC

func _ready():
	# 1. Conecta o NPC
	if npc1: npc1.iniciar_dialogo.connect(conversa_npc1)
	
	# 2. Conecta todos os livros dentro da pasta "Livros"
	if container_livros:
		for livro in container_livros.get_children():
			if livro.has_signal("pedir_puzzle"):
				# Conecta o sinal de cada livro à função de abrir o puzzle
				livro.pedir_puzzle.connect(ativar_puzzle)
				print("Livro conectado: ", livro.name)
	else:
		print("ERRO: Nó 'Livros' não encontrado na cena!")

func conversa_npc1():
	abrir_dialogo(Dialogo1)

func abrir_dialogo(cena_dialogo):
	if has_node("Guts"): $Guts.pode_mover = false
	var caixa = cena_dialogo.instantiate()
	interface_layer.add_child(caixa)
	caixa.tree_exited.connect(func(): if has_node("Guts"): $Guts.pode_mover = true)

# Recebe os dados do Oracle_Fragmento.gd
func ativar_puzzle(enigma, senha):
	if puzzle_ativo != null: return
	
	if has_node("Guts"): $Guts.pode_mover = false
	puzzle_ativo = PuzzleScene.instantiate()
	interface_layer.add_child(puzzle_ativo)
	puzzle_ativo.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	# Passa o enigma e a senha para a tela do puzzle
	puzzle_ativo.configurar_puzzle(enigma, senha)
	puzzle_ativo.puzzle_resolvido.connect(desativar_puzzle)

# Adicionamos '_fase = ""' para aceitar o dado enviado pelo puzzle unificado
func desativar_puzzle(_fase = ""): 
	if puzzle_ativo != null:
		puzzle_ativo.queue_free()
		puzzle_ativo = null
		
		# Esta é a linha que faz o Guts voltar a andar!
		if has_node("Guts"): 
			$Guts.pode_mover = true 
			print("Guts liberado para mover!")
		
		# Lógica dos fragmentos continua igual...
		fragmentos_coletados += 1
		if fragmentos_coletados >= TOTAL_LIVROS:
			if door: door.abrir()
