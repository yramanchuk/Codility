//
//  ArraysStrings.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "EKNode.h"

@interface EKNode (Additions)
- (NSNumber *)data;
@end

@interface ArraysStrings : NSObject

+ (BOOL)hasDuplicates:(NSString *)string;
+ (void)rotate:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array;

+ (void)removeDuplicates:(NSMutableArray *)a;

+ (EKNode *)partition:(EKNode *)head around:(int)n;
+ (EKNode *)sum:(EKNode *)left with:(EKNode *)right;

@end
