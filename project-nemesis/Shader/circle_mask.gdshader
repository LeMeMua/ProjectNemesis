shader_type canvas_item;

uniform float time = 0.0;
uniform float circleSize : hint_range(0.0, 2.0) = 0.5;
uniform float fadeWidth : hint_range(0.01, 0.5) = 0.4;

void fragment() {
    vec2 uv = UV;
    vec2 center = vec2(0.5, 0.5);

    float dist = distance(uv, center);

    // El hueco transparente es el círculo, negro opaco es el borde
    float alpha = smoothstep(circleSize - fadeWidth, circleSize, dist);

    COLOR = vec4(0.0, 0.0, 0.0, alpha);
}