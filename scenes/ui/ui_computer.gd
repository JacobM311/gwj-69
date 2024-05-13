extends Control


func _on_account_id_text_submitted(new_text):
	if !Global.customer_manager.current_customer: 
		return 
		
	var customer = Global.customer_manager.current_customer
	
	if new_text == str(customer.account_id): 
		print("found account!")
