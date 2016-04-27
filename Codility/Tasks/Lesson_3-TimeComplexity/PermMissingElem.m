//
//  PermMissingElem.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "PermMissingElem.h"

@implementation PermMissingElem

+ (int)solution:(NSMutableArray *)A {
    
    int sum = 0;
    int factorial = 0;
    for (int i = 0; i < A.count; i++) {
        sum += [A[i] intValue];
        factorial += i + 1;
    }
    
    factorial += A.count + 1;
    
    int result = factorial - sum;
    
    return result;
    
}

@end
