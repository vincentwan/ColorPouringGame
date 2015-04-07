//
//  Level.h
//  ColorPouringGame
//
//  Created by 万欣 on 15/3/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UIColor+Mixing.h"
#import "Target.h"

@interface Level : NSObject

- (instancetype)initWithFile:(NSString *)filename;
- (int)serialAtX:(int) x andY:(int)y;
- (int *) targetGrid;

@end
