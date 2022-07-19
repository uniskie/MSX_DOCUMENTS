// NTSC effect
#define NTSC

#define COMPOSITE

#define SATURARION_F(x)	((x) * 1.5)

// begin params
#define PI 3.14159265

//#define CHROMA_MOD_FREQ (4.0 * PI / 15.0)
#define CHROMA_MOD_FREQ (2.0 * PI / 15.0)

#if defined(COMPOSITE)
	#define SATURATION 1.0
	#define BRIGHTNESS 1.0
	#define ARTIFACTING 1.0
	#define FRINGING 0.0
#elif defined(SVIDEO)
	#define SATURATION 1.0
	#define BRIGHTNESS 1.0
	#define ARTIFACTING 0.0
	#define FRINGING 0.0
#endif
// end params

#if defined(COMPOSITE) || defined(SVIDEO)
mat3 mix_mat = mat3(
	BRIGHTNESS, FRINGING, FRINGING,
	ARTIFACTING, 2.0 * SATURATION, 0.0,
	ARTIFACTING, 0.0, 2.0 * SATURATION
);
#endif

// begin ntsc-rgbyuv
const mat3 yiq2rgb_mat = mat3(
   1.0, 0.956, 0.6210,
   1.0, -0.2720, -0.6474,
   1.0, -1.1060, 1.7046);

vec3 yiq2rgb(vec3 yiq)
{
   return yiq * yiq2rgb_mat;
}

const mat3 yiq_mat = mat3(
      0.2989, 0.5870, 0.1140,
      0.5959, -0.2744, -0.3216,
      0.2115, -0.5229, 0.3114
);

vec3 rgb2yiq(vec3 col)
{
   return col * yiq_mat;
}

#define TAPS 32
float luma_filter1  = -0.000174844 * 0.75;
float luma_filter2  = -0.000205844 * 0.60;
float luma_filter3  = -0.000149453 * 0.50;
float luma_filter4  = -0.000051693 * 0.50;
float luma_filter5  =  0.000000000 * 0.50;
float luma_filter6  = -0.000066171 * 0.50;
float luma_filter7  = -0.000245058 * 0.50;
float luma_filter8  = -0.000432928 * 0.50;
float luma_filter9  = -0.000472644 * 0.50;
float luma_filter10 = -0.000252236 * 0.50;
float luma_filter11 =  0.000198929 * 0.25;
float luma_filter12 =  0.000687058 * 0.25;
float luma_filter13 =  0.000944112 * 0.25;
float luma_filter14 =  0.000803467 * 0.25;
float luma_filter15 =  0.000363199 * 0.25;
float luma_filter16 =  0.000013422 * 0.25;
float luma_filter17 =  0.000253402 * 0.25;
float luma_filter18 =  0.001339461 * 0.25;
float luma_filter19 =  0.002932972 * 0.25;
float luma_filter20 =  0.003983485 * 0.25;
float luma_filter21 =  0.00302668  * 0.25;
float luma_filter22 = -0.001102056 * 0.125;
float luma_filter23 = -0.008373026 * 0.125;
float luma_filter24 = -0.016897700 * 0.125;
float luma_filter25 = -0.022914480 * 0.125;
float luma_filter26 = -0.021642347 * 0.125;
float luma_filter27 = -0.008863273 * 0.125;
float luma_filter28 =  0.017271957 * 0.125;
float luma_filter29 =  0.054921920 * 0.125;
float luma_filter30 =  0.098342579 * 0.125;
float luma_filter31 =  0.139044281 * 0.125;
float luma_filter32 =  0.168055832 * 0.125;
float luma_filter33 =  0.178571429 * 4.75;

float chroma_filter1  = 0.001384762;
float chroma_filter2  = 0.001678312;
float chroma_filter3  = 0.002021715;
float chroma_filter4  = 0.002420562;
float chroma_filter5  = 0.002880460;
float chroma_filter6  = 0.003406879;
float chroma_filter7  = 0.004004985;
float chroma_filter8  = 0.004679445;
float chroma_filter9  = 0.005434218;
float chroma_filter10 = 0.006272332;
float chroma_filter11 = 0.007195654;
float chroma_filter12 = 0.008204665;
float chroma_filter13 = 0.009298238;
float chroma_filter14 = 0.010473450;
float chroma_filter15 = 0.011725413;
float chroma_filter16 = 0.013047155;
float chroma_filter17 = 0.014429548;
float chroma_filter18 = 0.015861306;
float chroma_filter19 = 0.017329037;
float chroma_filter20 = 0.018817382;
float chroma_filter21 = 0.020309220;
float chroma_filter22 = 0.021785952;
float chroma_filter23 = 0.023227857;
float chroma_filter24 = 0.024614500;
float chroma_filter25 = 0.025925203;
float chroma_filter26 = 0.027139546;
float chroma_filter27 = 0.028237893;
float chroma_filter28 = 0.029201910;
float chroma_filter29 = 0.030015081;
float chroma_filter30 = 0.030663170;
float chroma_filter31 = 0.031134640;
float chroma_filter32 = 0.031420995;
float chroma_filter33 = 0.031517031;
// end ntsc-decode-filter-3phase

//---------------------

uniform sampler2D tex;
uniform sampler2D videoTex;
uniform float minScanline;
uniform float sizeVariance;

varying vec3 texStep;
varying vec4 intCoord;
varying vec4 cornerCoord0;
varying vec4 cornerCoord1;

vec4 getColor(const vec2 texCoord0, const vec2 texCoord1)
{
	vec4 src = texture2D(tex, texCoord0);
#if SUPERIMPOSE
	vec4 vid = texture2D(videoTex, texCoord1);
	vec4 rgb = mix(vid, src, src.a);
#else
	vec4 rgb = src;
#endif
	return rgb;
}

// RGB -> YIQ -> Decode
vec4 encode(const vec2 texCoord0,
            const vec2 texCoord1,
            const vec2 pixCoord,
    		const int FrameCount)
{

	vec4 rgb = getColor(texCoord0, texCoord1);
#if 1
	vec4 distComp = fract(intCoord);
	rgb = rgb * smoothstep(
		minScanline + sizeVariance * (vec4(1.0) - rgb),
		vec4(1.0),
		vec4(distComp.y) + (1.0 - minScanline) );
#endif
	vec3 yiq = rgb2yiq(rgb.rgb);

	float chroma_phase = PI * 1.2;//(mod(pixCoord.y, 2.0) + float(FrameCount));
	float mod_phase = pixCoord.x * CHROMA_MOD_FREQ + chroma_phase;

	float i_mod = cos(mod_phase);
	float q_mod = sin(mod_phase);

	yiq.yz *= vec2(i_mod, q_mod); // Modulate.
	yiq *= mix_mat; // Cross-talk.
	yiq.yz *= vec2(i_mod, q_mod); // Demodulate.
//	yiq.yz = vec2(0.0);

	return vec4(yiq, rgb.a);
}

#define fetch_offset(offset) \
   encode( texCoord0 + vec2((offset) * texStep.x, 0.0) \
         , texCoord1 + vec2((offset) * texStep.x, 0.0) \
         , intCoord.xy + vec2((offset), 0.0), FrameCount).rgb

void main()
{
	int FrameCount = 0;
	vec2 texCoord0 = cornerCoord0.xy;
	vec2 texCoord1 = cornerCoord1.xy;

	// envoded YIQ -> decode YIQ

#if 1
	vec3 signal = vec3(0.0);
	float offset;
	vec3 sums;

	#define macro_loopz(c) offset = float(c) - 1.0; \
		sums = fetch_offset(offset - float(TAPS) ) \
		     + fetch_offset(float(TAPS) - offset); \
		signal += sums * vec3(luma_filter##c, SATURARION_F(chroma_filter##c), SATURARION_F(chroma_filter##c));
	
	macro_loopz(1)
	macro_loopz(2)
	macro_loopz(3)
	macro_loopz(4)
	macro_loopz(5)
	macro_loopz(6)
	macro_loopz(7)
	macro_loopz(8)
	macro_loopz(9)
	macro_loopz(10)
	macro_loopz(11)
	macro_loopz(12)
	macro_loopz(13)
	macro_loopz(14)
	macro_loopz(15)
	macro_loopz(16)
	macro_loopz(17)
	macro_loopz(18)
	macro_loopz(19)
	macro_loopz(20)
	macro_loopz(21)
	macro_loopz(22)
	macro_loopz(23)
	macro_loopz(24)
	macro_loopz(25)
	macro_loopz(26)
	macro_loopz(27)
	macro_loopz(28)
	macro_loopz(29)
	macro_loopz(30)
	macro_loopz(31)
	macro_loopz(32)

	signal += fetch_offset(0.0) *
		vec3(luma_filter33, chroma_filter33, chroma_filter33);

#else

	vec3 signal = encode(texCoord0, texCoord1, intCoord.xy, FrameCount).rgb;
	
#endif
	
	// YIQ -> RGB
	vec3 rgb = yiq2rgb(signal);
	gl_FragColor = vec4(rgb, 1.0);

//	gl_FragColor.xyz = vec3(sizeVariance);
}
