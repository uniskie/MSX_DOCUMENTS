uniform mat4 u_mvpMatrix;
uniform vec3 texSize; // xy = texSize1,  xz = texSize2

attribute vec4 a_position;
attribute vec3 a_texCoord;

varying vec4 texStep;   // pixel_size(x1, y, x2), phase
varying vec4 intCoord;
varying vec4 cornerCoord0;
varying vec4 cornerCoord1;

// If you want to adjust the amount of bleeding, please play with this value.
#define BLUR_MILTIPLE   (10.0/32.0)//(8.0/32.0)

void main()
{
    float pix_mul = (texSize.x > 400.0) ? BLUR_MILTIPLE*1.5 : BLUR_MILTIPLE;

    texStep.xyz = pix_mul / texSize.xyz;            // pixel_size(x1, y, x2)
    texStep.w = (texSize.x > 400.0) ? 2.0 : 3.0;    // phaze

    gl_Position = u_mvpMatrix * a_position;
    intCoord.xy = a_texCoord.xy * texSize.xy;
    intCoord.zw = -intCoord.xy;
    cornerCoord0 = vec4(a_texCoord.xy,
                        a_texCoord.xy + texStep.xy);
    cornerCoord1 = vec4(a_texCoord.xz,
                        a_texCoord.xz + texStep.xz);
}
