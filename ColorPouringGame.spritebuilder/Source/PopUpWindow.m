//
//  PopUpWindow.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "PopUpWindow.h"

@implementation PopUpWindow {
    
}

- (void)showInView:(UIView *)aView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [aView addSubview:self.view];
    });
}


@end
