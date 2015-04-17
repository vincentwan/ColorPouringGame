//
//  Level.h
//  ColorPouringGame
//
//  Created by 万欣 on 15/3/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Target.h"

@interface Level : NSObject

@property (nonatomic, assign) int numRow;
@property (nonatomic, assign) int numCol;

- (instancetype)initWithFile:(NSString *)filename;
- (int) serialAtX:(int) x andY:(int)y;

- (int) getNumRow;
- (int) getNumCol;


@end
