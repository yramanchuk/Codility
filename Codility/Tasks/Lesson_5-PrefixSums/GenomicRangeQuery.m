//
//  GenomicRangeQuery.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/29/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

//ACGT
//1234
//
//0123456
//CAGCCTA
//2132241
//
//0100001 - A -> create prefix sum array
//1001101 - C -> create prefix sum array
//0010000 - G -> create prefix sum array
//0000010 - T -> create prefix sum array

#import "GenomicRangeQuery.h"

@implementation GenomicRangeQuery


+ (NSMutableArray *)solution:(NSString *)S from:(NSMutableArray *)P till:(NSMutableArray *)Q {
    
    NSMutableArray *prefixSumA = [NSMutableArray arrayWithObject:@0];
    NSMutableArray *prefixSumC = [NSMutableArray arrayWithObject:@0];
    NSMutableArray *prefixSumG = [NSMutableArray arrayWithObject:@0];
    NSMutableArray *prefixSumT = [NSMutableArray arrayWithObject:@0];
    int sumA = 0;
    int sumC = 0;
    int sumG = 0;
    int sumT = 0;
    
    
    for (int i = 0; i < S.length; i++) {
        char c = [S characterAtIndex:i];
        switch (c) {
            case 'A':
                sumA++;
                break;
            case 'C':
                sumC++;
                break;
            case 'G':
                sumG++;
                break;
            case 'T':
                sumT++;
                break;
                
            default:
                break;
        }
        
        [prefixSumA addObject:@(sumA)];
        [prefixSumC addObject:@(sumC)];
        [prefixSumG addObject:@(sumG)];
        [prefixSumT addObject:@(sumT)];

        
    }
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (int i = 0; i < P.count; i++) {
        int pVal = [P[i] intValue];
        int qVal = [Q[i] intValue] + 1;
        
        sumA = [prefixSumA[qVal] intValue] - [prefixSumA[pVal] intValue];
        sumC = [prefixSumC[qVal] intValue] - [prefixSumC[pVal] intValue];
        sumG = [prefixSumG[qVal] intValue] - [prefixSumG[pVal] intValue];
        sumT = [prefixSumT[qVal] intValue] - [prefixSumT[pVal] intValue];
        
        if (sumA > 0) {
            [result addObject:@(1)];
        } else if (sumC > 0) {
            [result addObject:@(2)];
        } else if (sumG > 0) {
            [result addObject:@(3)];
        } else if (sumT > 0) {
            [result addObject:@(4)];
        }
    }
    
    return result;
}


@end
