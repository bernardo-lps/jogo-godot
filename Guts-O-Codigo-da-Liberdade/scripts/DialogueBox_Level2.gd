# DialogueBox_Level2.gd
extends CanvasLayer

@onready var texto_label = $Panel/Label 
@onready var painel = $Panel

# --- ROTEIRO DA FASE 2 (COM A NOVA REGRA) ---
var falas = [
	"Ancião: Excelente! Quebramos a primeira defesa.",
	"Ancião: Mas Zorthar não é bobo. Ele deixou instruções para seus servos.",
	"Ancião: Precisamos saber para onde ele fugiu.",
	"Ancião: Cuidado: A chave mudou! Veja o símbolo da Mão Aberta no selo.",
	"Ancião: Uma mão tem 5 dedos... Agora volte 5 casas para traduzir!",
	"Ancião: A mensagem é 'WZRT...'. Descubra o destino dele!"
]

var indice_fala = 0

func _ready():
	mostrar_fala()

func _input(event):
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"):
		proxima_fala()

func mostrar_fala():
	if indice_fala < falas.size():
		texto_label.text = falas[indice_fala]
	else:
		queue_free() # Fecha o diálogo

func proxima_fala():
	indice_fala += 1
	mostrar_fala()
