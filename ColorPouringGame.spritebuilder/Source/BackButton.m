//
//  BackButton.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/5/2.
//  Copyright (c) 2015年 vincent. All rights reserved.
//

#import "BackButton.h"

@implementation BackButton

- (instancetype)initBtnwithX:(NSString *) text Width:(double) wid Height:(double) hei{

    self = [super initWithTitle:@"Back"
                             spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Buttons/back.png"]
                  highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Buttons/back.png"]
                     disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Buttons/back.png"]];
    
    self.position = ccp(wid,hei);
    self.anchorPoint = ccp(0.5,0.5);
    self.zOrder = 1;
    self.enabled = true;
    return self;
}


@end
