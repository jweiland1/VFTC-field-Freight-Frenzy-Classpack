Shader "TextMeshPro/Distance Field" {
	Properties {
		_FaceTex ("Face Texture", 2D) = "white" {}
		_FaceUVSpeedX ("Face UV Speed X", Range(-5, 5)) = 0
		_FaceUVSpeedY ("Face UV Speed Y", Range(-5, 5)) = 0
		_FaceColor ("Face Color", Vector) = (1,1,1,1)
		_FaceDilate ("Face Dilate", Range(-1, 1)) = 0
		_OutlineColor ("Outline Color", Vector) = (0,0,0,1)
		_OutlineTex ("Outline Texture", 2D) = "white" {}
		_OutlineUVSpeedX ("Outline UV Speed X", Range(-5, 5)) = 0
		_OutlineUVSpeedY ("Outline UV Speed Y", Range(-5, 5)) = 0
		_OutlineWidth ("Outline Thickness", Range(0, 1)) = 0
		_OutlineSoftness ("Outline Softness", Range(0, 1)) = 0
		_Bevel ("Bevel", Range(0, 1)) = 0.5
		_BevelOffset ("Bevel Offset", Range(-0.5, 0.5)) = 0
		_BevelWidth ("Bevel Width", Range(-0.5, 0.5)) = 0
		_BevelClamp ("Bevel Clamp", Range(0, 1)) = 0
		_BevelRoundness ("Bevel Roundness", Range(0, 1)) = 0
		_LightAngle ("Light Angle", Range(0, 6.283185)) = 3.1416
		_SpecularColor ("Specular", Vector) = (1,1,1,1)
		_SpecularPower ("Specular", Range(0, 4)) = 2
		_Reflectivity ("Reflectivity", Range(5, 15)) = 10
		_Diffuse ("Diffuse", Range(0, 1)) = 0.5
		_Ambient ("Ambient", Range(1, 0)) = 0.5
		_BumpMap ("Normal map", 2D) = "bump" {}
		_BumpOutline ("Bump Outline", Range(0, 1)) = 0
		_BumpFace ("Bump Face", Range(0, 1)) = 0
		_ReflectFaceColor ("Reflection Color", Vector) = (0,0,0,1)
		_ReflectOutlineColor ("Reflection Color", Vector) = (0,0,0,1)
		_Cube ("Reflection Cubemap", Cube) = "black" {}
		_EnvMatrixRotation ("Texture Rotation", Vector) = (0,0,0,0)
		_UnderlayColor ("Border Color", Vector) = (0,0,0,0.5)
		_UnderlayOffsetX ("Border OffsetX", Range(-1, 1)) = 0
		_UnderlayOffsetY ("Border OffsetY", Range(-1, 1)) = 0
		_UnderlayDilate ("Border Dilate", Range(-1, 1)) = 0
		_UnderlaySoftness ("Border Softness", Range(0, 1)) = 0
		_GlowColor ("Color", Vector) = (0,1,0,0.5)
		_GlowOffset ("Offset", Range(-1, 1)) = 0
		_GlowInner ("Inner", Range(0, 1)) = 0.05
		_GlowOuter ("Outer", Range(0, 1)) = 0.05
		_GlowPower ("Falloff", Range(1, 0)) = 0.75
		_WeightNormal ("Weight Normal", Float) = 0
		_WeightBold ("Weight Bold", Float) = 0.5
		_ShaderFlags ("Flags", Float) = 0
		_ScaleRatioA ("Scale RatioA", Float) = 1
		_ScaleRatioB ("Scale RatioB", Float) = 1
		_ScaleRatioC ("Scale RatioC", Float) = 1
		_MainTex ("Font Atlas", 2D) = "white" {}
		_TextureWidth ("Texture Width", Float) = 512
		_TextureHeight ("Texture Height", Float) = 512
		_GradientScale ("Gradient Scale", Float) = 5
		_ScaleX ("Scale X", Float) = 1
		_ScaleY ("Scale Y", Float) = 1
		_PerspectiveFilter ("Perspective Correction", Range(0, 1)) = 0.875
		_Sharpness ("Sharpness", Range(-1, 1)) = 0
		_VertexOffsetX ("Vertex OffsetX", Float) = 0
		_VertexOffsetY ("Vertex OffsetY", Float) = 0
		_MaskCoord ("Mask Coordinates", Vector) = (0,0,32767,32767)
		_ClipRect ("Clip Rect", Vector) = (-32767,-32767,32767,32767)
		_MaskSoftnessX ("Mask SoftnessX", Float) = 0
		_MaskSoftnessY ("Mask SoftnessY", Float) = 0
		_StencilComp ("Stencil Comparison", Float) = 8
		_Stencil ("Stencil ID", Float) = 0
		_StencilOp ("Stencil Operation", Float) = 0
		_StencilWriteMask ("Stencil Write Mask", Float) = 255
		_StencilReadMask ("Stencil Read Mask", Float) = 255
		_ColorMask ("Color Mask", Float) = 15
	}
	SubShader {
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask 0 -1
			ZWrite Off
			Cull Off
			Stencil {
				ReadMask 0
				WriteMask 0
				Comp Disabled
				Pass Keep
				Fail Keep
				ZFail Keep
			}
			Fog {
				Mode Off
			}
			GpuProgramID 59269
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[3];
						vec4 _UnderlayColor;
						float _UnderlayOffsetX;
						float _UnderlayOffsetY;
						float _UnderlayDilate;
						float _UnderlaySoftness;
						vec4 unused_0_13[2];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _ScaleRatioC;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_20[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_COLOR1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    vs_TEXCOORD2.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xyw = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyw = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
					    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
					    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
					    u_xlat0.x = u_xlat6.x / u_xlat0.x;
					    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
					    u_xlat8.x = u_xlat0.x * u_xlat1.y;
					    u_xlat1.xy = (-u_xlat1.zw) * vec2(_GradientScale);
					    u_xlat1.xy = u_xlat1.xy / vec2(_TextureWidth, _TextureHeight);
					    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
					    vs_COLOR1.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
					    vs_COLOR1.w = _UnderlayColor.w;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_ALPHACLIP" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[3];
						vec4 _UnderlayColor;
						float _UnderlayOffsetX;
						float _UnderlayOffsetY;
						float _UnderlayDilate;
						float _UnderlaySoftness;
						vec4 unused_0_13[2];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _ScaleRatioC;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_20[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_COLOR1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    vs_TEXCOORD2.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xyw = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyw = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
					    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
					    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
					    u_xlat0.x = u_xlat6.x / u_xlat0.x;
					    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
					    u_xlat8.x = u_xlat0.x * u_xlat1.y;
					    u_xlat1.xy = (-u_xlat1.zw) * vec2(_GradientScale);
					    u_xlat1.xy = u_xlat1.xy / vec2(_TextureWidth, _TextureHeight);
					    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
					    vs_COLOR1.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
					    vs_COLOR1.w = _UnderlayColor.w;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_ALPHACLIP" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[3];
						vec4 _UnderlayColor;
						float _UnderlayOffsetX;
						float _UnderlayOffsetY;
						float _UnderlayDilate;
						float _UnderlaySoftness;
						vec4 unused_0_13[2];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _ScaleRatioC;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_20[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_COLOR1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    vs_TEXCOORD2.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xyw = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyw = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
					    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
					    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
					    u_xlat0.x = u_xlat6.x / u_xlat0.x;
					    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
					    u_xlat8.x = u_xlat0.x * u_xlat1.y;
					    u_xlat1.xy = (-u_xlat1.zw) * vec2(_GradientScale);
					    u_xlat1.xy = u_xlat1.xy / vec2(_TextureWidth, _TextureHeight);
					    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
					    vs_COLOR1.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
					    vs_COLOR1.w = _UnderlayColor.w;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[3];
						vec4 _UnderlayColor;
						float _UnderlayOffsetX;
						float _UnderlayOffsetY;
						float _UnderlayDilate;
						float _UnderlaySoftness;
						vec4 unused_0_13[2];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _ScaleRatioC;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_20[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_COLOR1;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat3 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat3 = min(u_xlat3, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat3.xy);
					    vs_TEXCOORD2.xy = (-u_xlat3.zw) + u_xlat0.xy;
					    u_xlat0.xyw = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyw = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyw;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyw;
					    u_xlat1 = vec4(_UnderlaySoftness, _UnderlayDilate, _UnderlayOffsetX, _UnderlayOffsetY) * vec4(vec4(_ScaleRatioC, _ScaleRatioC, _ScaleRatioC, _ScaleRatioC));
					    u_xlat0.x = u_xlat1.x * u_xlat6.x + 1.0;
					    u_xlat0.x = u_xlat6.x / u_xlat0.x;
					    u_xlat4 = u_xlat8.x * u_xlat0.x + -0.5;
					    u_xlat8.x = u_xlat0.x * u_xlat1.y;
					    u_xlat1.xy = (-u_xlat1.zw) * vec2(_GradientScale);
					    u_xlat1.xy = u_xlat1.xy / vec2(_TextureWidth, _TextureHeight);
					    vs_TEXCOORD4.xy = u_xlat1.xy + in_TEXCOORD0.xy;
					    vs_TEXCOORD4.z = u_xlat0.x;
					    vs_TEXCOORD4.w = (-u_xlat8.x) * 0.5 + u_xlat4;
					    vs_COLOR1.xyz = _UnderlayColor.www * _UnderlayColor.xyz;
					    vs_COLOR1.w = _UnderlayColor.w;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						float _FaceDilate;
						float _OutlineSoftness;
						vec4 unused_0_3;
						float _OutlineWidth;
						vec4 unused_0_5[4];
						mat4x4 _EnvMatrix;
						vec4 unused_0_7[7];
						float _WeightNormal;
						float _WeightBold;
						float _ScaleRatioA;
						float _VertexOffsetX;
						float _VertexOffsetY;
						vec4 unused_0_13[2];
						vec4 _ClipRect;
						float _MaskSoftnessX;
						float _MaskSoftnessY;
						float _GradientScale;
						float _ScaleX;
						float _ScaleY;
						float _PerspectiveFilter;
						float _Sharpness;
						vec4 _FaceTex_ST;
						vec4 _OutlineTex_ST;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2;
						vec4 _ScreenParams;
						vec4 unused_1_4[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[3];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[5];
						mat4x4 glstate_matrix_projection;
						vec4 unused_3_2[8];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_COLOR0;
					in  vec2 in_TEXCOORD0;
					in  vec2 in_TEXCOORD1;
					out vec4 vs_COLOR0;
					out vec2 vs_TEXCOORD0;
					out vec4 vs_TEXCOORD1;
					out vec4 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat6;
					vec2 u_xlat8;
					bool u_xlatb8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = in_POSITION0.xy + vec2(_VertexOffsetX, _VertexOffsetY);
					    u_xlat1 = u_xlat0.yyyy * unity_ObjectToWorld[1];
					    u_xlat1 = unity_ObjectToWorld[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat1;
					    u_xlat2 = u_xlat1 + unity_ObjectToWorld[3];
					    u_xlat1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat1.xyz;
					    u_xlat1.xyz = (-u_xlat1.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat3 = u_xlat2.yyyy * unity_MatrixVP[1];
					    u_xlat3 = unity_MatrixVP[0] * u_xlat2.xxxx + u_xlat3;
					    u_xlat3 = unity_MatrixVP[2] * u_xlat2.zzzz + u_xlat3;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat2.wwww + u_xlat3;
					    gl_Position = u_xlat2;
					    vs_COLOR0 = in_COLOR0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy;
					    u_xlat8.xy = _ScreenParams.yy * glstate_matrix_projection[1].xy;
					    u_xlat8.xy = glstate_matrix_projection[0].xy * _ScreenParams.xx + u_xlat8.xy;
					    u_xlat8.xy = abs(u_xlat8.xy) * vec2(_ScaleX, _ScaleY);
					    u_xlat8.xy = u_xlat2.ww / u_xlat8.xy;
					    u_xlat13 = dot(u_xlat8.xy, u_xlat8.xy);
					    u_xlat8.xy = vec2(_MaskSoftnessX, _MaskSoftnessY) * vec2(0.25, 0.25) + u_xlat8.xy;
					    vs_TEXCOORD2.zw = vec2(0.25, 0.25) / u_xlat8.xy;
					    u_xlat8.x = inversesqrt(u_xlat13);
					    u_xlat12 = abs(in_TEXCOORD1.y) * _GradientScale;
					    u_xlat13 = _Sharpness + 1.0;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat13 = u_xlat12 * u_xlat8.x;
					    u_xlat2.x = (-_PerspectiveFilter) + 1.0;
					    u_xlat2.x = abs(u_xlat13) * u_xlat2.x;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + (-u_xlat2.x);
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat6.xyz = vec3(u_xlat12) * u_xlat3.xyz;
					    u_xlat12 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * u_xlat1.xyz;
					    u_xlat12 = dot(u_xlat6.xyz, u_xlat3.xyz);
					    u_xlat8.x = abs(u_xlat12) * u_xlat8.x + u_xlat2.x;
					    u_xlatb12 = glstate_matrix_projection[3].w==0.0;
					    u_xlat6.x = (u_xlatb12) ? u_xlat8.x : u_xlat13;
					    u_xlatb8 = 0.0>=in_TEXCOORD1.y;
					    u_xlat8.x = u_xlatb8 ? 1.0 : float(0.0);
					    u_xlat12 = (-_WeightNormal) + _WeightBold;
					    u_xlat8.x = u_xlat8.x * u_xlat12 + _WeightNormal;
					    u_xlat8.x = u_xlat8.x * 0.25 + _FaceDilate;
					    u_xlat8.x = u_xlat8.x * _ScaleRatioA;
					    u_xlat6.z = u_xlat8.x * 0.5;
					    vs_TEXCOORD1.yw = u_xlat6.xz;
					    u_xlat12 = 0.5 / u_xlat6.x;
					    u_xlat13 = (-_OutlineWidth) * _ScaleRatioA + 1.0;
					    u_xlat13 = (-_OutlineSoftness) * _ScaleRatioA + u_xlat13;
					    u_xlat13 = u_xlat13 * 0.5 + (-u_xlat12);
					    vs_TEXCOORD1.x = (-u_xlat8.x) * 0.5 + u_xlat13;
					    u_xlat8.x = (-u_xlat8.x) * 0.5 + 0.5;
					    vs_TEXCOORD1.z = u_xlat12 + u_xlat8.x;
					    u_xlat2 = max(_ClipRect, vec4(-2e+10, -2e+10, -2e+10, -2e+10));
					    u_xlat2 = min(u_xlat2, vec4(2e+10, 2e+10, 2e+10, 2e+10));
					    u_xlat0.xy = u_xlat0.xy * vec2(2.0, 2.0) + (-u_xlat2.xy);
					    vs_TEXCOORD2.xy = (-u_xlat2.zw) + u_xlat0.xy;
					    u_xlat0.xyz = u_xlat1.yyy * _EnvMatrix[1].xyz;
					    u_xlat0.xyz = _EnvMatrix[0].xyz * u_xlat1.xxx + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = _EnvMatrix[2].xyz * u_xlat1.zzz + u_xlat0.xyz;
					    u_xlat0.x = in_TEXCOORD1.x * 0.000244140625;
					    u_xlat8.x = floor(u_xlat0.x);
					    u_xlat8.y = (-u_xlat8.x) * 4096.0 + in_TEXCOORD1.x;
					    u_xlat0.xy = u_xlat8.xy * vec2(0.001953125, 0.001953125);
					    vs_TEXCOORD5.xy = u_xlat0.xy * _FaceTex_ST.xy + _FaceTex_ST.zw;
					    vs_TEXCOORD5.zw = u_xlat0.xy * _OutlineTex_ST.xy + _OutlineTex_ST.zw;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat4 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat8.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat12 = u_xlat4 * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = u_xlat4 * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat4 = u_xlat8.x * u_xlat12;
					    u_xlat8.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat8.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat2.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat8.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat8.xy);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat3;
					    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat8.x = u_xlat4 * vs_TEXCOORD1.y;
					    u_xlat4 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat8.x * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat4;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_COLOR1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat0 = texture(_OutlineTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _OutlineColor;
					    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
					    u_xlat1.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.w * _FaceColor.w;
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.www;
					    u_xlat0 = u_xlat0 + (-u_xlat2);
					    u_xlat1.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat1.x = u_xlat1.x * vs_TEXCOORD1.y;
					    u_xlat5 = min(u_xlat1.x, 1.0);
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat5 = sqrt(u_xlat5);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat3.w) + vs_TEXCOORD1.z;
					    u_xlat13 = u_xlat9 * vs_TEXCOORD1.y + u_xlat1.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat1.x = u_xlat9 * vs_TEXCOORD1.y + (-u_xlat1.x);
					    u_xlat5 = u_xlat5 * u_xlat13;
					    u_xlat0 = vec4(u_xlat5) * u_xlat0 + u_xlat2;
					    u_xlat5 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat9 = u_xlat5 * vs_TEXCOORD1.y;
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + 1.0;
					    u_xlat1.x = u_xlat9 * 0.5 + u_xlat1.x;
					    u_xlat1.x = u_xlat1.x / u_xlat5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = (-u_xlat0.w) * u_xlat1.x + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD4.xy);
					    u_xlat4 = u_xlat1.w * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = vec4(u_xlat4) * vs_COLOR1;
					    u_xlat0 = u_xlat1 * u_xlat0.xxxx + u_xlat2;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						float _Bevel;
						float _BevelOffset;
						float _BevelWidth;
						float _BevelClamp;
						float _BevelRoundness;
						float _BumpOutline;
						float _BumpFace;
						vec4 _ReflectFaceColor;
						vec4 _ReflectOutlineColor;
						vec4 unused_0_18[5];
						vec4 _SpecularColor;
						float _LightAngle;
						float _SpecularPower;
						float _Reflectivity;
						float _Diffuse;
						float _Ambient;
						vec4 unused_0_25[4];
						float _ShaderFlags;
						float _ScaleRatioA;
						vec4 unused_0_28[4];
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						vec4 unused_0_32[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					uniform  sampler2D _BumpMap;
					uniform  samplerCube _Cube;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat8;
					vec2 u_xlat10;
					bool u_xlatb10;
					float u_xlat13;
					bool u_xlatb15;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat5 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
					    u_xlat1.xy = vec2(0.5, 0.5) / vec2(_TextureWidth, _TextureHeight);
					    u_xlat1.z = 0.0;
					    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy).wxyz;
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat3.z = u_xlat2.w;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat3.w = u_xlat1.w;
					    u_xlat3.y = u_xlat2.w;
					    u_xlat1 = u_xlat0.xxxx + u_xlat3;
					    u_xlat1 = u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat0.x = _BevelWidth + _OutlineWidth;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1 = u_xlat1 / u_xlat0.xxxx;
					    u_xlat0.x = u_xlat0.x * _Bevel;
					    u_xlat0.x = u_xlat0.x * _GradientScale;
					    u_xlat0.x = u_xlat0.x * -2.0;
					    u_xlat1 = u_xlat1 + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat2 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.x = _ShaderFlags * 0.5;
					    u_xlatb15 = u_xlat10.x>=(-u_xlat10.x);
					    u_xlat10.x = fract(abs(u_xlat10.x));
					    u_xlat10.x = (u_xlatb15) ? u_xlat10.x : (-u_xlat10.x);
					    u_xlatb10 = u_xlat10.x>=0.5;
					    u_xlat1 = (bool(u_xlatb10)) ? u_xlat2 : u_xlat1;
					    u_xlat2 = u_xlat1 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
					    u_xlat2 = sin(u_xlat2);
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat1 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat1;
					    u_xlat10.x = (-_BevelClamp) + 1.0;
					    u_xlat1 = min(u_xlat10.xxxx, u_xlat1);
					    u_xlat10.xy = u_xlat0.xx * u_xlat1.xz;
					    u_xlat1.yz = u_xlat1.wy * u_xlat0.xx + (-u_xlat10.yx);
					    u_xlat1.x = float(-1.0);
					    u_xlat1.w = float(1.0);
					    u_xlat0.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat10.x = dot(u_xlat1.zw, u_xlat1.zw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.x = u_xlat10.x * u_xlat1.z;
					    u_xlat2.yz = u_xlat10.xx * vec2(1.0, 0.0);
					    u_xlat1.z = 0.0;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.xzw * u_xlat2.xyz;
					    u_xlat0.xzw = u_xlat2.zxy * u_xlat0.zwx + (-u_xlat1.xyz);
					    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_BumpMap, u_xlat1.xy);
					    u_xlat1 = texture(_FaceTex, u_xlat1.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat17 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat17 = min(u_xlat17, 1.0);
					    u_xlat17 = (-u_xlat17) + 1.0;
					    u_xlat2.z = sqrt(u_xlat17);
					    u_xlat17 = (-_BumpFace) + _BumpOutline;
					    u_xlat3.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat3.x = u_xlat3.x * vs_TEXCOORD1.y;
					    u_xlat8 = u_xlat3.x * 0.5;
					    u_xlat3.x = min(u_xlat3.x, 1.0);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat13 = u_xlat5 * vs_TEXCOORD1.y + u_xlat8;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + (-u_xlat8);
					    u_xlat17 = u_xlat13 * u_xlat17 + _BumpFace;
					    u_xlat0.xzw = (-u_xlat2.xyz) * vec3(u_xlat17) + u_xlat0.xzw;
					    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xzw = u_xlat0.xzw * u_xlat2.xxx;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xzw));
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = u_xlat0.xzw * u_xlat2.xxx + vs_TEXCOORD3.xyz;
					    u_xlat2 = texture(_Cube, u_xlat2.xyz);
					    u_xlat4.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
					    u_xlat4.xyz = vec3(u_xlat13) * u_xlat4.xyz + _ReflectFaceColor.xyz;
					    u_xlat17 = u_xlat3.x * u_xlat13;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat1.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.www;
					    u_xlat1.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat1 = (-u_xlat3) + u_xlat1;
					    u_xlat1 = vec4(u_xlat17) * u_xlat1 + u_xlat3;
					    u_xlat17 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat3.x = u_xlat17 * vs_TEXCOORD1.y;
					    u_xlat17 = u_xlat17 * vs_TEXCOORD1.y + 1.0;
					    u_xlat5 = u_xlat3.x * 0.5 + u_xlat5;
					    u_xlat5 = u_xlat5 / u_xlat17;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat5 = (-u_xlat5) + 1.0;
					    u_xlat1 = vec4(u_xlat5) * u_xlat1;
					    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
					    u_xlat3.x = sin(_LightAngle);
					    u_xlat4.x = cos(_LightAngle);
					    u_xlat3.y = u_xlat4.x;
					    u_xlat3.z = -1.0;
					    u_xlat5 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat5 = inversesqrt(u_xlat5);
					    u_xlat3.xyz = vec3(u_xlat5) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xzw, u_xlat3.xyz);
					    u_xlat5 = u_xlat0.w * u_xlat0.w;
					    u_xlat10.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Reflectivity;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * _SpecularColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat17 = (-_Ambient) + 1.0;
					    u_xlat5 = u_xlat5 * u_xlat17 + _Ambient;
					    u_xlat1.xyz = u_xlat0.xzw * vec3(u_xlat5) + u_xlat2.xyz;
					    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat4 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat8.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat12 = u_xlat4 * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = u_xlat4 * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat4 = u_xlat8.x * u_xlat12;
					    u_xlat8.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat8.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat2.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat8.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat8.xy);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat3;
					    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat8.x = u_xlat4 * vs_TEXCOORD1.y;
					    u_xlat4 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat8.x * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat4;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat4 = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1;
					    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
					    u_xlatb0 = u_xlat4<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_ALPHACLIP" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[9];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_COLOR1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat0 = texture(_OutlineTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _OutlineColor;
					    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
					    u_xlat1.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.w * _FaceColor.w;
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.www;
					    u_xlat0 = u_xlat0 + (-u_xlat2);
					    u_xlat1.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat1.x = u_xlat1.x * vs_TEXCOORD1.y;
					    u_xlat5 = min(u_xlat1.x, 1.0);
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat5 = sqrt(u_xlat5);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat3.w) + vs_TEXCOORD1.z;
					    u_xlat13 = u_xlat9 * vs_TEXCOORD1.y + u_xlat1.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat1.x = u_xlat9 * vs_TEXCOORD1.y + (-u_xlat1.x);
					    u_xlat5 = u_xlat5 * u_xlat13;
					    u_xlat0 = vec4(u_xlat5) * u_xlat0 + u_xlat2;
					    u_xlat5 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat9 = u_xlat5 * vs_TEXCOORD1.y;
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + 1.0;
					    u_xlat1.x = u_xlat9 * 0.5 + u_xlat1.x;
					    u_xlat1.x = u_xlat1.x / u_xlat5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = (-u_xlat0.w) * u_xlat1.x + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD4.xy);
					    u_xlat4 = u_xlat1.w * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = vec4(u_xlat4) * vs_COLOR1;
					    u_xlat0 = u_xlat1 * u_xlat0.xxxx + u_xlat2;
					    u_xlat1.x = u_xlat0.w + -0.00100000005;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    u_xlatb0 = u_xlat1.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_ALPHACLIP" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						float _Bevel;
						float _BevelOffset;
						float _BevelWidth;
						float _BevelClamp;
						float _BevelRoundness;
						float _BumpOutline;
						float _BumpFace;
						vec4 _ReflectFaceColor;
						vec4 _ReflectOutlineColor;
						vec4 unused_0_18[5];
						vec4 _SpecularColor;
						float _LightAngle;
						float _SpecularPower;
						float _Reflectivity;
						float _Diffuse;
						float _Ambient;
						vec4 unused_0_25[4];
						float _ShaderFlags;
						float _ScaleRatioA;
						vec4 unused_0_28[4];
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						vec4 unused_0_32[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					uniform  sampler2D _BumpMap;
					uniform  samplerCube _Cube;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat6;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat12;
					bool u_xlatb15;
					float u_xlat18;
					float u_xlat20;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat6 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat0.xz);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat0.xzw = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat0.xzw = u_xlat0.xzw * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat0.xzw * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat12 = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat18 = u_xlat6 * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = u_xlat6 * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat6 = u_xlat12 * u_xlat18;
					    u_xlat1 = vec4(u_xlat6) * u_xlat1 + u_xlat3;
					    u_xlat6 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat12 = u_xlat6 * vs_TEXCOORD1.y;
					    u_xlat6 = u_xlat6 * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat12 * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat6;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat6 = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1;
					    u_xlatb0 = u_xlat6<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat0.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat2.x = dot(u_xlat0.xy, u_xlat0.xy);
					    u_xlat2.x = min(u_xlat2.x, 1.0);
					    u_xlat2.x = (-u_xlat2.x) + 1.0;
					    u_xlat0.z = sqrt(u_xlat2.x);
					    u_xlat2.x = vs_TEXCOORD1.w + _BevelOffset;
					    u_xlat3.xy = vec2(0.5, 0.5) / vec2(_TextureWidth, _TextureHeight);
					    u_xlat3.z = 0.0;
					    u_xlat4 = (-u_xlat3.xzzy) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = u_xlat3.xzzy + vs_TEXCOORD0.xyxy;
					    u_xlat5 = texture(_MainTex, u_xlat4.xy).wxyz;
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat5.z = u_xlat4.w;
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat5.w = u_xlat3.w;
					    u_xlat5.y = u_xlat4.w;
					    u_xlat2 = u_xlat2.xxxx + u_xlat5;
					    u_xlat2 = u_xlat2 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat3.x = _BevelWidth + _OutlineWidth;
					    u_xlat3.x = max(u_xlat3.x, 0.00999999978);
					    u_xlat2 = u_xlat2 / u_xlat3.xxxx;
					    u_xlat3.x = u_xlat3.x * _Bevel;
					    u_xlat3.x = u_xlat3.x * _GradientScale;
					    u_xlat3.x = u_xlat3.x * -2.0;
					    u_xlat2 = u_xlat2 + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat2 = clamp(u_xlat2, 0.0, 1.0);
					    u_xlat4 = u_xlat2 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat9 = _ShaderFlags * 0.5;
					    u_xlatb15 = u_xlat9>=(-u_xlat9);
					    u_xlat9 = fract(abs(u_xlat9));
					    u_xlat9 = (u_xlatb15) ? u_xlat9 : (-u_xlat9);
					    u_xlatb9 = u_xlat9>=0.5;
					    u_xlat2 = (bool(u_xlatb9)) ? u_xlat4 : u_xlat2;
					    u_xlat4 = u_xlat2 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
					    u_xlat4 = sin(u_xlat4);
					    u_xlat4 = (-u_xlat2) + u_xlat4;
					    u_xlat2 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat4 + u_xlat2;
					    u_xlat9 = (-_BevelClamp) + 1.0;
					    u_xlat2 = min(u_xlat2, vec4(u_xlat9));
					    u_xlat2.xz = u_xlat3.xx * u_xlat2.xz;
					    u_xlat2.yz = u_xlat2.wy * u_xlat3.xx + (-u_xlat2.zx);
					    u_xlat2.x = float(-1.0);
					    u_xlat2.w = float(1.0);
					    u_xlat3.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat20 = dot(u_xlat2.zw, u_xlat2.zw);
					    u_xlat20 = inversesqrt(u_xlat20);
					    u_xlat4.x = u_xlat20 * u_xlat2.z;
					    u_xlat4.yz = vec2(u_xlat20) * vec2(1.0, 0.0);
					    u_xlat2.z = 0.0;
					    u_xlat2.xyz = u_xlat3.xxx * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat4.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat20 = (-_BumpFace) + _BumpOutline;
					    u_xlat20 = u_xlat18 * u_xlat20 + _BumpFace;
					    u_xlat0.xyz = (-u_xlat0.xyz) * vec3(u_xlat20) + u_xlat2.xyz;
					    u_xlat2.x = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat2.xxx;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xyz));
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat2.xxx + vs_TEXCOORD3.xyz;
					    u_xlat2 = texture(_Cube, u_xlat2.xyz);
					    u_xlat3.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz + _ReflectFaceColor.xyz;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
					    u_xlat3.x = sin(_LightAngle);
					    u_xlat4.x = cos(_LightAngle);
					    u_xlat3.y = u_xlat4.x;
					    u_xlat3.z = -1.0;
					    u_xlat18 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat3.xyz);
					    u_xlat6 = u_xlat0.z * u_xlat0.z;
					    u_xlat12 = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
					    u_xlat12 = log2(u_xlat12);
					    u_xlat12 = u_xlat12 * _Reflectivity;
					    u_xlat12 = exp2(u_xlat12);
					    u_xlat3.xyz = vec3(u_xlat12) * _SpecularColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat20 = (-_Ambient) + 1.0;
					    u_xlat6 = u_xlat6 * u_xlat20 + _Ambient;
					    u_xlat1.xyz = u_xlat0.xzw * vec3(u_xlat6) + u_xlat2.xyz;
					    SV_Target0 = u_xlat1 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[3];
						vec4 _ClipRect;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat4 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat8.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat12 = u_xlat4 * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = u_xlat4 * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat4 = u_xlat8.x * u_xlat12;
					    u_xlat8.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat8.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat2.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat8.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat8.xy);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat3;
					    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat8.x = u_xlat4 * vs_TEXCOORD1.y;
					    u_xlat4 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat8.x * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat4;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[3];
						vec4 _ClipRect;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_COLOR1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat0 = texture(_OutlineTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _OutlineColor;
					    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
					    u_xlat1.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.w * _FaceColor.w;
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.www;
					    u_xlat0 = u_xlat0 + (-u_xlat2);
					    u_xlat1.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat1.x = u_xlat1.x * vs_TEXCOORD1.y;
					    u_xlat5 = min(u_xlat1.x, 1.0);
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat5 = sqrt(u_xlat5);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat3.w) + vs_TEXCOORD1.z;
					    u_xlat13 = u_xlat9 * vs_TEXCOORD1.y + u_xlat1.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat1.x = u_xlat9 * vs_TEXCOORD1.y + (-u_xlat1.x);
					    u_xlat5 = u_xlat5 * u_xlat13;
					    u_xlat0 = vec4(u_xlat5) * u_xlat0 + u_xlat2;
					    u_xlat5 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat9 = u_xlat5 * vs_TEXCOORD1.y;
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + 1.0;
					    u_xlat1.x = u_xlat9 * 0.5 + u_xlat1.x;
					    u_xlat1.x = u_xlat1.x / u_xlat5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = (-u_xlat0.w) * u_xlat1.x + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD4.xy);
					    u_xlat4 = u_xlat1.w * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = vec4(u_xlat4) * vs_COLOR1;
					    u_xlat0 = u_xlat1 * u_xlat0.xxxx + u_xlat2;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						float _Bevel;
						float _BevelOffset;
						float _BevelWidth;
						float _BevelClamp;
						float _BevelRoundness;
						float _BumpOutline;
						float _BumpFace;
						vec4 _ReflectFaceColor;
						vec4 _ReflectOutlineColor;
						vec4 unused_0_18[5];
						vec4 _SpecularColor;
						float _LightAngle;
						float _SpecularPower;
						float _Reflectivity;
						float _Diffuse;
						float _Ambient;
						vec4 unused_0_25[4];
						float _ShaderFlags;
						float _ScaleRatioA;
						vec4 unused_0_28[3];
						vec4 _ClipRect;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						vec4 unused_0_33[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					uniform  sampler2D _BumpMap;
					uniform  samplerCube _Cube;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat5;
					float u_xlat8;
					vec2 u_xlat10;
					bool u_xlatb10;
					float u_xlat13;
					bool u_xlatb15;
					float u_xlat17;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat5 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = vs_TEXCOORD1.w + _BevelOffset;
					    u_xlat1.xy = vec2(0.5, 0.5) / vec2(_TextureWidth, _TextureHeight);
					    u_xlat1.z = 0.0;
					    u_xlat2 = (-u_xlat1.xzzy) + vs_TEXCOORD0.xyxy;
					    u_xlat1 = u_xlat1.xzzy + vs_TEXCOORD0.xyxy;
					    u_xlat3 = texture(_MainTex, u_xlat2.xy).wxyz;
					    u_xlat2 = texture(_MainTex, u_xlat2.zw);
					    u_xlat3.z = u_xlat2.w;
					    u_xlat2 = texture(_MainTex, u_xlat1.xy);
					    u_xlat1 = texture(_MainTex, u_xlat1.zw);
					    u_xlat3.w = u_xlat1.w;
					    u_xlat3.y = u_xlat2.w;
					    u_xlat1 = u_xlat0.xxxx + u_xlat3;
					    u_xlat1 = u_xlat1 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat0.x = _BevelWidth + _OutlineWidth;
					    u_xlat0.x = max(u_xlat0.x, 0.00999999978);
					    u_xlat1 = u_xlat1 / u_xlat0.xxxx;
					    u_xlat0.x = u_xlat0.x * _Bevel;
					    u_xlat0.x = u_xlat0.x * _GradientScale;
					    u_xlat0.x = u_xlat0.x * -2.0;
					    u_xlat1 = u_xlat1 + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat1 = clamp(u_xlat1, 0.0, 1.0);
					    u_xlat2 = u_xlat1 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat2 = -abs(u_xlat2) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat10.x = _ShaderFlags * 0.5;
					    u_xlatb15 = u_xlat10.x>=(-u_xlat10.x);
					    u_xlat10.x = fract(abs(u_xlat10.x));
					    u_xlat10.x = (u_xlatb15) ? u_xlat10.x : (-u_xlat10.x);
					    u_xlatb10 = u_xlat10.x>=0.5;
					    u_xlat1 = (bool(u_xlatb10)) ? u_xlat2 : u_xlat1;
					    u_xlat2 = u_xlat1 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
					    u_xlat2 = sin(u_xlat2);
					    u_xlat2 = (-u_xlat1) + u_xlat2;
					    u_xlat1 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat2 + u_xlat1;
					    u_xlat10.x = (-_BevelClamp) + 1.0;
					    u_xlat1 = min(u_xlat10.xxxx, u_xlat1);
					    u_xlat10.xy = u_xlat0.xx * u_xlat1.xz;
					    u_xlat1.yz = u_xlat1.wy * u_xlat0.xx + (-u_xlat10.yx);
					    u_xlat1.x = float(-1.0);
					    u_xlat1.w = float(1.0);
					    u_xlat0.x = dot(u_xlat1.xy, u_xlat1.xy);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat10.x = dot(u_xlat1.zw, u_xlat1.zw);
					    u_xlat10.x = inversesqrt(u_xlat10.x);
					    u_xlat2.x = u_xlat10.x * u_xlat1.z;
					    u_xlat2.yz = u_xlat10.xx * vec2(1.0, 0.0);
					    u_xlat1.z = 0.0;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat0.xzw * u_xlat2.xyz;
					    u_xlat0.xzw = u_xlat2.zxy * u_xlat0.zwx + (-u_xlat1.xyz);
					    u_xlat1.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_BumpMap, u_xlat1.xy);
					    u_xlat1 = texture(_FaceTex, u_xlat1.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat17 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat17 = min(u_xlat17, 1.0);
					    u_xlat17 = (-u_xlat17) + 1.0;
					    u_xlat2.z = sqrt(u_xlat17);
					    u_xlat17 = (-_BumpFace) + _BumpOutline;
					    u_xlat3.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat3.x = u_xlat3.x * vs_TEXCOORD1.y;
					    u_xlat8 = u_xlat3.x * 0.5;
					    u_xlat3.x = min(u_xlat3.x, 1.0);
					    u_xlat3.x = sqrt(u_xlat3.x);
					    u_xlat13 = u_xlat5 * vs_TEXCOORD1.y + u_xlat8;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + (-u_xlat8);
					    u_xlat17 = u_xlat13 * u_xlat17 + _BumpFace;
					    u_xlat0.xzw = (-u_xlat2.xyz) * vec3(u_xlat17) + u_xlat0.xzw;
					    u_xlat2.x = dot(u_xlat0.xzw, u_xlat0.xzw);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat0.xzw = u_xlat0.xzw * u_xlat2.xxx;
					    u_xlat2.x = dot(vs_TEXCOORD3.xyz, (-u_xlat0.xzw));
					    u_xlat2.x = u_xlat2.x + u_xlat2.x;
					    u_xlat2.xyz = u_xlat0.xzw * u_xlat2.xxx + vs_TEXCOORD3.xyz;
					    u_xlat2 = texture(_Cube, u_xlat2.xyz);
					    u_xlat4.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
					    u_xlat4.xyz = vec3(u_xlat13) * u_xlat4.xyz + _ReflectFaceColor.xyz;
					    u_xlat17 = u_xlat3.x * u_xlat13;
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat1.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat3.www;
					    u_xlat1.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat1.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat1 = (-u_xlat3) + u_xlat1;
					    u_xlat1 = vec4(u_xlat17) * u_xlat1 + u_xlat3;
					    u_xlat17 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat3.x = u_xlat17 * vs_TEXCOORD1.y;
					    u_xlat17 = u_xlat17 * vs_TEXCOORD1.y + 1.0;
					    u_xlat5 = u_xlat3.x * 0.5 + u_xlat5;
					    u_xlat5 = u_xlat5 / u_xlat17;
					    u_xlat5 = clamp(u_xlat5, 0.0, 1.0);
					    u_xlat5 = (-u_xlat5) + 1.0;
					    u_xlat1 = vec4(u_xlat5) * u_xlat1;
					    u_xlat2.xyz = u_xlat1.www * u_xlat2.xyz;
					    u_xlat3.x = sin(_LightAngle);
					    u_xlat4.x = cos(_LightAngle);
					    u_xlat3.y = u_xlat4.x;
					    u_xlat3.z = -1.0;
					    u_xlat5 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat5 = inversesqrt(u_xlat5);
					    u_xlat3.xyz = vec3(u_xlat5) * u_xlat3.xyz;
					    u_xlat0.x = dot(u_xlat0.xzw, u_xlat3.xyz);
					    u_xlat5 = u_xlat0.w * u_xlat0.w;
					    u_xlat10.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = (-u_xlat0.x) * _Diffuse + 1.0;
					    u_xlat10.x = log2(u_xlat10.x);
					    u_xlat10.x = u_xlat10.x * _Reflectivity;
					    u_xlat10.x = exp2(u_xlat10.x);
					    u_xlat3.xyz = u_xlat10.xxx * _SpecularColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat0.xxx * u_xlat3.xyz;
					    u_xlat17 = (-_Ambient) + 1.0;
					    u_xlat5 = u_xlat5 * u_xlat17 + _Ambient;
					    u_xlat1.xyz = u_xlat0.xzw * vec3(u_xlat5) + u_xlat2.xyz;
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[3];
						vec4 _ClipRect;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat5;
					vec2 u_xlat8;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat4 = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat8.x = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat8.x = sqrt(u_xlat8.x);
					    u_xlat12 = u_xlat4 * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat12 = clamp(u_xlat12, 0.0, 1.0);
					    u_xlat0.x = u_xlat4 * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat4 = u_xlat8.x * u_xlat12;
					    u_xlat8.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat8.xy);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat2.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat8.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat8.xy);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat1 = vec4(u_xlat4) * u_xlat1 + u_xlat3;
					    u_xlat4 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat8.x = u_xlat4 * vs_TEXCOORD1.y;
					    u_xlat4 = u_xlat4 * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat8.x * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat4;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat5 = u_xlat0.w * u_xlat1.x + -0.00100000005;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    u_xlatb0 = u_xlat5<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "UNDERLAY_ON" "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						vec4 unused_0_9[15];
						float _ScaleRatioA;
						vec4 unused_0_11[3];
						vec4 _ClipRect;
						vec4 unused_0_13[5];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_COLOR1;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					float u_xlat4;
					float u_xlat5;
					float u_xlat9;
					float u_xlat13;
					void main()
					{
					    u_xlat0.xy = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat0 = texture(_OutlineTex, u_xlat0.xy);
					    u_xlat0 = u_xlat0 * _OutlineColor;
					    u_xlat0.xyz = u_xlat0.www * u_xlat0.xyz;
					    u_xlat1.xyz = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat2 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat2.w = u_xlat2.w * _FaceColor.w;
					    u_xlat2.xyz = u_xlat1.xyz * u_xlat2.www;
					    u_xlat0 = u_xlat0 + (-u_xlat2);
					    u_xlat1.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat1.x = u_xlat1.x * vs_TEXCOORD1.y;
					    u_xlat5 = min(u_xlat1.x, 1.0);
					    u_xlat1.x = u_xlat1.x * 0.5;
					    u_xlat5 = sqrt(u_xlat5);
					    u_xlat3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = (-u_xlat3.w) + vs_TEXCOORD1.z;
					    u_xlat13 = u_xlat9 * vs_TEXCOORD1.y + u_xlat1.x;
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat1.x = u_xlat9 * vs_TEXCOORD1.y + (-u_xlat1.x);
					    u_xlat5 = u_xlat5 * u_xlat13;
					    u_xlat0 = vec4(u_xlat5) * u_xlat0 + u_xlat2;
					    u_xlat5 = _OutlineSoftness * _ScaleRatioA;
					    u_xlat9 = u_xlat5 * vs_TEXCOORD1.y;
					    u_xlat5 = u_xlat5 * vs_TEXCOORD1.y + 1.0;
					    u_xlat1.x = u_xlat9 * 0.5 + u_xlat1.x;
					    u_xlat1.x = u_xlat1.x / u_xlat5;
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat2 = u_xlat0 * u_xlat1.xxxx;
					    u_xlat0.x = (-u_xlat0.w) * u_xlat1.x + 1.0;
					    u_xlat1 = texture(_MainTex, vs_TEXCOORD4.xy);
					    u_xlat4 = u_xlat1.w * vs_TEXCOORD4.z + (-vs_TEXCOORD4.w);
					    u_xlat4 = clamp(u_xlat4, 0.0, 1.0);
					    u_xlat1 = vec4(u_xlat4) * vs_COLOR1;
					    u_xlat0 = u_xlat1 * u_xlat0.xxxx + u_xlat2;
					    u_xlat1.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat1.xy = u_xlat1.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat1.xy = u_xlat1.xy * vs_TEXCOORD2.zw;
					    u_xlat1.xy = clamp(u_xlat1.xy, 0.0, 1.0);
					    u_xlat1.x = u_xlat1.y * u_xlat1.x;
					    u_xlat5 = u_xlat0.w * u_xlat1.x + -0.00100000005;
					    u_xlat0 = u_xlat0 * u_xlat1.xxxx;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    u_xlatb0 = u_xlat5<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "BEVEL_ON" "UNITY_UI_ALPHACLIP" "UNITY_UI_CLIP_RECT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					#define HLSLCC_ENABLE_UNIFORM_BUFFERS 1
					#if HLSLCC_ENABLE_UNIFORM_BUFFERS
					#define UNITY_UNIFORM
					#else
					#define UNITY_UNIFORM uniform
					#endif
					#define UNITY_SUPPORTS_UNIFORM_LOCATION 1
					#if UNITY_SUPPORTS_UNIFORM_LOCATION
					#define UNITY_LOCATION(x) layout(location = x)
					#define UNITY_BINDING(x) layout(binding = x, std140)
					#else
					#define UNITY_LOCATION(x)
					#define UNITY_BINDING(x) layout(std140)
					#endif
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						float _FaceUVSpeedX;
						float _FaceUVSpeedY;
						vec4 _FaceColor;
						float _OutlineSoftness;
						float _OutlineUVSpeedX;
						float _OutlineUVSpeedY;
						vec4 _OutlineColor;
						float _OutlineWidth;
						float _Bevel;
						float _BevelOffset;
						float _BevelWidth;
						float _BevelClamp;
						float _BevelRoundness;
						float _BumpOutline;
						float _BumpFace;
						vec4 _ReflectFaceColor;
						vec4 _ReflectOutlineColor;
						vec4 unused_0_18[5];
						vec4 _SpecularColor;
						float _LightAngle;
						float _SpecularPower;
						float _Reflectivity;
						float _Diffuse;
						float _Ambient;
						vec4 unused_0_25[4];
						float _ShaderFlags;
						float _ScaleRatioA;
						vec4 unused_0_28[3];
						vec4 _ClipRect;
						float _TextureWidth;
						float _TextureHeight;
						float _GradientScale;
						vec4 unused_0_33[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[8];
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _FaceTex;
					uniform  sampler2D _OutlineTex;
					uniform  sampler2D _BumpMap;
					uniform  samplerCube _Cube;
					in  vec4 vs_COLOR0;
					in  vec2 vs_TEXCOORD0;
					in  vec4 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					vec3 u_xlat6;
					bool u_xlatb6;
					float u_xlat8;
					float u_xlat12;
					bool u_xlatb12;
					float u_xlat14;
					float u_xlat18;
					float u_xlat20;
					bool u_xlatb20;
					void main()
					{
					    u_xlat0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat0.x = u_xlat0.w + (-vs_TEXCOORD1.x);
					    u_xlat6.x = (-u_xlat0.w) + vs_TEXCOORD1.z;
					    u_xlatb0 = u_xlat0.x<0.0;
					    if(((int(u_xlatb0) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xz = vec2(_OutlineUVSpeedX, _OutlineUVSpeedY) * _Time.yy + vs_TEXCOORD5.zw;
					    u_xlat1 = texture(_OutlineTex, u_xlat0.xz);
					    u_xlat1 = u_xlat1 * _OutlineColor;
					    u_xlat1.xyz = u_xlat1.www * u_xlat1.xyz;
					    u_xlat0.xzw = vs_COLOR0.xyz * _FaceColor.xyz;
					    u_xlat2.xy = vec2(_FaceUVSpeedX, _FaceUVSpeedY) * _Time.yy + vs_TEXCOORD5.xy;
					    u_xlat3 = texture(_FaceTex, u_xlat2.xy);
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat0.xzw = u_xlat0.xzw * u_xlat3.xyz;
					    u_xlat3.w = u_xlat3.w * _FaceColor.w;
					    u_xlat3.xyz = u_xlat0.xzw * u_xlat3.www;
					    u_xlat1 = u_xlat1 + (-u_xlat3);
					    u_xlat0.x = _OutlineWidth * _ScaleRatioA;
					    u_xlat0.x = u_xlat0.x * vs_TEXCOORD1.y;
					    u_xlat12 = min(u_xlat0.x, 1.0);
					    u_xlat0.x = u_xlat0.x * 0.5;
					    u_xlat12 = sqrt(u_xlat12);
					    u_xlat18 = u_xlat6.x * vs_TEXCOORD1.y + u_xlat0.x;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = u_xlat6.x * vs_TEXCOORD1.y + (-u_xlat0.x);
					    u_xlat6.x = u_xlat12 * u_xlat18;
					    u_xlat1 = u_xlat6.xxxx * u_xlat1 + u_xlat3;
					    u_xlat6.x = _OutlineSoftness * _ScaleRatioA;
					    u_xlat12 = u_xlat6.x * vs_TEXCOORD1.y;
					    u_xlat6.x = u_xlat6.x * vs_TEXCOORD1.y + 1.0;
					    u_xlat0.x = u_xlat12 * 0.5 + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x / u_xlat6.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat1 = u_xlat0.xxxx * u_xlat1;
					    u_xlat0.xy = (-_ClipRect.xy) + _ClipRect.zw;
					    u_xlat0.xy = u_xlat0.xy + -abs(vs_TEXCOORD2.xy);
					    u_xlat0.xy = u_xlat0.xy * vs_TEXCOORD2.zw;
					    u_xlat0.xy = clamp(u_xlat0.xy, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.y * u_xlat0.x;
					    u_xlat6.x = u_xlat1.w * u_xlat0.x + -0.00100000005;
					    u_xlatb6 = u_xlat6.x<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat6.x = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat6.x = min(u_xlat6.x, 1.0);
					    u_xlat6.x = (-u_xlat6.x) + 1.0;
					    u_xlat2.z = sqrt(u_xlat6.x);
					    u_xlat6.x = vs_TEXCOORD1.w + _BevelOffset;
					    u_xlat3.xy = vec2(0.5, 0.5) / vec2(_TextureWidth, _TextureHeight);
					    u_xlat3.z = 0.0;
					    u_xlat4 = (-u_xlat3.xzzy) + vs_TEXCOORD0.xyxy;
					    u_xlat3 = u_xlat3.xzzy + vs_TEXCOORD0.xyxy;
					    u_xlat5 = texture(_MainTex, u_xlat4.xy).wxyz;
					    u_xlat4 = texture(_MainTex, u_xlat4.zw);
					    u_xlat5.z = u_xlat4.w;
					    u_xlat4 = texture(_MainTex, u_xlat3.xy);
					    u_xlat3 = texture(_MainTex, u_xlat3.zw);
					    u_xlat5.w = u_xlat3.w;
					    u_xlat5.y = u_xlat4.w;
					    u_xlat3 = u_xlat6.xxxx + u_xlat5;
					    u_xlat3 = u_xlat3 + vec4(-0.5, -0.5, -0.5, -0.5);
					    u_xlat6.x = _BevelWidth + _OutlineWidth;
					    u_xlat6.x = max(u_xlat6.x, 0.00999999978);
					    u_xlat3 = u_xlat3 / u_xlat6.xxxx;
					    u_xlat6.x = u_xlat6.x * _Bevel;
					    u_xlat6.x = u_xlat6.x * _GradientScale;
					    u_xlat6.x = u_xlat6.x * -2.0;
					    u_xlat3 = u_xlat3 + vec4(0.5, 0.5, 0.5, 0.5);
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat4 = u_xlat3 * vec4(2.0, 2.0, 2.0, 2.0) + vec4(-1.0, -1.0, -1.0, -1.0);
					    u_xlat4 = -abs(u_xlat4) + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat12 = _ShaderFlags * 0.5;
					    u_xlatb20 = u_xlat12>=(-u_xlat12);
					    u_xlat12 = fract(abs(u_xlat12));
					    u_xlat12 = (u_xlatb20) ? u_xlat12 : (-u_xlat12);
					    u_xlatb12 = u_xlat12>=0.5;
					    u_xlat3 = (bool(u_xlatb12)) ? u_xlat4 : u_xlat3;
					    u_xlat4 = u_xlat3 * vec4(1.57079601, 1.57079601, 1.57079601, 1.57079601);
					    u_xlat4 = sin(u_xlat4);
					    u_xlat4 = (-u_xlat3) + u_xlat4;
					    u_xlat3 = vec4(vec4(_BevelRoundness, _BevelRoundness, _BevelRoundness, _BevelRoundness)) * u_xlat4 + u_xlat3;
					    u_xlat12 = (-_BevelClamp) + 1.0;
					    u_xlat3 = min(vec4(u_xlat12), u_xlat3);
					    u_xlat3.xz = u_xlat6.xx * u_xlat3.xz;
					    u_xlat3.yz = u_xlat3.wy * u_xlat6.xx + (-u_xlat3.zx);
					    u_xlat3.x = float(-1.0);
					    u_xlat3.w = float(1.0);
					    u_xlat6.x = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat12 = dot(u_xlat3.zw, u_xlat3.zw);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat4.x = u_xlat12 * u_xlat3.z;
					    u_xlat4.yz = vec2(u_xlat12) * vec2(1.0, 0.0);
					    u_xlat3.z = 0.0;
					    u_xlat3.xyz = u_xlat6.xxx * u_xlat3.xyz;
					    u_xlat5.xyz = u_xlat3.xyz * u_xlat4.xyz;
					    u_xlat3.xyz = u_xlat4.zxy * u_xlat3.yzx + (-u_xlat5.xyz);
					    u_xlat6.x = (-_BumpFace) + _BumpOutline;
					    u_xlat6.x = u_xlat18 * u_xlat6.x + _BumpFace;
					    u_xlat2.xyz = (-u_xlat2.xyz) * u_xlat6.xxx + u_xlat3.xyz;
					    u_xlat6.x = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat6.x = inversesqrt(u_xlat6.x);
					    u_xlat2.xyz = u_xlat6.xxx * u_xlat2.xyz;
					    u_xlat6.x = dot(vs_TEXCOORD3.xyz, (-u_xlat2.xyz));
					    u_xlat6.x = u_xlat6.x + u_xlat6.x;
					    u_xlat3.xyz = u_xlat2.xyz * u_xlat6.xxx + vs_TEXCOORD3.xyz;
					    u_xlat3 = texture(_Cube, u_xlat3.xyz);
					    u_xlat4.xyz = (-_ReflectFaceColor.xyz) + _ReflectOutlineColor.xyz;
					    u_xlat6.xyz = vec3(u_xlat18) * u_xlat4.xyz + _ReflectFaceColor.xyz;
					    u_xlat6.xyz = u_xlat6.xyz * u_xlat3.xyz;
					    u_xlat6.xyz = u_xlat1.www * u_xlat6.xyz;
					    u_xlat3.x = sin(_LightAngle);
					    u_xlat4.x = cos(_LightAngle);
					    u_xlat3.y = u_xlat4.x;
					    u_xlat3.z = -1.0;
					    u_xlat20 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat20 = inversesqrt(u_xlat20);
					    u_xlat3.xyz = vec3(u_xlat20) * u_xlat3.xyz;
					    u_xlat2.x = dot(u_xlat2.xyz, u_xlat3.xyz);
					    u_xlat8 = u_xlat2.z * u_xlat2.z;
					    u_xlat14 = max(u_xlat2.x, 0.0);
					    u_xlat2.x = (-u_xlat2.x) * _Diffuse + 1.0;
					    u_xlat14 = log2(u_xlat14);
					    u_xlat14 = u_xlat14 * _Reflectivity;
					    u_xlat14 = exp2(u_xlat14);
					    u_xlat3.xyz = vec3(u_xlat14) * _SpecularColor.xyz;
					    u_xlat3.xyz = u_xlat3.xyz * vec3(vec3(_SpecularPower, _SpecularPower, _SpecularPower));
					    u_xlat3.xyz = u_xlat3.xyz * u_xlat1.www + u_xlat1.xyz;
					    u_xlat2.xzw = u_xlat2.xxx * u_xlat3.xyz;
					    u_xlat3.x = (-_Ambient) + 1.0;
					    u_xlat8 = u_xlat8 * u_xlat3.x + _Ambient;
					    u_xlat1.xyz = u_xlat2.xzw * vec3(u_xlat8) + u_xlat6.xyz;
					    u_xlat0 = u_xlat0.xxxx * u_xlat1;
					    SV_Target0 = u_xlat0 * vs_COLOR0.wwww;
					    return;
					}"
				}
			}
		}
	}
	Fallback "TextMeshPro/Mobile/Distance Field"
	CustomEditor "TMPro.EditorUtilities.TMP_SDFShaderGUI"
}