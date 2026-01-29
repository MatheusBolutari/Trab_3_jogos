extends Node

@onready var player: CharacterBody3D = $Player
@onready var hud: CanvasLayer = $Player/Primeira_Pessoa/Hud
@onready var gerencia_som: Node = $gerencia_som
var cena_final = load("res://Cenas/tela_vitoria.tscn")
var cena_game_over = load("res://Cenas/game_over.tscn")
@onready var delay_fim: Timer = $Delay_fim
@onready var deley_gameover: Timer = $Deley_gameover

signal tg_ui

func  _ready() -> void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event: InputEvent) -> void:
	if event.is_action_pressed("ui_cancel"):
		if Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
			Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			tg_ui.emit('ativa')
		else:
			Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
			tg_ui.emit('desativa')

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

func _on_gerencia_spawn_the_end() -> void:
	delay_fim.start(0.5)

func _on_delay_fim_timeout() -> void:
	get_tree().change_scene_to_packed(cena_final)

func _on_player_player_dead() -> void:
	deley_gameover.start(0.01)

func _on_deley_gameover_timeout() -> void:
	get_tree().change_scene_to_packed(cena_game_over)
