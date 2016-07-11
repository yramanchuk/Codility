//
//  PrintMatrixDiagonal.m
//  Codility
//
//  Created by Yury Ramanchuk on 7/10/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "PrintMatrixDiagonal.h"

@interface NodeNumber : NSObject
@property (nonatomic, assign, readonly) int value;
@property (nonatomic, assign, readonly) int x;
@property (nonatomic, assign, readonly) int y;

-(id)initWith:(NSArray *)array x:(int)x y:(int)y;

@end

@implementation NodeNumber
-(id)initWith:(NSArray *)array x:(int)x y:(int)y {
    if (self = [super init]) {
        _value = [array[x][y] intValue];
        _x = x;
        _y = y;
    }
    
    return self;
}

- (NSString *)description {
    return [NSString stringWithFormat:@"%d", self.value];
}
@end

@implementation PrintMatrixDiagonal

- (void)printMatrixDiagonal:(NSArray *)array {
    NodeNumber *element = [[NodeNumber alloc] initWith:array x:0 y:0];
    
    NSMutableArray *list = [[NSMutableArray alloc] initWithObjects:element, nil];
    
    while (list.count > 0) {
        NSMutableArray *children = [NSMutableArray new];
        NSLog(@"%@", [list componentsJoinedByString:@" "]);
        for (NodeNumber *node in list) {
            [children addObjectsFromArray:[self getChildren:array node:node]];
        }
        list = children;
    }
    
}

- (NSArray *)getChildren:(NSArray *)array node:(NodeNumber *)node {
    NSMutableArray *result = [NSMutableArray new];
    
    if (node.x < array.count - 1) {
        [result addObject:[[NodeNumber alloc]initWith: array x:node.x + 1 y:node.y]];
    }
    
    if (node.x == 0 && node.y < [array[0] count] - 1) {
        [result addObject:[[NodeNumber alloc]initWith: array x:node.x y:node.y + 1]];
    }
    return result;
}


@end
