extends PathFollow3D


var account_id = 0 
var user_dict = {}

# Called when the node enters the scene tree for the first time.
func _ready():
	generate()
	account_id = randi_range(10000, 99999)
	$MeshInstance3D.material_override.set("albedo_color", Color.PINK)


func generate(): 
	var file = FileAccess.open("res://users.json", FileAccess.READ)
	var json = JSON.new()
	
	json.parse(file.get_as_text())
	
	var l = len(json.data)
	var rand = randi_range(0, l - 1)
	var data = json.data[rand]
	
	user_dict = data

	
