//
//  Grid.h
//  GameOfLife
//
//  Created by 万欣 on 15/1/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "CCSprite.h"
#import "Level.h"

@interface Grid : CCSprite

@property (nonatomic, assign) int totalAlive;
@property (nonatomic, assign) int generation;
@property (strong, nonatomic) Level *level;



- (void)evolveStep;
- (void)countNeighbors;
- (void)updateCreatures;
- (void)clearCreatures;

@end
