//
//  ColorPanel.h
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/16.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "ColorHelper.h"

@interface ColorPanel : CCSprite


// stores the current state of the creature
@property (nonatomic, retain) UIColor * ccolor;
@property (nonatomic) int * serialnum;

- (instancetype)initPanelwithX:(double) xlen Y:(double) ylen PosX:(double) xpos PosY:(double) ypos
                         angle:(double) angle andImage:(int) serialnum;

@end
