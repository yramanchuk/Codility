//
//  ArraysStrings.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ArraysStrings : NSObject

+ (BOOL)hasDuplicates:(NSString *)string;
+ (void)rotate:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array;

+ (void)removeDuplicates:(NSMutableArray *)a;

@end
