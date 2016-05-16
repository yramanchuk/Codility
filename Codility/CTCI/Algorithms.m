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
#import "EKBTreeNode.h"
#import "EKLinkedList.h"
#import "EKNode.h"

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


+ (void) mergesortNonRecursive:(NSMutableArray *)array
{
    NSMutableArray *temp = [NSMutableArray new];
    int arraySize = array.count;
    
    int rght, rend;
    int i,j,m;
    
    for (int k=1; k < arraySize; k *= 2 ) {
        for (int left=0; left+k < arraySize; left += k*2 ) {
            rght = left + k;
            rend = rght + k;
            if (rend > arraySize) rend = arraySize;
            m = left; i = left; j = rght;
            while (i < rght && j < rend) {
                if (array[i] <= array[j]) {
                    temp[m] = array[i]; i++;
                } else {
                    temp[m] = array[j]; j++;
                }
                m++;
            }
            while (i < rght) {
                temp[m]=array[i];
                i++; m++;
            }
            while (j < rend) {
                temp[m]=array[j];
                j++; m++;
            }
            for (m=left; m < rend; m++) {
                array[m] = temp[m];
            }
        }
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

#pragma mark dynamic programming
//     1 2 4 1 2 2 3 3
//
//3    0 0 0 0 0 0 1 1
//3    0 0 0 0 0 0 1 2
//2    0 1 1 1 1 1 1 2
//2    0 1 1 1 2 2 2 2
//1    1 1 1 2 2 2 2 2
//4    1 1 2 2 2 2 2 2
//2    1 2 2 2 3 3 3 3
//1    1 2 2 3 3 3 3 3
//
//1 2 1
+ (int)longestCommonSubstring:(NSString *)str1 with:(NSString *)str2
{
    if (str1.length == 0 || str2.length == 0)
        return 0;
    
    NSMutableArray *num = [NSMutableArray new];
    for (int i = 0; i <= str1.length; i++) {
        NSMutableArray *inner = [NSMutableArray new];
        [num addObject:inner];
        for (int j = 0; j <= str2.length; j++) {
            [inner addObject:@(0)];
        }
    }
    
    int maxlen = 0;
    
    for (int row = 0; row < str1.length; row++) {
        for (int col = 0; col < str2.length; col++) {
            if ([str1 characterAtIndex:row] == [str2 characterAtIndex:col]) {
                //take up and left + 1
                int newValue = [num[row][col] intValue] + 1;
                num[row + 1][col + 1] = @(newValue);
                
                //increase longest string
                maxlen = fmax(maxlen, newValue);
                
            } else if ([num[row][col + 1] intValue] >= [num[row + 1][col] intValue]) {
                //take up
                num[row + 1][col + 1] = @([num[row][col + 1] intValue]);
            } else {
                //take left
                num[row + 1][col + 1] = @([num[row + 1][col] intValue]);
            }
        }
    }
    
    return maxlen;
}

//quarters (25 cents), dimes (10 cents), nickels (5 cents) and pennies (1 cent)
//makeChange(100 using 0 quarters) =
//    makeChange(100 using 0 quarters, 0 dimes) +
//    makeChange(100 using 0 quarters, 1 dime) +
//    makeChange(l00 using 0 quarters, 2 dimes) +
//    ...
//    makeChange(100 using 0 quarters, 10 dimes)
//
//makeChange(75 using 0 quarters) =
//    makeChange(75 using 0 quarters, 0 dimes) +
//    makeChange(75 using 0 quarters, 1 dime) +
//    makeChange(75 using 0 quarters, 2 dimes) +
//    ...
//    makeChange(75 using 0 quarters, 7 dimes)
//
//makeChange(50 using 0 quarters) =
//    makeChange(50 using 0 quarters, 0 dimes) +
//    makeChange(50 using 0 quarters, 1 dime) +
//    makeChange(50 using 0 quarters, 2 dimes) +
//    ...
//    makeChange(50 using 0 quarters, 5 dimes)
//
//makeChange(25 using 0 quarters) =
//    makeChange(25 using 0 quarters, 0 dimes) +
//    makeChange(25using0quarters,1dime) +
//    makeChange(25 using 0 quarters, 2 dimes

+ (int)checkPossibilities:(int)num with:(NSMutableArray *)values {
    if (num == 0) {
        return 1;
    } else if (num < 0) {
        return 0;
    }
    if (values.count == 0) {
        return 0;
    }
    
    
    int possiblities = 0;
    int value = [values[0] intValue];
    
    NSMutableArray *restCoins = [values mutableCopy];
    [restCoins removeObject:restCoins.firstObject];
    
    while (num >= 0) {
        possiblities += [self checkPossibilities:num with:restCoins];;
        num -= value;
    }
    return possiblities;
}

#pragma mark bit manipulation

// x ^ 0s = x
// x ^ 1s = ~x -> num ^ (((long)1 << 32) - 1)
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


#pragma mark Trees

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

#pragma mark find node BFS
- (EKBTreeNode *)find:(NSObject *)object fromRoot:(EKBTreeNode *)root
{
    EKQueue *queue = [[EKQueue alloc] init];
    [queue insertObject:root];
    EKBTreeNode *node;
    while (![queue isEmpty]) {
        node = [queue removeFirstObject];
        if ([node.object isEqual:object]) {
            return node;
        }
        if (node.leftChild) {
            [queue insertObject:node.leftChild];
        }
        if (node.rightChild) {
            [queue insertObject:node.rightChild];
        }
    }
    return nil;
}

- (NSArray *)bfsWithLinkedList:(EKBTreeNode *)root {
    EKLinkedList *current = [EKLinkedList new];
    NSMutableArray *result = [NSMutableArray new];
    [current addToBack:root];
    
    while (current.count > 0) {
        [result addObject:current];
        EKLinkedList *parents = current;
        
        current = [EKLinkedList new];
        
        for (EKBTreeNode *node in parents) {
            if (node.leftChild) {
                [current addToBack:node.leftChild];
            }
            if (node.rightChild) {
                [current addToBack:node.rightChild];
            }
        }
    }
    
    return result;

}


#pragma mark create minimal depth BST from sorted array

+ (EKBTreeNode *)createMinimalBST:(NSMutableArray *)arr {
    return [self createMinimalBST:arr start:0 end:arr.count - 1];
}

+ (EKBTreeNode *)createMinimalBST:(NSMutableArray *)arr start:(int)start end:(int)end {
    if (end< start) {
        return nil;
    }
    
    int mid = (start + end) / 2;
    EKBTreeNode *n = [EKBTreeNode new];
    n.object = arr[mid];
    
    n.leftChild = [self createMinimalBST:arr start:start end:mid - 1];
    n.rightChild = [self createMinimalBST:arr start:mid + 1 end:end];
    return n;
}

#pragma mark Tree traversal

- (void)levelOrderTraversal:(EKBTreeNode *)root
{
    if (root) {
        EKQueue *queue = [[EKQueue alloc] init];
        [queue insertObject:root];
        while (![queue isEmpty]) {
            EKBTreeNode *currentNode = [queue removeFirstObject];
            if (currentNode.leftChild) {
                [queue insertObject:currentNode.leftChild];
            }
            if (currentNode.rightChild) {
                [queue insertObject:currentNode.rightChild];
            }
            NSLog(@"%@", currentNode.object);
        }
    }
}

+ (void)preOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        NSLog(@"%@",node.object);
        [self preOrderTraversalRecursive:node.leftChild];
        [self preOrderTraversalRecursive:node.rightChild];
    }
}

+ (void)inOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        [self inOrderTraversalRecursive:node.leftChild];
        NSLog(@"%@",node.object);
        [self inOrderTraversalRecursive:node.rightChild];
    }
}

+ (void)postOrderTraversalRecursive:(EKBTreeNode *)node
{
    if (node) {
        [self postOrderTraversalRecursive:node.leftChild];
        [self postOrderTraversalRecursive:node.rightChild];
        NSLog(@"%@",node.object);
    }
}


#pragma mark tree mirroring
+ (EKTreeNode *)mirror:(EKTreeNode *)input {
    if (!input) {
        return nil;
    }
    
//    if (input.visited) {
//        return input;
//    }
    
    EKTreeNode *result = [EKTreeNode new];
    result.object = input.object;
//    [input setVisited];
    
    result.sibling = [self mirror: input.child];
    result.child = [self mirror: input.sibling];
    
    return result;
}

+ (void)mirrorMutated:(EKTreeNode *)input {
    if (!input) {
        return;
    }
    
    //    if (input.visited) {
    //        return input;
    //    }
    
    //    [input setVisited];

    
    [self mirror: input.child];
    [self mirror: input.sibling];
    EKTreeNode *temp = input.child;
    input.child = input.sibling;
    input.sibling = temp;
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

+ (BOOL)isLucky:(int)n {
    
    int ith = 2;
    int next_pos = n;
    
    while(next_pos >= ith){
        if(next_pos%ith == 0){
            return false;
        }
        
        next_pos -= (next_pos)/ith;
        ith++;
    }
    
    return YES;

//    //correct too
//    int pos = n;
//    int del = 2;
//    while( pos >= del ){
//        if( pos%del == 0 )
//            return false;
//        pos = pos - pos/del;
//        del++;
//    }
//    return true;
}


//observe pow as a binary number. I don't do Java, so I'll just sketch this in C, which is quite like it.
//So, you are observing x, x2, x4, x8,... and multiplying with them if the corresponding binary digit of pow is equal to 1.
//5ˆ7 = 5ˆ(1+2+4)=5ˆ(2ˆ0+2ˆ1+2ˆ2)
+ (double)pow:(int)x to:(int)pow {
    if (pow == 0) {
        return 1;
    }
    
    BOOL isPositive = pow > 0;
    pow = isPositive ? pow : -pow;
    
    double px = x; // current power of x
    double result = 1;
    while (pow > 0) {
        if (pow % 2 != 0) {
            result *= px;
        }
        pow /= 2;
        px *= px;
    }

    return isPositive ? result : 1 / result;

}

#pragma mark Linked list operations

/* Function to reverse the linked list */
+ (EKNode *) reverseLinkedList:(EKNode *) node {
    EKNode *prev = nil;
    EKNode *current = node;
    EKNode *next = nil;
    while (current != nil) {
        next = current.next;
        current.next = prev;
        prev = current;
        current = next;
    }
    node = prev;
    return node;
}


@end
