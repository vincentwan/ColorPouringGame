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

static CCParticleSystem *particle;
+ (CCParticleSystem *) particle
{ @synchronized(self) { return particle; } }
+ (void) setParticle:(CCParticleSystem *)val
{ @synchronized(self) { particle = val; } }

+ (void) setParticlePos:(CGPoint)val
{ @synchronized(self) { particle.position = val; } }
+ (void) setParticleVisible:(BOOL)val
{ @synchronized(self) { particle.visible = val; } }


static BOOL tutorialLevel = YES;
+ (BOOL) tutorialLevel
{ @synchronized(self) { return tutorialLevel; } }
+ (void) setTutorialLevel:(BOOL)val
{ @synchronized(self) { tutorialLevel = val; } }

static int currNum;
+ (int) currNum
{ @synchronized(self) { return currNum; } }
+ (void) setCurrNum:(int)val
{ @synchronized(self) { currNum = val; } }

static int stepTutorial=2;
+ (int) stepTutorial
{ @synchronized(self) { return stepTutorial; } }
+ (void) setStepTutorial:(int)val
{ @synchronized(self) { stepTutorial = val; } }

static int totalTutorial = 2;

static int levelNum = 0;
+ (int) levelNum
{ @synchronized(self) { return levelNum; } }
+ (void) setLevelNum:(int)val
{ @synchronized(self) {
    levelNum = val;
    NSLog(@"Here is set level %d\n", val);
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

- (void)onEnter
{
    [super onEnter];
    
    _grid.posX = _grid.positionInPoints.x;
    _grid.posY = _grid.positionInPoints.y - (_grid.boundingBox.size.height/2);
    _grid.scaleX = _grid.scaleX;
    
    
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

- (void) addParticle {
    particle = (CCParticleSystem *)[CCBReader load:@"Shining"];
    particle.autoRemoveOnFinish = NO;
    particle.position = ccp(-20,-20);
    particle.zOrder = 2;
    [self addChild:particle];
}

- (void) onNotify:(NSNotification *) notification
{
    // [notification name] should always be @"TestNotification"
    // unless you use this method for observation of other notifications
    // as well.

    if ([[notification name] isEqualToString:@"TestNotification"]) {
        NSLog (@"Successfully received the test notification!");
        NSLog(@"Here is notification at step: %d\n", stepTutorial);
        if(levelNum == 0) {
            switch (stepTutorial) {
                case 0:
                    [self displayMessage];
                    [self addParticle];
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
        else {
            switch (stepTutorial) {
                case 0:
                    [self addParticle];
                    [self disableAll:2];
                    [_grid disableAll:-1];
                    break;
                case 1:
                    [self disableAll:-1];
                    [_grid disableAll:3];
                    break;
                case 2:
                    [self disableAll:0];
                    [_grid disableAll:-1];
                    break;
                case 3:
                    [self disableAll:-1];
                    [_grid disableAll:0];
                    break;
                case 4:
                    [self disableAll:-1];
                    [_grid disableAll:4];
                    break;
                case 5:
                    [self disableAll:1];
                    [_grid disableAll:-1];
                    break;
                case 6:
                    [self disableAll:-1];
                    [_grid disableAll:2];
                    break;
                case 7:
                    [self disableAll:2];
                    [_grid disableAll:-1];
                    break;
                case 8:
                    [self disableAll:-1];
                    [_grid disableAll:1];
                    break;
                case 9:
                    [self disableAll:1];
                    [_grid disableAll:-1];
                    break;
                case 10:
                    [self disableAll:-1];
                    [_grid disableAll:5];
                    break;
                default:
                    break;
            }
            stepTutorial++;
        }
    }
}

- (void)displayMessage
{
    double height_total = self.contentSizeInPoints.height;
    double width_total = self.contentSizeInPoints.width;
    UIView *myview=[[UIView alloc] initWithFrame: CGRectMake(height_total*0.1, width_total*0.8,80,40)];
    UIView *parentView = [[CCDirector sharedDirector] view];
    myview.backgroundColor = [UIColor colorWithWhite:0.5 alpha:1.0];
    [parentView addSubview:myview];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:myview animated:YES];
    
    // Configure for text only and offset down
    hud.mode = MBProgressHUDModeText;
    hud.labelText = @"Some message...";
    //hud.margin = 10.f;
    //hud.yOffset = 150.f;
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:3];
}

- (void)disableAll:(int) pos
{
    _redBtn.enabled = false;
    _blueBtn.enabled = false;
    _yellowBtn.enabled = false;
    _restartBtn.enabled = false;
    switch (pos) {
        case -1:
            break;
        case 0:
            _redBtn.enabled = true;
            particle.position = _redBtn.position;
            _redBtn.highlighted = true;
            break;
        case 1:
            _blueBtn.enabled = true;
            particle.position = _blueBtn.position;
            _blueBtn.highlighted = true;
            break;
        case 2:
            _yellowBtn.enabled = true;
            particle.position = _yellowBtn.position;
            _yellowBtn.highlighted = true;
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
    if(tutorialLevel) {
        _redBtn.highlighted = NO;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TestNotification"
         object:self];
    }
    
    
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
    
    if(tutorialLevel) {
        _blueBtn.highlighted = NO;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TestNotification"
         object:self];
    }
    
    
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
    
    if(tutorialLevel) {
        _yellowBtn.highlighted = NO;
        [[NSNotificationCenter defaultCenter]
         postNotificationName:@"TestNotification"
         object:self];
    }
    
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
