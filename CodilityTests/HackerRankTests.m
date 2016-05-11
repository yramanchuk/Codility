//
//  HackerRankTests.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "NumberOfIslands.h"
#import "MaxProfit.h"
#import "TaskOne.h"


@interface HackerRankTests : XCTestCase

@end

@implementation HackerRankTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

- (void)testNumberOfIslands {
    NSArray *test = @[@[@1, @1, @0, @0, @0],
                      @[@0, @1, @0, @0, @1],
                      @[@1, @0, @0, @1, @1],
                      @[@0, @0, @0, @0, @0],
                      @[@1, @0, @1, @0, @1]
                      ];
    
    int result = [NumberOfIslands numberOfIslands:test];
    XCTAssertEqual(result, 5);
}

- (void)testMaxProfitTwice {
    NSArray *test = @[@10, @22, @5, @75, @65, @80];
    int result = [MaxProfit findMaxProfitTwice:test];
    XCTAssertEqual(result, 87);

    test = @[@2, @30, @15, @10, @8, @25, @80];
    result = [MaxProfit findMaxProfitTwice:test];
    XCTAssertEqual(result, 100);

}

- (void)testTaskOne {
//    TaskOne *task = [[TaskOne alloc] init];
    [TaskOne startMain];
}

@end
