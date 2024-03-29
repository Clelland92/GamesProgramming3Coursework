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

/******* Lighting Macros *******/
#define LIGHT_COORDS "World"

#define HAS_FP16

#include <include\\Quad.fxh>

float Script : STANDARDSGLOBAL <
    string UIWidget = "none";
    string ScriptClass = "scene";
    string ScriptOrder = "postprocess";
    string ScriptOutput = "color";
    string Script = "Technique=Technique?Main:Main10;";
> = 0.8;

// color and depth used for full-screen clears

float4 gClearColor <
    string UIWidget = "Color";
    string UIName = "Background";
> = {0,0,0,0};

float gClearDepth <string UIWidget = "none";> = 1.0;

#ifdef HAS_FP16
#define FAR 1000.0f
#else
#define FAR 1.0f
#endif

float4 gShadowClearColor <
	string UIName = "Shadow Far BG";
    string UIWidget = "none";
> = {FAR,FAR,FAR,0.0};

texture gFloorTexture <
    string UIName = "Surface Texture";
    string ResourceName = "floor.dds";
    //string ResourceName = "default_color.dds";
>;

sampler2D gFloorSampler = sampler_state
{
    texture = <gFloorTexture>;
    AddressU = Wrap;
    AddressV = Wrap;
#if DIRECT3D_VERSION >= 0xa00
    Filter = MIN_MAG_MIP_LINEAR;
#else 
    MinFilter = Linear;
    MipFilter = Linear;
    MagFilter = Linear;
#endif 
};

/**** UNTWEAKABLES ***/

// transform object vertices to world-space:
float4x4 gWorldXf : World < string UIWidget="None"; >;
// transform object normals, tangents, & binormals to world-space:
float4x4 gWorldITXf : WorldInverseTranspose < string UIWidget="None"; >;
// transform object vertices to view space and project them in perspective:
float4x4 gWvpXf : WorldViewProjection < string UIWidget="None"; >;
// provide tranform from "view" or "eye" coords back to world-space:
float4x4 gViewIXf : ViewInverse < string UIWidget="None"; >;

// and these transforms are used for the shadow projection:

float4x4 gLampViewXf : View <
   string UIName = "Lamp View Xform";
   //string UIWidget="None";
   string Object = "SpotLight0";
>;

float4x4 gLampProjXf : Projection <
   string UIName = "Lamp Projection Xform";
   //string UIWidget="None";
   string Object = "SpotLight0";
>;

/// TWEAKABLES ///

float3 gSpotLamp0Pos : POSITION <
    string Object = "SpotLight0";
    string UIName =  "Lamp 0 Position";
    string Space = (LIGHT_COORDS);
> = {-0.5f,2.0f,1.25f};
float3 gLamp0Color : COLOR <
    string UIName =  "Lamp 0";
    string Object = "Spotlight0";
    string UIWidget = "Color";
> = {1.0f,1.0f,1.0f};

// Parameters for the algorithm

float gLightSize <
   string UIWidget = "slider";
   float UIMin = 0.010;
   float UIMax = 0.100;
   float UIStep = 0.001;
   string UIName = "Light Size";
> = 0.05f;

float gShadBias <
   string UIWidget = "slider";
   float UIMin = 0.0;
   float UIMax = 10.3;
   float UIStep = 0.0001;
   string UIName = "Shadow Bias";
> = 0.01;

float gSceneScale <
   string UIWidget = "slider";
   float UIMin = 0.1;
   float UIMax = 100.0;
   float UIStep = 0.1;
   string UIName = "Near Plane Factor";
> = 1.0f;

// General lighting parameters

// Ambient Light
float3 gAmbiColor : AMBIENT <
    string UIName =  "Ambient Light";
    string UIWidget = "Color";
> = {0.07f,0.07f,0.07f};

/// surface

// surface color
float3 gSurfaceColor : DIFFUSE <
    string UIName =  "Surface";
    string UIWidget = "Color";
> = {1,1,1};

float gKd <
    string UIWidget = "slider";
    float UIMin = 0.0;
    float UIMax = 1.0;
    float UIStep = 0.01;
    string UIName =  "Diffuse";
> = 0.9;

/// TEXTURES ///

#define SHADOW_SIZE 1024

//#ifdef HAS_FP16
//#define SHADOW_FMT  "a16b16g16r16f"
#define SHADOW_FMT  "r32f"
//#else /* !HAS_FP16 */
//#define SHADOW_FMT  "a8b8g8r8"
//#endif /* !HAS_FP16 */

texture gShadMap : RENDERCOLORTARGET <
   float2 Dimensions = { SHADOW_SIZE, SHADOW_SIZE };
   string Format = (SHADOW_FMT) ;
   string UIWidget = "None";
>;
sampler2D gShadSampler = sampler_state {
    texture = <gShadMap>;
    AddressU = Clamp;
    AddressV = Clamp;
#if DIRECT3D_VERSION >= 0xa00
    Filter = MIN_MAG_MIP_POINT;
#else 
    MinFilter = Point;
    MagFilter = Point;
    MipFilter = Point;
#endif 
};

texture gShadDepthTarget : RENDERDEPTHSTENCILTARGET <
   float2 Dimensions = { SHADOW_SIZE, SHADOW_SIZE };
   string format = "D24S8";
   string UIWidget = "None";
>;

/// SHADER CODE BEGINS ///

/* data from application vertex buffer */
struct ShadowAppData {
   float3 Position     : POSITION;
   float4 UV           : TEXCOORD0;
   float4 Normal       : NORMAL;
};

// Connector from vertex to pixel shader
struct ShadowVertexOutput {
   float4 HPosition    : POSITION;
   float2 UV           : TEXCOORD0;
   float3 LightVec     : TEXCOORD1;
   float3 WNormal      : TEXCOORD2;
   float3 WView        : TEXCOORD3;
   float4 LP           : TEXCOORD4;    
};

// Connector from vertex to pixel shader
struct JustShadowVertexOutput {
   float4 HPosition    : POSITION;
   float4 LP           : TEXCOORD0;    
};

/// Vertex Shaders ///

JustShadowVertexOutput shadVS(ShadowAppData IN,
			       uniform float4x4 WorldITXf, 
	uniform float4x4 WorldXf,
	uniform float4x4 ViewIXf,
	uniform float4x4 WvpXf,
			       uniform float4x4 ShadowViewProjXf
) {
   JustShadowVertexOutput OUT = (JustShadowVertexOutput)0;
   float4 Po = float4(IN.Position.xyz,(float)1.0);     // object coordinates
   float4 Pw = mul(Po,WorldXf);                        // "P" in world coordinates
   float4 Pl = mul(Pw,ShadowViewProjXf);  // "P" in light coords
   OUT.LP = Pl;                // view coords 
   OUT.HPosition = Pl; // screen clipspace coords
   return OUT;
}

// from scene camera POV
ShadowVertexOutput mainCamVS(ShadowAppData IN,
			       uniform float4x4 WorldITXf, 
	uniform float4x4 WorldXf,
	uniform float4x4 ViewIXf,
	uniform float4x4 WvpXf,
			       uniform float4x4 ShadowViewProjXf,
			       uniform float3 SpotLightPos,
			       uniform float ShadBias
) {
   ShadowVertexOutput OUT = (ShadowVertexOutput)0;
   OUT.WNormal = mul(IN.Normal,WorldITXf).xyz; // world coords
   float4 Po = float4(IN.Position.xyz,(float)1.0);     // "P" in object coordinates
   float4 Pw = mul(Po,WorldXf);                        // "P" in world coordinates
   float4 Pl = mul(Pw,ShadowViewProjXf);  // "P" in light coords
   Pl.z -= ShadBias;	// factor in bias here to save pixel shader work
   OUT.LP = Pl;                                                       
// for pixel-shader shadow calcs
   OUT.WView = normalize(ViewIXf[3].xyz - Pw.xyz);     // world coords
   OUT.HPosition = mul(Po,WvpXf);    // screen clipspace coords
   OUT.UV = IN.UV.xy;   
   OUT.LightVec = SpotLightPos - Pw.xyz;               // world coords
   return OUT;
}

/*** pixel shader ***/

float4 shadPS(JustShadowVertexOutput IN) : COLOR
{
   return float4(IN.LP.zzz,1);
}

// Search for potential blockers
float findBlocker(float2 uv,
		float4 LP,
		uniform sampler2D ShadowMap,
		uniform float bias,
		float searchWidth,
		float numSamples)
{
        // divide filter width by number of samples to use
        float stepSize = 2 * searchWidth / numSamples;

        // compute starting point uv coordinates for search
        uv = uv - float2(searchWidth, searchWidth);

        // reset sum to zero
        float blockerSum = 0;
        float receiver = LP.z;
        float blockerCount = 0;
        float foundBlocker = 0;

        // iterate through search region and add up depth values
        for (int i=0; i<numSamples; i++) {
               for (int j=0; j<numSamples; j++) {
                       float shadMapDepth = tex2D(ShadowMap, uv +
                                                 float2(i*stepSize,j*stepSize)).x;
                       // found a blocker
                       if (shadMapDepth < receiver) {
                               blockerSum += shadMapDepth;
                               blockerCount++;
                               foundBlocker = 1;
                       }
               }
        }

		float result;
		
		if (foundBlocker == 0) {
			// set it to a unique number so we can check
			// to see if there was no blocker
			result = 999;
		}
		else {
		    // return average depth of the blockers
			result = blockerSum / blockerCount;
		}
		
		return result;
}

// Estimate penumbra based on
// blocker estimate, receiver depth, and light size

float estimatePenumbra(float4 LP,
			float Blocker,
			uniform float LightSize)
{
       // receiver depth
       float receiver = LP.z;
       // estimate penumbra using parallel planes approximation
       float penumbra = (receiver - Blocker) * LightSize / Blocker;
       return penumbra;
}

// Percentage-closer filter implementation with
// variable filter width and number of samples.
// This assumes a square filter with the same number of
// horizontal and vertical samples.

float PCF_Filter(float2 uv, float4 LP, uniform sampler2D ShadowMap, 
                uniform float bias, float filterWidth, float numSamples)
{
       // compute step size for iterating through the kernel
       float stepSize = 2 * filterWidth / numSamples;

       // compute uv coordinates for upper-left corner of the kernel
       uv = uv - float2(filterWidth,filterWidth);

       float sum = 0;  // sum of successful depth tests

       // repeat through the kernel and filter
       for (int i=0; i<numSamples; i++) {
               for (int j=0; j<numSamples; j++) {
                       // get depth at current texel of the shadow map
                       float shadMapDepth = 0;
                       
                       shadMapDepth = tex2D(ShadowMap, uv +
                                            float2(i*stepSize,j*stepSize)).x;

                       // test if depth in the shadow map is closer than
                       // the eye-view point
                       float shad = LP.z < shadMapDepth;

                       // total result
                       sum += shad;
               }
       }
       
       // return average of samples
       return sum / (numSamples*numSamples);

}

float4 useShadowPS(ShadowVertexOutput IN,
       uniform float3 SpotLightColor,
       uniform float LightSize,
       uniform float SceneScale,
       uniform float ShadBias,
       uniform float Kd,
       uniform float3 SurfColor,
       uniform sampler2D ShadSampler,
       uniform sampler2D FloorSampler) : COLOR
{
   // Generic lighting code 
   float3 Nn = normalize(IN.WNormal);
   float3 Vn = normalize(IN.WView);
   float3 Ln = normalize(IN.LightVec);
   float ldn = dot(Ln,Nn);
   float3 diffContrib = SurfColor*(Kd*ldn * SpotLightColor);
   // float3 result = diffContrib;
   
   float2 uv = float2(.5,-.5)*(IN.LP.xy)/IN.LP.w + float2(.5,.5);

   // Find blocker estimate
   float searchSamples = 6;   // how many samples to use for blocker search
   float zReceiver = IN.LP.z;
   float searchWidth = SceneScale * (zReceiver - 1.0) / zReceiver;
   float blocker = findBlocker(uv, IN.LP, ShadSampler, ShadBias,
                              SceneScale * LightSize / IN.LP.z, searchSamples);
   
   //return (blocker*0.3);  
   
   // Estimate penumbra using parallel planes approximation
   
   float penumbra;  
   penumbra = estimatePenumbra(IN.LP, blocker, LightSize);

   //return penumbra*32;  
   
   // Compute percentage-closer filter
   // based on penumbra estimate
   
   float samples = 8;	// reduce this for higher performance

   // Now do a penumbra-based percentage-closer filter
   float shadowed; 

   shadowed = PCF_Filter(uv, IN.LP, ShadSampler, ShadBias, penumbra, samples);
   
   // If no blocker is found, just return 1.0
   // since the point isn't occluded
   
   if (blocker > 998) 
   		shadowed = 1.0;

   // Visualize lighting and shadows
   
   float3 floorColor = tex2D(FloorSampler, IN.UV*2).rgb;
   //return floorColor;
   //return shadowed;
   
   return float4((shadowed*diffContrib*floorColor),1);
}

/// TECHNIQUES ///

#if DIRECT3D_VERSION >= 0xa00
RasterizerState DisableCulling { CullMode = NONE; };
DepthStencilState DepthEnabling { DepthEnable = TRUE; };
DepthStencilState DepthDisabling {
	DepthEnable = FALSE;
	DepthWriteMask = ZERO;
};
BlendState DisableBlend { BlendEnable[0] = FALSE; };


technique10 Main10 <
       string Script = "Pass=MakeShadow;"
		       "Pass=UseShadow;";
> {
       pass MakeShadow <
               string Script = "RenderColorTarget0=gShadMap;"
				"RenderDepthStencilTarget=gShadDepthTarget;"
				"RenderPort=SpotLight0;"
				"ClearSetColor=gShadowClearColor;"
				"ClearSetDepth=gClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
				"Draw=geometry;";
       > {
	    SetVertexShader( CompileShader( vs_4_0, shadVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf,
					   mul(gLampViewXf,gLampProjXf))));
	    SetGeometryShader( NULL );
	    SetPixelShader( CompileShader( ps_4_0, shadPS()));
	       SetRasterizerState(DisableCulling);
	    SetDepthStencilState(DepthEnabling, 0);
	    SetBlendState(DisableBlend, float4( 0.0f, 0.0f, 0.0f, 0.0f ), 0xFFFFFFFF);
       }
       pass UseShadow <
               string Script = "RenderColorTarget0=;"
			       "RenderDepthStencilTarget=;"
			       "RenderPort=;"
			       "ClearSetColor=gClearColor;"
			       "ClearSetDepth=gClearDepth;"
			       "Clear=Color;"
			       "Clear=Depth;"
			       "Draw=geometry;";
       > {
	    SetVertexShader( CompileShader( vs_4_0, mainCamVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf,
					   mul(gLampViewXf,gLampProjXf),
					   gSpotLamp0Pos,
					   gShadBias)));
	    SetGeometryShader( NULL );
	    SetPixelShader( CompileShader( ps_4_0, useShadowPS(
					       gLamp0Color,
					       gLightSize,
					       gSceneScale,
					       gShadBias,
					       gKd,
					       gSurfaceColor,
					       gShadSampler,
					       gFloorSampler
					       )));
	       SetRasterizerState(DisableCulling);
	    SetDepthStencilState(DepthEnabling, 0);
	    SetBlendState(DisableBlend, float4( 0.0f, 0.0f, 0.0f, 0.0f ), 0xFFFFFFFF);
       }
}

#endif 
technique Main <
       string Script = "Pass=MakeShadow;"
		       "Pass=UseShadow;";
> {
       pass MakeShadow <
               string Script = "RenderColorTarget0=gShadMap;"
				"RenderDepthStencilTarget=gShadDepthTarget;"
				"RenderPort=SpotLight0;"
				"ClearSetColor=gShadowClearColor;"
				"ClearSetDepth=gClearDepth;"
				"Clear=Color;"
				"Clear=Depth;"
				"Draw=geometry;";
       > {
	   VertexShader = compile vs_3_0 shadVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf,
					   mul(gLampViewXf,gLampProjXf));
	       ZEnable = true;
		ZWriteEnable = true;
		ZFunc = LessEqual;
		AlphaBlendEnable = false;
		CullMode = None;
	   PixelShader = compile ps_3_0 shadPS();
       }
       pass UseShadow <
               string Script = "RenderColorTarget0=;"
			       "RenderDepthStencilTarget=;"
			       "RenderPort=;"
			       "ClearSetColor=gClearColor;"
			       "ClearSetDepth=gClearDepth;"
			       "Clear=Color;"
			       "Clear=Depth;"
			       "Draw=geometry;";
       > {
	   VertexShader = compile vs_3_0 mainCamVS(gWorldITXf,gWorldXf,
				gViewIXf,gWvpXf,
					   mul(gLampViewXf,gLampProjXf),
					   gSpotLamp0Pos,
					   gShadBias);
	       ZEnable = true;
		ZWriteEnable = true;
		ZFunc = LessEqual;
		AlphaBlendEnable = false;
		CullMode = None;
	   PixelShader = compile ps_3_0 useShadowPS(
					       gLamp0Color,
					       gLightSize,
					       gSceneScale,
					       gShadBias,
					       gKd,
					       gSurfaceColor,
					       gShadSampler,
					       gFloorSampler
					       );
}

}