//
//  ColorPick.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/2/22.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "ColorPick.h"

@implementation ColorPick

- (void)onEnter
{
    [super onEnter];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    CCColor * tempcolor = self.colorRGBA;
    const CGFloat* components = CGColorGetComponents(tempcolor.CGColor);
    NSLog(@"Red: %f", components[0]);
    NSLog(@"Green: %f", components[1]);
    NSLog(@"Blue: %f", components[2]);
    NSLog(@"Alpha: %f", CGColorGetAlpha(tempcolor.CGColor));
}

@end
