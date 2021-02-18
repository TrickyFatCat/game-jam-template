shader_type canvas_item;

uniform vec2 speed = vec2(0.25, 0.25);

void fragment()
{
    vec2 newuv = UV;
    newuv.x += TIME * speed.x;
	newuv.y += TIME * speed.y;
    vec4 c = texture(TEXTURE, newuv);
    COLOR = c;
}