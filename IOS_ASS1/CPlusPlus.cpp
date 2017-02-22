//
//  q8.cpp
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-21.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#include "CPlusPlus.h"

int CPlusPlus::GetVal()
{
    return val;
}

void CPlusPlus::SetVal(int newVal)
{
    val = newVal;
}

void CPlusPlus::IncrVal(int incr)
{
    val += incr;
}
