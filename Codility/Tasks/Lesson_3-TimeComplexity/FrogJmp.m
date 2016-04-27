//
//  FrogJmp.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "FrogJmp.h"

@implementation FrogJmp

+ (int) solution:(int) X toY:(int) Y withD:(int) D {
    
    assert(D != 0);
    
    int result = 0;
    int delta = Y - X;
    
    
    if (delta % D == 0) {
        result = delta / D;
    } else {
        result = delta / D + 1;
    }
    
    return result;
}

@end
