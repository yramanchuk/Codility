//
//  MainClass.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/11/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MainClass : NSObject
+ (BOOL)startMain;
@end

@implementation MainClass

+ (BOOL)startMain {
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

+ (NSArray *)readLong2DimArrayOfLength:(NSInteger)len {
    NSMutableArray *result = [NSMutableArray array];
    for (int i =0; i < len; i++) {
        [result addObject:[NSMutableArray array]];
        for (int j =0; j < len; j++) {
            [result[i] addObject:@([self readLong])];
        }
    }
    return [result copy];
}

+ (NSArray *)readLongArrayOfLength:(NSInteger)len {
    NSMutableArray *result = [NSMutableArray array];
    for (int i =0; i < len; i++) {
        [result addObject:@([self readLong])];
    }
    return [result copy];
}

//Helpers
+ (void)printLong:(long)i {
    printf("%ld\n",(long)i);
}

+ (void)printFloat:(float)i {
    printf("%f\n", i);
}

+ (void)printString:(NSString *)s {
    printf("%s\n", [s UTF8String]);
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

//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        return [MainClass startMain];
//    }
//}

//DO NOT COPY
//@interface MainClass : NSObject
//+ (BOOL)startMain;
//@end
//
//@implementation MainClass
//
//+ (BOOL)startMain {
//
//    return YES;
//}
//
//@end