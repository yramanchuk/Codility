//
//  TaskOne.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "TaskOne.h"

@implementation TaskOne

+ (BOOL)startMain {
    //Read the STDIN here using the Objective-C wrapper methods
    NSInteger n = [self readLong];
    
    [self printLong:n];
    NSArray *numbers = [self readLongArrayOfLength:n];
    [self printLongNumberArray:numbers];
    return YES;
}

+ (long)readLong {
    long n;
    scanf("%ld",&n);
    return n;
}

+ (NSArray *)readLongArrayOfLength:(NSInteger)len {
    NSMutableArray *result = [NSMutableArray array];
    for (int i =0; i < len; i++) {
        [result addObject:@([self readLong])];
    }
    return [result copy];
}

//Helpers to print an int and array of ints to STDOUT
+ (void)printLong:(long)i {
    printf("%ld\n",(long)i);
}

+ (void)printLongNumberArray:(NSArray *)array {
    printf("[");
    [array enumerateObjectsUsingBlock:^(NSNumber *n, NSUInteger idx, BOOL * _Nonnull stop) {
        printf("%ld",(long)[n longValue]);
        if (idx < array.count-1) {
            printf(",");
        }
    }];
    printf("]\n");
}

@end
