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
    CCButton * _restartBtn;
    CCNode * _background;
}

static BOOL tutorialLevel = NO;
+ (BOOL) tutorialLevel
{ @synchronized(self) { return tutorialLevel; } }
+ (void) setTutorialLevel:(BOOL)val
{ @synchronized(self) { tutorialLevel = val; } }

static int currNum;
+ (int) currNum
{ @synchronized(self) { return currNum; } }
+ (void) setCurrNum:(int)val
{ @synchronized(self) { currNum = val; } }

static int stepTutorial=0;
+ (int) stepTutorial
{ @synchronized(self) { return stepTutorial; } }
+ (void) setStepTutorial:(int)val
{ @synchronized(self) { stepTutorial = val; } }

static int totalTutorial = 0;

static int levelNum = 0;
+ (int) levelNum
{ @synchronized(self) { return levelNum; } }
+ (void) setLevelNum:(int)val
{ @synchronized(self) {
    levelNum = val;
    if(levelNum < totalTutorial) {
        tutorialLevel = YES;
    }
    else {
        tutorialLevel = NO;
    }
} }

// Read only static variable
static int totalLevel = 12;
+ (int) totalLevel
{ @synchronized(self) { return totalLevel; } }


- (id)init
{
    self = [super init];
    
    if (self) {
        _timer = [[CCTimer alloc] init];
    }
    
    NSLog(@"This is MainScene!");
    
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
    if(tutorialLevel) {
        stepTutorial = 0;
        [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onNotify:)
                                                 name:@"TestNotification"
                                               object:nil];
    }
    return self;
}

- (void) onNotify:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.
    
    if ([[notification name] isEqualToString:@"TestNotification"]) {
        NSLog (@"Successfully received the test notification!");
        NSLog(@"Here is notification at step: %d\n", stepTutorial);
        switch (stepTutorial) {
            case 0:
                [self disableAll:0];
                [_grid disableAll:-1];
                break;
            case 1:
                [self disableAll:-1];
                [_grid disableAll:2];
                break;
            case 2:
                [self disableAll:1];
                [_grid disableAll:-1];
                break;
            case 3:
                [self disableAll:-1];
                [_grid disableAll:3];
                break;
            case 4:
                [self disableAll:0];
                [_grid disableAll:-1];
                break;
            case 5:
                [self disableAll:-1];
                [_grid disableAll:0];
                break;
            case 6:
                [self disableAll:2];
                [_grid disableAll:-1];
                break;
            case 7:
                [self disableAll:-1];
                [_grid disableAll:1];
                break;
            default:
                break;
        }
        stepTutorial++;
    }
}

- (void)onEnter
{
    [super onEnter];
    double height_total = self.contentSizeInPoints.height;
    double width_total = self.contentSizeInPoints.width;
    
    NSLog(@"self.contentSize.width: %f", width_total);
    NSLog(@"self.contentSize.height: %f", height_total);
    
    double centralX = width_total*0.086;//width_total*0.915;//520;
    double centralY = height_total*0.541;//height_total*0.6;//192;
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
    
    double buttonX = width_total*0.893;//width_total*0.724;
    double buttonY1 = height_total*0.76;
    double buttonY2 = height_total*0.625;
    double buttonY3 = height_total*0.49;
    
    _redBtn = [[ColorButton alloc] initBtnwithX:buttonX andY:buttonY1 andNum:0];
    _redBtn.zOrder = 1;
    [_redBtn setTarget:self selector:@selector(selectred)];
    [self addChild:_redBtn];
    _blueBtn = [[ColorButton alloc] initBtnwithX:buttonX andY:buttonY2 andNum:4];
    _blueBtn.zOrder = 1;
    [_blueBtn setTarget:self selector:@selector(selectblue)];
    [self addChild:_blueBtn];
    _yellowBtn = [[ColorButton alloc] initBtnwithX:buttonX andY:buttonY3 andNum:8];
    _yellowBtn.zOrder = 1;
    [_yellowBtn setTarget:self selector:@selector(selectyellow)];
    [self addChild:_yellowBtn];
    
    NSString *resetString = @"ColorPouringAssets/Buttons/reset_button.png";
    
    _restartBtn = [CCButton buttonWithTitle:@"" spriteFrame:[CCSpriteFrame frameWithImageNamed:resetString] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:resetString] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:resetString]];

    _restartBtn.zOrder = 1;
    _restartBtn.position = ccp(buttonX, height_total*0.358);
    _restartBtn.anchorPoint = ccp(0.5,0.5);
    [_restartBtn setTarget:self selector:@selector(restart)];
    [self addChild:_restartBtn];
    
    
    _background.scaleX = width_total/(_background.contentSizeInPoints.width);
    _background.scaleY = height_total/(_background.contentSizeInPoints.height);
    
    if(_grid == NULL) {
        NSLog(@"grid is null!");
    }
    
    _grid.scaleX = (width_total*0.54)/_grid.contentSizeInPoints.width;
    _grid.scaleY = (height_total*0.78)/_grid.contentSizeInPoints.height;
    
    _stepCount.string = [NSString stringWithFormat:@"%d", 0];
    _grid.stepCount = _stepCount;
    _stepScore.string = [NSString stringWithFormat:@"%d", 0];
    _grid.stepScore = _stepScore;
    _restartBtn.enabled = YES;
    _grid.restartBtn = _restartBtn;

    if(tutorialLevel) {
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TestNotification"
         object:self];
        NSLog(@"This is MainScene tutorial onEnter");
    }
    else {
        [self selectred];
        NSLog(@"This is MainScene onEnter");
    }

}

- (void)disableAll:(int) pos
{
    switch (pos) {
        case -1:
            _redBtn.enabled = false;
            _blueBtn.enabled = false;
            _yellowBtn.enabled = false;
            _restartBtn.enabled = false;
            break;
        case 0:
            _redBtn.enabled = true;
            _blueBtn.enabled = false;
            _yellowBtn.enabled = false;
            _restartBtn.enabled = false;
            break;
        case 1:
            _blueBtn.enabled = true;
            _redBtn.enabled = false;
            _yellowBtn.enabled = false;
            _restartBtn.enabled = false;
            break;
        case 2:
            _yellowBtn.enabled = true;
            _blueBtn.enabled = false;
            _redBtn.enabled = false;
            _restartBtn.enabled = false;
            break;
        default:
            break;
    }
}

- (void) dealloc
{
    // If you don't remove yourself as an observer, the Notification Center
    // will continue to try and send notification objects to the deallocated
    // object.
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TestNotification"
     object:self];
    
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
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TestNotification"
     object:self];
    
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
    
    [[NSNotificationCenter defaultCenter]
     postNotificationName:@"TestNotification"
     object:self];
    
    NSLog(@"Here yellow!");
}

- (void)restart
{
    CCScene *mainScene = [CCBReader loadAsScene:@"MainScene"];
    [[CCDirector sharedDirector]replaceScene:mainScene];
    NSLog(@"Restart!");
}


-(void) shareToFacebook {
    FBSDKShareLinkContent *content = [[FBSDKShareLinkContent alloc] init];
    
    // this should link to FB page for your app or AppStore link if published
    content.contentURL = [NSURL URLWithString:@"https://www.facebook.com/makeschool"];
    // URL of image to be displayed alongside post
    content.imageURL = [NSURL URLWithString:@"https://git.makeschool.com/MakeSchool-Tutorials/News/f744d331484d043a373ee2a33d63626c352255d4//663032db-cf16-441b-9103-c518947c70e1/cover_photo.jpeg"];
    // title of post
    content.contentTitle = [NSString stringWithFormat:@"Try Playing Color Pouring Game!"];
    // description/body of post
    content.contentDescription = @"Check out this Color Pouring Game!";
    
    [FBSDKShareDialog showFromViewController:[CCDirector sharedDirector]
                                 withContent:content
                                    delegate:nil];
}

@end
