extends Node

func _on_gerencia_bracos_colisao(arg: String, dano: int) -> void:
	if arg == 'soco' and dano < 100:
		if randf() < 0.5:
			$Som_Soco1.play()
		else :
			$Som_Soco2.play()
	elif arg == 'soco' and dano == 100:
		$Som_Soco9.play()


func _on_inimigo_attack_sound() -> void:
	if randf() < 0.5:
		$Som_Soco3.play()
	else :
		$Som_Soco4.play()
		
