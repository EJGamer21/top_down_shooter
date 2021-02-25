extends RigidBody2D

var speed = 500;
var velocity = Vector2();

func start(pos, dir):
	rotation = dir;
	position = pos;
	# velocity = Vector2(speed, 0).rotated(rotation);

func _physics_process(delta):
	# var collision = move_and_collide(velocity * delta);
	apply_impulse(Vector2.ZERO, Vector2(speed * delta, 0).rotated(rotation))
	var collisions = get_colliding_bodies();
	if collisions.size() > 0:
		velocity = Vector2.ZERO;
		for collision in collisions:
			if (collision.collider.name == "Enemy"
				and collision.collider.has_method("die")
			):
				collision.collider.die();

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()
