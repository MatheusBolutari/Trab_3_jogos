extends Inimigo

@export var velocidade_animacao: float

func movimenta() -> Vector3:
	animation_player.play("T-pose")
	rotate(Vector3.UP, 45)
	return velocidade * (position.direction_to($NavigationAgent3D.get_next_path_position()).normalized()) * Vector3(1,0,1)

func ataque() -> void:
	animation_player.speed_scale = velocidade_animacao
	animation_player.play("Attack1")
