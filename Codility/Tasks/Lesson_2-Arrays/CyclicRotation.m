//
//  CyclicRotation.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CyclicRotation.h"

@implementation CyclicRotation


//static NSMutableArray * solution(NSMutableArray *A, int K) {
+ (NSMutableArray *)solution:(NSMutableArray *)A size:(int) K {
// write your code in Objective-C 2.0
    NSMutableArray *result = [NSMutableArray new];
    
    if (A.count == 0) {
        return A;
    }
    
    int startIdx = A.count - (K % A.count);
    int nextIdx;
    
    for (int i = 0; i < A.count; i++) {
        nextIdx = (i + startIdx) % A.count;
        
        [result addObject:A[nextIdx]];
        
        
    }
    
    NSLog(@"%@", result);
    
    return result;
    
}




@end
