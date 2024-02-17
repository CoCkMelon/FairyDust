extends Node

# Current selected weapon index
var currentWeaponIndex : int = 0
# Reference to the currently spawned weapon instance
var currentWeaponInstance : Node = null

func _ready():
	currentWeaponInstance = $"../Fantasy staff"

func _input(event):
	if event.is_action_released("scroll_up"):
		#print("Wheee~! Scrolling up! (*^▽^*)")
		# Call your custom function for scrolling up
		prevWeapon()
	elif event.is_action_released("scroll_down"):
		#print("Oh noes! Scrolling down~! (╯︵╰,)")
		# Call your custom function for scrolling down
		nextWeapon()

# Function to scroll to the next weapon
func nextWeapon():
	if PlayerStats.weapons.size() > 0:
		currentWeaponIndex = (currentWeaponIndex + 1) % PlayerStats.weapons.size()
		# Display the cute selected weapon message UwU
		print("Nyaa~! I choose my adorable ", PlayerStats.weapons[currentWeaponIndex].name)
		var prevWeaponInstance = currentWeaponInstance
		if spawnNewWeapon():
			if prevWeaponInstance != null:
				prevWeaponInstance.queue_free()

	else:
		# Pouty face if no weapons available T_T
		print("Oh noes! No magic wands to choose from, so sad... (╥_╥)")

# Function to scroll to the previous weapon
func prevWeapon():
	if PlayerStats.weapons.size() > 0:
		currentWeaponIndex = (currentWeaponIndex - 1 + PlayerStats.weapons.size()) % PlayerStats.weapons.size()
		# Happy wiggle when going back to a previous magical weapon UwU
		print("Yay~! Back to my lovely ", PlayerStats.weapons[currentWeaponIndex].name)
		var prevWeaponInstance = currentWeaponInstance
		if spawnNewWeapon():
			if prevWeaponInstance != null:
				prevWeaponInstance.queue_free()
	else:
		# Dramatic sigh if no weapons available T_T
		print("Sigh... No magical artifacts to scroll through, such emptiness... ( ˘︹˘ )")
func spawnNewWeapon():
	# Instantiate the new weapon scene
	var newWeaponScene = load(PlayerStats.weapons[currentWeaponIndex].scenePath)
	if newWeaponScene == null:
		push_error("failed to load", PlayerStats.weapons[currentWeaponIndex].scenePath)
		return false
	currentWeaponInstance = newWeaponScene.instantiate()


	# Add the new weapon instance as a sibling to this node
	add_sibling(currentWeaponInstance)
	currentWeaponInstance.position = Vector3.ZERO
	return true
