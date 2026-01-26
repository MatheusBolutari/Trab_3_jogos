extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var player: CharacterBody3D = $"../Player"

var target_pos : Vector3

signal hit

func _physics_process(delta: float) -> void:
	if player:
		target_pos = player.position
		$NavigationAgent3D.target_position = target_pos
		if !$NavigationAgent3D.is_navigation_finished() and position.distance_to(target_pos) >= 2:
			velocity += velocidade * position.direction_to($NavigationAgent3D.target_position).normalized() * Vector3(1,0,1)
			animation_player.play("Run")
		look_at(player.position)
		if position.distance_to(target_pos) < 2:
			animation_player.play("Attack1")
	elif !player:
		if randf() > 0.5:
			velocity += velocidade * Vector3.FORWARD
			animation_player.play("Run")
		else:
			velocity += velocidade * Vector3.BACK
			animation_player.play("Run")
	move_and_slide()

func _on_colision_controller_attack(arg : String) -> void:
	if arg == "dano":
		print("HIT")
		hit.emit()
