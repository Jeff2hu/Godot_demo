extends HBoxContainer


@onready var animation_player = $"../AnimationPlayer"
@onready var timer = $"../Timer"


var current_animation_index = 1


func _ready():
	timer.autostart = true
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))


func _on_Timer_timeout():
	var animation_name = "MoveAndScale_" + str(current_animation_index)
	animation_player.play(animation_name)
	current_animation_index = 1 if current_animation_index >= 3 else current_animation_index + 1
