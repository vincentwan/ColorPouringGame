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
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
}

static int currNum;
+ (int) currNum
{ @synchronized(self) { return currNum; } }
+ (void) setCurrNum:(int)val
{ @synchronized(self) { currNum = val; } }


- (id)init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    

    return self;
}

- (void)play
{
    //this tells the game to call a method called 'step' every half second.
    [self schedule:@selector(step) interval:0.5f];
}

- (void)pause
{
    [self unschedule:@selector(step)];
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
    NSLog(@"Here red!");
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
    NSLog(@"Here yellow!");
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
    NSLog(@"Here blue!");
}

- (void)restart
{
    [_grid clearCreatures];
    NSLog(@"Restart!");
}


// this method will get called every half second when you hit the play button and will stop getting called when you hi the pause button
- (void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
}

@end
