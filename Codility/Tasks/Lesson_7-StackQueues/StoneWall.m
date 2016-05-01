//
//  StoneWall.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "StoneWall.h"

@implementation StoneWall

+ (int)solution:(NSMutableArray *)H {

    
    int currentHeight = [H[0] intValue];
    NSMutableArray *blocks = [NSMutableArray arrayWithObject:@(currentHeight)];
    int blockCount = 1;
    
    
    for (int i = 1; i < H.count; i++) {
        int height = [H[i] intValue];
        
        if (height == currentHeight) {
            //do nothing
        } else if (height < currentHeight) {
            while (blocks.count > 0 && height < [blocks.lastObject intValue]) {
                [blocks removeLastObject];
            }
            if (blocks.count == 0 || [blocks.lastObject intValue] != height) {
                [blocks addObject:@(height)];
                blockCount++;
            }
        } else {
            [blocks addObject:@(height)];
            blockCount++;
        }
        currentHeight = height;
    }
    
    
   
    return blockCount;
}

@end
