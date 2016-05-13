//
//  HRVertexEdge.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/14/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark Vertex Wrapper
@interface HRVertex : NSObject
@property (nonatomic, copy) NSString *label;
@property (nonatomic, copy) NSString *idx;
@property (nonatomic, assign) BOOL wasVisited;
@property (nonatomic, strong) NSMutableSet *adjacentEdges;
@end

@implementation HRVertex
-(instancetype)init{
    if (self = [super init]) {
        self.adjacentEdges = [NSMutableSet new];
    }
    return self;
}
- (NSUInteger)hash {
    return [self.idx hash];
}
@end

#pragma mark Edge Wrapper
@interface HREdge : NSObject
@property (nonatomic, strong) HRVertex *adjacentFrom;
@property (nonatomic, strong) HRVertex *adjacentTo;
@property (nonatomic, strong) NSNumber *weight;
@property (nonatomic, assign) BOOL used;
- (instancetype)initWithAdjacentFrom:(HRVertex *)vertexFrom
                                  To:(HRVertex *)vertexTo
                           andWeight:(NSNumber *)weight;

@end

@implementation HREdge
- (instancetype)initWithAdjacentFrom:(HRVertex *)vertexFrom
                                  To:(HRVertex *)vertexTo
                           andWeight:(NSNumber *)weight {
    self = [super init];
    if (self) {
        self.adjacentFrom = vertexFrom;
        self.adjacentTo = vertexTo;
        self.weight = weight;
        self.used = NO;
        
        [vertexFrom.adjacentEdges addObject:self];
    }
    return self;
}

- (BOOL)isEqual:(HREdge *)object {
    return [self.adjacentFrom isEqual:object.adjacentFrom] && [self.adjacentTo isEqual:object.adjacentTo];
}

- (NSUInteger)hash {
    return 7 * [self.adjacentFrom hash] + 13 * [self.adjacentTo hash];
}
@end

