//
//  Level.m
//  ColorPouringGame
//
//  Created by 万欣 on 15/3/17.
//  Copyright (c) 2015年 Apportable. All rights reserved.
//

#import "Level.h"


@implementation Level {

    int *_targetGrid;
    
}

- (NSDictionary *)loadJSON:(NSString *)filename {
    NSString *path = [[NSBundle mainBundle] pathForResource:filename ofType:@"json"];
    if (path == nil) {
        NSLog(@"Could not find level file: %@", filename);
        return nil;
    }
    
    NSError *error;
    NSData *data = [NSData dataWithContentsOfFile:path options:0 error:&error];
    if (data == nil) {
        NSLog(@"Could not load level file: %@, error: %@", filename, error);
        return nil;
    }
    
    NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (dictionary == nil || ![dictionary isKindOfClass:[NSDictionary class]]) {
        NSLog(@"Level file '%@' is not valid JSON: %@", filename, error);
        return nil;
    }
    
    return dictionary;
}

- (instancetype)initWithFile:(NSString *)filename {
    self = [super init];
    if (self != nil) {
        NSDictionary *dictionary = [self loadJSON:filename];
        
        [dictionary[@"dimension"] enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger row, BOOL *stop) {
            
            // Loop through the columns in the current row
            if(row == 0) {
                _numRow = [value intValue];
                NSLog(@"Here Level numRow = %d", _numRow);
            }
            else if(row == 1) {
                _numCol = [value intValue];
                NSLog(@"Here Level numCol = %d", _numCol);
            }
        }];
        
        _targetGrid = malloc(sizeof(int) * _numRow * _numCol);
        
        // Loop through the rows
        [dictionary[@"grids"] enumerateObjectsUsingBlock:^(NSArray *array, NSUInteger row, BOOL *stop) {
            
            // Loop through the columns in the current row
            [array enumerateObjectsUsingBlock:^(NSNumber *value, NSUInteger column, BOOL *stop) {
                
                // Note: In Sprite Kit (0,0) is at the bottom of the screen,
                // so we need to read this file upside down.
                // NSLog(@"Oh, value:%d\n",[value intValue]);
                NSLog(@"Here initialization: row = %d, col = %d, value = %d", (unsigned)row, (unsigned)column, [value intValue]);
                _targetGrid[(row*_numCol)+column] = [value intValue];
            }];
        }];
    }
    return self;
}


- (int) serialAtX:(int) x andY:(int)y {
    
    return _targetGrid[(x*_numCol)+y];
}

- (int) getNumRow {
    
    return _numRow;
}

- (int) getNumCol {
    
    return _numCol;
}

@end
