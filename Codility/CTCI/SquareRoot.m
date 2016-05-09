//
//  SquareRoot.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/9/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "SquareRoot.h"

@implementation SquareRoot

+ (double)sqrt:(double)value {
    double precision = 0.001;
    double low = 0;
    double high = value;
    double mid = value > 1.0 ? value / 2 : (double) 1.0;
    
    while (fabs(mid * mid - value) > precision) {
        //delta = remains / 2;
        if (mid * mid == value) {
            return mid;
        }
        
        if (mid * mid < value) {
            low = mid;
        } else {
            high = mid;
        }
        mid = (low + high) / 2;
    }
    
    return mid;
    
}

@end
