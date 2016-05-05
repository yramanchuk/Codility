//
//  CTCI.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/5/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CTCI.h"

@interface CTCI ()

{
    NSMutableArray *steps;
}

@end

@implementation CTCI

////0 1 2 3 4 5 6 8 9
////1 1 2 4 7
//
//1 1 1 1
//1 1 2
//1 2 1
//2 1 1
//2 2
//1 3
//3 1

- (id)init {
    
    if ((self = [super init])) {
        steps = [NSMutableArray arrayWithObjects:@1, nil];
    }
    
    return self;
}

- (void)prepareArray:(int)n {
    int delta = n - steps.count + 1;
    if (delta > 0) {
        for (int i = 0; i < delta; i++) {
            [steps addObject:@0];
        }
    }
}

- (long)countPossibleWays:(int) n {
    [self prepareArray:n];
    return [self countPossibleWaysRecursive:n];
}

- (long)countPossibleWaysRecursive:(int) n {
    if (n < 0) {
        return 0;
    } else if (n == 0) {
        return [steps[n] longValue];
    }
    
    long steps1 = [self countPossibleWaysRecursive:n-1];
    long steps2 = [self countPossibleWaysRecursive:n-2];
    long steps3 = [self countPossibleWaysRecursive:n-3];
    
    long result = steps1 + steps2 + steps3;
    
   steps[n] = @(result);
    
    return  result;
    
}


@end
