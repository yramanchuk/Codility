//
//  CyclicRotation.h
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CyclicRotation : NSObject

//static NSMutableArray * solution(NSMutableArray *A, int K);
+ (NSMutableArray *)solution:(NSMutableArray *)A size:(int) K;

+ (int)getStart:(NSArray *)array;
+ (int)findRotated:(NSArray *)array;

@end
