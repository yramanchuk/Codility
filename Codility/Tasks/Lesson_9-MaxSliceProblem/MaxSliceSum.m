//
//  MaxSliceSum.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/28/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MaxSliceSum.h"

@implementation MaxSliceSum


+ (int)solution:(NSMutableArray *)A {
    
    int maxEnding = 0; //current max ending
    int maxSlice = 0; //max of all endings
    
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        maxEnding = fmax(0, maxEnding + val);
        maxSlice = fmax(maxSlice, maxEnding);
    }
    
    
    
    return maxSlice;
}

@end
