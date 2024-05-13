extends Camera3D

var mouse_vel: Vector2
var update = true 
var init_xform: Transform3D

func _ready():
	init_xform = global_transform
	
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	if !update: 
		return 
		
	rotation_degrees.x = clamp(rotation_degrees.x, -89, 89)
	
	var cast := $RayCast3D
	
	if cast.is_colliding(): 
		if cast.get_collider() is CamSelect and Input.is_action_just_pressed("mouse_down"): 
			cast.get_collider().select(self)
	
func _unhandled_input(event):
	if !update: 
		return 
		
	if event is InputEventMouseMotion: 
		rotation_degrees.x -= event.relative.y
		rotation_degrees.y -= event.relative.x 
		
