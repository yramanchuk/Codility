//
//  AStarAlgorithm.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/23/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AStarAlgorithm : NSObject

+ (int)getShortestPath:(NSArray<NSArray <NSNumber *> *> *)input fromX:(int)m fromY:(int)n toX:(int)toX toY:(int)toY;

@end
