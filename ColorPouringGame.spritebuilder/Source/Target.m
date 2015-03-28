//
//  Target.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/3/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Target.h"

@implementation Target

- (instancetype)initTargetwithX:(double) xlen andY:(double) ylen andImage:(int) serialnum{
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    self = [super initWithImageNamed:@"ColorPouringAssets/Assets/cell.png"];
    [super setScaleX:(xlen/self.contentSize.width)];
    [super setScaleY:(ylen/self.contentSize.height)];
    self.visible = true;
    return self;
    self.ccolor =
}

- (void)setColorWithFile:(int)serialnum {
    
    _ccolor = [UIColor colorWithRed:255.0f/255.0f green:83.0f/255.0f blue:111.0f/255.0f alpha:1.0f]
    self.colorRGBA = [];
}


- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _ccolor = [col copy];
    self.colorRGBA = [CCColor colorWithUIColor:_ccolor];
    //NSLog(@"Here!");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}




@end
