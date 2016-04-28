//
//  CodilityTests.m
//  CodilityTests
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "BinaryGap.h"
#import "CyclicRotation.h"
#import "OddOccurrencesInArray.h"
#import "FrogJmp.h"
#import "TapeEquilibrium.h"
#import "PermMissingElem.h"
#import "FrogRiverOne.h"
#import "PermCheck.h"
#import "MissingInteger.h"
#import "MaxCounters.h"

#import "MaxSliceSum.h"

@interface CodilityTests : XCTestCase

@end

@implementation CodilityTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBinaryGap{
    XCTAssertEqual(0 ,[BinaryGap solution:2147483647 - 16 - 32 - 15]);
    XCTAssertEqual(3 ,[BinaryGap solution:561892]);
    XCTAssertEqual(2 ,[BinaryGap solution:51712]);
    XCTAssertEqual(1 ,[BinaryGap solution:5]);
    XCTAssertEqual(2 ,[BinaryGap solution:9]);
    XCTAssertEqual(5 ,[BinaryGap solution:1041]);
    XCTAssertEqual(0 ,[BinaryGap solution:15]);
    XCTAssertEqual(29 ,[BinaryGap solution:1073741825]);
    XCTAssertEqual(0 ,[BinaryGap solution:1073741824]);

    XCTAssertEqual(0 ,[BinaryGap solution:6]);
    XCTAssertEqual(2 ,[BinaryGap solution:19]);
    XCTAssertEqual(3 ,[BinaryGap solution:1162]);
    XCTAssertEqual(1 ,[BinaryGap solution:20]);
    XCTAssertEqual(3 ,[BinaryGap solution:561892]);
    XCTAssertEqual(9 ,[BinaryGap solution:66561]);
    XCTAssertEqual(20 ,[BinaryGap solution:6291457]);
    XCTAssertEqual(4 ,[BinaryGap solution:74901729]);
    XCTAssertEqual(25 ,[BinaryGap solution:805306373]);
    XCTAssertEqual(5 ,[BinaryGap solution:1376796946]);
}

- (void)testCyclicRotation {
    [CyclicRotation solution:[@[@3, @8, @9, @7, @6] mutableCopy] size:6];
    [CyclicRotation solution:[@[] mutableCopy] size:6];
}

- (void)testOddOccurrencesInArray {

    int result = [OddOccurrencesInArray solution:[@[@2, @1, @3, @2, @1, @2, @2, @3, @4, @1, @1, @5, @5] mutableCopy]];
    XCTAssertEqual(4 ,result);

    result = [OddOccurrencesInArray solution:[@[@2, @1, @3, @2, @1, @2, @2, @3, @4, @1, @1] mutableCopy]];
    XCTAssertEqual(4 ,result);
    
    result = [OddOccurrencesInArray solution:[@[@2, @2, @3, @3, @4] mutableCopy]];
    XCTAssertEqual(4 ,result);
    
    
    result = [OddOccurrencesInArray solution:[@[@42] mutableCopy]];
    XCTAssertEqual(42 ,result);
    
    result = [OddOccurrencesInArray solution:[@[@9, @3, @9, @3, @9, @7, @9] mutableCopy]];
    XCTAssertEqual(7 ,result);


}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testFrogJmp {
    XCTAssertEqual(3 , [FrogJmp solution:10 toY:85 withD:30]);
    XCTAssertEqual(1 , [FrogJmp solution:10 toY:85 withD:130]);
    XCTAssertEqual(7692308 , [FrogJmp solution:10 toY:1000000000 withD:130]);
    XCTAssertEqual(0 , [FrogJmp solution:10 toY:10 withD:130]);
}

- (void)testTapeEquilibrium {
    int result = [TapeEquilibrium solution:[@[@3, @1, @2, @4, @3] mutableCopy]];
    XCTAssertEqual(1, result);

    result = [TapeEquilibrium solution:[@[@3, @1] mutableCopy]];
    XCTAssertEqual(2, result);

    result = [TapeEquilibrium solution:[@[@3, @1, @-3] mutableCopy]];
    XCTAssertEqual(5, result);

}

- (void)testPermMissingElem {
    int result = [PermMissingElem solution:[@[@2, @3, @1, @5] mutableCopy]];
    XCTAssertEqual(4, result);
    
    result = [PermMissingElem solution:[@[@2] mutableCopy]];
    XCTAssertEqual(1, result);

}

- (void)testFrogRiverOne {
    int result = [FrogRiverOne solution:5 witArray:[@[@1, @3, @1, @4, @2, @3, @5, @4] mutableCopy]];
    XCTAssertEqual(6, result);

    result = [FrogRiverOne solution:6 witArray:[@[@1, @3, @1, @4, @2, @3, @5, @4] mutableCopy]];
    XCTAssertEqual(-1, result);

    result = [FrogRiverOne solution:4 witArray:[@[@1, @3, @1, @4, @2, @3, @5, @4] mutableCopy]];
    XCTAssertEqual(4, result);

}

- (void)testPermCheck {
    int result = [PermCheck solution:[@[@4, @1, @2, @3] mutableCopy]];
    XCTAssertEqual(1, result);
    
    result = [PermCheck solution:[@[@5, @1, @2, @3] mutableCopy]];
    XCTAssertEqual(0, result);

    result = [PermCheck solution:[@[@5, @1, @3, @1] mutableCopy]];
    XCTAssertEqual(0, result);

    result = [PermCheck solution:[@[@5, @5, @5, @4, @1, @1] mutableCopy]];
    XCTAssertEqual(0, result);

    result = [PermCheck solution:[@[@1] mutableCopy]];
    XCTAssertEqual(1, result);
    
    result = [PermCheck solution:[@[@0] mutableCopy]];
    XCTAssertEqual(0, result);
    
    result = [PermCheck solution:[@[@2] mutableCopy]];
    XCTAssertEqual(0, result);
}

- (void)testMissingInteger {
    int result = [MissingInteger solution:[@[@1, @3, @6, @4, @1, @2] mutableCopy]];
    XCTAssertEqual(5, result);
    
    result = [MissingInteger solution:[@[@100, @300, @600, @40, @10, @20] mutableCopy]];
    XCTAssertEqual(1, result);
    
    result = [MissingInteger solution:[@[@100, @1, @600, @40, @10, @20] mutableCopy]];
    XCTAssertEqual(2, result);
    
    result = [MissingInteger solution:[@[@1, @-2, @600, @40, @10, @20] mutableCopy]];
    XCTAssertEqual(2, result);

    result = [MissingInteger solution:[@[@-2147483646, @-2, @600, @40, @10, @20] mutableCopy]];
    XCTAssertEqual(1, result);

    result = [MissingInteger solution:[@[@100, @3, @2147483647, @2147483646, @10, @20] mutableCopy]];
    XCTAssertEqual(1, result);

    result = [MissingInteger solution:[@[@1] mutableCopy]];
    XCTAssertEqual(2, result);

    result = [MissingInteger solution:[@[@2] mutableCopy]];
    XCTAssertEqual(1, result);

    result = [MissingInteger solution:[@[@1, @3, @2, @4, @5, @6] mutableCopy]];
    XCTAssertEqual(7, result);

}

- (void)testMaxCounters {
    NSMutableArray *result = [MaxCounters  solution:5 forArray:[@[@3, @4, @4, @6, @1, @4, @4] mutableCopy]];
    NSMutableArray *expected = [@[@3, @2, @2, @4, @2] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:2 forArray:[@[@1, @1] mutableCopy]];
    expected = [@[@2, @0] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:2 forArray:[@[@1, @3] mutableCopy]];
    expected = [@[@1, @1] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:2 forArray:[@[@3, @2] mutableCopy]];
    expected = [@[@0, @1] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:2 forArray:[@[@1, @2] mutableCopy]];
    expected = [@[@1, @1] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:3 forArray:[@[@3, @4, @4, @6, @1] mutableCopy]];
    expected = [@[@2, @1, @1] mutableCopy];
    [self testArray:result withExpected:expected];
    
    result = [MaxCounters  solution:3 forArray:[@[@3, @4, @4, @6, @1, @4] mutableCopy]];
    expected = [@[@2, @2, @2] mutableCopy];
    [self testArray:result withExpected:expected];

}


- (void)testArray:(NSArray<NSNumber *> *)array withExpected:(NSArray<NSNumber *> *)expected {
    XCTAssertTrue(array.count == expected.count);
    for (int i = 0; i < array.count; i++) {
        XCTAssertEqual([array[i] intValue], [expected[i] intValue]);
    }
}


- (void)testMaxSliceSum {
    int result = [MaxSliceSum solution:[@[@3, @2, @(-6), @4, @0] mutableCopy]];
    XCTAssertEqual(5, result);
    
    result = [MaxSliceSum solution:[@[@5, @-7, @3, @5, @-2, @4, @-1] mutableCopy]];
    XCTAssertEqual(10, result);
}

@end
