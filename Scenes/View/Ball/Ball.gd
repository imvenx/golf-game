extends RigidBody


var startPosition = Vector2()  # or Vector3 for 3D
var timer

func _ready():
	startPosition = global_transform
	# Create a Timer node
	timer = Timer.new()
	timer.wait_time = 4  # 4 seconds
	timer.one_shot = true  # Timer will stop after timing out once
	timer.connect("timeout", self, "_on_Timer_timeout")
	add_child(timer)

func _on_Timer_timeout():
	linear_velocity = Vector3.ZERO
	angular_velocity = Vector3.ZERO
	global_transform = startPosition
	timer.stop()


func _on_Ball_RB_body_shape_entered(body_rid, body, body_shape_index, local_shape_index):
	if body.name == "Bat":
		print("********** BALL HIT **********")
		timer.start()
		
