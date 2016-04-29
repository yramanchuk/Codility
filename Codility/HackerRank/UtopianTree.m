//
//  UtopianTree.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/29/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "UtopianTree.h"

@implementation UtopianTree

+ (int)solution:(int)n {
    int result = (1 << ((n + 1) / 2 + 1)) - (n % 2) - 1;
    
    return result;
}

@end
