# World.gd
extends Node2D

# 1. PRÉ-CARREGAMENTO DAS CENAS (IMPORTANTE!)
# Carrega a cena do Puzzle
const CifraCesarScene = preload("res://scenes/CifraCesar.tscn")

# (CORREÇÃO) Carrega a cena do Diálogo. 
# Verifique se o caminho "res://scenes/DialogoBox.tscn" está certo. 
# Se você salvou na pasta raiz, apague o "scenes/".
const DialogoScene = preload("res://scenes/DialogueBox.tscn") 

var puzzle_ativo = null

# REFERÊNCIAS AOS NÓS NA CENA WORLD:
@onready var Oracle = $Oracle
@onready var interface_layer = $InterfaceLayer
@onready var door = $Door
@onready var npc = $NPC

func _ready():
	# Conecta o sinal do Oráculo
	if Oracle:
		Oracle.pedir_puzzle.connect(ativar_puzzle)
	else:
		print("ERRO: Nó 'Oracle' não encontrado.")
		
	# Conecta o sinal do NPC
	if npc:
		npc.iniciar_dialogo.connect(comecar_conversa)
	else:
		print("AVISO: Nó 'NPC' não encontrado.")

# Função que roda quando falamos com o NPC
func comecar_conversa():
	print("Iniciando diálogo visual...")
	
	# Trava o Guts
	$Guts.pode_mover = false
	
	# (CORREÇÃO AQUI)
	# Usamos a constante 'DialogoScene' que carregamos lá em cima
	var caixa_dialogo = DialogoScene.instantiate()
	
	# Adiciona na tela (InterfaceLayer)
	interface_layer.add_child(caixa_dialogo)
	
	# Conecta o sinal para saber quando o diálogo fechou (saiu da árvore)
	caixa_dialogo.tree_exited.connect(_fim_da_conversa)

func _fim_da_conversa():
	# Destrava o Guts quando o diálogo acaba
	$Guts.pode_mover = true
	print("Conversa encerrada.")

func ativar_puzzle():
	if puzzle_ativo != null:
		return

	print("Ativando Puzzle...")
	$Guts.pode_mover = false
	
	puzzle_ativo = CifraCesarScene.instantiate()
	interface_layer.add_child(puzzle_ativo)
	
	puzzle_ativo.set_anchors_preset(Control.PRESET_FULL_RECT)
	
	puzzle_ativo.puzzle_resolvido.connect(desativar_puzzle)

func desativar_puzzle():
	if puzzle_ativo != null:
		puzzle_ativo.queue_free()
		puzzle_ativo = null
		
		$Guts.pode_mover = true
		
		if door != null:
			print("Puzzle vencido! Abrindo a porta...")
			door.abrir()
