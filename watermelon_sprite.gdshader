shader_type canvas_item;
uniform vec4 value;
uniform bool is_highlight;
varying vec4 changed;
void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	// Called for every pixel the material is visible on.
	vec4 pixelcolor = texture(TEXTURE, UV);
	if (is_highlight == true){
		changed = vec4(value.rgb,0.3);
		COLOR = pixelcolor * changed;
	}
	else{
	COLOR = pixelcolor *value;	
	}
}

//void light() {
	// Called for every pixel for every light affecting the CanvasItem.
	// Uncomment to replace the default light processing function with this one.
//}
