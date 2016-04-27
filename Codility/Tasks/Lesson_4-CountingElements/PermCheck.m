//
//  PermCheck.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "PermCheck.h"

@implementation PermCheck

+ (int)solution:(NSMutableArray *)A {
    long sum = 0;
    long factorial = 0;
    long checkSum = 0;
    
    for (int i = 0; i < A.count; i++) {
        sum += [A[i] intValue];
        factorial += i;
        checkSum ^= [A[i] intValue];
        checkSum ^= (i + 1);
    }
    
    factorial += A.count;
    
    int result = (factorial == sum && checkSum == 0) ? 1 : 0;
    
    return result;
    
    
}

@end
