//
//  LexicographicallyLargestString.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "LexicographicallyLargestString.h"

// GIven a string "str" and pair of "N" swapping indices, generate a lexicographically largest string. Swapping indices can be reused any number times.
// Eg 1)
// String = "abdc"
// Indices:
// (1,4)
// (3,4)
// Answer:
// cdba, cbad, dbac,dbca
// ​you should print only "dbca" which is lexicographically largest.
#import <Foundation/Foundation.h>
#import <stdio.h>




@implementation LexicographicallyLargestString
- (NSString *)lexicographicallyLargestString:(NSString *)string with:(NSArray *)swaps {
    NSMutableArray *allSwaps = [NSMutableArray new];
    for (int i = 0; i < string.length; i++) {
        [allSwaps addObject:[NSMutableArray new]];
    }
    
    
    
    for (int index = 0; index < swaps.count; index++) {
        //NSString *character = [string substringWithRange:NSRangeMake(index, 1)];
        
        int fromIndex = [swaps[index][0] intValue];
        int toIndex = [swaps[index][1] intValue];
        
        [self addPair:allSwaps toIndex:toIndex newPair:fromIndex];
        [self addPair:allSwaps toIndex:fromIndex newPair:toIndex];
        
    }
    
    for (int index = 0; index < string.length; index++) {
        [allSwaps[index] addObject:@(index)];
    }
    
    NSMutableString *result = [NSMutableString new];
    for (int i = 0; i < string.length; i++) {
        NSMutableArray *indexes = allSwaps[i];
        [self sortIndexes:indexes fromString:string];
        
        int biggestIndex = [indexes[0] intValue];
        [result appendFormat:@"%c", [string characterAtIndex:biggestIndex]];
        
    }
    
    return result;
    
    
}

- (void)addPair:(NSMutableArray *)allSwaps toIndex:(int)toIndex newPair:(int)pairIndex {
    NSArray *existingPares = allSwaps[toIndex];
    for (NSNumber *subIndex in existingPares) {
        [allSwaps[subIndex.intValue] addObject:@(pairIndex)];
    }
    [allSwaps[toIndex] addObject:@(pairIndex)];
    
}

- (void)sortIndexes:(NSMutableArray *)indexes fromString:(NSString *)string {
    [indexes sortUsingComparator:^NSComparisonResult(id obj1, id obj2) {
        char char1 = [string characterAtIndex: [obj1 intValue]];
        char char2 = [string characterAtIndex: [obj2 intValue]];
        return char1 < char2;
    }];
}
@end

