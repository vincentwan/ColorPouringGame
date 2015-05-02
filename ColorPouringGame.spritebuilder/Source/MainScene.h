//
//  MainScene.h
//  PROJECTNAME
//
//  Created by Viktor on 10/10/13.
//  Copyright (c) 2013 Apportable. All rights reserved.
//

#import "CCNode.h"
#import "Level.h"
#import "ColorPanel.h"
#import "ColorHelper.h"
#import "AppDelegate.h"
#import "ColorButton.h"


@interface MainScene : CCNode

@property (nonatomic, retain) ColorButton * redBtn;
@property (nonatomic, retain) ColorButton * blueBtn;
@property (nonatomic, retain) ColorButton * yellowBtn;


+ (BOOL) tutorialLevel;
+ (void) setTutorialLevel:(BOOL)val;
+ (int) currNum;
+ (void) setCurrNum:(int)val;
+ (int) levelNum;
+ (void) setLevelNum:(int)val;
+ (int) totalLevel;
+ (int) stepTutorial;
+ (void) setStepTutorial:(int)val;
+ (CCParticleSystem *) particle;
+ (void) setParticle:(CCParticleSystem *)val;
+ (void) setParticlePos:(CGPoint)val;

@end
