//
//  PassingCars.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/29/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "PassingCars.h"

@implementation PassingCars

+ (int)solution:(NSMutableArray *)A {
    int countWest = 0;
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        val == 1 ? countWest++ : countWest;
    }
    
    int total = 0;
    
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        if (val == 0) {
            total += countWest;
            
            if (-1 > total || total > 1000000000) {
                total = -1;
                break;
            }
        } else {
            countWest--;
        }
    }
    
    return total;
    
    
}

@end
