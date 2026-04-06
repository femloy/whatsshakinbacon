varying vec2 v_vTexcoord;
varying vec4 v_vColour;
uniform float u_time;           // Time for animation (in seconds)
uniform float u_intensity;      // Distortion intensity (0.0 to 1.0)
uniform vec2 u_resolution;      // Screen or surface resolution
uniform float u_wave_amplitude; // Wave distortion strength
uniform float u_wave_frequency; // Wave distortion frequency

void main()
{
    // Normalize texture coordinates
    vec2 uv = v_vTexcoord;

    // Calculate distortion based on intensity and time
    float distort = u_intensity * u_wave_amplitude;
    uv.x += sin(uv.y * u_wave_frequency + u_time) * distort;
    uv.y += cos(uv.x * u_wave_frequency + u_time * 0.7) * distort;

    // Sample texture with distorted coordinates
    vec4 color = texture2D(gm_BaseTexture, uv);

	vec2 offset = vec2(0.01 * u_intensity, 0.0);
	color.r = texture2D(gm_BaseTexture, uv + offset).r;
	color.b = texture2D(gm_BaseTexture, uv - offset).b;
	
    // Fade to transparent if out of bounds
    if (uv.x < 0.0 || uv.x > 1.0 || uv.y < 0.0 || uv.y > 1.0)
    {
        color = vec4(0.0);
    }

    gl_FragColor = color * v_vColour;
}