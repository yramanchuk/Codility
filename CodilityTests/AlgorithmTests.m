//
//  AlgorithmTests.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "Algorithms.h"
#import "NSString+EKStuff.h"

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

- (void)testMergeSortNonRecursive {
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(arc4random()%50)];
    }
    
    NSMutableArray *result = [testArray mutableCopy];
    NSMutableArray *expected = [testArray mutableCopy];
    
    [Algorithms mergesortNonRecursive:result];
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

- (void)testLCS {
    NSString *str = @"1241";
    int result = [Algorithms longestCommonSubstring:str with:[str reversedString]];
    XCTAssertEqual(result, 3);

    str = @"12415566";
    result = [Algorithms longestCommonSubstring:str with:[str reversedString]];
    XCTAssertEqual(result, 3);

    str = @"12412233";
    NSArray *lcs = [str LCS_WithString:[str reversedString]];
    NSLog(@"%@", lcs);
    XCTAssertEqual(lcs.count, 3);

    str = @"12415332";
    lcs = [str LCS_WithString:[str reversedString]];
    NSLog(@"LCS_WithString %@", lcs);
    XCTAssertEqual(lcs.count, 4);

    str = @"12412233";
    result = [Algorithms longestCommonSubstring:str with:[str reversedString]];
    XCTAssertEqual(result, 3);

    str = @"124135332";
    result = [Algorithms longestCommonSubstring:str with:[str reversedString] ];
    XCTAssertEqual(result, 5);
    
}

- (void)testPossibleDenominations {
    int result = [Algorithms checkPossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);

    result = [Algorithms checkPossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);
    
    result = [Algorithms checkPossibilities:5 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(5, result);
    
}

- (void)testLucky {
    XCTAssertFalse([Algorithms isLucky:17]);
    XCTAssertTrue([Algorithms isLucky:13]);
    XCTAssertTrue([Algorithms isLucky:19]);
    XCTAssertFalse([Algorithms isLucky:21]);
}

- (void)testPow {
    for (int i = -11; i < 12; i++) {
        XCTAssertEqual(pow(3, i), [Algorithms pow:3 to:i], @"not equal for pow(3, %d)", i);
    }
}
@end
