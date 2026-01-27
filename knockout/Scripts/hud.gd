extends CanvasLayer

@onready var barra_de_vida_player: ProgressBar = $"Barra de Vida Player"
@onready var nome_inimigo: Label = $"Barra de Vida Inimigo/Nome Inimigo"
@onready var barra_de_vida_inimigo: ProgressBar = $"Barra de Vida Inimigo"

func _on_player_health_bar(vida: int) -> void:
	barra_de_vida_player.value = vida

func _on_inimigo_enemy_name(nome: String) -> void:
	nome_inimigo.text = nome

func _on_inimigo_enemy_health_bar(vida: int) -> void:
	barra_de_vida_inimigo.value = vida
