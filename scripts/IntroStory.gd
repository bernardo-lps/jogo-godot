extends Control

# Caminho para a primeira fase (ajuste se necessário)
const PRIMEIRA_FASE = "res://scenes/World.tscn"

# --- PÁGINAS DA HISTÓRIA E EDUCAÇÃO ---
var paginas = [
	# Página 1: História (Lore)
	"O Reino de Veridia caiu nas sombras...\n\nO Necromante Zorthar bloqueou todas as passagens com selos mágicos baseados em códigos antigos. Nossos exércitos estão presos e a esperança se apaga.",
	
	# Página 2: O Desafio (Lore)
	"Guts, sua missão é infiltrar-se nas linhas inimigas e quebrar os selos que bloqueiam o caminho.\n\nMas cuidado: os selos são protegidos pela CRIPTOGRAFIA — a ciência de esconder mensagens através de códigos secretos.",
	
	# Página 3: O que é Criptografia? (Educação)
	"O QUE É CRIPTOGRAFIA?\n\nÉ o uso de técnicas para tornar uma mensagem incompreensível para quem não conhece o segredo. Zorthar usa chaves numéricas para transformar palavras comuns em selos impenetráveis.",
	
	# Página 4: A Cifra de César (Teoria)
	"A CIFRA DE CÉSAR:\n\nÉ uma das técnicas mais antigas. Ela funciona trocando cada letra da mensagem por outra que está algumas posições à frente no alfabeto.\n\nPor exemplo: Com uma chave '3', a letra A vira D, e a letra B vira E.",
	
	# Página 5: Preparação Final
	"Guts, sua lógica será tão importante quanto sua espada. Busque o Ancião nos vilarejos para descobrir as chaves de cada selo.\n\nO destino da guerra está em suas mãos. Inicie a missão!"
]

var pagina_atual = 0

func _ready():
	# Configura a primeira página baseada nos seus nós
	$ColorRect/Label.text = paginas[pagina_atual]
	$ColorRect/Button.text = "PROSSEGUIR"
	
	# Conecta o sinal do seu botão
	$ColorRect/Button.pressed.connect(_avancar_introducao)

func _avancar_introducao():
	pagina_atual += 1
	
	if pagina_atual < paginas.size():
		# Troca o texto para a próxima explicação ou história
		$ColorRect/Label.text = paginas[pagina_atual]
		
		# Muda o texto do botão na última página
		if pagina_atual == paginas.size() - 1:
			$ColorRect/Button.text = "INICIAR JOGO"
	else:
		# Encerra e vai para o World.tscn
		get_tree().change_scene_to_file(PRIMEIRA_FASE)
