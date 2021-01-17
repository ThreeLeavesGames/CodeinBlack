Shader "Unlit/quadToParallelogram"
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
            };

            struct v2f
            {
                float4 clipPos:SV_POSITION;
            };

            v2f vert(appdata v)
            {

                v2f o;
                if (v.vertex.y > 0) {//calculation done in object space before passing the data for conversion
                    v.vertex.x = v.vertex.x + _XPosition;
                    v.vertex.z = v.vertex.z + _ZPosition;
                }
                o.clipPos = UnityObjectToClipPos(v.vertex);
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
                return _MainColor;
            }
            ENDCG
        }
    }
}