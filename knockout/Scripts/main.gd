extends Node

@onready var player: CharacterBody3D = $Player
@onready var hud: CanvasLayer = $Player/Primeira_Pessoa/Hud
@onready var gerencia_som: Node = $gerencia_som

func  _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

func conectar_sinais_inimigo(inimigo):
	inimigo.Enemy_Health_Bar.connect(hud._on_inimigo_enemy_health_bar) 
	inimigo.Enemy_Name.connect(hud._on_inimigo_enemy_name) 
	inimigo.hit.connect(player._on_inimigo_hit)
	inimigo.knockback.connect(player._on_inimigo_knockback)
	inimigo.attack_sound.connect(gerencia_som._on_inimigo_attack_sound)
	player.get_node("gerencia_bracos").colisao.connect(inimigo._on_gerencia_bracos_colisao)
	
func _on_gerencia_spawn_spawn() -> void:
	for inimigo in get_tree().get_nodes_in_group("Inimigos"):
		conectar_sinais_inimigo(inimigo)
