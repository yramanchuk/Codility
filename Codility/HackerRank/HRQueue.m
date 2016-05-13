//
//  HRQueue.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/14/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//
#import <Foundation/Foundation.h>


@interface HRQueue : NSObject
- (void)insertObject:(id)object;
- (id)removeFirstObject;
- (id)peek;
- (BOOL)isEmpty;
- (void)clear;
- (NSArray *)allObjectsFromQueue;

@property (nonatomic, strong) NSMutableArray *queueArray;

@end

@implementation HRQueue

#pragma mark - init

- (id)init {
    self = [super init];
    if (self) {
        self.queueArray = [@[] mutableCopy];
    }
    return self;
}

#pragma mark - Public API

- (void)insertObject:(id)object {
    if (object != nil) {
        [self.queueArray addObject:object];
    }
    else {
        NSAssert(object != nil, @"You can't push nil object to deque");
    }
}

- (id)removeFirstObject {
    if ([self.queueArray count] > 0) {
        id object = [self peek];
        [self.queueArray removeObjectAtIndex:0];
        return object;
    }
    return nil;
}

- (id)peek {
    if ([self.queueArray count] > 0) {
        return [self.queueArray objectAtIndex:0];
    }
    return nil;
}

- (BOOL)isEmpty {
    return [self.queueArray count] == 0;
}

- (void)clear {
    [self.queueArray removeAllObjects];
}

- (NSArray *)allObjectsFromQueue {
    NSMutableArray *buffer = [@[] mutableCopy];
    
    for (id object in self.queueArray) {
        [buffer addObject:object];
    }
    
    return [buffer copy];
}

@end
