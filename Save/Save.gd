class_name Save

const SAVE_FILE_PATH = "user://save_file.json"

static var save_object:Dictionary

static func create_new_save():
	save_object = {
		"multifruit": false,
		"rationalite": false,
		"emotion": false,
	}
	save_save()


static func load_save():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		create_new_save()
	else:
		var save_string = FileAccess.get_file_as_string(SAVE_FILE_PATH)
		var json = JSON.new()
		var err = json.parse(save_string)
		if err != OK:
			print("Couldn't parse the save JSON.")
		save_object = json.data
	return save_object

static func save_tree_win(tree_name:String):
	if save_object.has(tree_name):
		save_object[tree_name] = true
		save_save()
	else:
		print("The tree does not exists in save object.")

static func save_save():
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save_object))
	
