//
//  q8.hpp
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-21.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#ifndef __MixedLanguages__CPlusPlus__
#define __MixedLanguages__CPlusPlus__

#include <iostream>

class CPlusPlus
{
    
public:
    CPlusPlus() { val = 0; };
    ~CPlusPlus() {};
    
    int GetVal();
    void SetVal(int newVal);
    void IncrVal(int incr = 1);
    
private:
    int val;
    
};

#endif /* defined(__MixedLanguages__CPlusPlus__) */
