shader_type canvas_item;

uniform sampler2D screen_texture: hint_screen_texture, repeat_disable, filter_linear_mipmap;
uniform float blur_amount : hint_range(0, 3.5) = 0.0; // Strength of the blur effect

void fragment() {
    // Original color of the pixel from the screen
    vec4 pixelColor = texture(screen_texture, UV);
    
    // Color with blur effect from the screen
    vec4 blurColor = textureLod(screen_texture, SCREEN_UV, blur_amount);

    COLOR = blurColor;
}