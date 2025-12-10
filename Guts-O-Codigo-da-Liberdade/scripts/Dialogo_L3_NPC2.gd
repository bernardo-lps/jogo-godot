extends CanvasLayer
@onready var texto_label = $Panel/Label 
var falas = [
	"Prisioneiro: O código é uma inversão total!",
	"Prisioneiro: A letra 'A' vira 'Z'. A letra 'B' vira 'Y'.",
	"Prisioneiro: A profecia para derrotá-lo começa com 'URN WZ...'",
	"Prisioneiro: Traduza 'FIM DA...' e acabe com essa noite eterna!"
]
# (Copie o resto das funções _ready, _input, mostrar e proximo do script acima, é igual)
var indice = 0
func _ready(): mostrar()
func _input(event): if event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"): proximo()
func mostrar(): 
	if indice < falas.size(): texto_label.text = falas[indice]
	else: queue_free()
func proximo(): indice += 1; mostrar()
