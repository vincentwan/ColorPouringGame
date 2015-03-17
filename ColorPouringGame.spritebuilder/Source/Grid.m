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
    
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / GRID_COLUMNS;
    _cellHeight = self.contentSize.height / GRID_ROWS;
    
    float x = 0;
    float y = 0;
    
    _generation = 0;
    _totalAlive = 0;
    
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
            Creature *creature = [[Creature alloc] initCreature];
            creature.anchorPoint = ccp(0, 0);
            creature.position = ccp(x, y);
            
            Target *targetcolor = [[Target alloc] initTargetwithX:_cellWidth andY:_cellHeight];
            targetcolor.anchorPoint = ccp(0,0);
            targetcolor.position = ccp(x,y);
            
            [self addChild:creature];
            [self addChild:targetcolor];
            
            // this is shorthand to access an array inside an array
            _colorCell[i][j] = creature;
            _colorTarget[i][j] = targetcolor;
            
            x+=_cellWidth;
        }
        
        y += _cellHeight;
    }
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
        CGFloat c1, c2, c3, notUsed;
        creature.isAlive = true;
        [creature setCcolor:MainScene.currColor];
        [MainScene.currColor getRed:&c1 green:&c2 blue:&c3 alpha:&notUsed];
        /*
        NSLog(@"red: %g\n",c1);
        NSLog(@"green: %g\n",c2);
        NSLog(@"blue: %g\n",c3);
         */
    }
    if(row>0) {
        Creature * temp = _colorCell[row-1][column];
        if(temp.isAlive) {
            [temp setCcolor:[UIColor rgbMixForColors:[NSArray arrayWithObjects:
                            temp.ccolor,
                            creature.ccolor,
                            nil]]];
        }
    }
    if(row<GRID_ROWS-1) {
        Creature * temp = _colorCell[row+1][column];
        if(temp.isAlive) {
            UIColor * ctemp = [UIColor rgbMixForColors:[NSArray arrayWithObjects:
                                temp.ccolor,
                                creature.ccolor,
                                nil]];
            [temp setCcolor: ctemp];
        }
    }
    if(column>0) {
        Creature * temp = _colorCell[row][column-1];
        if(temp.isAlive) {
            [temp setCcolor:[UIColor rgbMixForColors:[NSArray arrayWithObjects:
                            temp.ccolor,
                            creature.ccolor,
                            nil]]];
        }
    }
    if(column<GRID_COLUMNS-1) {
        Creature * temp = _colorCell[row][column+1];
        if(temp.isAlive) {
            [temp setCcolor:[UIColor rgbMixForColors:[NSArray arrayWithObjects:
                            temp.ccolor,
                            creature.ccolor,
                            nil]]];
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

- (void)evolveStep
{
    //update each Creature's neighbor count
    [self countNeighbors];
    
    //update each Creature's state
    [self updateCreatures];
    
    //update the generation so the label's text will display the correct generation
    _generation++;
}


- (void)countNeighbors
{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    for (int i = 0; i < [_colorCell count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_colorCell[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _colorCell[i][j];
            
            // remember that every creature has a 'livingNeighbors' property that we created earlier
            currentCreature.livingNeighbors = 0;
            
            // now examine every cell around the current one
            
            // go through the row on top of the current cell, the row the cell is in, and the row past the current cell
            for (int x = (i-1); x <= (i+1); x++)
            {
                // go through the column to the left of the current cell, the column the cell is in, and the column to the right of the current cell
                for (int y = (j-1); y <= (j+1); y++)
                {
                    // check that the cell we're checking isn't off the screen
                    BOOL isIndexValid;
                    isIndexValid = [self isIndexValidForX:x andY:y];
                    
                    // skip over all cells that are off screen AND the cell that contains the creature we are currently updating
                    if (!((x == i) && (y == j)) && isIndexValid)
                    {
                        Creature *neighbor = _colorCell[x][y];
                        if (neighbor.isAlive)
                        {
                            currentCreature.livingNeighbors += 1;
                        }
                    }
                }
            }
        }
    }
}

- (void)updateCreatures
{
    // iterate through the rows
    // note that NSArray has a method 'count' that will return the number of elements in the array
    int numAlive = 0;
    for (int i = 0; i < [_colorCell count]; i++)
    {
        // iterate through all the columns for a given row
        for (int j = 0; j < [_colorCell[i] count]; j++)
        {
            // access the creature in the cell that corresponds to the current row/column
            Creature *currentCreature = _colorCell[i][j];
            long liveNeighbors = currentCreature.livingNeighbors;
            if (liveNeighbors == 3)
            {
                currentCreature.isAlive=true;
            }
            else if (liveNeighbors <= 1 || liveNeighbors >=4)
            {
                currentCreature.isAlive=false;
            }
            if(currentCreature.isAlive==true)
            {
                numAlive++;
            }
        }
    }
    _totalAlive = numAlive;
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
