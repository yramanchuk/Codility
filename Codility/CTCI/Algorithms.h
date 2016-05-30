//
//  Algorithms.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Algorithms : NSObject

+ (int)binarySearchRecursive:(NSArray *)array x:(int)x;
+ (int)binarySearch:(NSArray *)array x:(int)x;


+ (void)mergeSort:(NSMutableArray *)array;
+ (void)mergesortNonRecursive:(NSMutableArray *)array;
+ (void)quickSort:(NSMutableArray *)array;

+ (NSString *)longestUniqueSubstring:(NSString *)string;
+ (int)longestCommonSubstring:(NSString *)str1 with:(NSString *)str2;
+ (int)checkChangePossibilities:(int)num with:(NSMutableArray *)values;
+ (int)printChangePosiibilitesUnique:(int)num from:(int)start using:(NSMutableArray *)array;
+ (int)printChangePosiibilitesAll:(int)num using:(NSMutableArray *)array;

+ (void)sumArray:(NSMutableArray<NSNumber *> *)A with:(int)num;

+ (NSArray *)unwrapArray:(NSObject *)array;
+ (int)calcNestedSum:(NSArray *)array;

+ (BOOL)isLucky:(int)n;
+ (double)pow:(int)x to:(int)pow;

+ (NSArray *)primeNumbersFromSieveEratosthenes:(NSUInteger)firstNPrimesCount;

+ (NSArray *)findAllSubstitutions:(NSString *)word;
+ (NSArray *)findAllPermutations:(NSString *)word;
+ (BOOL)isIsomorpthic:(NSString *)first with:(NSString *)second;
@end
