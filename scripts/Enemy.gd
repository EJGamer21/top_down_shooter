extends KinematicBody2D

export var movement_speed = 300;
export var vec_to_player = Vector2();
var player = null;

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("enemies");
	

func _physics_process(delta):
	if player == null:
		return;

	vec_to_player = player.global_position - global_position;
	vec_to_player = vec_to_player.normalized() * movement_speed;
	global_rotation = atan2(vec_to_player.y, vec_to_player.x);
	
	var collision = move_and_collide(vec_to_player * delta);
	if collision:
		if (collision.collider.name == "Player"
			and collision.collider.has_method("die")
		):
			collision.collider.die();

func set_player(p):
	player = p;

func die():
	queue_free();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
