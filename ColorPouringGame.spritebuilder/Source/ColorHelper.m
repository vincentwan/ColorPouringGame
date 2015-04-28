//
//  ColorHelper.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/4/5.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "ColorHelper.h"

@implementation ColorHelper

+ (UIColor *)setColorWithFile:(int)serialnum {
    UIColor * tempc;
    if(serialnum==0) {
        //tempc=[UIColor colorWithRed:0xFF/255.0f green:0x51/255.0f blue:0x57/255.0f alpha:1.0f];
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x0/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==1) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x79/255.0f blue:0xB7/255.0f alpha:1.0f];
    }
    else if(serialnum==2) {
        tempc=[UIColor colorWithRed:0xC9/255.0f green:0x22/255.0f blue:0xDC/255.0f alpha:1.0f];
    }
    else if(serialnum==3) {
        tempc=[UIColor colorWithRed:0x8A/255.0f green:0x31/255.0f blue:0xDC/255.0f alpha:1.0f];
    }
    else if(serialnum==4) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==5) {
        tempc=[UIColor colorWithRed:0x47/255.0f green:0xF5/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==6) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==7) {
        tempc=[UIColor colorWithRed:0xD7/255.0f green:0xFF/255.0f blue:0x4F/255.0f alpha:1.0f];
    }
    else if(serialnum==8) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==9) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xC5/255.0f blue:0x6D/255.0f alpha:1.0f];
    }
    else if(serialnum==10) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x80/255.0f blue:0x6F/255.0f alpha:1.0f];
    }
    else {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x6F/255.0f blue:0x04/255.0f alpha:1.0f];
    }
    /* Color Past
    if(serialnum==0) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x0/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==1) {
        tempc=[UIColor colorWithRed:0xBF/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==2) {
        tempc=[UIColor colorWithRed:0x99/255.0f green:0x0/255.0f blue:0xCC/255.0f alpha:1.0f];
    }
    else if(serialnum==3) {
        tempc=[UIColor colorWithRed:0x5E/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==4) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0x0/255.0f blue:0xFF/255.0f alpha:1.0f];
    }
    else if(serialnum==5) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0xFF/255.0f blue:0x40/255.0f alpha:1.0f];
    }
    else if(serialnum==6) {
        tempc=[UIColor colorWithRed:0x0/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==7) {
        tempc=[UIColor colorWithRed:0x80/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==8) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xFF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==9) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0xBF/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else if(serialnum==10) {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x80/255.0f blue:0x0/255.0f alpha:1.0f];
    }
    else {
        tempc=[UIColor colorWithRed:0xFF/255.0f green:0x33/255.0f blue:0x0/255.0f alpha:1.0f];
    }
     */
    UIColor * color = [tempc copy];
    
    CGFloat red = 0.0, green = 0.0, blue = 0.0, alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    
    NSLog(@"Helper color red %f green %f blue %f\n", red, green, blue);
    
    return color;
}

@end
