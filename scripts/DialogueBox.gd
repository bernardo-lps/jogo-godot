# DialogoBox.gd
extends CanvasLayer

@onready var texto_label = $Panel/Label # Ajuste o caminho se necessário
@onready var painel = $Panel

# Lista de frases que o NPC vai falar
var falas = [
	"Guts, meu jovem... O Reino de Enigmatia sucumbiu às sombras. O Necromante Zorthar selou nossas passagens com runas de confusão.",
	"Este é o Selo do Princípio. Para quebrá-lo, deves usar a Cifra de César.",
	"Imagine que o alfabeto é uma engrenagem: para cada letra do código, deves saltar três casas à frente para encontrar a verdadeira.",
	"O pergaminho diz GHVWLQR. Traduza-o com a chave do 'Três' e aceite o seu papel nesta jornada. O seu futuro depende disso!",
	
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
