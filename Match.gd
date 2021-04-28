extends Control

onready var playerScoreLabel = $playerScore
onready var enemyScoreLabel = $enemyScore
onready var choiceLabel = $choiceLabel
onready var label1 = $Label1
onready var label2 = $Label2
onready var label3 = $Label3
onready var label4 = $Label4

var playerChoice = 0
var enemyChoice = 0
var playerScore = 0
var enemyScore = 0

var enemyStrategy = 0

var lastEnemyChoice = 0
var lastPlayerChoice = 0

var numRounds = 0

var playerHasDefected = false
var playerDefectTwice = false
var enemyMustDefectTwice = false

func _ready():
	playerScoreLabel.text = "Player Score: 0"
	enemyScoreLabel.text = "Enemy Score: 0"
	enemyStrategy = randomize_strategy()
	print(enemyStrategy)


func _process(delta):
	playerScoreLabel.text = "Player Score: %s" % playerScore
	enemyScoreLabel.text = "Enemy Score: %s" % enemyScore


func randomize_strategy():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	return rng.randi_range(0,10)


func enemyStrategyFunction():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	
	if enemyStrategy == 0: # Unconditional Cooperator
		enemyChoice = 0
	elif enemyStrategy == 1: # Unconditional Defector
		enemyChoice = 1
	elif enemyStrategy == 2: # Random
		enemyChoice = rng.randi_range(0,1)
	elif enemyStrategy == 3: # Switch-Cooperate
		if(numRounds == 0):
			enemyChoice = 0
		else:
			if(lastEnemyChoice == 0):
				enemyChoice = 1
			elif(lastEnemyChoice == 1):
				enemyChoice = 0
	elif enemyStrategy == 4: # Switch-Defect
		if(numRounds == 0):
			enemyChoice = 1
		else:
			if(lastEnemyChoice == 0):
				enemyChoice = 1
			elif(lastEnemyChoice == 1):
				enemyChoice = 0
	elif enemyStrategy == 5: # Tit-for-tat
		if(numRounds == 0):
			enemyChoice = 0
		else:
			enemyChoice = lastPlayerChoice
	elif enemyStrategy == 6: # Suspicious Tit-for-tat
		if(numRounds == 0):
			enemyChoice = 1
		else:
			enemyChoice = lastPlayerChoice
	elif enemyStrategy == 7: # Grim
		if playerHasDefected:
			enemyChoice = 1
		else:
			enemyChoice = 0
	elif enemyStrategy == 8: # Pavlov / Win-stay-lose-shift / Singleton
		if(numRounds == 0):
			enemyChoice = 0
		else:
			if(lastPlayerChoice == lastEnemyChoice):
				enemyChoice = 0
			else:
				enemyChoice = 1
	elif enemyStrategy == 9: # Tit-for-two-tats 
		if(numRounds == 0):
			enemyChoice = 0
		else:
			if(playerDefectTwice):
				enemyChoice = 1
			else:
				enemyChoice = 0
	elif enemyStrategy == 10: # Two-tits-for-tat
		if(numRounds == 0):
			enemyChoice = 0
		else:
			if(lastPlayerChoice == 1):
				enemyChoice = 1
				enemyMustDefectTwice = true
			elif(enemyMustDefectTwice):
				enemyChoice == 1
				if(playerChoice == 0):
					enemyMustDefectTwice = false
			elif(lastPlayerChoice == 0):
				enemyChoice = 0
				enemyMustDefectTwice = false
				


func _on_cButton_button_up():
	playerChoice = 0
	choiceLabel.text = "Are you sure you want to cooperate?"


func _on_dButton_button_up():
	playerChoice = 1
	choiceLabel.text = "Are you sure you want to defect?"


func _on_confirmButton_button_up():
	enemyStrategyFunction()
	if(playerChoice == 1 and lastPlayerChoice == 1):
		playerDefectTwice = true
	else:
		playerDefectTwice = false
	lastPlayerChoice = playerChoice
	lastEnemyChoice = enemyChoice
	numRounds += 1
	if(playerChoice == 1 and playerHasDefected == false):
		playerHasDefected = true
		
	if(playerChoice == 0 and enemyChoice == 0):
		playerScore += 3
		enemyScore += 3
		label1.text = "You chose to cooperate."
		label2.text = "Your enemy chose to cooperate."
		label3.text = "You got 3 points."
		label4.text = "Your Enemy got 3 points."
	elif(playerChoice == 0 and enemyChoice == 1):
		enemyScore += 5
		label1.text = "You chose to cooperate."
		label2.text = "Your enemy chose to defect."
		label3.text = "You got 0 points."
		label4.text = "Your Enemy got 5 points."
	elif(playerChoice == 1 and enemyChoice == 0):
		playerScore += 5
		label1.text = "You chose to defect."
		label2.text = "Your enemy chose to cooperate."
		label3.text = "You got 5 points."
		label4.text = "Your Enemy got 0 points."
	elif(playerChoice == 1 and enemyChoice == 1):
		playerScore += 1
		enemyScore += 1
		label1.text = "You chose to defect."
		label2.text = "Your enemy chose to defect."
		label3.text = "You got 1 point."
		label4.text = "Your Enemy got 1 point."
