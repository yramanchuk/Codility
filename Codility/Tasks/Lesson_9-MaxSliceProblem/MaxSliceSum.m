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
    
    int sum = 0; //current max ending
    int maxSum = 0; //max of all endings
    
    for (int i = 0; i < A.count; i++) {
        int val = [A[i] intValue];
        sum = fmax(0, sum + val);
        maxSum = fmax(maxSum, sum);
    }
    
    
    
    return maxSum;
}

// 5 3 8 10
// 2 1 -100 10 -5
+ (long)maxProduct:(NSMutableArray *)A {

    assert(A.count > 2);
    
    long maxProductOfThree = [A[0] intValue] * [A[1] intValue] * [A[2] intValue];
    
    long maxProductOfTwo = [A[0] intValue] * [A[1] intValue];
    long minProductOfTwo = [A[0] intValue] * [A[1] intValue];

    long maxElement = fmax([A[0] intValue], [A[1] intValue]);
    long minElement = fmin([A[0] intValue], [A[1] intValue]);

    for (int i = 2; i < A.count; i++) {
        int val = [A[i] intValue];
        
        
        maxProductOfThree = fmax(fmax(maxProductOfThree, minProductOfTwo * val), maxProductOfTwo * val);

        maxProductOfTwo = fmax(fmax(maxProductOfTwo, maxElement * val), minElement * val);
        minProductOfTwo = fmin(fmin(minProductOfTwo, minElement * val), maxElement * val);

        maxElement = fmax(maxElement, val);
        minElement = fmin(minElement, val);

    }
    
    return maxProductOfThree;
}


//public int getMaxProfit(int[] stockPricesYesterday) {
//    
//    // make sure we have at least 2 prices
//    if (stockPricesYesterday.length < 2) {
//        throw new IllegalArgumentException("Getting a profit requires at least 2 prices");
//    }
//    
//    // we'll greedily update minPrice and maxProfit, so we initialize
//    // them to the first price and the first possible profit
//    int minPrice = stockPricesYesterday[0];
//    int maxProfit = stockPricesYesterday[1] - stockPricesYesterday[0];
//    
//    // start at the second (index 1) time
//    // we can't sell at the first time, since we must buy first,
//    // and we can't buy and sell at the same time!
//    // if we started at index 0, we'd try to buy /and/ sell at time 0.
//    // this would give a profit of 0, which is a problem if our
//    // maxProfit is supposed to be /negative/--we'd return 0!
//    for (int i = 1; i < stockPricesYesterday.length; i++) {
//        int currentPrice = stockPricesYesterday[i];
//        
//        // see what our profit would be if we bought at the
//        // min price and sold at the current price
//        int potentialProfit = currentPrice - minPrice;
//        
//        // update maxProfit if we can do better
//        maxProfit = Math.max(maxProfit, potentialProfit);
//        
//        // update minPrice so it's always
//        // the lowest price we've seen so far
//        minPrice = Math.min(minPrice, currentPrice);
//    }
//    
//    return maxProfit;
//}




//Write a function getProductsOfAllIntsExceptAtIndex() that takes an array of integers and returns an array of the products.
//
//For example, given:
//
//[1, 7, 3, 4]
//
//your function would return:
//
//[84, 12, 28, 21]
//
//by calculating:
//
//[7*3*4, 1*3*4, 1*7*4, 1*7*3]
//
//Do not use division in your solution.

//public int[] getProductsOfAllIntsExceptAtIndex(int[] intArray) {
//    
//    // we make an array with the length of the input array to
//    // hold our products
//    int[] productsOfAllIntsExceptAtIndex = new int[intArray.length];
//    
//    // for each integer, we find the product of all the integers
//    // before it, storing the total product so far each time
//    int productSoFar = 1;
//    for (int i = 0; i < intArray.length; i++) {
//        productsOfAllIntsExceptAtIndex[i] = productSoFar;
//        productSoFar *= intArray[i];
//    }
//    
//    // for each integer, we find the product of all the integers
//    // after it. since each index in products already has the
//    // product of all the integers before it, now we're storing
//    // the total product of all other integers
//    productSoFar = 1;
//    for (int i = intArray.length - 1; i >= 0; i--) {
//        productsOfAllIntsExceptAtIndex[i] *= productSoFar;
//        productSoFar *= intArray[i];
//    }
//    
//    return productsOfAllIntsExceptAtIndex;
//}



//    There are N coins with coordinates (x, y) where x >= 0 and y >= 0
//    You start at (0, 0) and you can only do steps of form (dx, dy) where dx >0 and dy > 0
//    Print the maximum number of coins that you can collect.
//
//    Clarification: you can do as many moves as you wish, the point is to collect maximum number of coins. If you are located at position (a, b) you may jump to position (a+dx, b+dy) for all dx >= 0 and dy >= 0



+(NSUInteger) maxFromPosition:(NSArray *)grid startX:(NSUInteger)xPos  startY:(NSUInteger)yPos chache:(NSMutableDictionary *)cache {
    
    NSString *key = [NSString stringWithFormat:@"%ld-%ld",xPos, yPos];
    NSNumber *value = cache[key];
    
    if (value) {
        return [value integerValue];
    }
    
    int maxCoins = 0;

// not needed to check
//    if(xPos > grid.count - 1 || yPos > [grid[xPos] count] - 1){
//        return 0;
//    }
    
    for(NSUInteger row = xPos; row < [grid count]; row++){
        for(NSUInteger col = yPos; col < [grid[row] count]; col++){
            if (row != xPos || col != yPos) {
                NSInteger total = [self maxFromPosition:grid startX:row startY:col chache:cache];
                maxCoins = fmax(total, maxCoins);
            }
        }
    }
    
    maxCoins += [grid[xPos][yPos] intValue];
    
    [cache setObject:@(maxCoins) forKey:key];
    
    return maxCoins;
    
}


+(NSUInteger) findMaxCoins:(NSArray *)grid {
    return [self maxFromPosition:grid startX:0 startY:0 chache:[NSMutableDictionary new]];
}


@end
