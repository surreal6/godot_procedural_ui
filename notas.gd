extends Node



# get_texture   from viewport
func _ready():
	await RenderingServer.frame_post_draw
	$Viewport.get_texture().get_image().save_png("user://Screenshot.png")
