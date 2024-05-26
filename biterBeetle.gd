extends CharacterBody2D


const speed = 300.0
const health = 3

# stuff for jumping
const jumpSpeed = 80
const jumpDist = 100
var jumpTarget
var isJumping
var jumpInactive = true

var hitWithAttack : bool = false

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var getdelta

func _physics_process(delta):
	getdelta = delta
	if isJumping:
		handleAttack
		handleJump(delta)

	move_and_slide()

func handleAttack():
	for possibleTarget in $attackArea.get_overlapping_bodies():
		var viable = false
		for child in possibleTarget.get_children():
			if child.name == "Damageable":
				viable = true
		if viable == true:
			possibleTarget.damageable.getHit(1)

func handleJump(delta):
	if position.distance_to(jumpTarget) > 10 and !hitWithAttack:
		velocity = position.direction_to(jumpTarget) * minf(speed, position.distance_to(jumpTarget))
	else:
		$biterBeetleAnimations.play("attack",8)
		isJumping = false

func jumpAttack(targetLocation):
	jumpTarget = targetLocation
	$biterBeetleAnimations.play("attack")
	print(1)

func walkTowards(xspot,yspot):
	pass

# jump functions
func beginJump():
	rotation = position.angle_to(jumpTarget)
	isJumping = true
	jumpInactive = false

func stopJumpAnim():
	$biterBeetleAnimations.pause()

func endJumpAnim():
	velocity = Vector2(0,0)
	jumpInactive = true
