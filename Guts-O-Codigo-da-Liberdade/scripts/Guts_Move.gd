# Guts_Move.gd
extends CharacterBody2D

# --- Variáveis ---
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pode_mover = true 

# Referência ao Nó de Animação (NOVO)
# O $AnimatedSprite2D busca o nó filho com esse nome exato
@onready var anim = $AnimatedSprite2D 

func _physics_process(delta):
	if not pode_mover:
		velocity.x = 0
		anim.play("idle") # (NOVO) Se não pode mover, fica parado
		move_and_slide()
		return

	# 1. Gravidade e Pulo
	if not is_on_floor():
		velocity.y += gravity * delta
		anim.play("jump") # (NOVO) Se está no ar, toca animação de pulo

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 2. Movimento Horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		
		# (NOVO) Lógica de Animação e Direção
		if is_on_floor():
			anim.play("run") # Corre se estiver no chão
			
		# (NOVO) Vira o personagem para esquerda ou direita
		if direction < 0:
			anim.flip_h = true # Vira para a esquerda
		else:
			anim.flip_h = false # Vira para a direita (original)
			
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		# (NOVO) Se parou e está no chão, toca idle
		if is_on_floor():
			anim.play("idle")

	move_and_slide()
