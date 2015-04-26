//
//  EndGame.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "EndGame.h"

@implementation EndGame {
    CCLabelTTF *_scoreMessage;
}


- (void)setMessage:(NSString *)message score:(NSInteger)score {
    _scoreMessage.string = [NSString stringWithFormat:@"%ld", (long)score];
}

- (void)newGame
{
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:mainScene];
    NSLog(@"Restart!");
}

- (void)nextLevel
{
    [MainScene setLevelNum:(5)];
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:mainScene];
    NSLog(@"Next Level: %d!", MainScene.levelNum);
}

@end
