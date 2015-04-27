//
//  Creature.m
//  GameOfLife
//
//  Created by 万欣 on 15/1/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Creature.h"


@implementation Creature

- (instancetype)initCreaturewithX:(double) xlen andY:(double) ylen {
    //self = [super initWithImageNamed:@"ColorPouringAssets/Assets/cell.png"];
    //[super setScaleX:(xlen/self.contentSize.width)];
    //[super setScaleY:(ylen/self.contentSize.height)];
    
    CCTexture *colTexture = [CCTexture textureWithFile:@"ColorPouringAssets/Assets/full_color_inner.png"];
    
    CCSpriteFrame *frame = [CCSpriteFrame frameWithTexture:colTexture
                                              rectInPixels:CGRectMake(0, 0, xlen, ylen)
                                                   rotated:NO
                                                    offset:CGPointZero
                                              originalSize:CGSizeMake(614, 614)];
    
    self = [super initWithSpriteFrame: frame];
    
    if (self) {
        self.isAlive = NO;
        self.isMutable = YES;
    }
    
    return self;
}


- (void)setIsAlive:(BOOL)newState {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _isAlive = newState;
    
    // 'visible' is a property of any class that inherits from CCNode. CCSprite is a subclass of CCNode, and Creature is a subclass of CCSprite, so Creatures have a visible property
    self.visible = _isAlive;
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}

- (void) setSerialnum:(int) num {
    _serialnum = num;
    //[self setCcolor:[ColorHelper setColorWithFile:num]];
}



- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    self.colorRGBA = [CCColor colorWithUIColor:col];
    //NSLog(@"Here!");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}


@end
