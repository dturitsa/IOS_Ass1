//
//  MixFile.cpp
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-22.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#import "MixTest.h"
#include "CPlusPlus.h"

struct CPlusPlusClass
{
    CPlusPlus theObj;
};

@implementation MixTest

@synthesize objCVal;

- (id)init
{
    self = [super init];
    if (self) {
        objCVal = 0;
        cPlusPlusObject = new CPlusPlusClass;
    }
    return self;
}

-(int)incrementObjCVal{
    objCVal++;
    return objCVal;
}

-(int)incrementCppVal{
    cPlusPlusObject->theObj.IncrVal();
    return cPlusPlusObject->theObj.GetVal();
}


@end
