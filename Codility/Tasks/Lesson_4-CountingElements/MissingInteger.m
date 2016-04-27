//
//  MissingInteger.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MissingInteger.h"

@implementation MissingInteger

+(int)solution:(NSMutableArray *)A {
    NSMutableArray *check = [NSMutableArray arrayWithCapacity:A.count];
    
    for (int i = 1; i <= A.count; i++) {
        [check addObject:@(i)];
    }
    
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        
        if (val <= A.count && val > 0) {
            int checkSum = [check[val - 1] intValue] ^ val;
            if (checkSum == 0) {
                check[val - 1] = @0;
            }
        }
    }
    
    int result = A.count + 1;
    for (int i = 0; i < check.count; i++) {
        int val = [check[i] intValue];
        if (val != 0) {
            result = val;
            break;
        }
    }
    
    return result;
    
}

@end
