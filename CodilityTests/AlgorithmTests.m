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
#import "AStarAlgorithm.h"
#import "PrintMatrixDiagonal.h"

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

- (void)testFindKLargestf {
    NSMutableArray *test = [@[@3, @7, @2, @5, @4] mutableCopy];
    int result = [Algorithms findKthLargestElement:test k:2 left:0 right:test.count-1];
    XCTAssertEqual(5, result);

    
    NSMutableArray *testArray = [NSMutableArray new];
    for (int i = 0; i < 100; i++) {
        [testArray addObject:@(i)];
    }
    result = [Algorithms findKthLargestElement:testArray k:9 left:0 right:testArray.count-1];
    XCTAssertEqual(91, result);
    
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
    int result = [Algorithms checkChangePossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);

    result = [Algorithms checkChangePossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);
    
    result = [Algorithms checkChangePossibilities:5 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(5, result);
    
}

- (void)testPrintPossibleDenominations {
    XCTAssertEqual(15, [Algorithms printChangePosiibilitesAll:5 using:[NSMutableArray new]]);
    NSLog(@" ");
    XCTAssertEqual(6, [Algorithms printChangePosiibilitesUnique:5 from:1 using:[NSMutableArray new]]);
}

- (void)testLucky {
    XCTAssertFalse([Algorithms isLucky:17]);
    XCTAssertTrue([Algorithms isLucky:13]);
    XCTAssertTrue([Algorithms isLucky:19]);
    XCTAssertFalse([Algorithms isLucky:21]);
}

- (void)testSumArray {
    NSMutableArray *test = [@[@0, @0, @3] mutableCopy];
    [Algorithms sumArray:test with:1009];
    NSLog(@"%@", [test componentsJoinedByString:@" "]);
}

- (void)testreconstructSum {
    NSArray *test = @[@6, @11, @101, @15, @105, @110];
    [Algorithms reconstructFromSum:test];
}

- (void)testPrimes {
    NSLog(@"primes: %@", [[Algorithms primeNumbersFromSieveEratosthenes:26] componentsJoinedByString:@" "]);
}

- (void)testPow {
    for (int i = -11; i < 12; i++) {
        XCTAssertEqual(pow(3, i), [Algorithms pow:3 to:i], @"not equal for pow(3, %d)", i);
    }
}


- (void)testAStar {
    NSArray *input = @[@[@0, @0, @0],
                       @[@0, @0, @0],
                       @[@0, @0, @0]];
    int result = [AStarAlgorithm getShortestPath:input fromX:0 fromY:0 toX:2 toY:1];
    XCTAssertEqual(3, result);

    input = @[@[@0, @0, @0],
              @[@-1, @-1, @0],
              @[@-1, @0, @0]];
    result = [AStarAlgorithm getShortestPath:input fromX:0 fromY:0 toX:2 toY:1];
    XCTAssertEqual(5, result);

    input = @[@[@0, @0, @0],
              @[@-1, @-1, @-1],
              @[@-1, @0, @0]];
    result = [AStarAlgorithm getShortestPath:input fromX:0 fromY:0 toX:2 toY:1];
    XCTAssertEqual(-1, result);

    input = @[@[@0, @0, @0, @0],
              @[@-1, @-1, @-1, @0],
              @[@-1, @0, @-1, @0],
              @[@0, @0, @0, @0]];
    result = [AStarAlgorithm getShortestPath:input fromX:0 fromY:0 toX:2 toY:1];
    XCTAssertEqual(9, result);

    input = @[@[@0, @0, @0, @0],
              @[@0, @-1, @-1, @0],
              @[@0, @0, @-1, @0],
              @[@0, @0, @0, @0]];
    result = [AStarAlgorithm getShortestPath:input fromX:0 fromY:0 toX:2 toY:1];
    XCTAssertEqual(3, result);
}

- (void)testUnwrap {
    NSArray *test = @[@1,@[@4,@3],@6,@[@5,@[@1,@0]]];
    
    NSArray *result = [Algorithms unwrapArray:test];
    NSLog(@"unwrapped %@", [result componentsJoinedByString:@" "]);
}

- (void)testNestedSum {
    NSArray *test = @[@1, @[@4, @[@6]]]; //@[@1,@[@4,@3],@6,@[@5,@[@1,@0]]];
    int result = [Algorithms calcNestedSum:test];
    XCTAssertEqual(27, result);
    
    test = @[@[@1, @1], @2, @[@1, @1]];
    result = [Algorithms calcNestedSum:test];
    XCTAssertEqual(10, result);
}

- (void)testFindSubstitutions {
    NSArray *result = [Algorithms findAllSubstitutions:@"fb1"];
    NSLog(@"Substitutions %@", [result componentsJoinedByString:@" "]);
}

- (void)testFindPermutations {
    NSArray *result = [Algorithms findAllPermutations:@"abc"];
    NSLog(@"Permutations %@", [result componentsJoinedByString:@" "]);
}

- (void)testLongestUniqueSubstring {
    NSString *result = [Algorithms longestUniqueSubstring:@"aaabcadcbc"];
    XCTAssertEqualObjects(@"bcad", result);

    result = [Algorithms longestUniqueSubstring:@"aaabcadcbcdfg"];
    XCTAssertEqualObjects(@"bcdfg", result);

}

- (void)testIsomorphic {
    XCTAssertEqual(true, [Algorithms isIsomorpthic:@"foo" with:@"app"]);
    XCTAssertEqual(false, [Algorithms isIsomorpthic:@"foo" with:@"bar"]);
    XCTAssertEqual(true, [Algorithms isIsomorpthic:@"turtle" with:@"tletur"]);
    XCTAssertEqual(false, [Algorithms isIsomorpthic:@"turtle" with:@"tlerur"]);
}

- (void)testReversePossibilities {
    NSArray *result = [Algorithms reversePossibilities:@"11111"];
    XCTAssertEqual(8, result.count);
}

- (void)testEqualAvg {
    [Algorithms getEqualAvg:@[@18, @2, @13, @8, @15, @20, @8]];
    [Algorithms getEqualAvg:@[@7, @8, @6, @7]];
    [Algorithms getEqualAvg:@[@2, @7, @9, @11, @15, @28]];
    [Algorithms getEqualAvg:@[@1, @1, @1, @1, @1, @1]];

    [Algorithms sumOfTwo:@[@3, @4, @7, @1, @2, @9, @8]];

}

- (void)testPairs {
    NSArray *result = [Algorithms getPairs:@"1234"];
    NSLog(@"\n(%@)", [result componentsJoinedByString:@")\n("]);
}

- (void)testGetDistance {
    NSArray *intervals = @[@[@0, @5, @10], @[@0, @4, @1], @[@1, @2, @5], @[@2, @5, @1]];
    float result = [Algorithms minCostOfDistance:0 finish:5 withIntervals:intervals];
    XCTAssertEqual(2, result);

    intervals = @[@[@1, @4, @10], @[@2, @5, @6]];
    result = [Algorithms minCostOfDistance:0 finish:5 withIntervals:intervals];
    XCTAssertEqual(-1, result);
}

- (void)testEncodeString {
    NSString *result = [Algorithms encodeString:@"p14akkkkkkkkpqqqq"];
    XCTAssertEqualObjects(@"p14a8xkp4xq", result);
}

- (void)testPrintDiagonal {
    NSArray *array = @[
                       @[@1, @2, @3, @4],
                       @[@5, @6, @7, @8],
                       @[@9, @10, @11, @12]
                       ];
    PrintMatrixDiagonal *print = [PrintMatrixDiagonal new];
    [print printMatrixDiagonal:array];
}

@end
