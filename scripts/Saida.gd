extends Area2D

# --- A MÁGICA DO @EXPORT ---
@export_file("*.tscn") var proxima_cena

func _ready():
	body_entered.connect(_ao_entrar_na_saida)

func _ao_entrar_na_saida(body):
	# RECOMENDAÇÃO: Use is_in_group("player") se você adicionou o nó Guts ao grupo 'player'.
	# Se não o fez, pode continuar a usar body.name == "Guts".
	if body.name == "Guts": 
		
		if proxima_cena == null or proxima_cena == "":
			print("ERRO: Você esqueceu de definir a próxima cena no Inspetor!")
			return
			
		print("Passando de fase...")
		
		# CORREÇÃO: Chamamos a função 'mudar_cena' de forma diferida.
		# Isso impede que o nó de colisão seja removido durante o cálculo de física.
		call_deferred("mudar_cena") 
		
# NOVO: Esta função fará a mudança de cena no próximo ciclo seguro.
func mudar_cena():
	get_tree().change_scene_to_file(proxima_cena)
