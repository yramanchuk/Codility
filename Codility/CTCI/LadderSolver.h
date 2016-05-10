//
//  LadderSolver.h
//  Codility
//
//  Created by Yury Ramanchuk on 5/10/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface LadderSolver : NSObject
+ (int)wordLadder:(NSString *)startWord end:(NSString *)endWord dictionary:(NSMutableArray *)dictionary;

@end
