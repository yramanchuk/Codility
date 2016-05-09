//
//  MultiPutBlockingBoundedQueueImpl.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/9/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MultiPutBlockingBoundedQueueImpl : NSObject

- (instancetype) init:(int)capacity;
- (NSObject *)get;
- (void)put:(NSObject *)object;
- (void)multiput:(NSArray *)objects;

@end
