extends Node3D


func _ready():
	Global.customer_changed.connect(_customer_changed)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	
func _customer_changed(customer): 
	$AccountIDSubViewport/AccountID/ID.text = str(customer.account_id)
