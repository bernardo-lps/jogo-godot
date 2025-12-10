extends CanvasLayer
@onready var texto_label = $Panel/Label 
var falas = [
	"Guts! Você chegou aos portões da Necrópole de Zorthar.",
	"O Necromante usou sua magia negra mais poderosa para trancar a entrada: o Selo de Cristal.",
	"Para romper este selo, força bruta não basta.",
	"Você deve recuperar os Três Fragmentos da Essência Mística protegidos pelos Oráculos.",
	"Somente unindo o poder dessas três relíquias teremos força para confrontar o vilão!",
	"O código desta fase é o Reflexo de Atbash.",
	"O alfabeto se olha no espelho: a primeira letra vira a última. O 'A' torna-se 'Z'. O 'B' torna-se 'Y'.",
	"Purifique os fragmentos refletindo a verdade e a porta da torre enfim se abrirá!",
]
var indice = 0
func _ready(): mostrar()
func _input(event): if event.is_action_pressed("ui_accept") or event.is_action_pressed("Interact"): proximo()
func mostrar(): 
	if indice < falas.size(): texto_label.text = falas[indice]
	else: queue_free()
func proximo(): indice += 1; mostrar()
