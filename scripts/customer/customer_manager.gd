extends Node3D

@onready var customers = $Customers
var current_customer = null 

# Called when the node enters the scene tree for the first time.
func _ready():
	Global.customer_manager = self 
	Global.customer_changed.connect(_customer_changed)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	for i in customers.get_children().size(): 
		var customer: PathFollow3D = customers.get_child(i)
		var amount = 1 - (i * 0.1)
		
		if customer.progress_ratio < amount: 
			customer.progress_ratio += delta / 5
		
		if i == 0: 
			if customer.progress_ratio == 1 and !current_customer: 
				current_customer = customer
				Global.emit_signal("customer_changed", customer)
		
		customer.global_position.x = cos(delta * Time.get_ticks_msec() / 10 + i) * 0.2

func _on_spawn_timer_timeout():
	var customer = preload("res://scenes/customer/customer.tscn").instantiate()
	customers.add_child(customer)
	customer.progress_ratio = 0 

func _customer_changed(c): 
	$CustomerInfo/AnimationPlayer.play("give")
		
