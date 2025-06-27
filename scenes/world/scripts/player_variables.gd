extends Node 

var _life_points = 3: get = get_life_points

func get_life_points() -> int:
	return _life_points
	
var _last_portion_collected_location: Vector2 = Vector2.ZERO: get = get_last_portion_collected_location

func get_last_portion_collected_location() -> Vector2:
	return _last_portion_collected_location

func resetLifePoints() -> void:
	_life_points = 3

func reduceLifePoint() -> void:
	_life_points -= 1

func increaseLifePoint() -> void:
	_life_points += 1
	
func updateLastPortionCollectionLocation(new_location: Vector2) -> void:
	_last_portion_collected_location = new_location
	
