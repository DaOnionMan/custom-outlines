#version 150

#moj_import <fog.glsl>
#moj_import <settings.glsl>

uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform float GameTime;

in float vertexDistance;
in vec2 texCoord0;

out vec4 fragColor;

float overlay(float a,float b){
    if(a<.5){
        return 2.*a*b;
    }else{
        return 1.-2.*(1.-a)*(1.-b);
    }
}

void main() {
    vec4 color = texture(Sampler0, texCoord0) * ColorModulator;
    if (color.a < 0.1) {
        discard;
    }
    vec3 glintOverlay = color_setting(0, GameTime);
    float glintValue = ceil(.299*(255.*glintOverlay.r)+.587*(255.*glintOverlay.g)+.114*(255.*glintOverlay.b))/255.;
    float colorValue = ceil(.299*(255.*color.r)+.587*(255.*color.g)+.114*(255.*color.b))/255.;
    color.rgb = vec3(colorValue, colorValue, colorValue);
    color.r = overlay(color.r, glintOverlay.r);
    color.g = overlay(color.g, glintOverlay.g);
    color.b = overlay(color.b, glintOverlay.b);
    
    float fade = linear_fog_fade(vertexDistance, FogStart, FogEnd);
    fragColor = vec4(color.rgb * fade, color.a);
}
