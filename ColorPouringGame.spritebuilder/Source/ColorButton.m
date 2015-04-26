//
//  ColorButton.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/26.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "ColorButton.h"

@implementation ColorButton


static int btnSizeX = 70;
static int btnSizeY = 35;

+ (int) btnSizeX
{ @synchronized(self) { return btnSizeX; } }
+ (int) btnSizeY
{ @synchronized(self) { return btnSizeY; } }

- (instancetype)initBtnwithX:(double) xlen andY:(double) ylen andNum:(int) serialnum andSel:(SEL) select{
    self = [CCButton buttonWithTitle:@""
                                      spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/cell.png"]
                           highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/cell_highlighted.png"]
                              disabledSpriteFrame:nil];
    self.togglesSelectedState = YES;
    self.position = ccp(xlen,ylen);
    self.anchorPoint = ccp(0.5,0.5);
    [super setTarget:self selector:select];

    [super setScaleX:(btnSizeX/self.contentSize.width)];
    [super setScaleY:(btnSizeY/self.contentSize.height)];
    super.colorRGBA = [CCColor colorWithUIColor:[[ColorHelper setColorWithFile:serialnum] copy]];
    return self;
}

@end
