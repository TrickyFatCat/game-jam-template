shader_type canvas_item;

uniform float u_alpha : hint_range(0.0, 1.0) = 0.0;
uniform vec4 u_colour: hint_color = vec4(1.0);

void fragment()
{
	vec4 texture_colour = texture(TEXTURE, UV);
	COLOR.rbg = texture_colour.rbg * (1.0 - u_alpha) + u_colour.rbg * u_alpha;
	COLOR.a = texture_colour.a;
}