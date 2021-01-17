Shader "Unlit/LineShader_Horizontal"
{
    Properties
    {
        _MainColor("Main Color", Color) = (1,0,0,1)
            _LineWidth("Line Width", Float)=0.2
        _ZPosition("Z Position of the Line", Float)=0
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
            float _LineWidth;
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
                float4 objectPos:TEXCOORD0;

            };

            v2f vert(appdata v)
            {

                v2f o;
                o.color=v.vertex+0.5;//adding o.5 bcoz vertex positions are between -0.5 and 0.5. However, color values should be between 0 and 1. Therefore, we have to remap it to make colors brighter
                //https://www.codinblack.com/vertex-shader-and-manipulating-vertices/
                o.clipPos = UnityObjectToClipPos(v.vertex);
                o.objectPos=v.vertex;
                return o;
            }

            fixed4 frag(v2f i) : SV_Target
            {
               fixed4 col;
                if(i.objectPos.z>_ZPosition - _LineWidth/2 && i.objectPos.z<_ZPosition+_LineWidth/2)
                {
                    col=_MainColor;
                }else{
                    col=fixed4(0,0,0,1);
                }
                return col;
            }
            ENDCG
        }
    }
}