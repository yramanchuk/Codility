    //
//  RomanNumbers.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/9/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "RomanNumbers.h"

@implementation RomanNumbers





+ (int)getIntValue:(char)c {
    //use hashmap
    int value = 0;
    
    switch (c) {
            
        case 'i':
            value = 1;
            break;
            
        case 'v':
            value = 5;
            break;
            
        case 'x':
            value = 10;
            break;
            
        case 'm':
            value = 1000;
            break;
            
        case 'l':
            value = 50;
            break;

        case 'c':
            value = 100;
            break;

        case 'd':
            value = 500;
            break;
            
        default:
            @throw [NSException new];
    }
    
    return value;
}

//4 = 1 + 5 - 1 -1
//9 = 1 + 10 -1 -1
//LXX


// iii = 3
// iv = 4
// v = 5
// ix = 9
// xxix
+ (int)romanNumber:(NSString *)roman {
    NSAssert(roman, @"value can not be nil");
    NSAssert(roman.length > 0, @"value can not be empty");
    
    roman = [roman lowercaseString];
    
    int prevValue = [self getIntValue: [roman characterAtIndex:0]];
    int sum = prevValue;
    
    for (int i = 1; i < roman.length; i++) {
        char c = [roman characterAtIndex:i];
        int charValue = [self getIntValue:c];
        sum += charValue;
        
        if (prevValue < charValue) {
            sum = sum - 2 * prevValue;
        }
        prevValue = charValue;
        
    }
    
    
    return sum;
}


//int romanNumber(String roman){
//    int valueOfLastChar = 0, valueOfCurrentChar =0;
//    int total = 0;
//    
//    for(int i= roman.length()-1; 0<=i; i--){
//        switch(roman.charAt(i)){
//            case 'I': valueOfCurrentChar = 1; break;
//            case 'V': valueOfCurrentChar = 5; break;
//            case 'X': valueOfCurrentChar = 10; break;
//            case 'L': valueOfCurrentChar = 50; break;
//            case 'C': valueOfCurrentChar = 100; break;
//            case 'D': valueOfCurrentChar = 500; break;
//            case 'M': valueOfCurrentChar = 1000; break;
//        }
//        
//        total += (valueOfCurrentChar < valueOfLastChar) ? -1*valueOfCurrentChar : valueOfCurrentChar;
//        valueOfLastChar = valueOfCurrentChar;
//    }
//    
//    return total;
//}
@end
