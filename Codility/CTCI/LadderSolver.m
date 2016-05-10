//
//  LadderSolver.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/10/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "LadderSolver.h"
#import "EKStack.h"
@interface WordNode : NSObject 

@property (nonatomic, copy) NSString *word;
@property (nonatomic, assign) int length;

- (id)initWith:(NSString *)word;
- (id)initWith:(NSString *)word length:(int)length;

@end

@implementation WordNode

- (id)initWith:(NSString *)word {
    if (self = [super init]) {
        self.word = word;
        self.length = 1;
    }
    
    return self;
}

- (id)initWith:(NSString *)word length:(int)length {
    if (self = [self initWith:word]) {
        self.length = length;
    }
    
    return self;
}


@end

@implementation LadderSolver
+ (int)wordLadder:(NSString *)startWord end:(NSString *)endWord dictionary:(NSMutableArray *)dictionary {
    
    //check dict not empty; start == end;
    
    [dictionary addObject:endWord];
    EKStack *stack = [EKStack new];
    
    
    [stack push:[[WordNode alloc] initWith:startWord]];
    
    while (!stack.isEmpty) {
        WordNode *node = [stack peek];
        
        NSMutableString *chars = [node.word mutableCopy];
        
        for (int charIdx = 0; charIdx < node.word.length; charIdx++) {
            char wordChar = [node.word characterAtIndex:charIdx];
            
            for (char c = 'a'; c < 'z'; c++) {
                
                [chars replaceCharactersInRange:NSMakeRange(charIdx, 1) withString:[NSString stringWithFormat:@"%c", c]];
  
                if ([dictionary containsObject:chars]) {
                    if ([chars isEqualToString:endWord]) {
                        return node.length + 1;
                    } else {
                        [stack push:[[WordNode alloc] initWith:chars length:(node.length+1)]];
                        [dictionary removeObject:chars];
                        
                    }
                }
              
            }

            [chars replaceCharactersInRange:NSMakeRange(charIdx, 1) withString:[NSString stringWithFormat:@"%c", wordChar]];
        }
        
    }
    
    return 0;
    
}
@end
