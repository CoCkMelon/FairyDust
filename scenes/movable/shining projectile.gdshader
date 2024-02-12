shader_type particles;

uniform float distortion_strength : hint_range(0.0, 1.0) = 0.1;
uniform float speed : hint_range(0.0, 1.0) = 0.5;
uniform float noise_scale_x : hint_range(0.1, 10.0) = 2.0;
uniform float noise_scale_y : hint_range(0.1, 10.0) = 2.0;

uniform float frequency : hint_range(0.1, 5.0) = 1.0;
uniform float amplitude : hint_range(0.1, 5.0) = 1.0;


void vertex() {

}

void fragment() {}

void start () {
	
}

void process() {
    // Particle properties
    vec3 position = TRANSFORM[3].xyz;
    vec4 color = COLOR;
    
    // Calculate Perlin noise for magical texture effect
    float noise_value = length(sin(position * 0.1)); // Adjust the scale as needed
    
    // Modify color based on the Perlin noise
    color.rgb += noise_value * 0.5; // Adjust the intensity as needed
    
    // Output final color
    COLOR = color;
}

void light() {
	 //Called for every pixel for every light affecting the material.
	 //Uncomment to replace the default light processing function with this one.
}
