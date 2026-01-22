extends Node

signal colisao
var soco : bool = false

func _on_colisao_bd_body_entered(body: Node3D) -> void:
	if soco and body:
		colisao.emit('soco')
		soco = false

func _on_colisao_be_body_entered(body: Node3D) -> void:
	if soco and body:
		colisao.emit('soco')
		soco = false

func _on_player_punch(arg : String) -> void:
	if arg == 'soco':
		soco = true
	if arg == '!soco':
		soco = false
		
