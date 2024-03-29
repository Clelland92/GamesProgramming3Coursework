#ifdef _3DSMAX_
int ParamID = 0x0003;		
#endif 
#ifdef _XSI_
#define Main Static
#endif 

#ifndef FXCOMPOSER_VERSION	
#define FXCOMPOSER_VERSION 180
#endif 

#ifndef DIRECT3D_VERSION
#define DIRECT3D_VERSION 0x900
#endif 

#define FLIP_TEXTURE_Y


#define LIGHT_COORDS "World"

float Script : STANDARDSGLOBAL <
    string UIWidget = "none";
    string ScriptClass = "object";
    string ScriptOrder = "standard";
    string ScriptOutput = "color";
    string Script = "Technique=Technique?Main:Main10;";
> = 0.8;

/**** UNTWEAKABLES: Hidden & Automatically-Tracked Parameters **********/

// transform object vertices to world-space:
float4x4 gWorldXf : World < string UIWidget="None"; >;
// transform object normals, tangents, & binormals to world-space:
float4x4 gWorldITXf : WorldInverseTranspose < string UIWidget="None"; >;
// transform object vertices to view space and project them in perspective:
float4x4 gWvpXf : WorldViewProjection < string UIWidget="None"; >;
// provide tranform from "view" or "eye" coords back to world-space:
float4x4 gViewIXf : ViewInverse < string UIWidget="None"; >;

/*** tweakables ***/

/// Point Lamp 0 ////////////
float3 gLamp0Pos : POSITION <
    string Object = "PointLight0";
    string UIName =  "Lamp 0 Position";
    string Space = (LIGHT_COORDS);
> = {-0.5f,2.0f,1.25f};
float3 gLamp0Color : SPECULAR <
    string UIName =  "Lamp 0";
    string Object = "Pointlight0";
    string UIWidget = "Color";
> = {1.0f,1.0f,1.0f};


// Ambient Light
float3 gAmbiColor : AMBIENT <
    string UIName =  "Ambient Light";
    string UIWidget = "Color";
> = {0.17f,0.17f,0.17f};

//// values for "lighter" bands

float3 gWoodColor1 <
    string UIName =  "Lighter Wood";
    string UIWidget = "Color";
> = {0.85f, 0.55f, 0.01f};

float gKs1 <
    string UIWidget = "slider";
    float UIMin = 0.0;
    float UIMax = 2.0;
    float UIStep = 0.01;
    string UIName =  "Lighter Wood Specularity";
> = 0.5;

// values for "darker" bands"

float3 gWoodColor2 <
    string UIName =  "Darker Wood";
    string UIWidget = "Color";
> = {0.60f, 0.41f, 0.0f};

float gKs2 <
    string UIWidget = "slider";
    float UIMin = 0.0;
    float UIMax = 2.0;
    float UIStep = 0.01;
    string UIName =  "Darker Wood Specularity";
> = 0.7;

float gSpecExpon <
    string UIWidget = "slider";
    float UIMin = 1.0;
    float UIMax = 128.0;
    float UIStep = 1.0;
    string UIName =  "Specular Exponent";
> = 30.0;

float gRingScale <
    string units = "inch";
    string UIWidget = "slider";
    float UIMin = 0.0;
    float UIMax = 10.0;
    float UIStep = 0.01;
    string UIName =  "Ring Scale";
> = 0.46;

float gAmpScale <
    string UIWidget = "slider";
    float UIMin = 0.01;
    float UIMax = 2.0;
    float UIStep = 0.01;
    string UIName = "Wobbliness";
> = 0.7;

//	They define the relative size of the log to the model.
float gWoodScale <
    string UIWidget = "slider";
    float UIMin = 0.01;
    float UIMax = 20.0;
    float UIStep = 0.01;
    string UIName =  "Model Size, Relative to Wood";
> = 8;

float gWOffX <
    string UIWidget = "slider";
    float UIMin = -20.0;
    float UIMax = 20.0;
    float UIStep = 0.01;
    string UIName =  "X Log-Center Offset";
> = -10.0;

float gWOffY <
    string UIWidget = "slider";
    float UIMin = -20.0;
    float UIMax = 20.0;
    float UIStep = 0.01;
    string UIName =  "Y Log-Center Offset";
> = -11.0;

float gWOffZ <
    string UIWidget = "slider";
    float UIMin = -20.0;
    float UIMax = 20.0;
    float UIStep = 0.01;
    string UIName =  "Z Log-Center Offset";
> = 7.0;

static float3 gWoodOffset = (float3(gWOffX,gWOffY,gWOffZ));

float gNoiseScale <
    string UIWidget = "slider";
    float UIMin = 0.01;
    float UIMax = 100.0;
    float UIStep = 0.01;
    string UIName =  "Size of Noise Features";
> = 32.0;

// NOISE_SCALE only applies if PROCEDURAL_TEXTURE is true
#define NOISE_SCALE 40.0
#include <include\\noise_3d.fxh>

/************* DATA STRUCTS **************/

/* data from application vertex buffer */
struct appdata {
    float3 Position	: POSITION;
    float4 UV		: TEXCOORD0;
    float4 Normal	: NORMAL;
    float4 Tangent	: TANGENT0;
    float4 Binormal	: BINORMAL0;
};

/* data passed from vertex shader to pixel shader */
struct woodVertexOutput {
    float4 HPosition	: POSITION;
    float3 WoodPos	: TEXCOORD0; // wood grain coordinate system
    float3 LightVec	: TEXCOORD1;
    float3 WorldNormal	: TEXCOORD2;
    float3 WorldView	: TEXCOORD3;
};

/*********** vertex shader ******/

woodVertexOutput mainVS(appdata IN,
    uniform float4x4 WorldITXf, // our four standard "untweakable" xforms
	uniform float4x4 WorldXf,
	uniform float4x4 ViewIXf,
	uniform float4x4 WvpXf,
    uniform float WoodScale,
    uniform float3 WoodOffset,
    uniform float3 LampPos
) {
    woodVertexOutput OUT = (woodVertexOutput)0;
    OUT.WorldNormal = mul(IN.Normal,WorldITXf).xyz;
    float4 Po = float4(IN.Position.xyz,1);
    float3 Pw = mul(Po,WorldXf).xyz;
    OUT.LightVec = LampPos - Pw;
    OUT.WorldView = (ViewIXf[3].xyz - Pw);
    float4 hpos = mul(Po,WvpXf);
    OUT.HPosition = hpos;
    //
    // This shader uses the object coordinates to determine the wood-grain
    //   coordinate system at shader runtime. Alternatively, you could bake
    //	 the coordinate system into the model as an alternative texcoord. The
    //	 current method applies to all possible models, while baking-in lets
    //	 you try different tricks such as modeling the grain of bent wood,
    //	 say for a bow or for the hull timbers of a ship.
    //
    OUT.WoodPos = (WoodScale*Po.xyz) + WoodOffset; // wood grain coordinate system
    return OUT;
}

/********* pixel shader ********/

float4 woodPS(woodVertexOutput IN,
		uniform float3 WoodColor1,
		uniform float3 WoodColor2,
		uniform float Ks1,
		uniform float Ks2,
		uniform float SpecExpon,
		uniform float RingScale,
		uniform float AmpScale,
		uniform float3 LampColor,
		uniform float3 AmbiColor,
		uniform float NoiseScale,
		uniform sampler3D NoiseSamp
) : COLOR
{
    float3 Ln = normalize(IN.LightVec);
    float3 Nn = normalize(IN.WorldNormal);
    float3 noiseval = tex3D(NoiseSamp,IN.WoodPos.xyz/NoiseScale).xyz;
    float3 Pwood = IN.WoodPos + (AmpScale * noiseval);
    float r = RingScale * sqrt(dot(Pwood.yz,Pwood.yz));
    r = r + tex3D(NoiseSamp,r.xxx/32.0).x;
    r = r - floor(r);
    r = smoothstep(0.0, 0.8, r) - smoothstep(0.83,1.0,r);
    float3 dColor = lerp(WoodColor1,WoodColor2,r);
    float Ks = lerp(Ks1,Ks2,r);
    float3 Vn = normalize(IN.WorldView);
    float3 Hn = normalize(Vn + Ln);
    float hdn = dot(Hn,Nn);
    float ldn = dot(Ln,Nn);
    float4 litV = lit(ldn,hdn,SpecExpon);
    float3 diffContrib = dColor * ((litV.y*LampColor) + AmbiColor);
    float3 specContrib = Ks * litV.z * LampColor;
    float3 result = diffContrib + specContrib;
    return float4(result,1);
}

/// TECHNIQUES 

#if DIRECT3D_VERSION >= 0xa00
// Standard DirectX10 Material State Blocks
RasterizerState DisableCulling { CullMode = NONE; };
DepthStencilState DepthEnabling { DepthEnable = TRUE; };
DepthStencilState DepthDisabling {
	DepthEnable = FALSE;
	DepthWriteMask = ZERO;
};
BlendState DisableBlend { BlendEnable[0] = FALSE; };

technique10 Main10 <
	string Script = "Pass=p0;";
> {
    pass p0 <
	string Script = "Draw=geometry;";
    > {
        SetVertexShader( CompileShader( vs_4_0, mainVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf, gWoodScale,
			    gWoodOffset, gLamp0Pos) ) );
        SetGeometryShader( NULL );
        SetPixelShader( CompileShader( ps_4_0, woodPS(gWoodColor1, gWoodColor2,
			    gKs1, gKs2, gSpecExpon,
			    gRingScale, gAmpScale,
			    gLamp0Color, gAmbiColor,
			    gNoiseScale,
			    gNoiseSampler) ) );
	    SetRasterizerState(DisableCulling);
	    SetDepthStencilState(DepthEnabling, 0);
	    SetBlendState(DisableBlend, float4( 0.0f, 0.0f, 0.0f, 0.0f ), 0xFFFFFFFF);
    }
}

#endif 

technique Main <
	string Script = "Pass=p0;";
> {
    pass p0 <
	string Script = "Draw=geometry;";
    > {
        VertexShader = compile vs_3_0 mainVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf, gWoodScale,
			    gWoodOffset, gLamp0Pos);
		ZEnable = true;
		ZWriteEnable = true;
		ZFunc = LessEqual;
		AlphaBlendEnable = false;
		CullMode = None;
        PixelShader = compile ps_3_0 woodPS(gWoodColor1, gWoodColor2,
			    gKs1, gKs2, gSpecExpon,
			    gRingScale, gAmpScale,
			    gLamp0Color, gAmbiColor,
			    gNoiseScale,
			    gNoiseSampler);
    }
}
