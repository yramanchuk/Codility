//
//  CountDiv.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/29/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CountDiv.h"

@implementation CountDiv

+(int)solution:(int) A for:(int)B by:(int)K {
    int c = (B / K);
    int d =  (A / K);
    if (A % K == 0) {
        c++;
    }
    return c - d;
}

@end
