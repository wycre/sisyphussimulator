extends CharacterBody2D

const moveX = 2
const moveY = -1.55
@export var moveRate: float = 10

var player_started = false

var summited = false
var start_pos

const GROUND = 433

const SPEED = 300.0
const JUMP_VELOCITY = -400.0

func _ready():
	start_pos = position

func _process(_delta: float):
	if summited:
		return
	if Input.is_action_just_pressed("right") and position.y < GROUND and player_started:
		_pushRock()
	$PlayerCamera.position_smoothing_enabled = false

func _physics_process(delta: float) -> void:
	if player_started:
		if summited:
			move_and_slide()
			return
		# Add the gravity.
		if not is_on_floor():
			velocity += get_gravity() * delta

		# Handle jump.
		if Input.is_action_just_pressed("jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY

		 #Get the input direction and handle the movement/deceleration.
		 #As good practice, you should replace UI actions with custom gameplay actions.
		var direction := Input.get_axis("left", "right")
		if direction and position.y > GROUND:
			velocity.x = direction * SPEED
		else:
			velocity.x = move_toward(velocity.x, 0, SPEED)

		move_and_slide()

func _pushRock():
	# Move the rock
	position.x += moveX * moveRate
	position.y += moveY * moveRate
	
	# TODO animate sprite and play sound
	
func handle_summit():
	summited = true
	$AnimatedSprite2D.visible = false
	$LocationIndicator.visible = false
	
	# TODO Play return animation
	
func reset_summit():
	summited = false;
	$AnimatedSprite2D.visible = true
	$RockPusherAnim.visible = false
	$PlayerCamera.make_current()
	
	position = start_pos
	player_started = false
	
	# TODO Reset sprites to start
	
func start_game():
	player_started = true
	$PlayerCamera.position_smoothing_enabled = false
	$RockPusherAnim.visible = true
