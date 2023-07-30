Shader "Custom/ShaderForLesson"
{
    Properties
    {
        _Tex1("Texture1", 2D) = "white" {}
        _Tex2("Texture2", 2D) = "white" {}
        _MixValue("MixValue", Range(0, 1)) = 0.5
        _Color("Main Color", Color) = (1, 1, 1, 1)
        _Heigth ("Heigth", Range(0, 20)) = 0.5
    }

    SubShader
    {
        Tags{"RenderType" = "Opaque"}
        LOD 100

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #include "UnityCG.cginc"

            sampler2D _Tex1;
            float4 _Tex1_ST;
            sampler2D _Tex2;
            float4 _Tex2_ST;

            float _MixValue;
            float4 _Color;
            float _Heigth;

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata_full v)
            {
                v2f result;
                v.vertex.xyz += -v.normal * _Heigth * v.vertex.x * v.vertex.x;
                result.vertex = UnityObjectToClipPos(v.vertex);
                result.uv = TRANSFORM_TEX(v.texcoord, _Tex1);
                return result;
            }

            fixed4 frag(v2f i) : SV_TARGET
            {
                fixed4 color;
                color = tex2D(_Tex1, i.uv) * _MixValue;
                color += tex2D(_Tex2, i.uv) * (1 - _MixValue);
                color = color * _Color;
                return color;
            }

            ENDCG
        }
    }
}
