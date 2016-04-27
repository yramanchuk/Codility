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

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
