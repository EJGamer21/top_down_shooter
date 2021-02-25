extends KinematicBody2D

export var movement_speed = 300;

var velocity = Vector2();
var Bullet = preload("res://scenes/Bullet.tscn");


# Called when the node enters the scene tree for the first time.
func _ready():
	yield(get_tree(), "idle_frame");
	get_tree().call_group("enemies", "set_player", self);

func _physics_process(delta):
	get_input();
	move_and_collide(velocity * delta);

	var look_vec = get_global_mouse_position() - global_position;
	if look_vec.length() > 5:
		rotation = atan2(look_vec.y, look_vec.x);

func get_input():
	# look_at(get_global_mouse_position());
	velocity.x = (
		Input.get_action_strength("right") -
		Input.get_action_strength("left")
	);

	velocity.y = (
		Input.get_action_strength("down") -
		Input.get_action_strength("up")
	);

	# if Input.is_action_pressed("up"):
	# 	velocity.y -= Input;
	# if Input.is_action_pressed("down"):
	# 	velocity.y += 1;
	# if Input.is_action_pressed("left"):
	# 	velocity.x -= 1;
	# if Input.is_action_pressed("right"):
	# 	velocity.x += 1;
	
	if Input.is_action_pressed("lmb"):
		shoot()
	velocity = velocity.normalized() * movement_speed;

func shoot():
	var bullet = Bullet.instance();
	bullet.start(position, rotation);
	get_parent().add_child(bullet);


func die():
	get_tree().reload_current_scene();
