extends StaticBody2D

# --- Caminhos para os nós filhos ---
@onready var animacao = $AnimatedSprite2D
@onready var colisao = $CollisionShape2D

func abrir():
	print("DEBUG: A porta está a abrir...")
	
	# 1. Desativa a colisão IMEDIATAMENTE.
	colisao.set_deferred("disabled", true) 
	
	# 2. Toca a animação de abertura. (Usando 'open' em minúsculas)
	animacao.play("open") 

# Esta função será chamada após conectar o sinal 'animation_finished' do AnimatedSprite2D.
func _on_animated_sprite_2d_animation_finished():
	# Esta função é chamada automaticamente quando a animação 'open' termina.
	if animacao.animation == "open":
		# Se você quer que a porta fique PERMANENTEMENTE ABERTA (apenas visual), mantenha esta linha:
		animacao.stop()
		
		# Se você quer que a porta SUMA após a abertura, DESCOMENTE a linha abaixo:
		# queue_free()
