extends CharacterBody2D

# --- Variáveis ---
const SPEED = 200.0
const JUMP_VELOCITY = -400.0
# Usamos esta variável 'gravity' que é um número (float)
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var pode_mover = true 

@onready var anim = $AnimatedSprite2D 

func _physics_process(delta):
	if not pode_mover:
		velocity.x = 0
		if not is_on_floor():
			# CORREÇÃO CRÍTICA (Linha 18): Usamos a variável 'gravity' (float) 
			# em vez da função 'get_gravity()' (Vector2) para evitar o crash
			velocity.y += gravity * delta 
		else:
			velocity.y = 0
		
		anim.play("idle") 
		move_and_slide()
		return # Sai da função para ignorar comandos de pulo/andar

	# 1. Gravidade e Pulo (Quando está a mover-se)
	if not is_on_floor():
		velocity.y += gravity * delta
		anim.play("jump") 

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# 2. Movimento Horizontal
	var direction = Input.get_axis("ui_left", "ui_right")
	
	if direction:
		velocity.x = direction * SPEED
		if is_on_floor():
			anim.play("run") 
			
		if direction < 0:
			anim.flip_h = true 
		else:
			anim.flip_h = false 
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		if is_on_floor():
			anim.play("idle")

	move_and_slide()
