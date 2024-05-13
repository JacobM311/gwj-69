extends Area3D

class_name CamSelect

var camera: Camera3D = null 
var selected = false 

signal on_selected
signal on_deselected

var select_tween: Tween = null 
var deselect_tween: Tween = null 

func select(cam): 
	if deselect_tween and deselect_tween.is_running(): 
		return 
	
	camera = cam
	camera.update = false 
	
	select_tween = get_tree().create_tween()
	
	select_tween.set_ease(Tween.EASE_IN_OUT)
	select_tween.set_trans(Tween.TRANS_CUBIC)
	
	select_tween.tween_property(camera, "global_transform", global_transform, 0.5)
	
	selected = true 
	emit_signal("on_selected")
	
func deselect(): 
	if select_tween and select_tween.is_running(): 
		return 
	
	deselect_tween = get_tree().create_tween()
	
	deselect_tween.set_ease(Tween.EASE_IN_OUT)
	deselect_tween.set_trans(Tween.TRANS_CUBIC)
	deselect_tween.tween_property(camera, "global_transform", camera.init_xform, 0.2)
	
	camera.update = true 
	selected = false 
	
	await  deselect_tween.finished
	
	camera = null
	emit_signal("on_deselected")
	
	
func _input(event):
	if event.is_action_pressed("exit") and selected: 
		deselect()
