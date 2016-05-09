//
//  Algorithms.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/8/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "Algorithms.h"
#import "EKTreeNode.h"
#import "EKVertex.h"
#import "EKStack.h"
#import "EKEdge.h"
#import "EKQueue.h"


@implementation Algorithms

#pragma mark binary search recursive

//helper
+ (int)binarySearchRecursive:(NSArray *)array x:(int)x {
    return [self binarySearchRecursive:array x:x low:0 high:array.count - 1];
}

+ (int)binarySearchRecursive:(NSArray *)array x:(int)x low:(int)low high:(int)high {
    if (low> high) {
        return -1; // Error
    }
    int mid = (low+ high) / 2;
    
    if ([array[mid] intValue] < x) {
        return [self binarySearchRecursive:array x:x low:mid + 1 high:high];
    } else if ([array[mid] intValue] > x) {
        return [self binarySearchRecursive:array x:x low:low high:mid - 1];
    } else {
        return mid;
    }
    
}

#pragma mark binary search linear
+ (int)binarySearch:(NSArray *)array x:(int)x {
    int low = 0;
    int high = array.count - 1;
    int mid;
    while (low <= high) {
        mid = (low + high) / 2;
        if ([array[mid] intValue] < x) {
            
            low = mid + 1;
            
        } else if ([array[mid] intValue] > x) {
            high = mid - 1;
        } else {
            return mid;
        }
    }
    return -1; // Error
}

#pragma mark merge sort operation
//helper
+ (void)mergeSort:(NSMutableArray *)array {
    NSMutableArray *helper = [NSMutableArray arrayWithCapacity:array.count];
    for (NSInteger i = 0; i < helper.count; i++) {
        [helper addObject:[NSNull null]];
    }
    [self mergeSort:array withHelper:helper low:0 high:array.count - 1];
    
}

+ (void)mergeSort:(NSMutableArray *)array withHelper:(NSMutableArray *)helper low:(int)low high:(int)high {
    if (low < high) {
        int middle = (low + high) / 2;
        [self mergeSort:array withHelper:helper low:low high:middle];
        [self mergeSort:array withHelper:helper low:middle + 1 high:high];
        [self merge:array withHelper:helper low:low middle:middle high:high];
    }
}

+ (void)merge:(NSMutableArray *)array withHelper:(NSMutableArray *)helper low:(int)low middle:(int)middle high:(int)high {
    /* Copy both halves into a helper array */
    for (int i = low; i <= high; i++) {
        helper[i] = array[i];
    }
    
    int helperLeft = low;
    int helperRight = middle + 1;
    int current = low;
    
    
    /* Iterate through helper array. Compare the left and right 
     * half, copying back the smaller element from the two halves 
     * into the original array. */
    while (helperLeft <= middle && helperRight <= high) {
        if (helper[helperLeft] <= helper[helperRight]) {
            array[current] = helper[helperLeft];
            helperLeft++;
        } else {
            // If right element is smaller than left element
            array[current] = helper[helperRight];
            helperRight++;
        }
        current++;
    }
    /* Copy the rest of the left side of the array into the * target array */
    int remaining = middle - helperLeft;
    for (int i = 0; i <= remaining; i++) {
        array[current + i] = helper[helperLeft + i];
    }
}

#pragma mark quick sort
//helper
+ (void)quickSort:(NSMutableArray *)array {
    [self quickSort:array left:0 right:array.count - 1];
}

+ (void)quickSort:(NSMutableArray *)array left:(int)left right:(int)right {
    int index = [self partition:array left:left right:right];
    if (left < index - 1){
        // Sort left half
        [self quickSort:array left:left right:index - 1];
    }
    if (index < right) {
        // Sort right half
        [self quickSort:array left:index right:right];
        
    }
}

+ (int)partition:(NSMutableArray *)array left:(int)left right:(int)right {
    int pivot = [array[(left + right) / 2] intValue]; // Pick pivot point
    while (left <= right) {
        // Find element on left that should be on right
        while ([array[left] intValue] < pivot) {
            left++;
        }
        
        // Find element on right that should be on left
        while ([array[right] intValue] > pivot) {
            right--;
        }
        // Swap elements, and move left and right indices
        if (left <= right) {
            [array exchangeObjectAtIndex:left withObjectAtIndex:right];
            left++;
            right--;
        }
    }
    return left;
    
}

#pragma mark rotation
+ (void)rotateArray:(NSArray *)array times:(int)n {
    
}

- (void)reverse:(NSMutableArray *)array {
    NSUInteger count = array.count;
    
    for (int i = 0; i < count / 2; i++) {
        [array exchangeObjectAtIndex:i withObjectAtIndex:(count - 1 - i)];
    }
    
}

- (void)shuffle:(NSMutableArray *)array {
    NSUInteger i = array.count;
    
    while (i) {
        NSUInteger randomIndex = arc4random_uniform((u_int32_t)i);
        [array exchangeObjectAtIndex:randomIndex withObjectAtIndex:--i];
    }
}

- (void)shuffleInteratively:(NSMutableArray *)array {
    for (int i = 0; i < array.count; i++) {
        int k = arc4random_uniform(i);
        [array exchangeObjectAtIndex:i withObjectAtIndex:k];
    }
}

#pragma mark DFS implementation
- (void)searchDFS:(EKVertex *)root {
    
//    root.label = @"Start vertex";
    root.wasVisited = YES;
//    [self displayVisitedVertex:root];
    
    EKStack *stack = [[EKStack alloc] init];
    [stack push:root];
    
    while (![stack isEmpty]) {
        EKVertex *lastVertex = [stack peek];
        BOOL isAddNewVertex = NO;
        
        for (EKEdge *adjacentEdge in lastVertex.adjacentEdges) {
            if (!adjacentEdge.adjacentTo.wasVisited) {
                [stack push:adjacentEdge.adjacentTo];
                adjacentEdge.adjacentTo.wasVisited = YES;
                isAddNewVertex = YES;
//                [self displayVisitedVertex:adjacentEdge.adjacentTo];
                break;
            }
        }
        if (!isAddNewVertex) {
            [stack popLastObject];
        }
    }
    
//    [self clearVisitHistory];
}

- (void)searchDFS_Recursive:(EKVertex *)root {
    if (!root) {
        return;
    }
    
    root.wasVisited = YES;
//    [self displayVisitedVertex:root];
    
    for (EKEdge *adjacentEdge in root.adjacentEdges) {
        if (!adjacentEdge.adjacentTo.wasVisited) {
            [self searchDFS_Recursive:adjacentEdge.adjacentTo];
        }
    }
//    [self clearVisitHistory];
}

#pragma mark BFS implementation

- (void)breadthFirstSearch:(EKVertex *)root
{
//    NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
    root.label = @"Start vertex";
    root.wasVisited = YES;
//    [self displayVisitedVertex:self.firstVertex];
    
    EKQueue *queue = [[EKQueue alloc] init];
    [queue insertObject:root];
    
    while (![queue isEmpty]) {
        EKVertex *foo = [queue removeFirstObject];
        for (EKEdge *adjacentEdge in foo.adjacentEdges) {
            if (!adjacentEdge.adjacentTo.wasVisited) {
                [queue insertObject:adjacentEdge.adjacentTo];
                adjacentEdge.adjacentTo.wasVisited = YES;
//                [self displayVisitedVertex:adjacentEdge.adjacentTo];
            }
        }
    }
    
//    [self clearVisitHistory];
}

#pragma mark bit manipulation

// x ^ 0s = x
// x ^ 1s = ~x
// x ^ x  = 0

// 1 -> 0; 0 -> 1
-(int)flipBit:(int)num {
    return 1 ^ num;
}

-(BOOL)getBit:(int)num idx:(int)i {
    return ((num & (1 << i)) != 0);
}

//sets i'th bit to 1
-(int)setBit:(int)num idx:(int)i {
    return num | (1 << i);
}

-(int)clearBit:(int)num idx:(int)i {
    int mask = ~(1 << i);
    return num & mask;
}

//To clear allbits from the most significant bit through i (inclusive)
// 10110, 2 -> 00010
-(int)clearBitsMSBthroughI:(int)num idx:(int)i {
    int mask = (1 << i) - 1;
    return num & mask;
}
//To clear all bits from i through 0(inclusive)
// 10110, 2 -> 10100
//mask = ~(11)=1..111100
-(int)clearBitsIthrough0:(int)num idx:(int)i {
    int mask = ~((1 << (i + 1)) - 1);
    return num & mask;
}

// 111, 1, 0 -> 101
-(int)updateBit:(int)num idx:(int)i toValue:(int)v {
    int mask = ~(1 << i);
    return (num & mask) | (v << i);
}

#pragma mark probability

//  A & B
//P(A and B) = P(B given A) P(A)

//  A | B
//P(A or B) = P(A) + P(B) - P(A and B)

//Independence A & B
//P(A and B) = P(B) P(A)

//Independence A | B
//P(A or B) = P(A) + P(B)

#pragma mark design patterns

//singleton
static id _instance = nil;
+ (instancetype)getInstance {
    if (!_instance) {
        _instance = [[Algorithms alloc] init];
    }
    
    return _instance;
}

//factory
+ (instancetype)createInstance:(int)type {
    if (type == 0) {
        return [[Algorithms alloc] init]; //[Algorithms1 new];
    } else if (type == 1){
        return [[Algorithms alloc] init]; //[Algorithms2 new];
    }
    
    return nil;
}

//#pragma mark HashTable implementation
//http://ciechanowski.me/blog/2014/04/08/exposing-nsdictionary/
//- (id)objectForKey:(id)aKey
//{
//    NSUInteger sizeIndex = _szidx;
//    NSUInteger size = __NSDictionarySizes[sizeIndex];
//
//    id *storage = (id *)object_getIndexedIvars(dict);
//
//    NSUInteger fetchIndex = [aKey hash] % size;
//
//    for (int i = 0; i < size; i++) {
//        id fetchedKey = storage[2 * fetchIndex];
//
//        if (fetchedKey == nil) {
//            return nil;
//        }
//
//        if (fetchedKey == aKey || [fetchedKey isEqual:aKey]) {
//            return storage[2 * fetchIndex + 1];
//        }
//
//        fetchIndex++;
//
//        if (fetchIndex == size) {
//            fetchIndex = 0;
//        }
//    }
//
//    return nil;
//}

@end
