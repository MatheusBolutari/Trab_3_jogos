extends CharacterBody3D

@export var velocidade: float
@export var velocidade_olho: float
@onready var primeira_pessoa: Camera3D = $Primeira_Pessoa
@onready var terceira_pessoa: Camera3D = $Terceira_Pessoa

var orientacao_base: Quaternion
var mouse_h = 0
var mouse_v = 0
var sprint = 0
var dt = 0
var soco = 0

var bloqueando: bool = false
var socando: bool = false

signal block
signal punch


func _ready() -> void:
	orientacao_base = quaternion

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_h += event.relative.x
		mouse_v = clampf(mouse_v + event.relative.y, -90, 90)

func _physics_process(delta: float) -> void:
	var dx = Input.get_axis("Esquerda","Direita")
	var dz = Input.get_axis("Frente","Atras")
	
	var angle_y = mouse_h * velocidade_olho * delta
	var angle_x = mouse_v * velocidade_olho * delta
	var rot_y = Quaternion(Vector3.UP, -angle_y)
	var rot_x = Quaternion(Vector3.LEFT, angle_x)
	
	if Input.is_action_just_pressed("Sprint"):
		sprint = 10
	if Input.is_action_just_released("Sprint"):
		sprint = 0
	
	if Input.is_action_just_pressed("Socar"):
		if soco == 0 and !$AnimationPlayer.is_playing() and !bloqueando:
			$AnimationPlayer.play("SocoD")
			punch.emit('soco')
			socando = true
			if randf() < 0.7:
				soco = 1
			else:
				soco = 0
		elif soco == 1 and !$AnimationPlayer.is_playing() and !bloqueando:
			$AnimationPlayer.play("SocoE")
			punch.emit('soco')
			socando = true
			if randf() < 0.7:
				soco = 0
			else:
				soco = 1
	if !$AnimationPlayer.is_playing():
		punch.emit('!soco')
	if Input.is_action_just_pressed("Bloquear"):
		$AnimationPlayer.play("Levantar_Bloqueio")
		bloqueando = true
		block.emit()
	if Input.is_action_just_released("Bloquear"):
		$AnimationPlayer.play("Abaixar_Bloqueio")
		bloqueando = false
		
	if Input.is_action_just_pressed("Trocar_Camera"):
		if primeira_pessoa.current:
			terceira_pessoa.make_current()
		else :
			primeira_pessoa.make_current()
	
	var direction = (transform.basis.x * dx + transform.basis.z * dz)
	direction = direction.normalized()
	
	velocity.x = direction.x * (velocidade + sprint)
	velocity.z = direction.z * (velocidade + sprint)

	quaternion = orientacao_base * rot_y
	#print(orientacao_base)
	move_and_slide()
	quaternion *= rot_x
	dt += delta
