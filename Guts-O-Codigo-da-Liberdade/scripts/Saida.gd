# ExitZone.gd
extends Area2D

# --- A MÁGICA DO @EXPORT ---
# Ao colocar @export, essa variável aparece na aba Inspetor do Godot!
# O filtro "*.tscn" faz com que ele só aceite arquivos de cena.
@export_file("*.tscn") var proxima_cena

func _ready():
	body_entered.connect(_ao_entrar_na_saida)

func _ao_entrar_na_saida(body):
	if body.name == "Guts":
		# Verifica se você esqueceu de colocar a cena no Inspetor
		if proxima_cena == null or proxima_cena == "":
			print("ERRO: Você esqueceu de definir a próxima cena no Inspetor!")
			return
			
		print("Passando de fase...")
		get_tree().change_scene_to_file(proxima_cena)
