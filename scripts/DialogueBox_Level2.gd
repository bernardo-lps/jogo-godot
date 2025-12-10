# DialogueBox_Level2.gd
extends CanvasLayer

@onready var texto_label = $Panel/Label 
@onready var painel = $Panel

# --- ROTEIRO DA FASE 2 (COM A NOVA REGRA) ---
var falas = [
		"Surpreendente! Você sobreviveu à primeira barreira. Mas agora entramos nos domínios do Mago do Tempo, o aliado mais fiel de Zorthar.",
		"Aqui, a magia é mais densa.", 
		"Ele usa a Mão do Mago: assim como temos cinco dedos, o código exige que você avance cinco passos no alfabeto.",
		"As runas brilham com a frase WZTRF XJQQJ. Não se perca no tempo",
		"Guts! Avance cinco casas e mantenha o seu passo firme em direção ao inimigo!",
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
