extends Node2D


@onready var submit_btn = $SubmitBtn
@onready var color_rect = $ColorRect


var transition_duration = 1.75
var elapsed_time = 0.0
var is_transitioning = false


func _ready():
	submit_btn.connect('pressed', Callable(self, '_on_submit_pressed'))


func _on_submit_pressed():
	is_transitioning = true


func _process(delta):
	if is_transitioning:
		color_rect.visible = true
		elapsed_time += delta
		var alpha = clamp(elapsed_time / transition_duration, 0, 1)
		color_rect.color.a = alpha

		if elapsed_time - 0.1 >= transition_duration:
			get_tree().change_scene_to_file("res://scene/hall/hallPage.tscn")
