//
//  MainScene.m
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "MainScene.h"
#import "Grid.h"

@implementation MainScene {
    Grid *_grid;
    CCTimer *_timer;
    CCLabelTTF *_generationLabel;
    CCLabelTTF *_populationLabel;
}

static UIColor * currColor;
+ (UIColor *) currColor
{ @synchronized(self) { return currColor; } }
+ (void) setCurrColor:(UIColor *)val
{ @synchronized(self) { currColor = val; } }

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
    
    currColor = [UIColor colorWithRed:255.0f/255.0f
                    green:0.0f/255.0f
                    blue:0.0f/255.0f
                    alpha:1.0f];
    
    NSLog(@"Here red!");
}

- (void)selectyellow
{
    
    currColor = [UIColor colorWithRed:255.0f/255.0f
                    green:255.0f/255.0f
                    blue:0.0f/255.0f
                    alpha:1.0f];
    
    NSLog(@"Here yellow!");
}

- (void)selectblue
{
    
    currColor = [UIColor colorWithRed:0.0f/255.0f
                    green:0.0f/255.0f
                    blue:255.0f/255.0f
                    alpha:1.0f];
     
    NSLog(@"Here blue!");
}


// this method will get called every half second when you hit the play button and will stop getting called when you hi the pause button
- (void)step
{
    [_grid evolveStep];
    _generationLabel.string = [NSString stringWithFormat:@"%d", _grid.generation];
    _populationLabel.string = [NSString stringWithFormat:@"%d", _grid.totalAlive];
}

@end
