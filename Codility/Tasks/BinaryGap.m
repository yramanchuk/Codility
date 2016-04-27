//
//  BinaryGap.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "BinaryGap.h"

@implementation BinaryGap

+ (int)solution:(int) N {
    // write your code in Objective-C 2.0
    int digit;int counter = 0;
    int shift;
    int length = 0;
    int maxLength = 0;
    bool foundDigit = NO;
    //    do {
    //        shift = 1 << counter;
    //        digit = N & shift;
    //        counter++;
    //        if (digit == 0 && foundDigit) {
    //
    //            length++;
    //        } else {
    //
    //            if (maxLength < length) {
    //
    //
    //                maxLength  = length;
    //
    //            }
    //
    //            length = 0;
    //
    //            foundDigit |= digit != 0;
    //        }
    //        NSLog(@"%ld - count %ld %d", digit, counter, shift);
    //    } while (((1 << counter) - 1) < N);
    
    while (((shift = (1 << counter)) - 1) < N) {
        digit = N & shift;
        counter++;
        if (digit == 0 && foundDigit) {
            
            length++;
        } else {
            
            if (maxLength < length) {
                
                
                maxLength  = length;
                
            }
            
            length = 0;
            
            foundDigit |= digit != 0;
        }
//        NSLog(@"%d - count %d %d %d", digit, counter, shift, N >> counter);
    }
    
    
    NSLog(@"result %d", maxLength);
    
    return maxLength;
}

@end
