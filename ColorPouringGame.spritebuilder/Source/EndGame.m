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
    CCLabelTTF *_messageLabel;
    NSInteger _threshold;
}

- (id) init:(int) finalScore
{
    self=[super init];
    _threshold = 40;
    return self;
}


- (void)setMessage:(int)score {
    if((MainScene.levelNum != MainScene.totalLevel - 1) && score >= _threshold) {
        CCButton * restartBtn = [CCButton buttonWithTitle:@"Restart"
                                              spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonNormal.png"]
                                   highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonHighlighted.png"]
                                      disabledSpriteFrame:nil];
        
        restartBtn.togglesSelectedState = YES;
        restartBtn.position = ccp(229,35);
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
        nextBtn.position = ccp(95,35);
        nextBtn.anchorPoint = ccp(0.5,0.5);
        [nextBtn setTarget:self selector:@selector(nextLevel)];
        nextBtn.zOrder = 1;
        nextBtn.horizontalPadding = 15.0;
        nextBtn.verticalPadding = 10.0;
        [self addChild:nextBtn];
    }
    else {
        CCButton * restartBtn = [CCButton buttonWithTitle:@"Restart"
                                              spriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonNormal.png"]
                                   highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"ColorPouringAssets/Assets/ccbButtonHighlighted.png"]
                                      disabledSpriteFrame:nil];
        
        restartBtn.togglesSelectedState = YES;
        restartBtn.position = ccp(162,35);
        restartBtn.anchorPoint = ccp(0.5,0.5);
        [restartBtn setTarget:self selector:@selector(restart)];
        restartBtn.zOrder = 1;
        restartBtn.horizontalPadding = 15.0;
        restartBtn.verticalPadding = 10.0;
        [self addChild:restartBtn];
    }
    _scoreMessage.string = [NSString stringWithFormat:@"%d", score];
    NSLog(@"Threshold: %ld", _threshold);
    if(score >= _threshold) {
        _messageLabel.string = [NSString stringWithFormat:@"You Win!"];
    }
    else {
        _messageLabel.string = [NSString stringWithFormat:@"Try to reach an accuracy rate of %ld", _threshold];
    }
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
