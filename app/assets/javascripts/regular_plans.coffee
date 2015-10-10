ready = ->
	$('#picker_start_date').datepicker({ dateFormat: 'yy-mm-dd' })
	$('#picker_end_date').datepicker({ dateFormat: 'yy-mm-dd' })

$(document).ready(ready)
$(document).on('page:load', ready)
