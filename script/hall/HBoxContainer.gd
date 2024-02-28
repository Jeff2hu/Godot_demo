extends HBoxContainer

@onready var sprites = [$Activity_1, $Activity_2, $Activity_3]
@onready var timer = $"../Timer"

var current_sprite_index = 0
var sprite_positions = []
var enlarged_scale = Vector2(0.8, 0.8) # 放大尺寸
var normal_scale = Vector2(0.5, 0.5) # 正常尺寸
var transition_time = 0.5 # 轉換動畫時間，單位為秒
var elapsed_time = 0.0 # 紀錄過渡動畫已進行的時間
var screen_width = 1024 # 假設螢幕寬度為1024，根據實際情況調整
	
func _ready():
	for sprite in sprites:
		sprite_positions.append(sprite.position)
	sprites[1].scale = enlarged_scale
	timer.call_deferred("start")
	timer.connect("timeout", Callable(self, "_on_Timer_timeout"))

func _process(delta):
	if elapsed_time < transition_time:
		elapsed_time += delta
		for i in range(sprites.size()):
			var sprite = sprites[i]
			var next_pos_index = (current_sprite_index + i) % sprites.size()
			var target_position = sprite_positions[next_pos_index]
			
			if next_pos_index == 0 and elapsed_time < transition_time / 2:
				# 如果是最後一個位置，先向右移動消失
				sprite.position.x += screen_width * (delta / transition_time)
			elif next_pos_index == 0:
				# 消失後，在正確位置重新出現
				sprite.position = target_position
			else:
				sprite.position = sprite.position.lerp(target_position, min(elapsed_time / transition_time, 1.0))
			
			var target_scale = normal_scale if next_pos_index != 1 else enlarged_scale
			sprite.scale = sprite.scale.lerp(target_scale, min(elapsed_time / transition_time, 1.0))

func _on_Timer_timeout():
	elapsed_time = 0 # 重置過渡動畫時間
	current_sprite_index = (current_sprite_index + 1) % sprites.size()

func _on_gameBtnClick():
	pass # 這裡填入按鈕點擊時的功能實現。
