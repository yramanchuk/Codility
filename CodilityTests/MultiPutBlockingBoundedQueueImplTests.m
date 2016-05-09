//
//  MultiPutBlockingBoundedQueueImplTests.m
//  
//
//  Created by Yury Ramanchuk on 5/9/16.
//
//

#import <XCTest/XCTest.h>
#import "MultiPutBlockingBoundedQueueImpl.h"

@interface MultiPutBlockingBoundedQueueImplTests : XCTestCase

@end

@implementation MultiPutBlockingBoundedQueueImplTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"arrived"];
    MultiPutBlockingBoundedQueueImpl *queue = [[MultiPutBlockingBoundedQueueImpl alloc] init:10];
    dispatch_queue_t aQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0);
    dispatch_queue_t aQueue2 = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    for (int i = 0; i < 100; i++) {
        dispatch_async(aQueue, ^ {
            [queue put:@(i)];
        });
    }
    
    for (int i = 0; i < 100; i++) {
        dispatch_async(aQueue2, ^ {
            NSLog(@"get: %@", [queue get]);
            if (i == 99) {
                [expectation fulfill];
            }
        });
    }
    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

- (void)testConcurrency {
    
    XCTestExpectation *expectation = [self expectationWithDescription:@"arrived"];
    MultiPutBlockingBoundedQueueImpl *queue = [[MultiPutBlockingBoundedQueueImpl alloc] init:10];
    dispatch_queue_t putQueue = dispatch_queue_create("put", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t getQueue = dispatch_queue_create("get", DISPATCH_QUEUE_CONCURRENT);
    dispatch_queue_t putMultQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    
    int dozens = 9;
    int individual = 500;
    
    dispatch_async(getQueue, ^ {
        for (int i = 0; i < individual + dozens * 10; i++) {
            NSLog(@"%d get: %@", i, [queue get]);
            if (i == individual + dozens * 10 - 1) {
                [expectation fulfill];
            }
        }
    });

    dispatch_async(putQueue, ^ {
        for (int i = 0; i < individual; i++) {
            [queue put:@(i)];
        }
    });
    
//    dispatch_apply(4, putMultQueue, ^(size_t num) {
//        [queue multiput:@[@(100*num + 0), @(100*num + 1),
//                          @(100*num + 2), @(100*num + 3),
//                          @(100*num + 4), @(100*num + 5),
//                          @(100*num + 6), @(100*num + 7),
//                          @(100*num + 8), @(100*num + 9)]];
//    });
    
    dispatch_apply(dozens, putMultQueue, ^(size_t num) {
        int delta = 10*num + individual + 1000;
        [queue multiput:@[@(delta + 0), @(delta + 1),
                          @(delta + 2), @(delta + 3),
                          @(delta + 4), @(delta + 5),
                          @(delta + 6), @(delta + 7),
                          @(delta + 8), @(delta + 9)]];
        NSLog(@"applied %ld", num);
    });


    
    [self waitForExpectationsWithTimeout:5 handler:nil];
    
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
