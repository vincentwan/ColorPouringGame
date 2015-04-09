//
//  Grid.m
//  GameOfLife
//
//  Created by 万欣 on 15/1/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Grid.h"
#import "Creature.h"
#import "Target.h"
#import "MainScene.h"
#import "UIColor+Mixing.h"

// these are variables that cannot be changed
static const int GRID_ROWS = 8;
static const int GRID_COLUMNS = 10;


@implementation Grid {
    NSMutableArray *_colorCell;
    NSMutableArray *_colorTarget;
    float _cellWidth;
    float _cellHeight;
}

- (void)onEnter
{
    [super onEnter];
    //self.visible = false;
    _level = [[Level alloc] initWithFile:@"Level_0"];
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    self.opacity = 0;
    
    float x = 0;
    float y = 0;
    
    _generation = 0;
    _totalAlive = 0;
    Level * tlevel = self.level;
    // initialize the array as a blank NSMutableArray
    _colorCell = [NSMutableArray array];
    _colorTarget = [NSMutableArray array];
    
    // initialize Creatures
    for (int i = 0; i < GRID_ROWS; i++) {
        // this is how you create two dimensional arrays in Objective-C. You put arrays into arrays.
        _colorCell[i] = [NSMutableArray array];
        _colorTarget[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < GRID_COLUMNS; j++) {
            int serial = [tlevel serialAtX:i andY:j];
            // NSLog(@"Here's Target %d, %d: %d\n", i, j, serial);
            Target *targetcolor = [[Target alloc] initTargetwithX:_cellWidth andY:_cellHeight
                                                         andImage:serial];
            targetcolor.anchorPoint = ccp(0,0);
            targetcolor.position = ccp(x,y);
            targetcolor.opacity = 0.3;
            
            Creature *creature = [[Creature alloc] initCreaturewithX:(_cellWidth/1.2) andY:(_cellHeight/1.2)];
            creature.anchorPoint = ccp(0.5, 0.5);
            creature.position = ccp(x+(_cellWidth/2), y+(_cellHeight/2));
            
            [self addChild:targetcolor];
            [self addChild:creature];
            
            
            // this is shorthand to access an array inside an array
            _colorTarget[i][j] = targetcolor;
            _colorCell[i][j] = creature;
            
            x+=_cellWidth;
        }
        y += _cellHeight;
    }
}

- (int)mixWithNum:(int) num1 and:(int)num2
{
    int ansnum=0;
    if(abs(num1-num2)>6) {
        if((num1+num2)%2==1) {
            if(num2>num1) {
                ansnum = (num1+num2+11)/2;
            }
            else {
                ansnum = (num1+num2+13)/2;
            }
        }
        else {
            ansnum = (num1+num2+12)/2;
        }
    }
    else {
        ansnum = (num1+num2)/2;
    }
    return ansnum;
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    
    int row = touchLocation.y / _cellHeight;
    int column = touchLocation.x / _cellWidth;
    
    Creature *creature = _colorCell[row][column];
    /*
    UIColor * tempC = [UIColor colorWithRed:60.0f/255.0f
                                      green:75.0f/255.0f
                                       blue:85.0f/255.0f
                                      alpha:1.0f];
    */
    //invert it's state - kill it if it's alive, bring it to life if it's dead.
    if(!creature.isAlive) {
        //CGFloat c1, c2, c3, notUsed;
        creature.isAlive = true;
        [creature setSerialnum:MainScene.currNum];
        /*
        [MainScene.currColor getRed:&c1 green:&c2 blue:&c3 alpha:&notUsed];
        NSLog(@"red: %g\n",c1);
        NSLog(@"green: %g\n",c2);
        NSLog(@"blue: %g\n",c3);
         */
    }
    else {
        return;
    }
    if(row>0) {
        Creature * temp = _colorCell[row-1][column];
        if(temp.isAlive) {
            /*
            [temp setCcolor:[UIColor rgbMixForColors:[NSArray arrayWithObjects:
                            temp.ccolor,
                            creature.ccolor,
                            nil]]];
             */
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            [temp setSerialnum:ansnum];
        }
    }
    if(row<GRID_ROWS-1) {
        Creature * temp = _colorCell[row+1][column];
        if(temp.isAlive) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            [temp setSerialnum:ansnum];
        }
    }
    if(column>0) {
        Creature * temp = _colorCell[row][column-1];
        if(temp.isAlive) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            [temp setSerialnum:ansnum];
        }
    }
    if(column<GRID_COLUMNS-1) {
        Creature * temp = _colorCell[row][column+1];
        if(temp.isAlive) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            [temp setSerialnum:ansnum];
        }
    }
}

- (Creature *)creatureForTouchPosition:(CGPoint)touchPosition
{
    //get the row and column that was touched, return the Creature inside the corresponding cell
    int row = touchPosition.y / _cellHeight;
    int column = touchPosition.x / _cellWidth;
    return _colorCell[row][column];
}



- (BOOL)isIndexValidForX:(int)x andY:(int)y
{
    BOOL isIndexValid = YES;
    if(x < 0 || y < 0 || x >= GRID_ROWS || y >= GRID_COLUMNS)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

- (void)clearCreatures
{
    for (int i = 0; i < GRID_ROWS; i++) {
        for (int j = 0; j < GRID_COLUMNS; j++) {
            Creature *currentCreature = _colorCell[i][j];
            currentCreature.isAlive=false;
        }
    }
}

@end
