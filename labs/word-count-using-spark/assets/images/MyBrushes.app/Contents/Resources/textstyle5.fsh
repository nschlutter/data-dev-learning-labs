// http://www.cocos2d-iphone.org
//两个光源：左右 右左
#ifdef GL_ES
precision lowp float;
#endif

varying vec2 v_texCoord;
uniform sampler2D CC_Texture0;
uniform		vec4 u_color;

varying vec2 v_texCorrdYRang[9];

void main()
{
    vec3 sum = vec3(0.0);
    float fValue = 1.0;
    float fTemp;
    
    vec2 topleft;
    for(int y=-1; y<2; y++)
        for(int x=-1; x<2; x++)
        {
            if(x==0 && y==0)
                fValue = 0.2;
            else fValue = 0.10;
            
            if( x==-1)
                topleft = v_texCorrdYRang[(y+1)*3+x+1] - vec2(0.00030, 0);
            else if(x==0)
                topleft = v_texCorrdYRang[(y+1)*3+x+1];
            else
                topleft = v_texCorrdYRang[(y+1)*3+x+1] - vec2(-0.00030, 0);

            fTemp = fValue * (texture2D(CC_Texture0, v_texCorrdYRang[(y+1)*3+x+1]).a - texture2D(CC_Texture0, topleft).a);
            //if(fTemp < 0.0)  fTemp = 0.0;
            //fTemp += 1.0*u_color.rgb;
            
            sum += vec3(fTemp);
            
        }
    
    gl_FragColor = vec4(sum +1.0*u_color.rgb, texture2D(CC_Texture0, v_texCorrdYRang[1*3+1]).a);
}
