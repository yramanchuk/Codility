//
//  Algorithms.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Algorithms : NSObject

+ (int)binarySearchRecursive:(NSArray *)array x:(int)x;
+ (int)binarySearch:(NSArray *)array x:(int)x;


+ (void)mergeSort:(NSMutableArray *)array;
+ (void)quickSort:(NSMutableArray *)array;
@end