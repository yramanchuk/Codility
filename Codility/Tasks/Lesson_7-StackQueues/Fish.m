//
//  Fish.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/1/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "Fish.h"

@implementation Fish

+ (int)solution:(NSMutableArray *)A andArray:(NSMutableArray *)B {
    
    int survived = 0;
    NSMutableArray *downstream = [NSMutableArray new];
    
    for (int i = 0; i < A.count; i++) {
        int valA = [A[i] intValue];
        int valB = [B[i] intValue];
        
        if (valB == 1) {
            [downstream addObject:@(valA)];
        } else if (valB == 0) {
            while (downstream.count > 0 && ([downstream.lastObject intValue]) < valA) {
                [downstream removeLastObject];
            }
            
            if (downstream.count == 0) {
                survived++;
            }
        }
        
    }
    
    survived += downstream.count;
    
    return survived;
}

@end
