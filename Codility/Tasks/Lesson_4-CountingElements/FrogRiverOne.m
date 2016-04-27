//
//  FrogRiverOne.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "FrogRiverOne.h"

@implementation FrogRiverOne

+ (int)solution:(int) X witArray:(NSMutableArray *)A {
    int factorial = 0;
    
    NSMutableArray *check = [NSMutableArray arrayWithCapacity:X];

    for (int i = 0; i <= X; i++) {
        factorial += i;
        [check addObject:@0];
    }
    
    int sum = 0;
    int result = -1;
    
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        if (val <= X && [check[val] intValue] != val) {
            sum += val;
            check[val] = @(val);
        }
        if (sum == factorial) {
            result = i;
            break;
        }
    }
    
    return result;
    
}

@end
