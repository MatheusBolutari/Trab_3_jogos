extends Node

func _on_gerencia_bracos_colisao(arg : String) -> void:
	if arg == 'soco':
		$Som_Soco1.play()
