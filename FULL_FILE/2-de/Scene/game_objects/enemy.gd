extends RigidBody2D

@onready var game_manager: Node = %GameManager

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_area_2d_body_entered(body):
	if body.name == "CharacterBody2D":
		
		if body.velocity.y > 0:
			print("Destroy enemy")
			queue_free()
			body.jump()
		else:
			print("Decrease player health")
			game_manager.decrease_health()
		
