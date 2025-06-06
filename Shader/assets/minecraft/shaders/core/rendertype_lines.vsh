#version 150

#moj_import <fog.glsl>
#moj_import <settings.glsl>

in vec3 Position;
in vec4 Color;
in vec3 Normal;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform float LineWidth;
uniform vec2 ScreenSize;
uniform int FogShape;
uniform float GameTime;

out float vertexDistance;
out vec4 vertexColor;

const float VIEW_SHRINK = 1.0 - (1.0 / 256.0);
const mat4 VIEW_SCALE = mat4(
    VIEW_SHRINK, 0.0, 0.0, 0.0,
    0.0, VIEW_SHRINK, 0.0, 0.0,
    0.0, 0.0, VIEW_SHRINK, 0.0,
    0.0, 0.0, 0.0, 1.0
);

void main() {
    float Width = LineWidth;

    if(Color == vec4(1., 1., 1., 1.)){
        // main hitbox color
        vertexColor = setting(2, GameTime);
        Width = float_setting(0);

    }else if(Color == vec4(1., 0., 0., 1.)){
        // hitbox eye level color
        vertexColor = setting(1, GameTime);
        Width = float_setting(0);

    }else if(Color == vec4(0., 0., 1., 1.)){
        // hitbox direction line color
        vertexColor = setting(0, GameTime);
        Width = float_setting(0);

    }else if(Color == vec4(0., 0., 0., .4)){
        // block outline
        vertexColor = setting(3, GameTime);
        Width = float_setting(1);

    }else{
        vertexColor = Color;
        Width = LineWidth;
    }

    vec4 linePosStart = ProjMat * VIEW_SCALE * ModelViewMat * vec4(Position, 1.0);
    vec4 linePosEnd = ProjMat * VIEW_SCALE * ModelViewMat * vec4(Position + Normal, 1.0);

    vec3 ndc1 = linePosStart.xyz / linePosStart.w;
    vec3 ndc2 = linePosEnd.xyz / linePosEnd.w;

    vec2 lineScreenDirection = normalize((ndc2.xy - ndc1.xy) * ScreenSize);
    vec2 lineOffset = vec2(-lineScreenDirection.y, lineScreenDirection.x) * Width / ScreenSize;

    if (lineOffset.x < 0.0) {
        lineOffset *= -1.0;
    }

    if (gl_VertexID % 2 == 0) {
        gl_Position = vec4((ndc1 + vec3(lineOffset, 0.0)) * linePosStart.w, linePosStart.w);
    } else {
        gl_Position = vec4((ndc1 - vec3(lineOffset, 0.0)) * linePosStart.w, linePosStart.w);
    }

    vertexDistance = fog_distance(ModelViewMat, Position, FogShape);
}
