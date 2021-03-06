Shader "Custom/ForLambert"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpeqColor ("SpeqColor", Color) = (1,1,1,1)
        _Speq ("Specular", Range(0,1)) = 0.5
        _Gloss ("Gloss", Range(0,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Lambert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        fixed4 _SpeqColor;
        half _Speq;
        half _Gloss;
        fixed4 _Color;

        struct Input
        {
            float2 uv_MainTex;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void surf (Input IN, inout SurfaceOutput o)
        {
            // Albedo comes from a texture tinted by color
            fixed4 c = _Color;
            o.Albedo = c.rgb;
            o.Specular = _Speq;
            o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
