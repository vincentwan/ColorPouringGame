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
    // since we made Creature inherit from CCSprite, 'super' below refers to CCSprite
    
    self = [super initWithImageNamed:@"ColorPouringAssets/Assets/cell.png"];
    [super setScaleX:(xlen/self.contentSize.width)];
    [super setScaleY:(ylen/self.contentSize.height)];
    
    if (self) {
        self.isAlive = NO;
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
    [self setCcolor:[ColorHelper setColorWithFile:num]];
}



- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _ccolor = [col copy];
    self.colorRGBA = [CCColor colorWithUIColor:_ccolor];
    //NSLog(@"Here!");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}


@end
