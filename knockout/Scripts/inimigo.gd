class_name Inimigo
extends CharacterBody3D

@export var velocidade: float
@onready var animation_player: AnimationPlayer = $"3DGodotRobot/AnimationPlayer"
@onready var player: CharacterBody3D = $"../Player"
@export var empurrao : float 
@export var dano : int
@export var nome : String
@export var vida : int
@export var velocidade_ataque : float
var target_pos : Vector3
var cooldown : float

signal hit
signal knockback
signal Enemy_Health_Bar
signal Enemy_Name
signal attack_sound
signal dead

func _ready() -> void:
	cooldown = 0
	vida = 100
	Enemy_Health_Bar.emit(vida)
	Enemy_Name.emit(nome)
	
func _physics_process(delta: float) -> void:
	Enemy_Health_Bar.emit(vida)
	Enemy_Name.emit(nome)
	#var v = Vector3.ZERO
	if player:
		target_pos = player.position
		$NavigationAgent3D.target_position = target_pos
		if !$NavigationAgent3D.is_navigation_finished():
			velocity = movimenta()
		if position.distance_to(target_pos) < 2 and cooldown > velocidade_ataque:
			ataque()
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

func movimenta() -> Vector3:
	animation_player.play("Run")
	look_at(target_pos)
	return velocidade * (position.direction_to($NavigationAgent3D.get_next_path_position()).normalized()) * Vector3(1,0,1)

func ataque() -> void:
	animation_player.play("Attack1")

func _on_colision_controller_attack(arg : String) -> void:
	if arg == "dano" and animation_player.current_animation == "Attack1":
		#print("HIT")
		hit.emit(dano)
		attack_sound.emit()
		if randf() > 0.7:
			knockback.emit(empurrao,basis.z)

func _on_gerencia_bracos_colisao(_arg: String, dano: int) -> void:
	if dano > 0:
		vida -= dano
		$GPUParticles3D.restart()
	Enemy_Health_Bar.emit(vida)
	if vida <= 0:
		dead.emit()
		Enemy_Health_Bar.emit(vida)
		queue_free()
