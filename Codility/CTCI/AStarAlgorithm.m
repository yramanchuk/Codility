//
//  AStarAlgorithm.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/23/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "AStarAlgorithm.h"

@implementation AStarAlgorithm


+ (int)getShortestPath:(NSArray<NSArray <NSNumber *> *> *)input fromX:(int)m fromY:(int)n toX:(int)toX toY:(int)toY{
    __block NSMutableArray<NSMutableArray <NSNumber *> *> *array = [input mutableCopy];
    for (int i=0; i < array.count; i++) {
        array[i] = [array[i] mutableCopy];
    }
    
    __block NSMutableArray<NSArray <NSNumber *> *> *queue = [NSMutableArray new];
    [queue addObject:@[@(m), @(n)]];
    
    while (queue.count > 0) {
        int currX = [queue.firstObject[0] intValue];
        int currY = [queue.firstObject[1] intValue];
        __block int currValue = [array[currX][currY] intValue];
        
        [queue removeObjectAtIndex:0];
        
        if (currX == toX && currY == toY) {
            return [array[currX][currY] intValue];
        }
        
        
        __block int nextX;
        __block int nextY;
        dispatch_block_t move = ^{
            if ([self canMove:array toX:nextX toY:nextY]) {
                array[nextX][nextY] = @(currValue + 1);
                [queue addObject:@[@(nextX), @(nextY)]];
            }

        };
        
        //right
        nextX = currX+1;
        nextY = currY;
        move();
        
        //down
        nextX = currX;
        nextY = currY+1;
        move();
        
        //left
        nextX = currX-1;
        nextY = currY;
        move();

        //up
        nextX = currX;
        nextY = currY-1;
        move();

    }
    
    
    return -1;
    
    
    
}



+ (BOOL)canMove:(NSArray<NSArray <NSNumber *> *> *)input toX:(int)toX toY:(int)toY {
    
    if (toX >= input.count) {
        return NO;
    }
    
    if (toY >= input[toX].count) {
        return NO;
    }
    
    if ([input[toX][toY] intValue] != 0) {
        return NO;
    }
    
    return YES;
}

@end
