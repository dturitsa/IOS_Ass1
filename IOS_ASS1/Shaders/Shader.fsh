//
//  Shader.fsh
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-20.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

varying lowp vec4 colorVarying;

void main()
{
    gl_FragColor = colorVarying;
}
