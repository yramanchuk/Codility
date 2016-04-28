//
//  MaxCounters.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/28/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MaxCounters.h"

@implementation MaxCounters

+ (NSMutableArray *)solution:(int) N forArray:(NSMutableArray *)A {
    
//    NSMutableString *str = [NSMutableString stringWithFormat:@"%d -", N];
//    
//    
//    for (int i = 0; i < A.count; i++) {
//        [str appendFormat:@" %d", [A[i] intValue]];
//    }
//    NSLog(@"%@", str);
    
    NSMutableArray *counters = [NSMutableArray arrayWithCapacity:N];
    for (int i = 0; i < N; i++) {
        [counters addObject:@0];
    }
    
    int maxCounter = 0;
    int maxValue = 0;
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue] - 1;
        
        if (val >= N) {
            maxCounter = maxValue;
        } else {
            int curVal = [counters[val] intValue];
            if (curVal < maxCounter) {
                counters[val] = @(maxCounter + 1);
            } else {
                 counters[val] = @(curVal + 1);
            }
            if ([counters[val] intValue] > maxValue) {
                maxValue = [counters[val] intValue];
            }
        }
    }
    
    for (int i = 0; i < counters.count; i++) {
        int val = [counters[i] intValue];
        if (val < maxCounter) {
            counters[i] = @(maxCounter);
        }
        
//        NSLog(@"%d ", [counters[i] intValue]);
    }
    
    
    
    return counters;
}



@end
