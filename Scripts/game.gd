extends Node2D

var rolling_rock = load("res://rolling_rock.tscn")
var man_scene = load("res://man.tscn")
var man

func start_game():
	$UI.visible = false
	$CameraSwapTimer.start() # Only start camera swaps when the game is started
	
	# swap active character
	$Player.start_game()
	man.queue_free()
	
func reset_game():
	$UI.visible = true
	$Player.reset_summit()
	man = man_scene.instantiate()
	man.position = Vector2(165,442)
	call_deferred("add_child", man)
	


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	man = man_scene.instantiate()
	man.position = Vector2(165,442)
	add_child(man)
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass


func _zoom_out():
	$Player/LocationIndicator.visible = true
	$GlobalCamera.make_current()
	$ZoomOutHold.start()
	
func _zoom_in():
	$Player/LocationIndicator.visible = false
	$Player/PlayerCamera.make_current()
	$CameraSwapTimer.start()


# Starts rolling the rock to the bottom
func _on_summit_zone_body_entered(_body: Node2D) -> void:
	$Player.handle_summit() # Let the player handle its own summit behavior
	
	# We want to stop the camera swapping for now
	$CameraSwapTimer.stop()
	$ZoomOutHold.stop()
	$GlobalCamera.make_current() # and set the global one to active
	
	# Make the physics rock that rolls down the mountain
	var roller = rolling_rock.instantiate()
	roller.position = $Player.position
	call_deferred("add_child", roller)
	
# Called when the rolling rock reaches the bottom
func _on_bottom_zone_body_entered(body: Node2D) -> void:
	body.queue_free() # always destroy the body that triggered this
	reset_game()


func _on_game_start_trigger_body_entered(_body: Node2D) -> void:
	start_game()
