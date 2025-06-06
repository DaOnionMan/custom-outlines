#version 150

#moj_import <fog.glsl>
#moj_import <settings.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;
uniform float GameTime;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightMapColor;
in vec4 overlayColor;
in vec2 texCoord0;
in vec4 normal;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord0);
    if (color.a < 0.1) {
        discard;
    }

    vec4 hitColor = overlayColor;
    if(overlayColor.xyz == vec3(1., 0., 0.) && overlayColor.w >= .6978125 && overlayColor.w <= .698125){
        hitColor = setting(4, GameTime);
    }

    color *= vertexColor * ColorModulator;
    color.rgb = mix(hitColor.rgb, color.rgb, hitColor.a);
    color *= lightMapColor;
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
}
