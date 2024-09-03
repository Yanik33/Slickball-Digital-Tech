extends CanvasLayer

var p1_score = 0
var p2_score = 0

# Called when the node enters the scene tree for the first time.
func _update_scoreboard(p1, p2):
	print(p1)
	print(p2)
	if p1:
		p1_score += 1
		$p1_scoreboard.text = str(p1_score)
	if p2:
		p2_score += 1 
		$p2_scoreboard.text = str (p2_score)
