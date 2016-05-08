//
//  AlgorithmTests.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Algorithms.h"

@interface AlgorithmTests : XCTestCase

@end

@implementation AlgorithmTests

- (void)testMergeSort {
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(arc4random()%50)];
    }
    
    NSMutableArray *result = [testArray mutableCopy];
    NSMutableArray *expected = [testArray mutableCopy];
    
    [Algorithms mergeSort:result];
    [expected sortUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < testArray.count; i++) {
        XCTAssertEqual([result[i] intValue], [expected[i] intValue]);
    }
    
}

- (void)testQuickSort {
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(arc4random()%50)];
    }
    
    NSMutableArray *result = [testArray mutableCopy];
    NSMutableArray *expected = [testArray mutableCopy];
    
    [Algorithms quickSort:result];
    [expected sortUsingSelector:@selector(compare:)];
    
    for (int i = 0; i < testArray.count; i++) {
        XCTAssertEqual([result[i] intValue], [expected[i] intValue]);
    }
    
}

- (void)testBinarySearch {
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(arc4random()%5000)];
    }
    [testArray sortUsingSelector:@selector(compare:)];
    int rand = arc4random()%(testArray.count - 1);
    int value = [testArray[rand] intValue];
    
    int expected = [Algorithms binarySearch:testArray x:value];
    
    XCTAssertEqual(rand, expected);
    
}

- (void)testBinarySearchRecursive {
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(arc4random()%5000)];
    }
    [testArray sortUsingSelector:@selector(compare:)];
    int rand = arc4random()%(testArray.count - 1);
    int value = [testArray[rand] intValue];
    
    int expected = [Algorithms binarySearchRecursive:testArray x:value];
    
    XCTAssertEqual(rand, expected);
    
}
@end
