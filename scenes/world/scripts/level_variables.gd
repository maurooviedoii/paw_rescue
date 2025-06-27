extends Node
var bones_collected: int = 0
var all_bones_in_current_level: int = 0

var bullet_touched: bool = false:
	get: return bullet_touched
	set(value):
		if bullet_touched != value:
			bullet_touched = value
			emit_signal("bullet_touched_changed", value)
			
signal bullet_touched_changed(new_value: bool)

var current_level: int = -1:
	get: return current_level
	set(value):
		if current_level != value:
			current_level = value
			emit_signal("current_level_changed", value)
			
signal current_level_changed(new_value: bool)

var show_info_layer: bool = false:
	get: return show_info_layer
	set(value):
		if show_info_layer != value:
			show_info_layer = value
			emit_signal("show_info_layer_changed", value)

signal show_info_layer_changed(new_value: bool)

var show_pause_menu: bool = false:
	get: return show_pause_menu
	set(value):
		if show_pause_menu != value:
			show_pause_menu = value
			emit_signal("show_pause_menu_changed", value)

signal show_pause_menu_changed(new_value: bool)
