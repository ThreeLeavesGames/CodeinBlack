Shader "Unlit/ColorCubeShader"
{
    Properties
    {
        _MainColor("Main Color", Color) = (1,0,0,1)
        _XPosition("X Position", Float) = 0
        _ZPosition("Z Position", Float) = 0
    }
    SubShader
    {
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag

            #include "UnityCG.cginc"

            fixed4 _MainColor;
            float _XPosition;
            float _ZPosition;

            struct appdata
            {
                float4 vertex:POSITION;
                float4 color: COLOR;

            };

            struct v2f
            {
                float4 clipPos:SV_POSITION;
                float4 color: COLOR;

            };

            v2f vert(appdata v)
            {

                v2f o;
                o.color=v.vertex+0.5;//adding o.5 bcoz vertex positions are between -0.5 and 0.5. However, color values should be between 0 and 1. Therefore, we have to remap it to make colors brighter
                //https://www.codinblack.com/vertex-shader-and-manipulating-vertices/
                o.clipPos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return i.color;
            }
            ENDCG
        }
    }
}