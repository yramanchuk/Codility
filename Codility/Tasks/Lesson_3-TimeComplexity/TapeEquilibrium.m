//
//  TapeEquilibrium.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "TapeEquilibrium.h"

@implementation TapeEquilibrium

+ (int)solution:(NSMutableArray *)A {
    int sum = 0;
    int curSum = 0;
    
    for (NSNumber *val in A) {
        sum += [val intValue];
    }
    
    curSum = [A[0] intValue];
    int minDifferece = abs(sum - 2 * [A[0] intValue]);
    
    for (int i = 1; i < A.count - 1; i++) {
        curSum += [A[i] intValue];
        int differece = abs(sum - 2 * curSum);
        if (minDifferece > differece) {
            minDifferece = differece;
        }
        
    }
    
    
    
    return minDifferece;
}

@end
