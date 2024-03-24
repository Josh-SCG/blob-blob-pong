extends AudioStreamPlayer


func sfxAudio(sound: AudioStream):
	var instance = AudioStreamPlayer.new()
	instance.stream = sound
	instance.bus = "sfx"
	instance.finished.connect(remove_node.bind(instance))
	add_child(instance)
	instance.play()

func remove_node(instance: AudioStreamPlayer):
	instance.queue_free()
