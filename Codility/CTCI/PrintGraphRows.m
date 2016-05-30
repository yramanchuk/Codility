//
//  PrintGraphRows.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/30/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

//     Input:
//           6
//          / \
//         3   4
//        / \   \
//       5   1   0
//      / \     /
//     9   2   8
//          \
//           7

//     Output:
//     9 5 3 2 6 1 7 4 8 0

#import <Foundation/Foundation.h>
#import <stdio.h>

@interface TreeNode : NSObject
-(id)init:(int)intValue;
@property (nonatomic, strong) NSObject *value;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
@end

@implementation TreeNode
-(id)init:(int)intValue {
    if (self = [super init]) {
        self.value = @(intValue);
    }
    
    return self;
}
@end

@interface PrintGraphRows : NSObject
@end

@implementation PrintGraphRows

+ (void)printTreeByRows:(TreeNode *)root {
    int leftWidth = [self getLeftWidth:root];
    int rightWidth = [self getRightWidth:root.right];
    NSMutableArray *result = [NSMutableArray new];
    for (int i = 0; i < leftWidth + rightWidth; i++) {
        [result addObject:[NSMutableArray new]];
    }
    
    [self dfsTree:root row:leftWidth-1 cache:result];
    NSMutableString *printVal = [NSMutableString new];
    for (int index = 0; index < result.count; index++) {
        [printVal appendFormat:@"%@ ", [result[index] componentsJoinedByString:@" "]];
    }
    NSLog(@"%@", printVal);
}

+ (void)dfsTree:(TreeNode *)node row:(int)row cache:(NSArray *)cache {
    if (!node) {
        return;
    }
    
    [cache[row] addObject:node.value];
    [self dfsTree:node.left row:row-1 cache:cache];
    [self dfsTree:node.right row:row+1 cache:cache];
}

+ (int)getLeftWidth:(TreeNode *)root {
    int result = 1;
    while (root.left) {
        result++;
        root = root.left;
    }
    
    return result;
}

+ (int)getRightWidth:(TreeNode *)root {
    int result = 1;
    while (root.right) {
        result++;
        root = root.right;
    }
    
    return result;
}

@end

int mainFake (int argc, const char * argv[])
{
    @autoreleasepool {
        NSMutableArray *nodes = [NSMutableArray new];
        for (int i = 0; i < 10; i++) {
            TreeNode *node = [[TreeNode alloc] init:i];
            [nodes addObject:node];
        }
        ((TreeNode*)nodes[6]).left = nodes[3];
        ((TreeNode*)nodes[6]).right = nodes[4];
        
        ((TreeNode*)nodes[3]).left = nodes[5];
        ((TreeNode*)nodes[3]).right = nodes[1];
        
        ((TreeNode*)nodes[4]).right = nodes[0];
        
        ((TreeNode*)nodes[5]).left = nodes[9];
        ((TreeNode*)nodes[5]).right = nodes[2];
        
        ((TreeNode*)nodes[0]).left = nodes[8];
        
        ((TreeNode*)nodes[2]).right = nodes[7];
        
        [PrintGraphRows printTreeByRows:nodes[6]];
    }
    
    return 0;
}
