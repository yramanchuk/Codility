//
//  CTCI.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/5/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CTCI.h"
#import "EKStack.h"

@interface CTCI ()

{
    NSMutableArray *steps;
}

@end

@implementation CTCI

////0 1 2 3 4 5 6 8 9
////1 1 2 4 7
//
//1 1 1 1
//1 1 2
//1 2 1
//2 1 1
//2 2
//1 3
//3 1

- (id)init {
    
    if ((self = [super init])) {
        steps = [NSMutableArray arrayWithObjects:@1, nil];
    }
    
    return self;
}

- (void)prepareArray:(int)n {
    int delta = n - steps.count + 1;
    if (delta > 0) {
        for (int i = 0; i < delta; i++) {
            [steps addObject:@0];
        }
    }
}

- (long)countPossibleWays:(int) n {
    [self prepareArray:n];
    return [self countPossibleWaysRecursive:n];
}

- (long)countPossibleWaysRecursive:(int) n {
    if (n < 0) {
        return 0;
    } else if (n == 0) {
        return [steps[n] longValue];
    }
    
    long steps1 = [self countPossibleWaysRecursive:n-1];
    long steps2 = [self countPossibleWaysRecursive:n-2];
    long steps3 = [self countPossibleWaysRecursive:n-3];
    
    long result = steps1 + steps2 + steps3;
    
   steps[n] = @(result);
    
    return  result;
    
}


//import java.util.List;
//import java.util.ArrayList;
//import java.util.Collections;
//import java.util.Comparator;
//
//public List<Meeting> mergeRanges(List<Meeting> meetings) {
//    
//    // sort by start times
//    List<Meeting> sortedMeetings = new ArrayList<Meeting>(meetings);
//    Collections.sort(sortedMeetings, new Comparator<Meeting>() {
//        public int compare(Meeting m1, Meeting m2)  {
//            return m1.startTime - m2.startTime;
//        }
//    });
//    
//    // initialize mergedMeetings with the earliest meeting
//    List<Meeting> mergedMeetings = new ArrayList<Meeting>();
//    mergedMeetings.add(sortedMeetings.get(0));
//    
//    for (Meeting currentMeeting : sortedMeetings) {
//        
//        Meeting lastMergedMeeting = mergedMeetings.get(mergedMeetings.size() - 1);
//        
//        // if the current and last meetings overlap, use the latest end time
//        if (currentMeeting.startTime <= lastMergedMeeting.endTime) {
//            lastMergedMeeting.endTime = Math.max(lastMergedMeeting.endTime, currentMeeting.endTime);
//            
//            // add the current meeting since it doesn't overlap
//        } else {
//            mergedMeetings.add(currentMeeting);
//        }
//    }
//    
//    return mergedMeetings;
//}


+ (int)checkPossibilities:(int)num with:(NSMutableArray *)values {
    if (num == 0) {
        return 1;
    } else if (num < 0) {
        return 0;
    }
    if (values.count == 0) {
        return 0;
    }
    
//    NSLog(@"checking %d with values:%@", num, values);
    
    int possiblities = 0;
    int value = [values[0] intValue];
    
    NSMutableArray *restCoins = [values mutableCopy];
    [restCoins removeObject:restCoins.firstObject];
    
    while (num >= 0) {
        int delta = [self checkPossibilities:num with:restCoins];
//        NSLog(@"adding %d checking %d with values:%@ from %d", delta, initNum, values, num);
        possiblities += delta;
        num -= value;
    }
    
    return possiblities;
}

+ (int) changePossibilitiesBottomUp:(int) amount with:(NSMutableArray<NSNumber *> *)denominations {
    NSMutableArray *waysOfDoingNCents = [NSMutableArray arrayWithCapacity:amount+1];
    for (int i = 0; i < amount+1; i++) {
        [waysOfDoingNCents addObject:@0];
    }
    
    waysOfDoingNCents[0] = @1;
    
    for (NSNumber *coin in denominations) {
        for (int higherAmount = [coin intValue]; higherAmount < amount + 1; higherAmount++) {
            int higherAmountRemainder = higherAmount - [coin intValue];
            waysOfDoingNCents[higherAmount] = @([waysOfDoingNCents[higherAmount] intValue] + [waysOfDoingNCents[higherAmountRemainder] intValue]);
//            NSLog(@"inner %@", waysOfDoingNCents);
        }
        NSLog(@"%@", waysOfDoingNCents);
    }
    
    return [waysOfDoingNCents[amount] intValue];
}


//Given string say ABCGRETCABCG and substring length let us take length as 3, find the count of possible substrings, for example in above string ABC => 2 and BCG => 2 , where CGR and other 3 word length substrings has a count of 1.
+ (NSDictionary *)findAllSubstringCount:(NSString *)string length:(int)length {
    NSMutableDictionary *result = [NSMutableDictionary new];
    for (int i = 0; i + length <= string.length; i++) {
        NSString *subst = [string substringWithRange:NSMakeRange(i, length)];
        NSNumber *count = result[subst];
        if (count) {
            result[subst] = @(count.intValue + 1);
        } else {
            result[subst] = @(1);
        }
    }
    
    return result;
}


//Given a set of numbers find if a triplet can form a triangle a+b > c , b+c > a and c+a > b. The result to display all possible combinations of triplets. [ 10 5 3 4 7 1] [5,3,4 ] is one possible triplet and there can be many more.
+ (NSArray *)findAllTriples:(NSArray *)array {
    NSArray *sortedArray = [array sortedArrayUsingSelector:@selector(compare:)];
    
    NSMutableArray *result = [NSMutableArray new];
    
    for (int i = 0; i + 2 < sortedArray.count; i++) {
        NSNumber *a = sortedArray[i];
        
        for (int j = i + 1; j + 1 < sortedArray.count; j++) {
            NSNumber *b = sortedArray[j];
            for (int k = j + 1; k < sortedArray.count; k++) {
                NSNumber *c = sortedArray[k];
                
                if (a.intValue + b.intValue > c.intValue) {
                    [result addObject:@[a, b, c]];
                } else {
                    break;
                }
            }
        }
        
        
    }
    
    return result;
    
}

//50 + ((1 + 2) × 4) − 3
//50 1 2 + 4 × + 3 −
+ (float)calcRPN:(NSString *)rpn {
    
    //validate empty; nil
    
    EKStack *stack = [EKStack new];
    
    char prevChar = 'a';
    for (int i = 0; i < rpn.length; i++) {
        char c = [rpn characterAtIndex:i];
        switch (c) {
            case '*': {
                long a = [[stack popLastObject] floatValue];
                long b = [[stack popLastObject] floatValue];
                [stack push:@(a*b)];
            }
                break;
            case '+': {
                long a = [[stack popLastObject] floatValue];
                long b = [[stack popLastObject] floatValue];
                [stack push:@(a+b)];
            }
                break;
            case '-': {
                long a = [[stack popLastObject] floatValue];
                long b = [[stack popLastObject] floatValue];
                [stack push:@(b-a)];
            }
                break;
            case '/': {
                long a = [[stack popLastObject] floatValue];
                long b = [[stack popLastObject] floatValue];
                [stack push:@(b/a)];
            }
                break;
            case '^': {
                long a = [[stack popLastObject] floatValue];
                long b = [[stack popLastObject] floatValue];
                [stack push:@(pow(a, b))];
            }
                break;
            case'0':
            case'1':
            case'2':
            case'3':
            case'4':
            case'5':
            case'7':
            case'8':
            case'9': {
                if (prevChar - '0' < 10 && prevChar - '0' >= 0) {
                    long a = [[stack popLastObject] floatValue];
                    [stack push:@(a * 10 + c - '0')];
                } else {
                    [stack push:@(c - '0')];
                }
            }
                break;
            case' ':
                break;
                
            default:
                @throw [NSException exceptionWithName:@"invalid format" reason:@"" userInfo:nil];
        }
        prevChar = c;
        
    }
    
    float result = [[stack popLastObject] floatValue];
    return result;
    
    
    
}


//0 1 2 3 4  5
//1 4 7 9 10 14
//
//4 5 6 7 9 11 14
//0 1 2 3 4 5  6

+ (NSDictionary *)collaps:(NSArray *)left with:(NSArray *)right {
    //validate nils
    int leftIdx = 0;
    int rightIdx = 0;
    NSMutableArray *intersection = [NSMutableArray new];
    NSMutableArray *unionArr = [NSMutableArray new];
    
    while (leftIdx < left.count || rightIdx < right.count) {
        //check out of bounds!
        
        int leftVal;
        if (leftIdx != left.count) {
            leftVal = [left[leftIdx] intValue];
        } else {
            [unionArr addObjectsFromArray:[right subarrayWithRange:NSMakeRange(rightIdx, left.count - leftVal)]];
            break;
        }
        
        int rightVal;
        if (rightIdx != right.count) {
            rightVal = [right[rightIdx] intValue];
        } else {
            
            [unionArr addObjectsFromArray:[left subarrayWithRange:NSMakeRange(leftIdx, left.count - leftVal)]];
            break;
        }
        
        
        if (leftVal == rightVal) {
            [intersection addObject:@(leftVal)];
            [unionArr addObject:@(leftVal)];
            leftIdx++;
            rightIdx++;
        } else if (leftVal < rightVal) {
            leftIdx++;
            [unionArr addObject:@(leftVal)];
        } else {
            rightIdx++;
            [unionArr addObject:@(rightVal)];
        }
        
    }
    
    return @{@"union":unionArr, @"intersaction":intersection};
    
}

@end
