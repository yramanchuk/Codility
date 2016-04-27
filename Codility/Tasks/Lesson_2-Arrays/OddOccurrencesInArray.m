//
//  OddOccurrencesInArray.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "OddOccurrencesInArray.h"

@implementation OddOccurrencesInArray

+ (int)solution:(NSMutableArray *)A {
    
////    NSArray *result = [A sortedArrayUsingDescriptors:@[[NSSortDescriptor sortDescriptorWithKey:@"intValue" ascending:YES]]];
//   
////    NSArray *result = quickSort(A);
//    
//    [A sortUsingSelector:@selector(compare:)];
//    NSMutableArray *result = A;
//    
//    int prevValue = [result[0] intValue];
//    int resultVal = [result[result.count - 1] intValue];
//    int count = 1;
//    
//    for (int i = 1; i < result.count; i++) {
//        int value = [result[i] intValue];
//
//        
//        if (value == prevValue) {
//            count ++;
//        } else {
//
//            if (count % 2 != 0 ) {
//                
//                
//                resultVal = prevValue;
//                
//                break;
//            } else {
//                count = 1;
//            }
//        }
//        prevValue = value;
//    }
    
    int resultVal = 0;
    for (NSNumber *value in A) {
        resultVal ^= [value intValue];
    }

    
    NSLog(@"result %d", resultVal);
    
    return resultVal;
    
}

//static NSArray * quickSort(NSMutableArray *unsortedDataArray)
////+ (NSArray *)quickSort:(NSMutableArray *)unsortedDataArray
//{
//    
//    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
//    NSMutableArray *greaterArray =[[NSMutableArray alloc] init];
//    if ([unsortedDataArray count] <1)
//    {
//        return nil;
//    }
//    int randomPivotPoint = [unsortedDataArray count] / 2; //arc4random() % [unsortedDataArray count];
//    NSNumber *pivotValue = [unsortedDataArray objectAtIndex:randomPivotPoint];
//    [unsortedDataArray removeObjectAtIndex:randomPivotPoint];
//    for (NSNumber *num in unsortedDataArray)
//    {
////        quickSortCount++; //This is required to see how many iterations does it take to sort the array using quick sort
//        if (num < pivotValue)
//        {
//            [lessArray addObject:num];
//        }
//        else
//        {
//            [greaterArray addObject:num];
//        }
//    }
//    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
//    [sortedArray addObjectsFromArray:quickSort(lessArray)];
//    [sortedArray addObject:pivotValue];
//    [sortedArray addObjectsFromArray:quickSort(greaterArray)];
//    return sortedArray;
//}

@end

