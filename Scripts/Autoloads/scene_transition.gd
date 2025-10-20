extends CanvasLayer

signal transition_half_finished
signal transition_finished

@onready var colorRect := $ColorRect
@onready var animationPlayer := $AnimationPlayer
var current_animation : String

func _ready() -> void:
	colorRect.visible = false

func transition():
	colorRect.visible = false
	animationPlayer.play("Fade_In_Transition")
	




func _on_animation_finished(anim_name: StringName) -> void:
	if anim_name == "Fade_In_Transition":
		transition_half_finished.emit()
		animationPlayer.play("Fade_Out_Transition")
	elif anim_name == "Fade_Out_Transition":
		colorRect.visible = false
		transition_finished.emit()
