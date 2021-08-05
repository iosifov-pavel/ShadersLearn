Shader "Custom/ForPhong"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _SpecColor ("SpecColor", Color) = (1,1,1,1)
        _Speq ("Specular", Range(0,1)) = 0.5
        _Gloss ("Gloss", Range(0,1)) = 0.5
    }
    SubShader
    {
        Tags { "Queue"="Geometry"}
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf BlinnPhong

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

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
            o.Albedo = _Color.rgb;
            o.Specular = _Speq;
            o.Gloss = _Gloss;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
