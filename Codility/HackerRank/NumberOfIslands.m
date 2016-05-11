//
//  NumberOfIslands.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "NumberOfIslands.h"

@implementation NumberOfIslands
//http://www.geeksforgeeks.org/find-number-of-islands/
+ (int)numberOfIslands:(NSArray<NSArray *> *)array {
    
    //validate imput
    NSMutableArray *visitedArray = [NSMutableArray new];
    for (int i = 0; i < array.count; i++) {
        NSMutableArray *inner = [NSMutableArray new];
        [visitedArray addObject:inner];
        
        for (int j = 0; j < array.count; j++) {
            [inner addObject:@(0)];
        }
    }
    
    int numberOfIslands = 0;
    
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < array.count; j++) {
            int wasVisited = [visitedArray[i][j] intValue];
            if (wasVisited > 0) {
                continue;
            }
            
            int isIsland = [array[i][j] intValue];
            if (isIsland > 0) {
                numberOfIslands++;
                [self bfsIsland:i y:j input:array visitedArray:visitedArray];
            }
            
            
        }
    }
    
    
    return numberOfIslands;
}

+ (void)bfsIsland:(int)x y:(int)y input:(NSArray<NSArray *> *)array visitedArray:(NSMutableArray<NSMutableArray *> *)visitedArray {
    NSMutableArray *queue = [NSMutableArray new];
    
    [queue addObject:@{@"x":@(x), @"y":@(y)}];
    visitedArray[x][y] = @(1);
    
    while (queue.count > 0) {
        NSDictionary *node = queue.lastObject;
        [queue removeObjectAtIndex:queue.count-1];

        int nodeX = [node[@"x"] intValue];
        int nodeY = [node[@"y"] intValue];
        
        NSArray *children = [self findChildren:nodeX y:nodeY input:array];
        
        for (NSDictionary *child in children) {
            int childX = [child[@"x"] intValue];
            int childY = [child[@"y"] intValue];
            int wasVisitedChild = [visitedArray[childX][childY] intValue];
            if (!wasVisitedChild) {
                [queue addObject:child];
                visitedArray[childX][childY] = @(1);
            }
            
        }
        
        
    }
    
}

+ (NSArray *)findChildren:(int)initX y:(int)initY input:(NSArray<NSArray *> *)array {
    NSMutableArray *result = [NSMutableArray new];
    int posX  = initX - 1;
    int posY  = initY - 1;
    for (int i = 0; i < 3; i ++) {
        if (posX >= 0 && posY >= 0 &&
            posX < array.count && posY < array[posX].count) {
            int isIsland = [array[posX][posY] intValue];
            if (isIsland > 0) {
                [result addObject:@{@"x":@(posX), @"y":@(posY)}];
            }
        }
        posY++;
    }

    posX  = initX + 1;
    posY  = initY - 1;
    for (int i = 0; i < 3; i ++) {
        if (posX >= 0 && posY >= 0 &&
            posX < array.count && posY < array[posX].count) {
            int isIsland = [array[posX][posY] intValue];
            if (isIsland > 0) {
                [result addObject:@{@"x":@(posX), @"y":@(posY)}];
            }
        }
        posY++;
    }

    posX  = initX;
    posY  = initY - 1;
    if (posX >= 0 && posY >= 0 &&
        posX < array.count && posY < array[posX].count) {
        int isIsland = [array[posX][posY] intValue];
        if (isIsland > 0) {
            [result addObject:@{@"x":@(posX), @"y":@(posY)}];
        }
    }

    
    posX  = initX;
    posY  = initY + 1;
    if (posX >= 0 && posY >= 0 &&
        posX < array.count && posY < array[posX].count) {
        int isIsland = [array[posX][posY] intValue];
        if (isIsland > 0) {
            [result addObject:@{@"x":@(posX), @"y":@(posY)}];
        }
    }

    return result;
}

@end
