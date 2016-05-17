//
//  CTCI.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/5/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCI : NSObject

- (long)countClimbPossibleWays:(int)n;
+ (int)checkChangePossibilities:(int)num with:(NSMutableArray *)values;
+ (int) changePossibilitiesBottomUp:(int) amount with:(NSMutableArray<NSNumber *> *)denominations;

+ (NSDictionary *)findAllSubstringCount:(NSString *)string length:(int)length;
+ (NSArray *)findAllTriples:(NSArray *)array;
+ (float)calcRPN:(NSString *)rpn;
+ (NSDictionary *)collaps:(NSArray *)left with:(NSArray *)right;
+(NSArray *)mergeUnion:(NSArray *)first with:(NSArray *)second;
@end
