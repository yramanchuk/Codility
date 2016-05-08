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
    XCTAssertEqual(7, [test countPossibleWays:4]);
    XCTAssertEqual(13, [test countPossibleWays:5]);
}

- (void)testProductOfThree {
    long result = [MaxSliceSum maxProduct:[@[@2, @1, @-100, @10, @-5] mutableCopy]];
    XCTAssertEqual(5000, result);

    result = [MaxSliceSum maxProduct:[@[@2, @1, @100, @10, @-5] mutableCopy]];
    XCTAssertEqual(2000, result);

    result = [MaxSliceSum maxProduct:[@[@1, @10, @-5, @1, @-100] mutableCopy]];
    XCTAssertEqual(5000, result);

}

- (void)testPossibleDenominations {
//    int result = [CTCI checkPossibilities:4 with:[@[@1, @2, @3] mutableCopy]];
//    XCTAssertEqual(4, result);
//
//    result = [CTCI changePossibilitiesBottomUp:4 with:[@[@1, @2, @3] mutableCopy]];
//    XCTAssertEqual(4, result);

    int result = [CTCI changePossibilitiesBottomUp:5 with:[@[@1, @2, @3] mutableCopy]];
    XCTAssertEqual(5, result);

}

@end
