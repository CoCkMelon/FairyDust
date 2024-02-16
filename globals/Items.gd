
# Declare a global singleton for items
extends Node
# Item.gd


# Define an enum for different item types
enum ItemType {
	WEAPON,
	ARMOR,
	POTION,
	SCROLL,
	# Add more adorable item types as needed UwU
}

# Define a structure to hold item information
class ItemData:
	var name : String
	var itemType : ItemType
	var description : String
	var scenePath : String

	# Constructor for ItemData
	func _init(newname, newitemType, newdescription, newscenePath):
		self.name = newname
		self.itemType = newitemType
		self.description = newdescription
		self.scenePath = newscenePath

# Define some magical items with scene paths
var bubbleWand = ItemData.new("Wand of Bubbles", ItemType.WEAPON, "White wand that shoots infinite bubbles, that nightmares are afraid of.", "res://scenes/gameplay/weapons/bubble_gun.tscn")
var stoneWand = ItemData.new("Stone staff", ItemType.WEAPON, "Stone staff to throw stones.", "res://scenes/gameplay/weapons/other_staff.tscn")
#var wandOfWonder = ItemData.new("Wand of Wonder", ItemType.WEAPON, "A magical wand that sparkles with enchantment.", "res://scenes/gameplay/weapons/wand_of_wonder.tscn")
#var enchantedRobe = ItemData.new("Enchanted Robe", ItemType.ARMOR, "A flowing robe that grants protection with a touch of elegance.", "res://scenes/gameplay/armors/enchanted_robe.tscn")
#var healingPotion = ItemData.new("Healing Potion", ItemType.POTION, "A potion that restores health and brings a warm, fuzzy feeling.", "res://scenes/gameplay/potions/healing_potion.tscn")
#var spellScroll = ItemData.new("Spell Scroll", ItemType.SCROLL, "A scroll containing ancient spells, waiting to be unleashed.", "res://scenes/gameplay/scrolls/spell_scroll.tscn")

# Add more adorable items with their respective scene paths UwU
#var kittyEars = ItemData.new("Kitty Ears", ItemType.ARMOR, "Cute cat ears that grant the wearer feline charm.", "res://scenes/gameplay/armors/kitty_ears.tscn")

func predefined_items_print():
	# Print a little message to show off the items and their paths
	print("Behold the magical items:")
	print(bubbleWand.name, ":", bubbleWand.description, " Scene Path:", bubbleWand.scenePath)
	#print(wandOfWonder.name, ":", wandOfWonder.description, " Scene Path:", wandOfWonder.scenePath)
	#print(enchantedRobe.name, ":", enchantedRobe.description, " Scene Path:", enchantedRobe.scenePath)
	#print(healingPotion.name, ":", healingPotion.description, " Scene Path:", healingPotion.scenePath)
	#print(spellScroll.name, ":", spellScroll.description, " Scene Path:", spellScroll.scenePath)
	#print(kittyEars.name, ":", kittyEars.description, " Scene Path:", kittyEars.scenePath)
