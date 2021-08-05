Shader "Custom/VertexInSurface"
{
    Properties
    {
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _ColorA ("ColorA", Color) = (1,1,1,1)
        _ColorB ("ColorB", Color) = (1,1,1,1)
        _TintAmount("Tint",Range(0,1)) = 0.5
        _Speed("Speed",Range(0,80))=10
        _Frequency("Frequency",Range(0,5))=2
        _Amplitude ("Amplitude", Range(-1,1)) = 0.0
    }
    SubShader
    {
        Tags { "RenderType"="Opaque" }
        LOD 200

        CGPROGRAM
        // Physically based Standard lighting model, and enable shadows on all light types
        #pragma surface surf Standard fullforwardshadows vertex:vert

        // Use shader model 3.0 target, to get nicer looking lighting
        #pragma target 3.0

        sampler2D _MainTex;
        float4 _ColorA;
        float4 _ColorB;
        float _TintAmount;
        float _Speed;
        float _Frequency;
        float _Amplitude;

        struct Input
        {
            float2 uv_MainTex;
            float4 vertColor;
        };


        // Add instancing support for this shader. You need to check 'Enable Instancing' on materials that use the shader.
        // See https://docs.unity3d.com/Manual/GPUInstancing.html for more information about instancing.
        // #pragma instancing_options assumeuniformscaling
        UNITY_INSTANCING_BUFFER_START(Props)
            // put more per-instance properties here
        UNITY_INSTANCING_BUFFER_END(Props)

        void vert(inout appdata_full v,out Input o){
            UNITY_INITIALIZE_OUTPUT(Input,o);
            float time = _Time * _Speed;
            float waveValueA = sin(time + v.vertex.x * _Frequency) * _Amplitude;
            float waveValueB = sin(time + v.vertex.z * _Frequency) * _Amplitude;
            float3 newWave = float3(v.vertex.x, v.vertex.y+lerp(waveValueA,waveValueB,sin(time)), v.vertex.z);
            v.vertex.xyz = newWave;
            v.normal = float3(v.normal.x+waveValueA, v.normal.y, v.normal.z+waveValueB);
            o.vertColor.rgb=float3(waveValueA,waveValueA,waveValueA);
        }

        void surf (Input IN, inout SurfaceOutputStandard o)
        {
           half4 c = tex2D(_MainTex, IN.uv_MainTex);
           float3 newColor = lerp(_ColorA,_ColorB, IN.vertColor).rgb;
           o.Albedo = c.rgb * (newColor * _TintAmount);
           o.Alpha = c.a;
        }
        ENDCG
    }
    FallBack "Diffuse"
}
