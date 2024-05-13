extends PathFollow3D


var account_id = 0 

# Called when the node enters the scene tree for the first time.
func _ready():
	generate()
	account_id = randi_range(10000, 99999)
	$MeshInstance3D.material_override.set("albedo_color", Color.PINK)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func generate(): 
	var file = FileAccess.open("res://users.json", FileAccess.READ)
	var json = JSON.new()
	
	print(file.get_as_text())
