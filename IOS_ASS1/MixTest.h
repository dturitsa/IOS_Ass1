//
//  MixFile.hpp
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-22.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#import <Foundation/Foundation.h>

struct CPlusPlusClass;

@interface MixTest : NSObject
{
    @private
    struct CPlusPlusClass *cPlusPlusObject;
}

@property (nonatomic) int objCVal;

-(int)incrementObjCVal;
-(int)incrementCppVal;

@end
