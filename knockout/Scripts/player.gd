extends CharacterBody3D

@export var velocidade: float
@export var velocidade_olho: float
@export var dano: int
@onready var primeira_pessoa: Camera3D = $Primeira_Pessoa
@onready var terceira_pessoa: Camera3D = $Terceira_Pessoa #Camera para DEBUG

var direcao_k : Vector3 #knockback
var orientacao_base: Quaternion #camera
var mouse_h: float #camera
var mouse_v: float #camera
var sprint : float #movimentação
var soco : int #controlador animação 0 = Braço Direito e 1 = Braço Esquerdo
var vida: int

var bloqueando: bool #controles
var socando: bool #controle

var knockback : float #knockback
var dx : float #Eixo x de movimentação
var dz : float #Eixo z de movimentação

#signal block
signal punch_sound #controla emissão de som
signal health_bar #controla barra de vida
signal punch_damage #controla dano causado pelo player
signal player_dead #controla quando o player morre


func _ready() -> void:
	mouse_h = 0
	mouse_v = 0
	orientacao_base = quaternion
	vida = 100
	dx = 0
	dz = 0
	knockback = 0
	direcao_k = Vector3.ZERO
	health_bar.emit(vida)
	sprint = 0
	soco = 0
	bloqueando = false
	socando = false

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		mouse_h += event.relative.x
		mouse_v = clampf(mouse_v + event.relative.y, -90, 90)

func _physics_process(delta: float) -> void:
	if knockback == 0:
		dx = Input.get_axis("Esquerda","Direita")
		dz = Input.get_axis("Frente","Atras")
	
	#CAMERA
	var angle_y = mouse_h * velocidade_olho * delta
	var angle_x = mouse_v * velocidade_olho * delta
	var rot_y = Quaternion(Vector3.UP, -angle_y)
	var rot_x = Quaternion(Vector3.LEFT, angle_x)
	
	#SPRINT
	if Input.is_action_just_pressed("Sprint"):
		sprint = 10
	if Input.is_action_just_released("Sprint"):
		sprint = 0
	
	#COMBATE
	if Input.is_action_just_pressed("Socar"):
		if soco == 0 and !$AnimationPlayer.is_playing() and !bloqueando:
			$AnimationPlayer.play("SocoD")
			punch_sound.emit('soco')
			punch_damage.emit(dano)
			socando = true
			if randf() < 0.7:
				soco = 1
			else:
				soco = 0
		elif soco == 1 and !$AnimationPlayer.is_playing() and !bloqueando:
			$AnimationPlayer.play("SocoE")
			punch_sound.emit('soco')
			punch_damage.emit(dano)
			socando = true
			if randf() < 0.7:
				soco = 0
			else:
				soco = 1
	if !$AnimationPlayer.is_playing():
		punch_sound.emit('!soco')
	if Input.is_action_just_pressed("Bloquear"):
		$AnimationPlayer.play("Levantar_Bloqueio")
		bloqueando = true
		#block.emit('bloqueio')
	if Input.is_action_just_released("Bloquear"):
		$AnimationPlayer.play("Abaixar_Bloqueio")
		bloqueando = false
		#block.emit('!bloqueio')
	
	#CAMERA DE DEBUG----------
	if Input.is_action_just_pressed("Trocar_Camera"):
		if primeira_pessoa.current:
			terceira_pessoa.make_current()
		else :
			primeira_pessoa.make_current()
	#--------------------------
	
	#MOVIMENTAÇÃO DO PLAYER E CAMERA
	var direction = (transform.basis.x * dx + transform.basis.z * dz)
	direction = direction.normalized()
	
	velocity.x = direction.x * (velocidade + sprint)
	velocity.z = direction.z * (velocidade + sprint)
	quaternion = orientacao_base * rot_y
	#print(orientacao_base)
	if knockback != 0:
		velocity = direcao_k*(-knockback)*Vector3(1,0,1)*velocidade
		knockback -= 0.5
		if knockback < 0:
			knockback = 0
	
	move_and_slide()
	quaternion *= rot_x


func _on_inimigo_hit(dano : int) -> void:
	if bloqueando:
		vida -= int(dano*0.4)
	else :
		vida -= dano
	health_bar.emit(vida)
	if vida <= 0:
		player_dead.emit()

func _on_inimigo_knockback(empurrao : float, direcao_k : Vector3) -> void:
	self.direcao_k = direcao_k
	if position.x + empurrao > 10 or position.x + empurrao < -10:
		empurrao = 0
	if position.z + empurrao > 10 or position.z + empurrao < -10:
		empurrao = 0
	knockback = empurrao
	
