# DialogoBox.gd
extends CanvasLayer

@onready var texto_label = $Panel/Label # Ajuste o caminho se necessário
@onready var painel = $Panel

# Lista de frases que o NPC vai falar
var falas = [
	"Ancião: Pelos deuses! O Necromante Zorthar bloqueou a passagem.",
	"Ancião: Este é um selo mágico antigo. Ele usa a Cifra de César.",
	"Ancião: O padrão é simples: ele avançou 3 casas no alfabeto.",
	"Ancião: Se você ver um 'D', na verdade é um 'A'.",
	"Ancião: Vá até o Oráculo, traduza a frase 'R VHOR...' e o caminho se abrirá!"
]

var indice_fala = 0

func _ready():
	mostrar_fala()

func _input(event):
	# Passa para a próxima fala ao apertar Espaço ou Enter
	if event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"):
		proxima_fala()

func mostrar_fala():
	if indice_fala < falas.size():
		texto_label.text = falas[indice_fala]
	else:
		# Acabaram as falas, fecha a caixa
		queue_free()
		# Aqui poderíamos avisar o World que o dialogo acabou para destravar o Guts

func proxima_fala():
	indice_fala += 1
	mostrar_fala()
