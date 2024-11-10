extends CharacterBody3D


@export var SPEED = 5.0
@export var JUMP_VELOCITY = 4.5
@onready var pivot: Node3D = $CamOrigin
@export var sensitivity = 0.5
@export var cameraTrimX = 5.0
@export var cameraTrimY = 2.0
@export var is2D = false

@onready var _2d_camera: Camera3D = $"2DCamera"
@onready var camera_3d: Camera3D = $CamOrigin/SpringArm3D/Camera3D
@onready var player: CharacterBody3D = $"."


func _ready() -> void:
	if !is2D: Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _input(event):
	if event is InputEventMouseMotion && !is2D:
		rotate_y(deg_to_rad(-event.relative.x * sensitivity))
		pivot.rotate_x(deg_to_rad(-event.relative.y * sensitivity))
		pivot.rotation.x = clamp(pivot.rotation.x, deg_to_rad(-90), deg_to_rad(45))
	
func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta
		
	if Input.is_action_just_pressed("SwitchCam"):
		if(is2D):
			is2D = false
			
			print("is3D")
	if Input.is_action_just_pressed("SwitchCam3D"):
		if(!is2D):
			is2D = true
			rotation = Vector3(0,0,0)

	if is2D:
		_2d_camera.set_current(true)
		_2d_camera.position.z = player.position.z
		_2d_camera.position.x = player.position.x + cameraTrimX
		_2d_camera.position.y = player.position.y + cameraTrimY
	if !is2D:
		camera_3d.set_current(true)

	# Handle jump.
	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	if Input.is_action_just_pressed("ExitGame"):
		get_tree().quit();

	var direction
	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var input_dir := Input.get_vector("Left", "Right", "Forward", "Backward")
	if !is2D:
		direction = (transform.basis * Vector3(input_dir.x, 0, input_dir.y)).normalized()
	else:
		direction = (transform.basis * Vector3(0, 0, -input_dir.x)).normalized()
	if direction:
		velocity.x = direction.x * SPEED
		velocity.z = direction.z * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
		velocity.z = move_toward(velocity.z, 0, SPEED)

	move_and_slide()


func _on_area_3d_area_entered(area: Area3D) -> void:
	if area.is_in_group("VisionSwitch3D") && !is2D:
		is2D = true
		print("2D")
	if area.is_in_group("VisionSwitch2D") && is2D:
		is2D = false
		print("3D")
