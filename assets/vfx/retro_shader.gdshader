shader_type canvas_item;

uniform int STEPS: instance_index(0);
uniform vec3 BACKGROUND_COLOR: source_color;
uniform sampler2D DITHER_TEXTURE;

const vec2 resolution = vec2(300, 240);

void fragment() {
	vec2 TEXTURE_RESOLUTION = vec2(textureSize(TEXTURE, 0));
	vec2 DITHER_RESOLUTION = vec2(8.0, 8.0);

	vec4 color = texture(TEXTURE, UV);

	vec3 COLOR_SPACE = vec3(1.0) - BACKGROUND_COLOR;

	vec2 TEXTURE_POS = UV * TEXTURE_RESOLUTION;
	vec2 DITHER_UV = mod(TEXTURE_POS, DITHER_RESOLUTION) / DITHER_RESOLUTION;

	color = pow(color, 1.0 - (texture(DITHER_TEXTURE, DITHER_UV)) * 0.2);

	color *= float(STEPS);
	color = round(color);
	color /= float(STEPS);

	COLOR = vec4(BACKGROUND_COLOR + (COLOR_SPACE * color.rgb), color.a);
}