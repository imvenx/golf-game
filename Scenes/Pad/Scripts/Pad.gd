extends Node

#onready var hitBallSound:AudioStreamPlayer = get_child(4)
var padQuaternion = Quat()


func _ready():
	Arcane.init({'deviceType': 'pad'})
	
	Arcane.signals.connect(AEventName.ArcaneClientInitialized, self, "init")

	
func _process(_delta):
	self.transform.basis = Basis(padQuaternion)
	
	
func init(_initialState):
	
	Arcane.pad.startGetQuaternion()

	# warning-ignore:RETURN_VALUE_DISCARDED
	Arcane.pad.connect(AEventName.GetQuaternion, self, 'onGetQuaternion')
	Arcane.utils.writeToScreen(Arcane.pad.user.name)


func _on_CalibrateQuaternion_pressed():
	Arcane.pad.calibrateQuaternion()


func onGetQuaternion(q):
	padQuaternion.x = -q.x
	padQuaternion.y = -q.y
	padQuaternion.z = q.z
	padQuaternion.w = q.w
