#version 150

// hitbox
#define hitbox_direction_color vec3(0, 0, 255)
#define hitbox_direction_opacity 255
#define hitbox_direction_rainbow true

#define hitbox_eye_color ivec3(255, 0, 0)
#define hitbox_eye_opacity 255
#define hitbox_eye_rainbow true

#define hitbox_box_color ivec3(255, 255, 255)
#define hitbox_box_opacity 255
#define hitbox_box_rainbow true

#define hitbox_width 2.5

// block outline
#define block_outline_color ivec3(0, 0, 0)
#define block_outline_opacity 102
#define block_outline_rainbow true

#define block_outline_width 2.5

// hit color
#define hit_color ivec3(255, 0, 0)
#define hit_opacity 178
#define hit_rainbow true

// enchant glint
#define glint_color ivec3(154, 79, 245)
#define glint_rainbow true

//do not change things below this

vec4 rainbow (float time, int opacity) {
    float rainbowHue = mod(time * 1600., 10.);
    vec3 c2 = vec3(rainbowHue/10. ,.99, .99);
    vec4 K2 = vec4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    vec3 p2 = abs(fract(c2.xxx + K2.xyz) * 6.0 - K2.www);
    vec3 c3 = c2.z * mix(K2.xxx, clamp(p2 - K2.xxx, 0.0, 1.0), c2.y);
    return vec4(c3.rgb, float(opacity)/255);
}

vec4 convert (ivec4 color) {
    return vec4(float(color.x), float(color.y), float(color.z), float(color.w)) / vec4(255.0, 255.0, 255.0, 255.0);
}

vec4 setting (int type, float gametime) {
    if( type == 0 ) {
        // hitbox direction
        if(hitbox_direction_rainbow){
            return rainbow(gametime, hitbox_direction_opacity);
        }else{
            return convert(ivec4(hitbox_direction_color.rgb, hitbox_direction_opacity));
        }

    }else if( type == 1 ) {
        // hitbox eye
        if(hitbox_eye_rainbow){
            return rainbow(gametime, hitbox_eye_opacity);
        }else{
            return convert(ivec4(hitbox_eye_color.rgb, hitbox_eye_opacity));
        }

    }else if( type == 2 ) {
        // hitbox box
        if(hitbox_box_rainbow){
            return rainbow(gametime, hitbox_box_opacity);
        }else{
            return convert(ivec4(hitbox_box_color.rgb, hitbox_box_opacity));
        }

    }else if( type == 3 ) {
        // block outline
        if(block_outline_rainbow){
            return rainbow(gametime, block_outline_opacity);
        }else{
            return convert(ivec4(block_outline_color.rgb, block_outline_opacity));
        }

    }else if( type == 4 ) {
        // hit
        if(hit_rainbow){
            return rainbow(gametime, hit_opacity);
        }else{
            return convert(ivec4(hit_color.rgb, hit_opacity));
        }

    }
}

float float_setting(int type) {
    if( type == 0 ) {
        return hitbox_width;

    }else if( type == 1 ) {
        return block_outline_width;

    }
}

vec3 color_setting(int type, float gametime) {
    if(type == 0){
        if(glint_rainbow) {
            return vec3(rainbow(gametime, 255).rgb);
        }else{
            return vec3(float(glint_color.r)/255., float(glint_color.g)/255., float(glint_color.b)/255.);
        }

    }
}

