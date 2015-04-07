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
@property (nonatomic, retain) UIColor * ccolor;
@property (nonatomic, retain) ColorHelper * helper;
@property (nonatomic) int serialnum;


// stores the amount of living neighbors
@property (nonatomic, assign) NSInteger livingNeighbors;

@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;

- (instancetype)initCreaturewithX:(double) xlen andY:(double) ylen;

@end