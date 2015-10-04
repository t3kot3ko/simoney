ready = ->
	$('#picker_planned_at').datepicker({ dateFormat: 'yy-mm-dd' })

$(document).ready(ready)
$(document).on('page:load', ready)
