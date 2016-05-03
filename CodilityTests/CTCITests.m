//
//  CTCITests.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "ArraysStrings.h"

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

@end
