extends Area3D


func _on_area_entered(_area):
	#PlayerGlobal.set_current_level(1)
	#PlayerGlobal.increment_current_level()
	#if(PlayerGlobal.currentLevel >= len(PlayerGlobal.levelScenePaths)):
		#get_tree().change_scene_to_file("res://scenes/main/main.tscn")
	#else:
		#get_tree().change_scene_to_file(PlayerGlobal.get_current_level_name())
	get_tree().change_scene_to_file("res://scenes/gameplay/Void.tscn")
