extends AudioStreamPlayer

func play_menu_song():
	self.stream = preload("res://Assets/Music/menus.ogg")
	self.play()
	
func play_fight_song():
	self.stream = preload("res://Assets/Music/fight.ogg")
	self.play()
