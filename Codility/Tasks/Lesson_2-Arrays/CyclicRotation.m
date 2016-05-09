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




//I want to learn some big words so people think I'm smart.
//I opened up a dictionary to a page in the middle and started flipping through, looking for words I didn't know. I put each word I didn't know at increasing indices in a huge array I created in memory. When I reached the end of the dictionary, I started from the beginning and did the same thing until I reached the page I started at.
//
//Now I have an array of words that are mostly alphabetical, except they start somewhere in the middle of the alphabet, reach the end, and then start from the beginning of the alphabet. In other words, this is an alphabetically ordered array that has been "rotated." For example:
//String[] words = new String[]{
//    "ptolemaic",
//    "retrograde",
//    "supplant",
//    "undulate",
//    "xenoepist",
//    "asymptote", // <-- rotates here!
//    "babka",
//    "banoffee",
//    "engender",
//    "karpatka",
//    "othellolagkage",
//};
//
//Write a function for finding the index of the "rotation point," which is where I started working from the beginning of the dictionary. This array is huge (there are lots of words I don't know) so we want to be efficient here.

+ (int)getStart:(NSArray *)array {
    return [self binaryRotatedSearch:array  low:0  high:array.count-1];
}

+ (int)binaryRotatedSearch:(NSArray *)array low:(int) lowIdx  high:(NSUInteger)highIdx {
    int midIdx = (lowIdx +  highIdx) / 2;
    NSString *mid = array[midIdx];
    NSString *low = array[ lowIdx];
    
    if (highIdx - lowIdx <= 1) {
        return lowIdx;
    }
    
    if ([low compare:mid] > 0) {
        return [self binaryRotatedSearch:array low:lowIdx high:midIdx];
    } else {
        return [self binaryRotatedSearch:array low:midIdx + 1 high:highIdx];
    }
}

+ (int)findRotated:(NSArray *)array {
    int lowIdx = 0;
    int highIdx = array.count - 1;
    NSString *low = array[lowIdx];
    
    while (lowIdx < highIdx) {
        int midIdx = lowIdx + (highIdx - lowIdx) / 2;
        
        NSString *mid = array[midIdx];
        
        
        if ([low compare:mid] > 0) {
            highIdx = midIdx;
        } else {
            lowIdx = midIdx;
        }
        
        if (highIdx - lowIdx == 1) {
            break;
        }
        
    }
    
    return highIdx;
}



@end
