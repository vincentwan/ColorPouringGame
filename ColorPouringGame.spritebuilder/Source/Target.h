//
//  Target.h
//  ColorPouringGame
//
//  Created by 万欣 on 15/3/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "ColorHelper.h"

@interface Target : CCSprite

// stores the current state of the creature
@property (nonatomic, retain) UIColor * ccolor;
@property (nonatomic) int * serialnum;
@property (nonatomic, retain) ColorHelper * helper;

- (instancetype)initTargetwithX:(double) xlen andY:(double) ylen andImage:(int) serialnum;

@end
