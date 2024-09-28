extends Node
class_name FiniteStateMachine

@onready var loop: AudioStreamPlayer2D = $"../BulletSounds/Loop"

var states : Dictionary = {}
var current_state : State
@export var initial_state : State
var last_state : State

func _ready():
	for child in get_children():
		if child is State:
			states[child.name.to_lower()] = child
			child.state_transition.connect(change_state)
			
	if initial_state:
		initial_state.Entre()
		current_state = initial_state
		
func _process(delta):
	if current_state:
		current_state.Update(delta)
		#print(current_state.name)


func change_state(source_state : State, new_state_name : String):
	if source_state != current_state:
		return
		
	var new_state = states.get(new_state_name.to_lower())
	if !new_state:
		print("new state is empty")
		return
			
	if current_state:
		current_state.Exit()
	
	new_state.Entre()
	last_state = current_state
	current_state = new_state
