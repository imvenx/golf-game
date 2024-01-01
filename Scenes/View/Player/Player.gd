extends Node


var pad:ArcanePad
var padQuaternion = Quat()
onready var bonkSound:AudioStreamPlayer3D = get_child(2)

func _ready():
	Arcane.signals.connect(AEventName.ArcaneClientInitialized, self, "init")
	
func init(initialState) -> void:
	if initialState.pads.size() == 0: return
	pad = initialState.pads[0]
	prints("Pad user", pad.user.name, "initialized")

	pad.startGetQuaternion()

	# warning-ignore:RETURN_VALUE_DISCARDED
	pad.connect(AEventName.GetQuaternion, self, 'onGetQuaternion')
	
	
func _process(_delta):
	self.transform.basis = Basis(padQuaternion)


func _exit_tree():
	pad.queue_free()
	
	
func onGetQuaternion(q):
	padQuaternion.x = -q.x
	padQuaternion.y = -q.y
	padQuaternion.z = q.z
	padQuaternion.w = q.w
	
	
func _on_Bat_body_entered(_body):
	return
	pad.vibrate(80)
	bonkSound.play()
