// NTSC effect (based on Themaister's NTSC shader)
#define NTSC

// 画質指定 : COMPOSITE も SVIDEO も無ければ 白黒(bw)と画質(quality)をユニフォームで指定
//---------------------
#define COMPOSITE
//#define SVIDEO

// PHASE指定 : 指定がなければテクスチャサイズから自動決定
//---------------------
//#define TWO_PHASE
//#define THRERE_PHASE

// additional filter
//---------------------
  #define vSATU(x)      (x * 1.25)  // 彩度を強調する
//#define vSATU(x)      (x)         // 彩度を強調しない

//#define vLUMA(x,c)    ((x) * (1.40 - float(c) * 0.02))    // 輝度マルチサンプルの重みに細工する(※モアレ発生)
  #define vLUMA(x,c)    (x)                                 // 輝度マルチサンプルの重みに細工しない

// begin params
//---------------------
#define PI 3.14159265

varying vec4 texStep;
varying vec4 intCoord;
varying vec4 cornerCoord0;
varying vec4 cornerCoord1;

uniform sampler2D tex;
uniform sampler2D videoTex;
uniform float minScanline;
uniform float sizeVariance;

#if defined(COMPOSITE)
   #define SATURATION  1.0
   #define BRIGHTNESS  0.95
   #define ARTIFACTING 1.0
   #define FRINGING    0.75
#elif defined(SVIDEO)
    #define SATURATION  1.0
    #define BRIGHTNESS  1.0
    #define ARTIFACTING 0.0
    #define FRINGING    0.0
#else
    uniform float quality;
    uniform float bw;
    #define mix_mat mat3(BRIGHTNESS, FRINGING, FRINGING, ARTIFACTING, 2.0 * SATURATION, 0.0, ARTIFACTING, 0.0, 2.0 * SATURATION)
#endif
#if defined(COMPOSITE) || defined(SVIDEO)
    mat3 mix_mat = mat3(
        BRIGHTNESS, FRINGING, FRINGING,
        ARTIFACTING, 2.0 * SATURATION, 0.0,
        ARTIFACTING, 0.0, 2.0 * SATURATION
    );
#endif
// end params

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

// begin ntsc-decode-filter-2phase
#define phase2_TAPS 32
float phase2_luma_filter1  = -0.000174844;
float phase2_luma_filter2  = -0.000205844;
float phase2_luma_filter3  = -0.000149453;
float phase2_luma_filter4  = -0.000051693;
float phase2_luma_filter5  =  0.000000000;
float phase2_luma_filter6  = -0.000066171;
float phase2_luma_filter7  = -0.000245058;
float phase2_luma_filter8  = -0.000432928;
float phase2_luma_filter9  = -0.000472644;
float phase2_luma_filter10 = -0.000252236;
float phase2_luma_filter11 =  0.000198929;
float phase2_luma_filter12 =  0.000687058;
float phase2_luma_filter13 =  0.000944112;
float phase2_luma_filter14 =  0.000803467;
float phase2_luma_filter15 =  0.000363199;
float phase2_luma_filter16 =  0.000013422;
float phase2_luma_filter17 =  0.000253402;
float phase2_luma_filter18 =  0.001339461;
float phase2_luma_filter19 =  0.002932972;
float phase2_luma_filter20 =  0.003983485;
float phase2_luma_filter21 =  0.00302668 ;
float phase2_luma_filter22 = -0.001102056;
float phase2_luma_filter23 = -0.008373026;
float phase2_luma_filter24 = -0.016897700;
float phase2_luma_filter25 = -0.022914480;
float phase2_luma_filter26 = -0.021642347;
float phase2_luma_filter27 = -0.008863273;
float phase2_luma_filter28 =  0.017271957;
float phase2_luma_filter29 =  0.054921920;
float phase2_luma_filter30 =  0.098342579;
float phase2_luma_filter31 =  0.139044281;
float phase2_luma_filter32 =  0.168055832;
float phase2_luma_filter33 =  0.178571429;

float phase2_chroma_filter1  = 0.001384762;
float phase2_chroma_filter2  = 0.001678312;
float phase2_chroma_filter3  = 0.002021715;
float phase2_chroma_filter4  = 0.002420562;
float phase2_chroma_filter5  = 0.002880460;
float phase2_chroma_filter6  = 0.003406879;
float phase2_chroma_filter7  = 0.004004985;
float phase2_chroma_filter8  = 0.004679445;
float phase2_chroma_filter9  = 0.005434218;
float phase2_chroma_filter10 = 0.006272332;
float phase2_chroma_filter11 = 0.007195654;
float phase2_chroma_filter12 = 0.008204665;
float phase2_chroma_filter13 = 0.009298238;
float phase2_chroma_filter14 = 0.010473450;
float phase2_chroma_filter15 = 0.011725413;
float phase2_chroma_filter16 = 0.013047155;
float phase2_chroma_filter17 = 0.014429548;
float phase2_chroma_filter18 = 0.015861306;
float phase2_chroma_filter19 = 0.017329037;
float phase2_chroma_filter20 = 0.018817382;
float phase2_chroma_filter21 = 0.020309220;
float phase2_chroma_filter22 = 0.021785952;
float phase2_chroma_filter23 = 0.023227857;
float phase2_chroma_filter24 = 0.024614500;
float phase2_chroma_filter25 = 0.025925203;
float phase2_chroma_filter26 = 0.027139546;
float phase2_chroma_filter27 = 0.028237893;
float phase2_chroma_filter28 = 0.029201910;
float phase2_chroma_filter29 = 0.030015081;
float phase2_chroma_filter30 = 0.030663170;
float phase2_chroma_filter31 = 0.031134640;
float phase2_chroma_filter32 = 0.031420995;
float phase2_chroma_filter33 = 0.031517031;
// end ntsc-decode-filter-2phase

// begin ntsc-decode-filter-3phase
#define phase3_TAPS 24
float phase3_luma_filter1  = -0.000012020;
float phase3_luma_filter2  = -0.000022146;
float phase3_luma_filter3  = -0.000013155;
float phase3_luma_filter4  = -0.000012020;
float phase3_luma_filter5  = -0.000049979;
float phase3_luma_filter6  = -0.000113940;
float phase3_luma_filter7  = -0.000122150;
float phase3_luma_filter8  = -0.000005612;
float phase3_luma_filter9  =  0.000170516;
float phase3_luma_filter10 =  0.000237199;
float phase3_luma_filter11 =  0.000169640;
float phase3_luma_filter12 =  0.000285688;
float phase3_luma_filter13 =  0.000984574;
float phase3_luma_filter14 =  0.002018683;
float phase3_luma_filter15 =  0.002002275;
float phase3_luma_filter16 = -0.000909882;
float phase3_luma_filter17 = -0.007049081;
float phase3_luma_filter18 = -0.013222860;
float phase3_luma_filter19 = -0.012606931;
float phase3_luma_filter20 =  0.002460860;
float phase3_luma_filter21 =  0.035868225;
float phase3_luma_filter22 =  0.084016453;
float phase3_luma_filter23 =  0.135563500;
float phase3_luma_filter24 =  0.175261268;
float phase3_luma_filter25 =  0.190176552;

float phase3_chroma_filter1  = -0.000118847;
float phase3_chroma_filter2  = -0.000271306;
float phase3_chroma_filter3  = -0.000502642;
float phase3_chroma_filter4  = -0.000930833;
float phase3_chroma_filter5  = -0.001451013;
float phase3_chroma_filter6  = -0.002064744;
float phase3_chroma_filter7  = -0.002700432;
float phase3_chroma_filter8  = -0.003241276;
float phase3_chroma_filter9  = -0.003524948;
float phase3_chroma_filter10 = -0.003350284;
float phase3_chroma_filter11 = -0.002491729;
float phase3_chroma_filter12 = -0.000721149;
float phase3_chroma_filter13 =  0.002164659;
float phase3_chroma_filter14 =  0.006313635;
float phase3_chroma_filter15 =  0.011789103;
float phase3_chroma_filter16 =  0.018545660;
float phase3_chroma_filter17 =  0.026414396;
float phase3_chroma_filter18 =  0.035100710;
float phase3_chroma_filter19 =  0.044196567;
float phase3_chroma_filter20 =  0.053207202;
float phase3_chroma_filter21 =  0.061590275;
float phase3_chroma_filter22 =  0.068803602;
float phase3_chroma_filter23 =  0.074356193;
float phase3_chroma_filter24 =  0.077856564;
float phase3_chroma_filter25 =  0.079052396;
// end ntsc-decode-filter-3phase


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

#if defined(TWO_PHASE)
    #define phase   2.0
#elif defined(THRERE_PHASE)
    #define phase   3.0
#else
    #define phase   texStep.w
#endif


#define MSX_HSCAN_RATE  1.0//(0.7485380) // (256.0 / 342.0)//ここを変えるとfilter値の変更も必要になる(※モアレ発生)
#define MSX_HSCAN_SHIFT 2.0//((342.0-256.0))

#define CHROMA_MOD_FREQ2    (MSX_HSCAN_RATE * PI * 4.0 / 15.0)
#define CHROMA_MOD_FREQ3    (MSX_HSCAN_RATE * PI / 3.0)
#define CHROMA_PHASE_SHIFT2 (MSX_HSCAN_SHIFT * PI)
#define CHROMA_PHASE_SHIFT3 (MSX_HSCAN_SHIFT * PI)

//#define CHROMA_MOD_FREQ   ((phase < 2.5) ? (4.0 * PI / 15.0) : (PI / 3.0))
#define CHROMA_MOD_FREQ     ((phase < 2.5) ? CHROMA_MOD_FREQ2 : CHROMA_MOD_FREQ3)
#define CHROMA_PHASE_SHIFT  ((phase < 2.5) ? CHROMA_PHASE_SHIFT2 : CHROMA_PHASE_SHIFT3)

// Sub : Encode YIQ (RGB -> YIQ) -> mix
//-----------------------------------------------------------------
vec4 encode(const vec2 texCoord0,
            const vec2 texCoord1,
            const vec2 pixCoord,
            const int FrameCount)
{
#if !defined(COMPOSITE) && !defined(SVIDEO)
    float ARTIFACTING = 1.0 - quality;
    float FRINGING = 1.0 - quality;
    float SATURATION = 1.0 - bw;
#endif
    
    vec4 rgb = getColor(texCoord0, texCoord1);
    
#if 1
    // 明るい部分を縦に膨張させる(Scanline有効時)
    float l = 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
    vec4 distComp = fract(intCoord);
    rgb = rgb * smoothstep(
        minScanline + sizeVariance * (vec4(1.0 - l)),
        vec4(1.0),
        vec4(distComp.y) + (1.0 - minScanline) );
#endif
    
    vec3 yiq = rgb2yiq(rgb.rgb);

    #if defined(TWO_PHASE)
        //float chroma_phase = PI * (mod(pixCoord.y, 2.0) + float(FrameCount));
        float chroma_phase = CHROMA_PHASE_SHIFT2; // MSXはy軸で位相が変化しない
        float mod_phase = pixCoord.x * CHROMA_MOD_FREQ2 + chroma_phase;
    #elif defined(THREE_PHASE)
        //float chroma_phase = 0.6667 * PI * (mod(pixCoord.y, 3.0) + float(FrameCount));
        float chroma_phase = CHROMA_PHASE_SHIFT3; // MSXはy軸で位相が変化しない
        float mod_phase = pixCoord.x * CHROMA_MOD_FREQ3 + chroma_phase;
    #else
        //float chroma_phase = (phase < 2.5) ? PI * (mod(pixCoord.y, 2.0) + mod(float(FrameCount), 2.)) : 0.6667 * PI * (mod(pixCoord.y, 3.0) + mod(float(FrameCount), 2.));
        float chroma_phase =CHROMA_PHASE_SHIFT; // MSXはy軸で位相が変化しない
        float mod_phase = pixCoord.x * CHROMA_MOD_FREQ + chroma_phase;
     #endif

    float i_mod = cos(mod_phase);
    float q_mod = sin(mod_phase);

    yiq.yz *= vec2(i_mod, q_mod); // Modulate.
    yiq *= mix_mat; // Cross-talk.
    yiq.yz *= vec2(i_mod, q_mod); // Demodulate.

    return vec4(yiq, rgb.a);
}

#define fetch_offset(offset) \
   encode( texCoord0 + vec2((offset) * texStep.x, 0.0) \
         , texCoord1 + vec2((offset) * texStep.x, 0.0) \
         , intCoord.xy + vec2((offset), 0.0), FrameCount).rgb

// Main : [encode YIQ -> mix] -> split -> decode YIQ
//-----------------------------------------------------------------
void main()
{
    int FrameCount = 0;
    vec2 texCoord0 = cornerCoord0.xy;
    vec2 texCoord1 = cornerCoord1.xy;

#if 1
    vec3 signal = vec3(0.0);
    float offset;
    vec3 sums;

    #define macro_loopz(p,c) offset = float(c) - 1.0; \
        sums = fetch_offset(offset - float(phase##p##_TAPS) ) \
             + fetch_offset(float(phase##p##_TAPS) - offset); \
        signal += sums * vec3(vLUMA(phase##p##_luma_filter##c, c), \
                              vSATU(phase##p##_chroma_filter##c), \
                              vSATU(phase##p##_chroma_filter##c));
    
    #if !defined(TWO_PHASE) && !defined(THREE_PHASE)
    if (phase < 2.5)
    {
    #endif
    #if defined(TWO_PHASE) || !defined(THREE_PHASE)
        macro_loopz(2, 1)
        macro_loopz(2, 2)
        macro_loopz(2, 3)
        macro_loopz(2, 4)
        macro_loopz(2, 5)
        macro_loopz(2, 6)
        macro_loopz(2, 7)
        macro_loopz(2, 8)
        macro_loopz(2, 9)
        macro_loopz(2, 10)
        macro_loopz(2, 11)
        macro_loopz(2, 12)
        macro_loopz(2, 13)
        macro_loopz(2, 14)
        macro_loopz(2, 15)
        macro_loopz(2, 16)
        macro_loopz(2, 17)
        macro_loopz(2, 18)
        macro_loopz(2, 19)
        macro_loopz(2, 20)
        macro_loopz(2, 21)
        macro_loopz(2, 22)
        macro_loopz(2, 23)
        macro_loopz(2, 24)
        macro_loopz(2, 25)
        macro_loopz(2, 26)
        macro_loopz(2, 27)
        macro_loopz(2, 28)
        macro_loopz(2, 29)
        macro_loopz(2, 30)
        macro_loopz(2, 31)
        macro_loopz(2, 32)
        signal += fetch_offset(0.0) *
            vec3(vLUMA(phase2_luma_filter33, 0), 
                 vSATU(phase2_chroma_filter33), 
                 vSATU(phase2_chroma_filter33));
    #endif
    #if !defined(TWO_PHASE) && !defined(THREE_PHASE)
    }
    else
    {
    #endif
    #if !defined(TWO_PHASE) || defined(THREE_PHASE)
        macro_loopz(3, 1)
        macro_loopz(3, 2)
        macro_loopz(3, 3)
        macro_loopz(3, 4)
        macro_loopz(3, 5)
        macro_loopz(3, 6)
        macro_loopz(3, 7)
        macro_loopz(3, 8)
        macro_loopz(3, 9)
        macro_loopz(3, 10)
        macro_loopz(3, 11)
        macro_loopz(3, 12)
        macro_loopz(3, 13)
        macro_loopz(3, 14)
        macro_loopz(3, 15)
        macro_loopz(3, 16)
        macro_loopz(3, 17)
        macro_loopz(3, 18)
        macro_loopz(3, 19)
        macro_loopz(3, 20)
        macro_loopz(3, 21)
        macro_loopz(3, 22)
        macro_loopz(3, 23)
        macro_loopz(3, 24)
        signal += fetch_offset(0.0) *
            vec3(vLUMA(phase3_luma_filter25, 0), 
                 vSATU(phase3_chroma_filter25), 
                 vSATU(phase3_chroma_filter25));
    #endif
    #if !defined(TWO_PHASE) && !defined(THREE_PHASE)
    }
    #endif

#else

    vec3 signal = encode(texCoord0, texCoord1, intCoord.xy, FrameCount).rgb;
    
#endif
    
    // YIQ -> RGB
    vec3 rgb = yiq2rgb(signal);
    gl_FragColor = vec4(rgb, 1.0);

//  gl_FragColor.xyz = vec3(sizeVariance);
}
