extends Node2D

var rolling_rock = load("res://rolling_rock.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraSwapTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _zoom_out():
	$GlobalCamera.make_current()
	$ZoomOutHold.start()
	
func _zoom_in():
	$Player/PlayerCamera.make_current()
	$CameraSwapTimer.start()

# Roll to bottom
func _on_summit_zone_body_entered(body: Node2D) -> void:
	$Player.handle_summit()
	$CameraSwapTimer.stop()
	var roller = rolling_rock.instantiate()
	roller.position = $Player.position
	get_parent().add_child(roller)
	$GlobalCamera.make_current()


func _on_bottom_zone_body_entered(body: Node2D) -> void:
	print("Returned")
	$Player.reset_summit()
	body.queue_free()
	$CameraSwapTimer.start()
