Shader "Custom/SecondShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _RangeX ("X", Range(-4,4)) = 0.0
        _RangeY ("Y", Range(-4,4)) = 0.0
        _Float ("Multiplier", Float) = 1
        _Normals ("NormalMap", 2D) = "bump"{}
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        sampler2D _Normals;
        fixed4 _Color;
        half _RangeX;
        half _RangeY;
        float _Float;
        float4 _Vector;


        struct Input
        {
            float2 uv_MainTex;
            float2 uv_Normals;
            float3 worldRefl;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            float2 uv = IN.uv_MainTex;
            float Xt = _RangeX * _Time;
            float Yt = _RangeY * _Time;
            uv += float2(Xt,Yt);
            fixed4 c = (tex2D (_MainTex, uv) * _Color);
            o.Albedo = c.rgb;
            o.Alpha = c.a;
            fixed3 nm = UnpackNormal(tex2D(_Normals,IN.uv_Normals));
            nm.x *=_Float;
            nm.y *=_Float;
            o.Normal = normalize(nm);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
