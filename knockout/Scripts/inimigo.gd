extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var player: CharacterBody3D = $"../Player"
@export var empurrao : float 
@export var dano : int
var target_pos : Vector3
var cooldown : float

signal hit
signal knockback

func _ready() -> void:
	cooldown = 0
	
func _physics_process(delta: float) -> void:
	#var v = Vector3.ZERO
	if player:
		target_pos = player.position
		$NavigationAgent3D.target_position = target_pos
		if !$NavigationAgent3D.is_navigation_finished():
			velocity = velocidade * (position.direction_to($NavigationAgent3D.get_next_path_position()).normalized()) * Vector3(1,0,1)
			animation_player.play("Run")
			look_at(target_pos)
		if position.distance_to(target_pos) < 2 and cooldown > 1.5:
			animation_player.play("Attack1")
			cooldown = 0
	elif !player:
		if randf() > 0.5:
			velocity = velocidade * Vector3.FORWARD
			animation_player.play("Run")
		else:
			velocity = velocidade * Vector3.BACK
			animation_player.play("Run")
	move_and_slide()
	cooldown += delta
	#translate(v)

func _on_colision_controller_attack(arg : String) -> void:
	if arg == "dano" and animation_player.current_animation == "Attack1":
		print("HIT")
		hit.emit(dano)
		if randf() > 0.7:
			knockback.emit(empurrao,basis.z)
