extends CanvasLayer
@onready var texto_label = $Panel/Label 
var falas = [
	"Prisioneiro: Você chegou ao coração das trevas...",
	"Prisioneiro: Zorthar trancou a sala do trono com o 'Código Espelho'.",
	"Prisioneiro: Ele inverteu tudo. O Princípio é o Fim.",
	"Prisioneiro: Fale com o outro prisioneiro para entender a chave."
]
var indice = 0
func _ready(): mostrar()
func _input(event): if event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"): proximo()
func mostrar(): 
	if indice < falas.size(): texto_label.text = falas[indice]
	else: queue_free()
func proximo(): indice += 1; mostrar()
