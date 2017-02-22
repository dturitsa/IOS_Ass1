//
//  GameViewController.h
//  IOS_ASS1
//
//  Created by Denis Turitsa on 2017-02-20.
//  Copyright © 2017 Denis Turitsa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GLKit/GLKit.h>
#import "MixTest.h"

@interface GameViewController : GLKViewController
{
    MixTest *theObject;
}

- (IBAction)ResetBut:(id)sender;
- (IBAction)q8But:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *posLabel;
@property (weak, nonatomic) IBOutlet UILabel *rotLabel;
@property (weak, nonatomic) IBOutlet UILabel *q8Label;

@end
