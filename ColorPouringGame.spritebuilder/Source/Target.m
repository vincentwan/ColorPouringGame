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
    
    [self setColorWithFile:serialnum];
    return self;
}

- (void)setColorWithFile:(int)serialnum {
    UIColor * tempc;
    if(serialnum==0) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x0/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==1) {
        tempc=[UIColor colorWithRed:0xBF/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==2) {
        tempc=[UIColor colorWithRed:0x99/255.0f green:0x0/255.0f blue:0xCC/255.0f alpha:1.0f];
    }
    else if(serialnum==3) {
        tempc=[UIColor colorWithRed:0x5E/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==4) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==5) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0xFF/255.0f blue:0x40/255.0f alpha:1.0f];
    }
    else if(serialnum==6) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==7) {
        tempc=[UIColor colorWithRed:0x80/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==8) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==9) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xBF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==10) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x80/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x33/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    _ccolor = [tempc copy];
    self.colorRGBA = [CCColor colorWithUIColor:_ccolor];
}


- (void)setCcolor:(UIColor *)col {
    //when you create an @property as we did in the .h, an instance variable with a leading underscore is automatically created for you
    _ccolor = [col copy];
    self.colorRGBA = [CCColor colorWithUIColor:_ccolor];
    //NSLog(@"Here!");
    
    //self.colorRGBA = [CCColor colorWithCcColor3b:<#(ccColor3B)#>];
}




@end
