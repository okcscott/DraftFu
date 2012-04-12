jQuery ->
	
	#flash message
	setTimeout (->
		$('#flash_msg').slideUp "fast"
	), 3000
	$("#flash_msg").click ->
		$('#flash_msg').hide()