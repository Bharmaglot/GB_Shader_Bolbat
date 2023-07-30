Shader "Custom/ShaderForLesson"
{
    Properties
    {
        _Tex1("Texture1", 2D) = "white" {}
        _Tex2("Texture2", 2D) = "white" {}
        _Color("Main Color", Color) = (1, 1, 1, 1)
        _Color2("Second Color", Color) = (1, 0, 1, 0.5)
        _Heigth("Heigth", Range(0, 3)) = 0.5

    }

        SubShader
        {
            Tags { "Queue" = "Transparent" "IgnoreProjector" = "True" "RenderType" = "Transparent" }
Blend SrcAlpha OneMinusSrcAlpha
            LOD 100

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                sampler2D _Tex1;
                float4 _Tex1_ST;

                float4 _Color;

                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };

                v2f vert(appdata_full v)
                {
                    v2f result;
                    result.vertex = UnityObjectToClipPos(v.vertex);
                    result.uv = TRANSFORM_TEX(v.texcoord, _Tex1);
                    return result;
                }

                fixed4 frag(v2f i) : SV_TARGET
                {
                    fixed4 color;
                    color = tex2D(_Tex1, i.uv);
                    color = color * _Color;
                    return color;
                }

                ENDCG
            }

            Pass
            {
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #include "UnityCG.cginc"

                sampler2D _Tex2;
                float4 _Tex2_ST;


                float4 _Color2;
                float _Heigth;

                struct v2f
                {
                    float2 uv : TEXCOORD0;
                    float4 vertex : SV_POSITION;
                };

                v2f vert(appdata_full v)
                {
                    v2f result;
                    v.vertex.xyz += v.normal * _Heigth;
                    result.vertex = UnityObjectToClipPos(v.vertex);
                    result.uv = TRANSFORM_TEX(v.texcoord, _Tex2);
                    return result;
                }

                fixed4 frag(v2f i) : SV_TARGET
                {
                    fixed4 color;
                    color = tex2D(_Tex2, i.uv);                    
                    color = color * _Color2;
                    return color;
                }

                ENDCG
            }
        }
}
