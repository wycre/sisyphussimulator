extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$CameraSwapTimer.start()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _zoom_out():
	$GlobalCamera.make_current()
	
func _zoom_in():
	$Player/PlayerCamera.make_current()
