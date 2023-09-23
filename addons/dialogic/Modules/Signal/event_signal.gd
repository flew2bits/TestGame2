@tool
class_name DialogicSignalEvent
extends DialogicEvent

## Event that emits the Dialogic.signal_event signal with an argument.
## You can connect to this signal like this: `Dialogic.signal_event.connect(myfunc)`


### Settings

## The argument that will be provided with the signal.
var argument: String = ""


################################################################################
## 						EXECUTE
################################################################################

func _execute() -> void:
	dialogic.emit_signal('signal_event', argument)
	finish()


################################################################################
## 						INITIALIZE
################################################################################

func _init() -> void:
	event_name = "Signal"
	set_default_color('Color6')
	event_category = "Logic"
	event_sorting_index = 8


################################################################################
## 						SAVING/LOADING
################################################################################

func get_shortcode() -> String:
	return "signal"


func get_shortcode_parameters() -> Dictionary:
	return {
		#param_name : property_info
		"arg"		: {"property": "argument", "default": ""},
	}

################################################################################
## 						EDITOR REPRESENTATION
################################################################################

func build_event_editor():
	add_header_edit('argument', ValueType.SINGLELINE_TEXT, {'left_text':'Emit with argument', 'autofocus':true})
