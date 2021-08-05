Shader "Custom/Hologram"
{
    Properties
    {
        _Color ("Rim Color", Color) = (1,1,1,1)
        _Color2("Color2", Color) = (1,1,1,1)
        _Power ("Power of Rim", Range(0,10)) = 1
        _CutOff ("Power of Cut", Range(0,1)) = 1
        _Alpha ("Alpha", Range(0,1)) = 1
    }
    SubShader
    {
        Tags { "RenderType"="Transparent" }
        Tags { "Queue"="Transparent"}
        LOD 200
        
        Pass{
            ZWrite On
            ColorMask 0
        }


        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows alpha:fade

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        float4 _Color;
        float4 _Color2;
        float _Power;
        float _CutOff;
        float _Alpha;


        struct Input
        {
            float3 worldRefl;
            float3 viewDir;
            float3 worldPos;
        };

        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
            fixed4 c = _Color;
            half dotp = 1-saturate(dot(normalize(IN.viewDir),normalize(o.Normal)));
            if(dotp<_CutOff) dotp = 0;
            o.Emission = c.rgb * pow(dotp,_Power);
            o.Albedo = _Color2.rgb;
            o.Alpha = _Alpha * pow(dotp,_Power);
        }
        ENDCG
    }
    FallBack "Diffuse"
}
