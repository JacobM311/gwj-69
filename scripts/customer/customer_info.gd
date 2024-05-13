extends Node3D


func _ready():
	Global.customer_changed.connect(_customer_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _customer_changed(customer): 
	$AccountIDSubViewport/AccountID/ID.text = str(customer.account_id)
	var data = customer.user_dict 
	var name = data.first_name + " " + data .last_name
	var vp_texture = ViewportTexture.new()
	
	$IDSubViewport/ID/ImageContainer/LabelCustomerName.text = str(name)
	$IDSubViewport/ID/ImageContainer/Picture.texture.set("viewport_path", Global.id_viewport.get_path())
	print($IDSubViewport/ID/ImageContainer/Picture.texture.get("viewport_path"))
