// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Hidden/Orthographic"
{
    Properties
    {
        _MainTex ("Texture", 2D) = "white" {}
        _PerspectiveMultiplier("Perspective multiplier", Range(0.0, 1.0)) = 1.0
        //unity_OrthoParams ("Ortho testing", float4) = 0.0
        _Pos("_position", Vector) = (0.0,0.0,0.0)
    }
        SubShader
        {
            // No culling or depth
            Cull Back ZWrite On ZTest Less

            Pass
            {
                Name "OrhtographicProjection"
                CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                float3 _Pos;
                float _PerspectiveMultiplier;
                //float _ZPos;

            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
                half3 worldNormal : TEXCOORD1;
            };

            v2f vert (appdata v, float3 normal : NORMAL)
            {
                v2f o;
                float3 vertex = v.vertex;
                //float3 oldPosition = UnityObjectToClipPos(vertex);
                //vertex.x += 2.5;
                o.vertex = UnityObjectToClipPos(vertex);
                float4 objectClipPos = UnityObjectToClipPos(float3(0,0,0));
                o.vertex.w = lerp(objectClipPos.w, o.vertex.w, _PerspectiveMultiplier);
                
               /* float3 objectPosition = float3(420.299988, 24.8999996, 80.0999985);
                float3 difference = UnityObjectToClipPos(objectPosition);
                objectPosition.x += 2.5;
                float3 difference2 = UnityObjectToClipPos(objectPosition);

                o.vertex.x += difference.x - difference2.x;
                
                vertex *= _Pos;*/
                //vertex.z *= _ZPos;
                //o.vertex = UnityObjectToClipPos(float4(vertex, 1));
                //o.vertex.w -= 5;
                //o.vertex.w = _ZPos;
                //o.vertex.z = 15;

                o.worldNormal = UnityObjectToWorldNormal(normal);

                o.uv = v.uv;
                return o;
            }

            // convert to screen space
            //Vec2f P_screen;
            //P_screen.x = near * P_camera.x / -P_camera.z;
            //P_screen.y = near * P_camera.y / -P_camera.z;

            // now convert point from screen space to NDC space (in range [-1, 1])
            //Vec3f P_ndc;
            //P_ndc.x = 2 * P_screen.x / (r - l) - (r + l) / (r - l);
            //P_ndc.y = 2 * P_screen.y / (t - b) - (t + b) / (t - b);

            sampler2D _MainTex;

            fixed4 frag (v2f i) : SV_Target
            {
                fixed4 col = tex2D(_MainTex, i.uv);
                // just invert the colors
                //col.rgb = 1 - col.rgb;
                //return float4(1-i.worldNormal, 1);
                return col;
            }
            ENDCG
        }
    }
}
