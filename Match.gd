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

func _ready():
	playerScoreLabel.text = "Player Score: 0"
	enemyScoreLabel.text = "Enemy Score: 0"

func _process(delta):
	playerScoreLabel.text = "Player Score: %s" % playerScore
	enemyScoreLabel.text = "Enemy Score: %s" % enemyScore

func _on_cButton_button_up():
	playerChoice = 0
	choiceLabel.text = "Are you sure you want to cooperate?"


func _on_dButton_button_up():
	playerChoice = 1
	choiceLabel.text = "Are you sure you want to defect?"


func _on_confirmButton_button_up():
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
