extends Node

func apply_damage(target, damage_amount: float):
	if target.has_method("take_damage"):
		target.take_damage(damage_amount)
	else:
		push_error("Target does not have take_damage method.")

# Connect this method to the damage_taken signal emitted by Mob
func _on_mob_damage_taken(damage_amount: float):
	# Example: Applying damage to the mob
	apply_damage($MobInstance, damage_amount)
