extends Node3D


@onready var vp = $SubViewport
@onready var cursor = $SubViewport/Control/Cursor
@onready var cam_select = $Area3D

func _ready():
	cam_select.connect("on_selected", _selected)
	cam_select.connect("on_deselected", _deselected)
	reset_cursor()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
		
		if !cam_select.selected: 
			return 
		
		var mouse_event = InputEventMouseButton.new()
		var motion = InputEventMouseMotion.new()
		

		motion.position = cursor.position
		
		if Input.is_action_pressed("mouse_down"): 
			mouse_event.pressed = true
		
		mouse_event.button_index = MOUSE_BUTTON_LEFT
		mouse_event.position = cursor.position
		
		vp.push_input(mouse_event)
		vp.push_input(motion)
		

func reset_cursor(): 
	cursor.position.x = 512 / 2
	cursor.position.y = 512 / 1.5
	

func _unhandled_input(event):
	
	if !cam_select.selected: 
		return 

	
	var mouse_event = InputEventMouseButton.new()
	
	if event is InputEventMouseButton: 
		if event.button_index == 1 and event.pressed: 
			$SFXMouse.play()
	
	if event is InputEventMouseMotion: 
		cursor.position += event.relative
		cursor.position.x = clamp(cursor.position.x, 0, 512 - (cursor.size.x * cursor.scale.x))
		cursor.position.y = clamp(cursor.position.y, 0, 512 - (cursor.size.y * cursor.scale.y))
		event.position = cursor.position
		
	
	if event is InputEventKey: 
		vp.push_input(event)
		$SFXKeys.play()
		
	if event is InputEventAction: 
		vp.push_input(event)

func _selected(): 
	$LabelLogin.hide()
	
func _deselected(): 
	pass
