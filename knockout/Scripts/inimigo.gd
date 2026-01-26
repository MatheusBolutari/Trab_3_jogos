extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var player: CharacterBody3D = $"../Player"
@export var empurrao : float 
var target_pos : Vector3

signal hit
signal knockback

func _physics_process(delta: float) -> void:
	#var v = Vector3.ZERO
	if player:
		target_pos = player.position
		$NavigationAgent3D.target_position = target_pos
		if !$NavigationAgent3D.is_navigation_finished():
			velocity = velocidade * (position.direction_to($NavigationAgent3D.get_next_path_position()).normalized()) * Vector3(1,0,1)
			animation_player.play("Run")
			look_at(target_pos)
		if position.distance_to(target_pos) < 2:
			animation_player.play("Attack1")
	elif !player:
		if randf() > 0.5:
			velocity = velocidade * Vector3.FORWARD
			animation_player.play("Run")
		else:
			velocity = velocidade * Vector3.BACK
			animation_player.play("Run")
	move_and_slide()
	#translate(v)

func _on_colision_controller_attack(arg : String) -> void:
	if arg == "dano":
		print("HIT")
		hit.emit()
		if randf() > 0.6:
			knockback.emit(empurrao)
