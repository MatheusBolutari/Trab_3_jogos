extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"


func _physics_process(delta: float) -> void:
	if randf() > 0.5:
		velocity += velocidade * Vector3.FORWARD
		animation_player.play("Run")
	else:
		velocity += velocidade * Vector3.BACK
		animation_player.play("Run")
	move_and_slide()
