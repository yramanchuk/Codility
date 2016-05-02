//
//  ArraysStrings.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "ArraysStrings.h"

@implementation ArraysStrings

+ (BOOL)hasDuplicates:(NSString *)string {
    NSMutableDictionary *strChars = [NSMutableDictionary dictionaryWithCapacity: string.length];
    BOOL result = NO;
    
    for (int i = 0; i < string.length; i++) {
        char c = [string characterAtIndex:i];
        int count = [strChars[@(c)] intValue];
        if (count > 0) {
            result = YES;
            break;
        } else {
            strChars[@(c)] = @1;
        }
        
    }
    
    return result;
    
}

+ (void)rotate:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array {
    //validate that it's not empty
    //validate that is nxn
    //retunt if length = 1;
    
    for (int i = 0; i < array.count - 1; i++) {
        NSMutableArray *row = array[i];
        for (int j = i + 1; j < row.count; j++) {
            NSNumber *valJ = row[j];
            NSNumber *valI = array[j][i];
            row[j] = valI;
            array[j][i] = valJ;
        }
    }
}

@end
