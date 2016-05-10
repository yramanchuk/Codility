//
//  CTCI.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/5/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CTCI : NSObject

- (long)countPossibleWays:(int)n;
+ (int)checkPossibilities:(int)num with:(NSMutableArray *)values;
+ (int) changePossibilitiesBottomUp:(int) amount with:(NSMutableArray<NSNumber *> *)denominations;

+ (NSDictionary *)findAllSubstringCount:(NSString *)string length:(int)length;
+ (NSArray *)findAllTriples:(NSArray *)array;
@end
