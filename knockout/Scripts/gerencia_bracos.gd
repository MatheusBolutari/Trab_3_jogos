extends Node

signal colisao
var soco : bool = false
var dano : int = 0

func _on_colisao_bd_body_entered(body: Node3D) -> void:
	if soco and body.is_in_group("Inimigos"):
		colisao.emit('soco', dano)
		soco = false
	if soco and body.is_in_group("Cenario"):
		colisao.emit('soco', 0)
		soco = 0

func _on_colisao_be_body_entered(body: Node3D) -> void:
	if soco and body.is_in_group("Inimigos"):
		colisao.emit('soco', dano)
		soco = false
	if soco and body.is_in_group("Cenario"):
		colisao.emit('soco', 0)
		soco = 0

func _on_player_punch_sound(arg: String) -> void:
	if arg == 'soco':
		soco = true
	if arg == '!soco':
		soco = false

func _on_player_punch_damage(dano: int) -> void:
	self.dano = dano
