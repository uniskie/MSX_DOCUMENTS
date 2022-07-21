uniform mat4 u_mvpMatrix;
uniform vec3 texSize; // xy = texSize1,  xz = texSize2

attribute vec4 a_position;
attribute vec3 a_texCoord;

varying vec3 texStep;
varying vec4 intCoord;
varying vec4 cornerCoord0;
varying vec4 cornerCoord1;

// If you want to adjust the amount of bleeding, please play with this value.
#define BLUR_MILTIPLE	0.169

void main()
{
	float pix_mul = (texSize.x > 500.0) ? BLUR_MILTIPLE*2.0 : BLUR_MILTIPLE;
	gl_Position = u_mvpMatrix * a_position;
	intCoord.xy = a_texCoord.xy * texSize.xy;
	intCoord.zw = -intCoord.xy;
	texStep.xyz = pix_mul / texSize.xyz;
	cornerCoord0 = vec4(a_texCoord.xy,
	                    a_texCoord.xy + texStep.xy);
	cornerCoord1 = vec4(a_texCoord.xz,
	                    a_texCoord.xz + texStep.xz);
}
