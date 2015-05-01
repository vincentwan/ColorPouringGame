//
//  Creature.h
//  GameOfLife
//
//  Created by 万欣 on 15/1/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "ColorHelper.h"

@interface Creature : CCSprite

// stores the current state of the creature
@property (nonatomic, assign) BOOL isAlive;
@property (nonatomic) int serialnum;
@property (nonatomic) double xlen;
@property (nonatomic) double ylen;
@property (nonatomic, assign) BOOL isMutable;

- (instancetype)initCreaturewithX:(double) xlen andY:(double) ylen;
- (void) setSerialnum:(int) num;
- (void)disable;
- (void)enable;

@end