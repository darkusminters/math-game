extends Window

signal math_solved # signals when the answer is right
@onready var line_edit: LineEdit = $LineEdit
@onready var label: Label = $Label
func _on_button_pressed() -> void:
	# Check if what the player typed equals "4" (strip_edges removes accidental spaces)
	if line_edit.text.strip_edges() == "4":
		line_edit.clear() # Reset the text box for next time
		hide() # Close the window
		math_solved.emit() # Tell node_2d.gd we won!
	else:
		# Optional: give feedback if they got it wrong
		line_edit.clear()
		line_edit.placeholder_text = "Try again!"
