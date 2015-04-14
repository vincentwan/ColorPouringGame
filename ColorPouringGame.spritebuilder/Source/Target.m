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
    self = [super initWithImageNamed:@"ColorPouringAssets/Assets/cut4.png"];
    _helper = [[ColorHelper alloc] init];
    [super setScaleX:(xlen/self.contentSize.width)];
    [super setScaleY:(ylen/self.contentSize.height)];
    self.visible = true;
    NSLog(@"Here! initTargetwithNum: %d\n", serialnum);
    UIColor * tempc = [_helper setColorWithFile:serialnum];
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [tempc getRed:&red green:&green blue:&blue alpha:&alpha];
    NSLog(@"Before setting target color red %f green %f blue %f\n", red, green, blue);

    [self setCcolor:tempc];
    return self;
}


- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _ccolor = [col copy];
    
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [_ccolor getRed:&red green:&green blue:&blue alpha:&alpha];
    
    NSLog(@"Here's setting target color red %f green %f blue %f\n", red, green, blue);
    
    self.colorRGBA = [CCColor colorWithUIColor:_ccolor];
    //NSLog(@"Here! setCcolor");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}




@end
