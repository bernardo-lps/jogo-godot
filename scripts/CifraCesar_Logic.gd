extends Control

signal puzzle_resolvido(fase_nome)

@onready var label_enunciado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label
@onready var input_resposta = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/LineEdit
@onready var botao_verificar = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Button
@onready var label_resultado = $CenterContainer/PanelContainer/MarginContainer/VBoxContainer/Label2

# --- DADOS DE PUZZLE UNIFICADOS ---
var PUZZLE_DATA = {
	"World": {
		"titulo": "QUEBRE O SELO (CHAVE +3):",
		"enigma": "GHVWLQR",
		"resposta_interna": "DESTINO",
		"dica_erro": "ERRADO. Volte 3 casas no alfabeto."
	},
	"Level2": {
		"titulo": "A MÃO DO MAGO (CHAVE +5):",
		"enigma": "WZTRF XJQQJ",
		"resposta_interna": "RUMOATORRE",
		"dica_erro": "ERRADO. A mão do mago tem 5 dedos."
	},
	"Level3": {
		"titulo": "DECODE FRAGMENTO (A=Z):",
		"enigma": "FRAGMENTO",
		"resposta_interna": "PADRAO",
		"dica_erro": "ERRADO. Tente o reflexo (A=Z)."
	},
}

func _ready():
	var cena_pai_nome = get_tree().current_scene.name
	var fase_encontrada = ""
	
	if cena_pai_nome == "World": fase_encontrada = "World"
	elif cena_pai_nome.contains("Level2"): fase_encontrada = "Level2"
	elif cena_pai_nome.contains("Level3"): fase_encontrada = "Level3"
	
	if not fase_encontrada.is_empty():
		configurar_visual(fase_encontrada)
	else:
		configurar_visual("World") 

	if botao_verificar:
		botao_verificar.pressed.connect(_ao_clicar_verificar)

func configurar_visual(fase_nome: String):
	var data = PUZZLE_DATA[fase_nome]
	label_enunciado.text = data.titulo + "\n\n" + data.enigma
	input_resposta.placeholder_text = "Digite a tradução..."
	input_resposta.grab_focus() 
	label_resultado.text = "" 

# --- CORREÇÃO AQUI: Limpa a senha vinda do livro (Fase 3) ---
func configurar_puzzle(enigma, senha):
	if label_enunciado:
		label_enunciado.text = "FRAGMENTO DO ESPELHO (A=Z):\n\n" + enigma
	
	# Transforma "A LUZ" em "ALUZ" antes de guardar no dicionário
	var senha_processada = senha.to_upper().replace(" ", "").strip_edges()
	
	PUZZLE_DATA["Level3"].enigma = enigma
	PUZZLE_DATA["Level3"].resposta_interna = senha_processada
	configurar_visual("Level3")

func _ao_clicar_verificar():
	var cena_pai_nome = get_tree().current_scene.name
	var fase_encontrada = ""
	
	if cena_pai_nome == "World": fase_encontrada = "World"
	elif cena_pai_nome.contains("Level2"): fase_encontrada = "Level2"
	elif cena_pai_nome.contains("Level3"): fase_encontrada = "Level3"
		
	if fase_encontrada.is_empty(): return 
		
	var data = PUZZLE_DATA[fase_encontrada]
	
	# Transforma o que o jogador digitou em "ALUZ" para comparar
	var texto_jogador = input_resposta.text.to_upper().replace(" ", "").strip_edges()
	
	if texto_jogador == data.resposta_interna:
		label_resultado.text = "CORRETO! O selo foi purificado."
		label_resultado.modulate = Color.GREEN
		puzzle_resolvido.emit(fase_encontrada) 
		botao_verificar.disabled = true
		await get_tree().create_timer(1.0).timeout
		queue_free()
	else:
		label_resultado.text = data.dica_erro
		label_resultado.modulate = Color.RED

func _on_button_pressed() -> void:
	pass # Replace with function body.
