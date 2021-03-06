//
//  CTCITests.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArraysStrings.h"
#import "EKLinkedList.h"
#import "CTCI.h"
#import "MaxSliceSum.h"
#import "CyclicRotation.h"
#import "RomanNumbers.h"
#import "SquareRoot.h"
#import "LadderSolver.h"
#import "LexicographicallyLargestString.h"

@interface CTCITests : XCTestCase
@end

@interface XCTestCase (Additions)
- (void)testArray:(NSArray<NSNumber *> *)array withExpected:(NSArray<NSNumber *> *)expected;

@end

@implementation XCTestCase (Additions)

- (void)testArray2:(NSArray<NSArray *> *)array withExpected:(NSArray<NSArray *> *)expected {
    XCTAssertTrue(array.count == expected.count);
    for (int i = 0; i < array.count; i++) {
        for (int j = 0; j < array[i].count; j++) {
            XCTAssertEqual([array[i][j] intValue], [expected[i][j] intValue]);
        }
    }
}

- (void)testArray:(NSArray<NSNumber *> *)array withExpected:(NSArray<NSNumber *> *)expected {
    XCTAssertTrue(array.count == expected.count);
    for (int i = 0; i < array.count; i++) {
        XCTAssertEqual([array[i] intValue], [expected[i] intValue]);
    }
}



@end

@implementation CTCITests

- (void)testArraysStrings {
    XCTAssertEqual(YES, [ArraysStrings hasDuplicates:@"asdzxac"]);
    XCTAssertEqual(NO, [ArraysStrings hasDuplicates:@"asdzxc"]);
    XCTAssertEqual(NO, [ArraysStrings hasDuplicates:@""]);
}

- (void)testRotate {
    NSArray *expected = @[@[@1, @0, @1], @[@0, @0, @0], @[@1, @1, @0]];

    NSMutableArray *array = [@[[@[@1, @0, @1] mutableCopy], [(@[@0, @0, @1]) mutableCopy] , [@[@1, @0, @0] mutableCopy]]mutableCopy];
    [ArraysStrings rotate:array];
    [self testArray2:array withExpected:expected];
    
}

- (void)testRemoveDuplicates {
    NSArray *expected = @[@2, @1, @0];
    NSMutableArray *array = [@[@2, @1, @0, @2] mutableCopy];
    [ArraysStrings removeDuplicates:array];
    [self testArray:array withExpected:expected];
    
    
}

- (void)testPartitionLL {
    //// 3 5 6 2 9 1 5 around 6

    EKLinkedList *list = [[EKLinkedList alloc] initWithHead:@3];
    EKNode *head = list.head;
    
    [list addToBack:@5];
    [list addToBack:@6];
    [list addToBack:@2];
    [list addToBack:@9];
    [list addToBack:@1];
    [list addToBack:@5];

    [list printList];
    [ArraysStrings partition:head around:6];
    NSLog(@"\n");
    [list printList];
    

    
}

- (void)testSum {
    EKLinkedList *left = [[EKLinkedList alloc] initWithHead:@7];
    [left addToBack:@1];
//    [left addToBack:@6];
    
    EKLinkedList *right = [[EKLinkedList alloc] initWithHead:@5];
    [right addToBack:@9];
    [right addToBack:@2];
    
    EKNode *result = [ArraysStrings sum:left.head with:right.head];
    while (result) {
        NSLog(@"%@", result.data);
        result = result.next;
    }
    
}

- (void)testToBinary {
    NSString *result = [ArraysStrings toBinary:.76];
    NSLog(@"%@", result);
}

- (void)testPrintMinMax {
    [ArraysStrings printSmallestAndLargest:18];
}

- (void)testCountSteps {
    CTCI *test = [CTCI new];
    XCTAssertEqual(7, [test countClimbPossibleWays:4]);
    XCTAssertEqual(13, [test countClimbPossibleWays:5]);
}

- (void)testProductOfThree {
    long result = [MaxSliceSum maxProduct:[@[@2, @1, @-100, @10, @-5] mutableCopy]];
    XCTAssertEqual(5000, result);

    result = [MaxSliceSum maxProduct:[@[@2, @1, @100, @10, @-5] mutableCopy]];
    XCTAssertEqual(2000, result);

    result = [MaxSliceSum maxProduct:[@[@1, @10, @-5, @1, @-100] mutableCopy]];
    XCTAssertEqual(5000, result);

}

- (void)testMaxCoins {
    NSArray *grid = @[
                      @[@1, @0, @0, @0],
                      @[@0, @0, @1, @0],
                      @[@11,@0, @1, @0],
                      @[@0, @1, @1, @0]
                      ];
    
    NSInteger max = [MaxSliceSum findMaxCoins:grid];
    XCTAssertEqual(14, max);
}

- (void)testPossibleDenominations {
    int result = [CTCI checkChangePossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);

    result = [CTCI changePossibilitiesBottomUp:4 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(4, result);

    result = [CTCI changePossibilitiesBottomUp:5 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(5, result);

    result = [CTCI checkChangePossibilities:5 with:[@[@1, @2, @3, @4] mutableCopy]];
    XCTAssertEqual(6, result);

}

- (void)testSearchStart {
    NSArray *testArray = @[@"ptolemaic", @"retrograde", @"supplant", @"undulate", @"xenoepist", @"asymptote", @"babka", @"banoffee", @"engender", @"karpatka", @"othellolagkage"];
    int result = [CyclicRotation getStart:testArray];
    XCTAssertEqual([testArray indexOfObject:@"asymptote"], result);
    XCTAssertEqual([testArray indexOfObject:@"asymptote"], [CyclicRotation findRotated:testArray]);
}

- (void)testRomanNumber {
    int result = [RomanNumbers romanNumber:@"Ix"];
    XCTAssertEqual(result, 9);
    
    result = [RomanNumbers romanNumber:@"MDCCCXCVI"];
    XCTAssertEqual(result, 1896);
}

- (void)testSquareRoot {
    double value = 120.0;
    double result = [SquareRoot sqrt:value];
    XCTAssert(fabs(sqrt(value) - result) < .001);

    value = 0.2;
    result = [SquareRoot sqrt:value];
    XCTAssert(fabs(sqrt(value) - result) < .001);

    NSDictionary *d;
    [d objectForKey:@""];
}

- (void)testAllSubstrings {
    NSLog(@"%@", [CTCI findAllSubstringCount:@"ABCGRETCABCG" length:3]);
    NSLog(@"%@", [CTCI findAllTriples:@[@10, @5, @3, @4, @7, @1]]);
}

- (void)testLadder {
    
    int result = [LadderSolver wordLadder:@"cat" end:@"dat" dictionary:[@[@"bat"] mutableCopy]];
    XCTAssertEqual(result, 2);

    result = [LadderSolver wordLadder:@"cat" end:@"dog" dictionary:[@[@"bat", @"hot", @"dot", @"cog", @"lot", @"log", @"cot"] mutableCopy]];
    XCTAssertEqual(result, 4);

    result = [LadderSolver wordLadder:@"hit" end:@"cog" dictionary:[@[@"hot", @"dot", @"dog", @"lot", @"log"] mutableCopy]];
    XCTAssertEqual(result, 5);
}

- (void)testCalcRPN {
    long result = [CTCI calcRPN:@"50 1 2 + 4 * + 3 -"];
    XCTAssertEqual(result, (long)59);
    
}

- (void)testCollaps {
    NSDictionary *result = [CTCI collaps:@[@1, @4, @4, @7, @9, @10, @14] with:@[@4, @4, @5, @6, @7, @9, @11, @14]];
    NSLog(@"Collaps %@", result);
}


- (void)testMergeUnion {
    NSArray *result = [CTCI mergeUnion:@[@"good", @"person"] with:@[@"he", @"is", @"g very"]];
    NSLog(@"union: %@", result);
}

- (void)testLexLargString {
    LexicographicallyLargestString *solution = [LexicographicallyLargestString new];
    NSArray *pairs = @[@[@0, @3], @[@2, @3]];
    NSString *result = [solution lexicographicallyLargestString:@"abdc" with:pairs];
    NSLog(@"%@", result);
}
@end
