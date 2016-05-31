//
//  LadderSolver.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/10/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "LadderSolver.h"
@interface WordNode : NSObject

@property (nonatomic, copy) NSString *word;
@property (nonatomic, assign) int length;
@property (nonatomic, strong) NSArray *path;

- (id)initWith:(NSString *)word;
- (id)initWith:(NSString *)word length:(int)length withPath:(NSArray *)newPath;

@end

@implementation WordNode

- (id)initWith:(NSString *)word {
    if (self = [super init]) {
        self.word = word;
        self.length = 1;
        _path = [NSArray arrayWithObject:self.word];
    }
    
    return self;
}

- (id)initWith:(NSString *)word length:(int)length withPath:(NSArray *)newPath {
    if (self = [self initWith:word]) {
        self.length = length;
        _path = newPath;
    }
    
    return self;
}


@end

@implementation LadderSolver
+ (int)wordLadder:(NSString *)startWord end:(NSString *)endWord dictionary:(NSMutableArray *)dictionary {
    
    //check dict not empty; start == end;
    
    [dictionary addObject:endWord];
    NSMutableArray *stack = [NSMutableArray new];
    
    [stack addObject:[[WordNode alloc] initWith:startWord]];
    
    //dfs all combinations
    while (stack.count > 0) {
        WordNode *node = [stack lastObject];
        [stack removeLastObject];
        
        NSMutableString *chars = [node.word mutableCopy];
        
        for (int charIdx = 0; charIdx < node.word.length; charIdx++) {
            char wordChar = [node.word characterAtIndex:charIdx];
            
            for (char c = 'a'; c < 'z'; c++) {
                
                [chars replaceCharactersInRange:NSMakeRange(charIdx, 1) withString:[NSString stringWithFormat:@"%c", c]];
  
                if ([dictionary containsObject:chars]) {
                    if ([chars isEqualToString:endWord]) {
                        NSArray *path = [node.path arrayByAddingObject: [chars copy]];
                        NSLog(@"ladder path %@", path);
                        return node.length + 1;
                    } else {
                        NSArray *path = [node.path arrayByAddingObject: [chars copy]];
                        [stack addObject:[[WordNode alloc] initWith:chars length:(node.length+1) withPath:path]];
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
