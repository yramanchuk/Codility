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

@end
