//
//  EndGame.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "EndGame.h"
#import <UIKit/UIKit.h>

@implementation EndGame {
    CCLabelTTF *_scoreMessage;
}

- (id) init
{
    if((self=[super init])) {
        CCButton * restartBtn = [CCButton buttonWithTitle:@"Restart"
                                                  spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonNormal.png"]
                                       highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonHighlighted.png"]
                                          disabledSpriteFrame:nil];
        
        restartBtn.togglesSelectedState = YES;
        restartBtn.position = ccp(229,29);
        restartBtn.anchorPoint = ccp(0.5,0.5);
        [restartBtn setTarget:self selector:@selector(restart)];
        restartBtn.zOrder = 1;
        restartBtn.horizontalPadding = 15.0;
        restartBtn.verticalPadding = 10.0;
        [self addChild:restartBtn];
        
        CCButton * nextBtn = [CCButton buttonWithTitle:@"Next Level"
                                              spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonNormal.png"]
                                   highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonHighlighted.png"]
                                      disabledSpriteFrame:nil];
        
        nextBtn.togglesSelectedState = YES;
        nextBtn.position = ccp(95,29);
        nextBtn.anchorPoint = ccp(0.5,0.5);
        [nextBtn setTarget:self selector:@selector(nextLevel)];
        nextBtn.zOrder = 1;
        nextBtn.horizontalPadding = 15.0;
        nextBtn.verticalPadding = 10.0;
        [self addChild:nextBtn];
    }
    return self;
}


- (void)setMessage:(NSString *)message score:(NSInteger)score {
    _scoreMessage.string = [NSString stringWithFormat:@"%ld", (long)score];
}

- (void)restart
{
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:mainScene];
    NSLog(@"Restart!");
}

- (void)nextLevel
{
    [MainScene setLevelNum:(MainScene.levelNum+1)];
    NSLog(@"Next Level: %d!", MainScene.levelNum);
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:mainScene];
}

@end
