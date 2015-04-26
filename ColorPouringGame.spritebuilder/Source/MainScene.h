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

@interface MainScene : CCNode

+ (int) currNum;
+ (void) setCurrNum:(int)val;
+ (int) levelNum;
+ (void) setLevelNum:(int)val;
+ (int) totalLevel;

@end
