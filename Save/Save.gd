class_name Save

const SAVE_FILE_PATH = "user://save_file.json"

static func create_new_save():
	var content = {
		"multifruit": false,
		"rationalite": false,
		"emotion": false,
	}
	save_save(content)


static func load_save():
	if not FileAccess.file_exists(SAVE_FILE_PATH):
		create_new_save()
	var save_string = FileAccess.get_file_as_string(SAVE_FILE_PATH)
	var json = JSON.new()
	var err = json.parse(save_string)
	if err != OK:
		print("Couldn't parse the save JSON.")
	return json.data


static func save_save(save):
	var file = FileAccess.open(SAVE_FILE_PATH, FileAccess.WRITE)
	file.store_string(JSON.stringify(save))
	
