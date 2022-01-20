extends Sprite

const LightTexture = preload("res://Action RPG Resources/Shadows/Light.png")
const GRID_SIZE = 8

var display_width = 420
var display_height = 300

var fogImage = Image.new()
var fogTexture = ImageTexture.new()
var lightImage = LightTexture.get_data()
var light_offset = Vector2(LightTexture.get_width()/2,LightTexture.get_height()/2)

func _ready() -> void:
	var fog_image_wight = display_width/GRID_SIZE
	var fog_image_height = display_height/GRID_SIZE
	fogImage.create(fog_image_wight, fog_image_height, false, Image.FORMAT_RGBAH)
	fogImage.fill(Color.black)
	lightImage.convert(Image.FORMAT_RGBAH)
	scale *= GRID_SIZE

func update_fog(new_grid_position):
	fogImage.lock()
	lightImage.lock()
	
	var light_rect = Rect2(Vector2.ZERO, Vector2(lightImage.get_width(), lightImage.get_height()))
	fogImage.blend_rect(lightImage, light_rect, new_grid_position - light_offset)
	
	fogImage.unlock()
	lightImage.unlock()
	update_fog_image_texture()

func update_fog_image_texture():
	fogTexture.create_from_image(fogImage)
	texture = fogTexture

func _on_Player_position(playerPosition) -> void:
	update_fog(playerPosition/GRID_SIZE)

