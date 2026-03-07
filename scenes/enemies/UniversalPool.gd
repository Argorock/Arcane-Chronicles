extends Node

var pool := {}   # path -> array

func get_creature(scene: PackedScene):
	var key := scene.resource_path
	if not pool.has(key):
		pool[key] = []

	var list = pool[key]
	var creature: Node

	if list.is_empty():
		creature = scene.instantiate()
		add_child(creature)
	else:
		creature = list.pop_back()

	if creature.get_parent() != null and creature.get_parent() != get_tree().current_scene:
		creature.get_parent().remove_child(creature)

	#creature.reset_state()
	creature.visible = true
	creature.set_physics_process(true)
	return creature


func return_creature(creature, scene):
	call_deferred("_deferred_return_creature", creature, scene)

func _deferred_return_creature(creature: Node, scene: PackedScene):
	var key: String = scene.resource_path

	creature.visible = false
	creature.set_physics_process(false)

	var parent: Node = creature.get_parent()
	if parent and parent != self:
		parent.remove_child(creature)

	if creature.get_parent() != self:
		add_child(creature)

	if not pool.has(key):
		pool[key] = []

	pool[key].append(creature)
