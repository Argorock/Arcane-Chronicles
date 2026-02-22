class_name biome_rules
extends Resource


var allowed_neighbors = []
var forbidden neightbors = []
var required_below = []
var required_above = []
var min_distance = {}
var max_distance = {}
var can_repeat = true
var can_be_island = false

{
	"name": "Volcano",
	"allowed_depths": ["surface"],
	"preferred_neighbors": ["Mountains", "Desert"],
	"forbidden_neighbors": ["Frozen Waste"],
	"required_below": ["Lava Caverns", "Molten Core"],
	"can_repeat": false,
	"can_be_island": true
}

{
	"name": "Ocean",
	"allowed_depths": ["surface"],
	"preferred_neighbors": ["Flooded Tunnels", "Underground Ocean"],
	"forbidden_neighbors": [""],
	"required_below": [""],
	"can_repeat": false,
	"can_be_island": true
}

{
	"name": "",
	"allowed_depths": [""],
	"preferred_neighbors": [""],
	"forbidden_neighbors": [""],
	"required_below": [""],
	"can_repeat": false,
	"can_be_island": true
}
