//
//  MainClass.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "MainClass.h"

@implementation MainClass

+ (BOOL)startMain {
    //Read the STDIN here using the Objective-C wrapper methods
    NSInteger n = [self readInt];
    
    [self printInt:n];
    NSArray *numbers = [self readIntArrayOfLength:n];
    [self printIntNumberArray:numbers];
    return YES;
}

+ (NSInteger)readInt {
    int n;
    scanf("%i",&n);
    return n;
}

+ (NSArray *)readIntArrayOfLength:(NSInteger)len {
    NSMutableArray *result = [NSMutableArray array];
    for (int i =0; i < len; i++) {
        [result addObject:@([self readInt])];
    }
    return [result copy];
}

//Helpers to print an int and array of ints to STDOUT
+ (void)printInt:(NSInteger)i {
    printf("%li\n",(long)i);
}

+ (void)printIntNumberArray:(NSArray *)array {
    printf("[");
    [array enumerateObjectsUsingBlock:^(NSNumber *n, NSUInteger idx, BOOL * _Nonnull stop) {
        printf("%li",(long)[n integerValue]);
        if (idx < array.count-1) {
            printf(",");
        }
    }];
    printf("]\n");
}

@end
