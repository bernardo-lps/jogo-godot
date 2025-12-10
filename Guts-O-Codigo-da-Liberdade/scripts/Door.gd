## Door.gd
extends StaticBody2D

func abrir():
	print("DEBUG: A porta recebeu o comando de abrir e vai sumir agora!")
	
	# Esta função remove o nó do jogo imediatamente (Visual + Colisão)
	queue_free()
