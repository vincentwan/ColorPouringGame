//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"



extern const int GRID_ROWS;
extern const int GRID_COLUMNS;

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF * _stepCount;
    CCLabelTTF * _stepScore;
}

static int currNum;
+ (int) currNum
{ @synchronized(self) { return currNum; } }
+ (void) setCurrNum:(int)val
{ @synchronized(self) { currNum = val; } }

static int levelNum = 0;
+ (int) levelNum
{ @synchronized(self) { return levelNum; } }
+ (void) setLevelNum:(int)val
{ @synchronized(self) { levelNum = val; } }

// Read only static variable
static int totalLevel = 2;
+ (int) totalLevel
{ @synchronized(self) { return totalLevel; } }


- (id)init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    NSLog(@"This is MainScene!");
    
    double centralX = 520;
    double centralY = 192;
    double radius = 30;
    double sizeX = 23;
    double sizeY = 28;
    
    for(int i=0; i<12; i++) {
        double ang = (i*M_PI)/6;
        double x = centralX + radius * sin(ang);
        double y = centralY + radius * cos(ang);
        ColorPanel * panel = [[ColorPanel alloc] initPanelwithX:sizeX Y:sizeY PosX:x PosY:y
                                                      angle:(30*i) andColor:i andType:0];
        panel.zOrder = 1;
        [self addChild:panel];
    }
    
    _redBtn = [[ColorButton alloc] initBtnwithX:430 andY:243.5 andNum:0];
    _redBtn.zOrder = 1;
    [_redBtn setTarget:self selector:@selector(selectred)];
    [self addChild:_redBtn];
    _blueBtn = [[ColorButton alloc] initBtnwithX:430 andY:200.5 andNum:4];
    _blueBtn.zOrder = 1;
    [_blueBtn setTarget:self selector:@selector(selectblue)];
    [self addChild:_blueBtn];
    _yellowBtn = [[ColorButton alloc] initBtnwithX:430 andY:157.5 andNum:8];
    _yellowBtn.zOrder = 1;
    [_yellowBtn setTarget:self selector:@selector(selectyellow)];
    [self addChild:_yellowBtn];
    
    /*
    double centralX = 520;
    double centralY = 192;
    double radius = 28;
    double sizeX = 45;
    double sizeY = 30;
    
    for(int i=0; i<6; i++) {
        double ang = (i*M_PI)/3;
        double x = centralX + radius * sin(ang);
        double y = centralY + radius * cos(ang);
        ColorPanel * panel = [[ColorPanel alloc] initPanelwithX:sizeX Y:sizeY PosX:x PosY:y
                                                          angle:(60*i) andColor:(2*i) andType:1];
        panel.zOrder = 1;
        [self addChild:panel];
    }
     */
    return self;
}

- (void)onEnter
{
    [super onEnter];
    
    [self selectred];
    NSLog(@"This is MainScene onEnter");
    
    _stepCount.string = [NSString stringWithFormat:@"%d", 0];
    _grid.stepCount = _stepCount;
    _stepScore.string = [NSString stringWithFormat:@"%d", 0];
    _grid.stepScore = _stepScore;

}

- (void)selectred
{
    /*
    currColor = [UIColor colorWithRed:255.0f/255.0f
                    green:83.0f/255.0f
                    blue:111.0f/255.0f
                    alpha:1.0f];
     */
    currNum = 0;

    [_redBtn setSelected:YES];
    [_blueBtn setSelected:NO];
    [_yellowBtn setSelected:NO];
    
    NSLog(@"Here red!");
    //[self loadMyViewController];
}

- (void)selectblue
{
    /*
     currColor = [UIColor colorWithRed:18.0f/255.0f
     green:83.0f/255.0f
     blue:255.0f/255.0f
     alpha:1.0f];
     */
    currNum = 4;
    [_blueBtn setSelected:YES];
    [_redBtn setSelected:NO];
    [_yellowBtn setSelected:NO];
    NSLog(@"Here blue!");
}

- (void)selectyellow
{
    /*
    currColor = [UIColor colorWithRed:255.0f/255.0f
                    green:255.0f/255.0f
                    blue:62.0f/255.0f
                    alpha:1.0f];
     */
    currNum = 8;
    [_yellowBtn setSelected:YES];
    [_blueBtn setSelected:NO];
    [_redBtn setSelected:NO];
    NSLog(@"Here yellow!");
}

- (void)restart
{
    [_grid clearCreatures];
    NSLog(@"Restart!");
}

- (void)loadMyViewController {

}

@end
