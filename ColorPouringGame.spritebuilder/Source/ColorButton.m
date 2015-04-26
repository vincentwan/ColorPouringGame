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

- (instancetype)initBtnwithX:(double) xlen andY:(double) ylen andNum:(int) serialnum{
    self = [super initWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/cell.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/cell_highlighted.png"] disabledSpriteFrame:nil];
    //self.togglesSelectedState = YES;
    self.position = ccp(xlen,ylen);
    self.anchorPoint = ccp(0.5,0.5);
    

    [super setScaleX:(btnSizeX/self.contentSize.width)];
    [super setScaleY:(btnSizeY/self.contentSize.height)];
    UIColor * tempc = [ColorHelper setColorWithFile:serialnum];
    [self setCcolor:tempc];
    return self;
}


- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    
    [self setBackgroundColor:[CCColor colorWithUIColor:col] forState:CCControlStateNormal];
    [self setBackgroundColor:[CCColor colorWithUIColor:col] forState:CCControlStateSelected];
    [self setBackgroundColor:[CCColor colorWithUIColor:col] forState:CCControlStateHighlighted];
    [self setBackgroundOpacity:0.7 forState:CCControlStateSelected];
    [self setBackgroundOpacity:0.7 forState:CCControlStateHighlighted];
    
    //NSLog(@"Here! setCcolor");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}


@end
