extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var player: CharacterBody3D = $"../Player"


func _physics_process(delta: float) -> void:
	if player:
		$NavigationAgent3D.target_position = player.position
		if !$NavigationAgent3D.is_navigation_finished():
			velocity += velocidade * position.direction_to($NavigationAgent3D.target_position).normalized() * Vector3(1,0,1)
			animation_player.play("Run")
		look_at(player.position)
	#if randf() > 0.5:
		#velocity += velocidade * Vector3.FORWARD
		#animation_player.play("Run")
	#else:
		#velocity += velocidade * Vector3.BACK
		#animation_player.play("Run")
	move_and_slide()
