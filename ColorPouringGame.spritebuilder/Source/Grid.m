//
//  Grid.m
//  GameOfLife
//
//  Created by 万欣 on 15/1/28.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Grid.h"

// these are variables that cannot be changed

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
    //_level = [[Level alloc] initWithFile:@"Level_0"];
    int levelN = MainScene.levelNum;
    _level = [[Level alloc] initWithFile:[NSString stringWithFormat:@"Level_%d", levelN]];
    _numRow = [_level getNumRow];
    _numCol = [_level getNumCol];
    [self setupGrid];
    
    // accept touches on the grid
    self.userInteractionEnabled = YES;
}

- (void)setupGrid
{
    // divide the grid's size by the number of columns/rows to figure out the right width and height of each cell
    _cellWidth = self.contentSize.width / _numCol;
    _cellHeight = self.contentSize.height / _numRow;
    self.opacity = 0;
    
    float x = 0;
    float y = 0;
    
    _steps = 0;
    _accurate = 0;
    Level * tlevel = self.level;
    // initialize the array as a blank NSMutableArray
    _colorCell = [NSMutableArray array];
    _colorTarget = [NSMutableArray array];
    
    // initialize Creatures
    for (int i = 0; i < _numRow; i++) {
        // this is how you create two dimensional arrays in Objective-C. You put arrays into arrays.
        _colorCell[i] = [NSMutableArray array];
        _colorTarget[i] = [NSMutableArray array];
        x = 0;
        
        for (int j = 0; j < _numCol; j++) {
            int serial = [tlevel serialAtX:i andY:j];
            // NSLog(@"Here's Target %d, %d: %d\n", i, j, serial);
            Target *targetcolor = [[Target alloc] initTargetwithX:_cellWidth andY:_cellHeight
                                                         andImage:serial];
            targetcolor.anchorPoint = ccp(0,0);
            targetcolor.position = ccp(x,y);
            // targetcolor.opacity = 0.3;
            
            Creature *creature = [[Creature alloc] initCreaturewithX:(_cellWidth/1.17) andY:(_cellHeight/1.2)];
            creature.anchorPoint = ccp(0.5, 0.5);
            creature.position = ccp(x+(_cellWidth/2), y+(_cellHeight/2));
            
            [self addChild:targetcolor];
            [self addChild:creature];
            
            // this is shorthand to access an array inside an array
            _colorTarget[i][j] = targetcolor;
            _colorCell[i][j] = creature;
            NSLog(@"creature created!");
            if(creature==nil) {
                NSLog(@"First nil!");
            }
            
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
    else if (abs(num1-num2) == 6) {
        ansnum = -1;
    }
    else {
        ansnum = (num1+num2)/2;
    }
    return ansnum;
}

- (void) win {
    EndGame *EndGamePopover = (EndGame *)[CCBReader load:@"EndGame"];
    EndGamePopover.positionType = CCPositionTypeNormalized;
    EndGamePopover.position = ccp(0.5, 0.5);
    EndGamePopover.zOrder = INT_MAX;
    
    int score = (_accurate*100)/(_numCol*_numRow);
    
    [EndGamePopover setMessage:score];
    
    _restartBtn.enabled = NO;
    
    printf("Here's the resultR\n");
    
    for (int i = 0; i < _numRow; i++) {
        for (int j = 0; j < _numCol; j++) {
            Creature * tempcreat = _colorCell[i][j];
            printf("%d,", tempcreat.serialnum);
        }
        printf("\n");
    }
    
    [self addChild:EndGamePopover];
}

- (void)touchBegan:(CCTouch *)touch withEvent:(CCTouchEvent *)event
{
    //get the x,y coordinates of the touch
    CGPoint touchLocation = [touch locationInNode:self];
    
    //get the Creature at that location
    
    int row = touchLocation.y / _cellHeight;
    int column = touchLocation.x / _cellWidth;
    
    Creature *creature = _colorCell[row][column];
    if(creature==nil) {
        NSLog(@"Second nil!");
    }
    if(!creature.isAlive) {
        creature.isAlive = true;
        int tempnum = MainScene.currNum;
        //NSLog(@"Here is creating creature: %d\n",tempnum);

        creature.serialnum = tempnum;
        _steps++;
        
        //NSLog(@"Here is updating steps: %d\n",_steps);
        
        _stepCount.string = [NSString stringWithFormat:@"%d", _steps];
        Target *tempTar = (_colorTarget[row][column]);
        if(tempnum == tempTar.serialnum) {
            _accurate++;
            creature.isMutable = NO;
        }
    }
    else {
        return;
    }

    if(row>0) {
        [self colorAffect:row-1 col:column num:creature.serialnum];
        /*
        Creature * temp = _colorCell[row-1][column];
        if(temp.isAlive && temp.isMutable) {

            
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            NSLog(@"ansnum = %d\n", ansnum);
            [temp setSerialnum:ansnum];
        }
         */
    }
    if(row<_numRow-1) {
        [self colorAffect:row+1 col:column num:creature.serialnum];
        /*
        Creature * temp = _colorCell[row+1][column];
        if(temp.isAlive && temp.isMutable) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            NSLog(@"ansnum = %d\n", ansnum);
            [temp setSerialnum:ansnum];
        }
         */
    }
    if(column>0) {
        [self colorAffect:row col:column-1 num:creature.serialnum];
        /*
        Creature * temp = _colorCell[row][column-1];
        if(temp.isAlive && temp.isMutable) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            NSLog(@"ansnum = %d\n", ansnum);
            [temp setSerialnum:ansnum];
        }
         */
    }
    if(column<_numCol-1) {
        [self colorAffect:row col:column+1 num:creature.serialnum];
        /*
        Creature * temp = _colorCell[row][column+1];
        if(temp.isAlive && temp.isMutable) {
            int num1 = temp.serialnum;
            int num2 = creature.serialnum;
            int ansnum = [self mixWithNum:num1 and:num2];
            NSLog(@"ansnum = %d\n", ansnum);
            [temp setSerialnum:ansnum];
        }
         */
    }
    NSLog(@"Accurate: %d\n", _accurate);
    _stepScore.string = [NSString stringWithFormat:@"%d", _accurate];
    if(_steps == _numCol * _numRow) {
        [self win];
    }
}

- (void)colorAffect:(int)rowNum col:(int)colNum num:(int)serialNum
{
    Creature * temp = _colorCell[rowNum][colNum];
    if(temp.isAlive && temp.isMutable) {
        int num1 = temp.serialnum;
        int ansnum = [self mixWithNum:num1 and:serialNum];
        NSLog(@"ansnum = %d\n", ansnum);
        [temp setSerialnum:ansnum];
        Target *tempTar = (_colorTarget[rowNum][colNum]);
        if(ansnum == tempTar.serialnum) {
            _accurate++;
            temp.isMutable = NO;
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
    if(x < 0 || y < 0 || x >= _numRow || y >= _numCol)
    {
        isIndexValid = NO;
    }
    return isIndexValid;
}

- (void)clearCreatures
{
    for (int i = 0; i < _numRow; i++) {
        for (int j = 0; j < _numCol; j++) {
            Creature *currentCreature = _colorCell[i][j];
            currentCreature.isAlive = NO;
            currentCreature.isMutable = YES;
        }
    }
    _steps = 0;
    _accurate = 0;
    _stepCount.string = [NSString stringWithFormat:@"%d", _steps];
    _stepScore.string = [NSString stringWithFormat:@"%d", _accurate];
}

@end
