//
//  MultiPutBlockingBoundedQueueImpl.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/9/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MultiPutBlockingBoundedQueueImpl.h"
@interface MultiPutBlockingBoundedQueueImpl()

@property (nonatomic) NSMutableArray *queue;
@property (nonatomic) NSCondition *lock;
@property (assign) int capacity;

@end


@implementation MultiPutBlockingBoundedQueueImpl



- (instancetype) init:(int)capacity {
    @synchronized ([self class]) {
        
        if (self.queue) {
            @throw [NSException exceptionWithName:@"invalid state" reason:@"" userInfo:nil];
        }
        
        if (capacity <= 0) {
            @throw [NSException exceptionWithName:@"invalid state" reason:@"" userInfo:nil];
        }
        
        if (self = [super init]) {
            self.lock = [NSCondition new];
            self.queue = [NSMutableArray arrayWithCapacity:capacity];
            self.capacity = capacity;
        }
    }
    return self;
}

- (NSObject *)get {
    [self.lock lock];
    
    //wait if needed
    if (self.queue.count == 0) {
        NSLog(@"start waiting to get%s", __func__);
        [self.lock wait];
        NSLog(@"stop waiting to get");
    }
    
    NSObject *result = self.queue.lastObject;
    [self.queue removeObjectAtIndex:self.queue.count - 1];
    
    [self.lock signal];
    [self.lock unlock];
    
    NSLog(@"return %@ count: %ld", result, self.queue.count);
    return result;
}

- (void)put:(NSObject *)object {
    NSAssert(object, @"value can not be nil");
    
    [self multiput:@[object]];
}

- (void)multiput:(NSArray *)objects {
    NSAssert(self.queue, @"queue is not initialized");
    
    [self.lock lock];
    
    
    //wait if needed
    while (self.capacity - self.queue.count < objects.count) {
        NSLog(@"start waiting to put:%ld %s", objects.count, __func__);
        [self.lock wait];
        NSLog(@"stop waiting:%ld ", objects.count);
    }
    
    [self.queue addObjectsFromArray:objects];
    NSLog(@"added:%ld current count %ld  -- %@", objects.count, self.queue.count, objects);
    NSAssert(self.queue.count <= _capacity, @"count exceeded %ld", self.queue.count);
    
    [self.lock signal];
    [self.lock unlock];
}

@end
