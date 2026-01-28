extends Marker3D

@export var cena_inimigo2: PackedScene
@export var cena_inimigo3 : PackedScene
@onready var timer: Timer = $Timer
@onready var player: CharacterBody3D = $"../Player"
@onready var hud: CanvasLayer = $"../Player/Primeira_Pessoa/Hud"

var inimigo_atual : int = 2

signal spawn
#@export var cena_inimigo4 : PackedScene
#@export var cena_inimigo5 : PackedScene

func enemy_spawn() -> void:
	var novo_inimigo
	match inimigo_atual:
		2: novo_inimigo = cena_inimigo2.instantiate()
		3: novo_inimigo = cena_inimigo3.instantiate()
		4: pass
		5: pass
	if novo_inimigo:
		novo_inimigo.position = global_position
		get_parent().add_child(novo_inimigo)
		novo_inimigo.dead.connect(_on_inimigo_dead)
		inimigo_atual += 1
		
func _on_inimigo_dead() -> void:
	timer.start()

func _on_timer_timeout() -> void:
	enemy_spawn()
	spawn.emit()
