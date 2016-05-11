//
//  MaxProfit.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MaxProfit.h"
//http://www.geeksforgeeks.org/maximum-profit-by-buying-and-selling-a-share-at-most-twice/
@implementation MaxProfit

+ (int)findMaxProfitTwice:(NSArray *)price {
    // Create profit array and initialize it as 0
    
    NSMutableArray *profit = [NSMutableArray new];
    for (int i = 0; i < price.count; i++) {
        [profit addObject:@(0)];
    }
    
    
    /* Get the maximum profit with only one transaction
     allowed. After this loop, profit[i] contains maximum
     profit from price[i..n-1] using at most one trans. */
    int max_price = [price.lastObject intValue];
    for (int i = price.count - 2; i >= 0; i--)
    {
        // max_price has maximum of price[i..n-1]
        if ([price[i] intValue] > max_price)
            max_price = [price[i] intValue];
        
        // we can get profit[i] by taking maximum of:
        // a) previous maximum, i.e., profit[i+1]
        // b) profit by buying at price[i] and selling at
        //    max_price
        profit[i] = @(fmax([profit[i+1] intValue], max_price - [price[i] intValue]));
    }
    
    /* Get the maximum profit with two transactions allowed
     After this loop, profit[n-1] contains the result */
    int min_price = [price[0] intValue];
    for (int i = 1; i < price.count; i++)
    {
        // min_price is minimum price in price[0..i]
        if ([price[i] intValue] < min_price)
            min_price = [price[i] intValue];
        
        // Maximum profit is maximum of:
        // a) previous maximum, i.e., profit[i-1]
        // b) (Buy, Sell) at (min_price, price[i]) and add
        //    profit of other trans. stored in profit[i]
        profit[i] = @(fmax([profit[i - 1] intValue], [profit[i] intValue] +
                        ([price[i] intValue] - min_price)));
    }
    int result = [profit.lastObject intValue];
    
    
    return result;
}


+ (NSArray *)getMaxProfit:(NSArray *)array {
    if (array.count < 2) {
        return 0;
    }
    
    int minPos = 0;
    int maxPos = 1;
    int min = [array[minPos] intValue];
    int max = [array[maxPos] intValue] - min;
    
    for (int i = 1; i < array.count; i++) {
        
        int current = [array[i] intValue];
        int delta = current - min;
        
        if (max < delta) {
            max = delta;
            maxPos = i;
        }

        if (min > current) {
            min = current;
            minPos = i;
        }
    }
    
    return @[@(max), @(minPos), @(maxPos)];
    
}


//+ (int)findMaxProfitTwice:(NSArray *)array {
//    if (array.count < 4) {
//        return 0;
//    }
//
//    NSMutableArray *mutCopy = [array mutableCopy];
//
//    NSArray *max1 = [self getMaxProfit:mutCopy];
//
////    NSMutableIndexSet *set = [NSMutableIndexSet indexSetWithIndex:[max1[1] intValue]];
////    [set addIndex:[max1[2] intValue]];
//
//    [mutCopy removeObjectsInRange:NSMakeRange([max1[1] intValue], [max1[2] intValue] - [max1[1] intValue] + 1)];
//
//    NSArray *max2 = [self getMaxProfit:mutCopy];
//
//    return [max1[0] intValue] + [max2[0] intValue];
//
//}
@end

