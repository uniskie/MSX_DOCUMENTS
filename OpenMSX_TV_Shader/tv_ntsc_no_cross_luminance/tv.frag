//#line   1 "tv.pre.frag"

varying vec4 texStep;
varying vec4 intCoord;
varying vec4 cornerCoord0;
varying vec4 cornerCoord1;

uniform sampler2D tex;
uniform sampler2D videoTex;
uniform float minScanline;
uniform float sizeVariance;

//#line   56 "tv.pre.frag"

    mat3 mix_mat = mat3(
        1.0, 0.0, 0.0,
        1.0, 2.0 * 1.0, 0.0,
        1.0, 0.0, 2.0 * 1.0
    );
//#line   63 "tv.pre.frag"

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

vec4 getColor(const vec2 texCoord0, const vec2 texCoord1)
{
    vec4 src = texture2D(tex, texCoord0);

//#line   221 "tv.pre.frag"
    vec4 rgb = src;
//#line   223 "tv.pre.frag"
    return rgb;
}

//#line   229 "tv.pre.frag"

//#line   231 "tv.pre.frag"
    
//#line   233 "tv.pre.frag"

vec4 encode(const vec2 texCoord0,
            const vec2 texCoord1,
            const vec2 pixCoord,
            const int FrameCount)
{

//#line   259 "tv.pre.frag"
    
    vec4 rgb = getColor(texCoord0, texCoord1);

    float l = 0.299 * rgb.r + 0.587 * rgb.g + 0.114 * rgb.b;
    vec4 distComp = fract(intCoord);
    rgb = rgb * smoothstep(
        minScanline + sizeVariance * (vec4(1.0 - l)),
        vec4(1.0),
        vec4(distComp.y) + (1.0 - minScanline) );
//#line   271 "tv.pre.frag"
    
    vec3 yiq = rgb2yiq(rgb.rgb);

//#line   279 "tv.pre.frag"

//#line   283 "tv.pre.frag"
        
        float chroma_phase =((texStep.w < 2.5) ? (2.0 * 3.14159265) : (2.0 * 3.14159265)); 
        float mod_phase = pixCoord.x * ((texStep.w < 2.5) ? (1.0 * 3.14159265 * 4.0 / 15.0) : (1.0 * 3.14159265 / 3.0)) + chroma_phase;
     //#line   287 "tv.pre.frag"

    float i_mod = cos(mod_phase);
    float q_mod = sin(mod_phase);

    yiq.yz *= vec2(i_mod, q_mod); 
    yiq *= mix_mat; 
    yiq.yz *= vec2(i_mod, q_mod); 

    return vec4(yiq, rgb.a);
}

void main()
{
    int FrameCount = 0;
    vec2 texCoord0 = cornerCoord0.xy;
    vec2 texCoord1 = cornerCoord1.xy;

    vec3 signal = vec3(0.0);
    float offset;
    vec3 sums;

    if (texStep.w < 2.5)
    {
    //#line   327 "tv.pre.frag"
    
        offset = float(1) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter1), (phase2_chroma_filter1), (phase2_chroma_filter1));
        offset = float(2) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter2), (phase2_chroma_filter2), (phase2_chroma_filter2));
        offset = float(3) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter3), (phase2_chroma_filter3), (phase2_chroma_filter3));
        offset = float(4) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter4), (phase2_chroma_filter4), (phase2_chroma_filter4));
        offset = float(5) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter5), (phase2_chroma_filter5), (phase2_chroma_filter5));
        offset = float(6) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter6), (phase2_chroma_filter6), (phase2_chroma_filter6));
        offset = float(7) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter7), (phase2_chroma_filter7), (phase2_chroma_filter7));
        offset = float(8) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter8), (phase2_chroma_filter8), (phase2_chroma_filter8));
        offset = float(9) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter9), (phase2_chroma_filter9), (phase2_chroma_filter9));
        offset = float(10) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter10), (phase2_chroma_filter10), (phase2_chroma_filter10));
        offset = float(11) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter11), (phase2_chroma_filter11), (phase2_chroma_filter11));
        offset = float(12) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter12), (phase2_chroma_filter12), (phase2_chroma_filter12));
        offset = float(13) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter13), (phase2_chroma_filter13), (phase2_chroma_filter13));
        offset = float(14) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter14), (phase2_chroma_filter14), (phase2_chroma_filter14));
        offset = float(15) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter15), (phase2_chroma_filter15), (phase2_chroma_filter15));
        offset = float(16) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter16), (phase2_chroma_filter16), (phase2_chroma_filter16));
        offset = float(17) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter17), (phase2_chroma_filter17), (phase2_chroma_filter17));
        offset = float(18) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter18), (phase2_chroma_filter18), (phase2_chroma_filter18));
        offset = float(19) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter19), (phase2_chroma_filter19), (phase2_chroma_filter19));
        offset = float(20) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter20), (phase2_chroma_filter20), (phase2_chroma_filter20));
        offset = float(21) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter21), (phase2_chroma_filter21), (phase2_chroma_filter21));
        offset = float(22) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter22), (phase2_chroma_filter22), (phase2_chroma_filter22));
        offset = float(23) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter23), (phase2_chroma_filter23), (phase2_chroma_filter23));
        offset = float(24) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter24), (phase2_chroma_filter24), (phase2_chroma_filter24));
        offset = float(25) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter25), (phase2_chroma_filter25), (phase2_chroma_filter25));
        offset = float(26) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter26), (phase2_chroma_filter26), (phase2_chroma_filter26));
        offset = float(27) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter27), (phase2_chroma_filter27), (phase2_chroma_filter27));
        offset = float(28) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter28), (phase2_chroma_filter28), (phase2_chroma_filter28));
        offset = float(29) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter29), (phase2_chroma_filter29), (phase2_chroma_filter29));
        offset = float(30) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter30), (phase2_chroma_filter30), (phase2_chroma_filter30));
        offset = float(31) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter31), (phase2_chroma_filter31), (phase2_chroma_filter31));
        offset = float(32) - 1.0; sums = encode( texCoord0 + vec2((offset - float(32)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(32)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(32)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(32) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(32) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(32) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase2_luma_filter32), (phase2_chroma_filter32), (phase2_chroma_filter32));
        signal += encode( texCoord0 + vec2((0.0) * texStep.x, 0.0) , texCoord1 + vec2((0.0) * texStep.x, 0.0) , intCoord.xy + vec2((0.0), 0.0), FrameCount).rgb *
            vec3((phase2_luma_filter33), 
                 (phase2_chroma_filter33), 
                 (phase2_chroma_filter33));
    //#line   365 "tv.pre.frag"
    
    }
    else
    {
    //#line   370 "tv.pre.frag"
    
        offset = float(1) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter1), (phase3_chroma_filter1), (phase3_chroma_filter1));
        offset = float(2) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter2), (phase3_chroma_filter2), (phase3_chroma_filter2));
        offset = float(3) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter3), (phase3_chroma_filter3), (phase3_chroma_filter3));
        offset = float(4) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter4), (phase3_chroma_filter4), (phase3_chroma_filter4));
        offset = float(5) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter5), (phase3_chroma_filter5), (phase3_chroma_filter5));
        offset = float(6) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter6), (phase3_chroma_filter6), (phase3_chroma_filter6));
        offset = float(7) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter7), (phase3_chroma_filter7), (phase3_chroma_filter7));
        offset = float(8) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter8), (phase3_chroma_filter8), (phase3_chroma_filter8));
        offset = float(9) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter9), (phase3_chroma_filter9), (phase3_chroma_filter9));
        offset = float(10) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter10), (phase3_chroma_filter10), (phase3_chroma_filter10));
        offset = float(11) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter11), (phase3_chroma_filter11), (phase3_chroma_filter11));
        offset = float(12) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter12), (phase3_chroma_filter12), (phase3_chroma_filter12));
        offset = float(13) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter13), (phase3_chroma_filter13), (phase3_chroma_filter13));
        offset = float(14) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter14), (phase3_chroma_filter14), (phase3_chroma_filter14));
        offset = float(15) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter15), (phase3_chroma_filter15), (phase3_chroma_filter15));
        offset = float(16) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter16), (phase3_chroma_filter16), (phase3_chroma_filter16));
        offset = float(17) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter17), (phase3_chroma_filter17), (phase3_chroma_filter17));
        offset = float(18) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter18), (phase3_chroma_filter18), (phase3_chroma_filter18));
        offset = float(19) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter19), (phase3_chroma_filter19), (phase3_chroma_filter19));
        offset = float(20) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter20), (phase3_chroma_filter20), (phase3_chroma_filter20));
        offset = float(21) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter21), (phase3_chroma_filter21), (phase3_chroma_filter21));
        offset = float(22) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter22), (phase3_chroma_filter22), (phase3_chroma_filter22));
        offset = float(23) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter23), (phase3_chroma_filter23), (phase3_chroma_filter23));
        offset = float(24) - 1.0; sums = encode( texCoord0 + vec2((offset - float(24)) * texStep.x, 0.0) , texCoord1 + vec2((offset - float(24)) * texStep.x, 0.0) , intCoord.xy + vec2((offset - float(24)), 0.0), FrameCount).rgb + encode( texCoord0 + vec2((float(24) - offset) * texStep.x, 0.0) , texCoord1 + vec2((float(24) - offset) * texStep.x, 0.0) , intCoord.xy + vec2((float(24) - offset), 0.0), FrameCount).rgb; signal += sums * vec3((phase3_luma_filter24), (phase3_chroma_filter24), (phase3_chroma_filter24));
        signal += encode( texCoord0 + vec2((0.0) * texStep.x, 0.0) , texCoord1 + vec2((0.0) * texStep.x, 0.0) , intCoord.xy + vec2((0.0), 0.0), FrameCount).rgb *
            vec3((phase3_luma_filter25), 
                 (phase3_chroma_filter25), 
                 (phase3_chroma_filter25));
    //#line   400 "tv.pre.frag"
    
    }
    //#line   403 "tv.pre.frag"

//#line   409 "tv.pre.frag"

    vec3 rgb = yiq2rgb(signal);
    gl_FragColor = vec4(rgb, 1.0);

}
