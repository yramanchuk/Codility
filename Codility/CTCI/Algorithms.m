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


//+ (void)mergeSort2:(NSMutableArray *)array {
//    NSMutableArray *helper = [array mutableCopy];
//    
//    [self mergeSort2:array helper:helper start:0 end:array.count-1];
//}
//
//+ (void)mergeSort2:(NSMutableArray *)array helper:(NSMutableArray *)helper start:(int)start end:(int)end {
//    if (start < end) {
//        int mid = (start + end) /2 ;
//        [self mergeSort2:array helper:helper start:start end:mid];
//        [self mergeSort2:array helper:helper start:mid+1 end:end];
//        
//        [self merge2:array helper:helper start:start mid:mid end:end];
//        
//    }
//    
//}
//
//+ (void)merge2:(NSMutableArray *)array helper:(NSMutableArray *)helper start:(int)start mid:(int)mid end:(int)end {
//    //copy helper
//    for (int i = start; i<=end; i++) {
//        helper[i] = array[i];
//    }
//    
//    int left = start;
//    int curr = start;
//    int rght = mid+1;
//    
//    while (left <= mid && rght <= end) {
//        if (helper[left] <= helper[rght]) {
//            array[curr] = helper[left];
//            left++;
//        } else {
//            array[curr] = helper[rght];
//            rght++;
//        }
//        curr++;
//    }
//    
//    for (int i=0; i <= mid - left; i++) {
//        array[curr+i] = helper[left+i];
//    }
//    
//}

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
    NSLog(@"pivot %d", pivot);
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
            NSLog(@"%@", [array componentsJoinedByString:@" "]);
            left++;
            right--;
        }
    }
    NSLog(@"final %@", [array componentsJoinedByString:@" "]);
    return left;
    
}

//http://www.geeksforgeeks.org/kth-smallestlargest-element-unsorted-array/
+ (int)findKthLargestElement:(NSMutableArray *)array k:(int)k left:(int)left right:(int)right {
    if (k > 0 && k <= right - left + 1) {
        int pivot = [self randomPartition:array left:left right:right];
        if (left + k - pivot - 1 == 0) {
            return [array[pivot] intValue];
        } else if (left + k - pivot - 1 < 0) {
            return [self findKthLargestElement:array k:k left:left right:pivot - 1];
        }
        return [self findKthLargestElement:array k:left + k - pivot - 1 left:pivot + 1 right:right];

    }
    return -1;
    
}

+ (int)randomPartition:(NSMutableArray *)array left:(int)left right:(int)right {
    int random = arc4random()%(right - left + 1);
    [array exchangeObjectAtIndex:left + random withObjectAtIndex:right];
    
    int pivot = [array[right] intValue];
    int index = left;
    
    for (int j = left; j <= right - 1; j++) {
        if ([array[j] intValue] >= pivot) {
            [array exchangeObjectAtIndex:j withObjectAtIndex:index];
            index++;
        }
    }
    [array exchangeObjectAtIndex:right withObjectAtIndex:index];
    return index;
}




#pragma mark rotation
+ (NSArray *)rotateArray:(NSArray *)array times:(int)n {
    NSMutableArray *ret = [NSMutableArray new];
    for (int i = 0; i < array.count; i++) {
        [ret addObject:array[(i + n) % array.count]];
    }
    return ret;
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

- (NSInteger) countAndRearrangeNonZeroElementsFromThisArray: (NSMutableArray*) array {
    int lastIndexOfZero = -1;
    int countZeros = 0;
    
    //iterate over all array to detect zeroes
    for (int index = 0; index < array.count; index++) {
        if ([array[index] intValue] == 0) {
            countZeros++;
            //if first zero found -> store it's value
            if (lastIndexOfZero == -1) {
                lastIndexOfZero = index;
            } else {
                //find minimal index of zero
                lastIndexOfZero = fmin(lastIndexOfZero, index);
            }
        } else if (lastIndexOfZero != -1) {
            //exchange with non-zero
            [array exchangeObjectAtIndex:index withObjectAtIndex:lastIndexOfZero];
            
            //next element is either zero or already swapped element
            lastIndexOfZero = lastIndexOfZero+1;
        }
    }
    
    return countZeros;
}

#pragma mark dynamic programming

//    0123456789
//    aaabcadcbc
//       bcad
+ (NSString *)longestUniqueSubstring:(NSString *)string {
    
    if (string.length == 1) {
        return string;
    }
    
    NSMutableArray *positions = [NSMutableArray arrayWithCapacity:256];
    for (int i = 0; i < 256; i++) {
        [positions addObject:@(-1)];
    }
    
    
    int character = (int)[string characterAtIndex:0];
    
    /* Mark first character as visited by storing the index
     of first   character in visited array. */
    positions[character] = @0;
    int maxLength = 1;
    int maxStartPos = 0;
    int currentLength = maxLength;
    
    /* Start from the second character. First character is
     already processed (cur_len and max_len are initialized
     as 1, and visited[str[0]] is set */
    for (int index = 1; index < string.length; index++) {
        character = (int)[string characterAtIndex:index];
        int charPosition = [positions[character] intValue];
        
        /* If the currentt character is not present in the
         already processed substring or it is not part of
         the current NRCS, then do cur_len++ */
        if (charPosition == -1 || index - currentLength > charPosition) {
            currentLength++;
        } else {
            
            if (maxLength < currentLength) {
                maxLength = currentLength;
                maxStartPos = index - currentLength;
            }
            
            currentLength = index - charPosition;
        }

        positions[character] = @(index);
    }
    
    if (maxLength < currentLength) {
        maxLength = currentLength;
        maxStartPos = string.length - currentLength;
    }
    
    return [string substringWithRange:NSMakeRange(maxStartPos, maxLength)];
    
}

////recursive LCS O(2^n)
///* Returns length of LCS for X[0..m-1], Y[0..n-1] */
//int lcs( char *X, char *Y, int m, int n )
//{
//    if (m == 0 || n == 0)
//        return 0;
//    if (X[m-1] == Y[n-1])
//        return 1 + lcs(X, Y, m-1, n-1);
//    else
//        return max(lcs(X, Y, m, n-1), lcs(X, Y, m-1, n));
//}

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
//the longest increasing subsequence of a sequence S is the longest common subsequence of S and T, where T is the result of sorting S


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

+ (int)checkChangePossibilities:(int)num with:(NSMutableArray *)values {
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
        possiblities += [self checkChangePossibilities:num with:restCoins];;
        num -= value;
    }
    return possiblities;
}

//    4:
//    1 1 1 1
//    1 1 2
//    1 2 1
//    1 3
//    2 1 1
//    2 2
//    3 1

+ (int)printChangePosiibilitesAll:(int)num using:(NSMutableArray *)array {
    int possiblities = 0;

    if (num == 0) {
        if(array.count != 1) {
            NSLog(@"%@", [array componentsJoinedByString:@" "]);
            possiblities = 1;
        }
    } else {
        for(int j = 1; j <= num; j++) {
            [array addObject:@(j)];
            possiblities += [self printChangePosiibilitesAll:num-j using:array];
            [array removeLastObject];
        }
    }
    
    return possiblities;
}



//    4:
//    1 1 1 1
//    1 1 2
//    1 3
//    2 2
+ (int)printChangePosiibilitesUnique:(int)num from:(int)start using:(NSMutableArray *)array {
    int possiblities = 0;
    
    if (num == 0) {
        if(array.count != 1) {
            NSLog(@"%@", [array componentsJoinedByString:@" "]);
            possiblities = 1;
        }
    } else {
        for(int j = start; j <= num; j++) {
            [array addObject:@(j)];
            possiblities += [self printChangePosiibilitesUnique:num-j from:j using:array];
            [array removeLastObject];
        }
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

int numSetBits(unsigned int A) {
    int ct=0;
    while(A)
    {
        if(0x1 & A)
            ct++;
        A = A>>1;
    }
    return ct;
}

-(int) numSetBits:(unsigned int) A {
    unsigned int testBit = 1;
    int indexOfBit = 0;
    int numOfBits = 0;
    while (testBit <= A && indexOfBit < 32) {
        //isBitSet(unsigned int A, int index)
        //return (A & (1 << index)) != 0
        
        if ((A & (1 << indexOfBit)) != 0) {
            numOfBits++;
        }
        indexOfBit++;
        testBit  = 1 << indexOfBit;
    }
    
    return numOfBits;
    
}

int greatestCommonDivisorWithNumber(int A, int B)
{
    if ( A==0 )
        return B;
    else
        return greatestCommonDivisorWithNumber( B%A, A );
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

//- (NSArray *)getListOfLevels:(TreeNode *)root {
//    
//    NSMutableArray *result = [NSMutableArray new];
//    
//    // create first level
//    NSMutableArray *current = [NSMutableArray new];
//    [current addObject:root];
//    
//    while (current.count > 0) {
//        
//        //save existing level
//        [result addObject:current];
//        
//        //retain existing level -> become parent level
//        NSMutableArray *parents = current;
//        
//        //container for new level
//        current = [NSMutableArray new];
//        
//        //add all children from previous parent level
//        for (TreeNode *node in parents) {
//            if (node.left) {
//                [current addObject:node.left];
//            }
//            if (node.right) {
//                [current addObject:node.right];
//            }
//        }
//    }
//    
//    return result;
//    
//}


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

/**
 * Definition for binary tree
 */
struct TreeNode {
    int val;
    struct TreeNode *left;
    struct TreeNode *right;
};

typedef struct TreeNode treenode;

treenode* treenode_new(int val) {
    treenode* node = (treenode *) malloc(sizeof(treenode));
    node->val = val;
    node->left = NULL;
    node->right = NULL;
    return node;
}

/**
 * @input A : Root pointer of the tree
 * @input B : Root pointer of the tree
 *
 * @Output Integer
 */
int compareTree(treenode* A, treenode* B) {
    return isEqualTree(A, B);
}
int isEqualTree(treenode* A, treenode* B) {
    
    if (!A && !B) {
        return 1;
    } else if (!A || !B) {
        return 0;
    }
    
    if (A->val != B->val) {
        return 0;
    }
    if (isEqualTree(A->left, B->left) == 0) {
        return 0;
    }
    
    if (isEqualTree(A->right, B->right) == 0) {
        return 0;
    }
    
    return 1;
}


treenode* flattenHelper(treenode* A, treenode* result) {
    
    if (!A) {
        return NULL;
    }
    
    treenode* node = treenode_new(A->val);
    result->right = node;
    
    if (A->left) {
        node = flattenHelper(A->left, node);
    }
    
    if (A->right) {
        node = flattenHelper(A->right, node);
    }
    
    
    return node;
}

treenode* flatten(treenode* A) {
    
    if (!A) {
        return NULL;
    }
    treenode* node = treenode_new(0);
    flattenHelper(A, node);
    
    return node->right;
}

//       1
//      / \
//     2   5
//    / \   \
//   3   4   6
//
//    INTO
//
//    1
//     \
//      2
//       \
//        3
//         \
//          4
//           \
//            5
//             \
//              6


treenode* flattenOptimal(treenode* A) {
    if(A== NULL)
        return NULL;
    if(A->left == NULL && A->right == NULL)
        return A;
    treenode *left = flatten(A->left);
    treenode *right = flatten(A->right);
    
    A->right = left;
    
    treenode *temp = left;
    while(temp != NULL && temp->right != NULL)
        temp = temp->right;
    if(temp != NULL)
        temp->right = right;
    else
        A->right = right;
    
    A->left = NULL;
    return A;
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

//        http://www.geeksforgeeks.org/lucky-numbers/
//        Take the set of integers
//        1,2,3,4,5,6,7,8,9,10,11,12,14,15,16,17,18,19,……
//
//        First, delete every second number, we get following reduced set.
//        1,3,5,7,9,11,13,15,17,19,…………
//
//        Now, delete every third number, we get
//        1, 3, 7, 9, 13, 15, 19,….….
//
//        Continue this process indefinitely……
//        Any number that does NOT get deleted due to above process is called “lucky”.
//
//        Therefore, set of lucky numbers is 1, 3, 7, 13,………
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
        if (pow & 1 /* pow % 2 != 0 */) {
            result *= px;
        }
        pow >>= 1; //pow /= 2;
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



//  Definition for singly-linked list.
  struct ListNode {
      int val;
      struct ListNode *next;
  };
 
  typedef struct ListNode listnode;
 
  listnode* listnode_new(int val) {
      listnode* node = (listnode *) malloc(sizeof(listnode));
      node->val = val;
      node->next = NULL;
      return node;
  }
 
/**
 * @input A : Head pointer of linked list
 *
 * @Output head pointer of list.
 */
listnode* detectCycle(listnode* A) {
    listnode* slow = A;
    listnode* fast = A;
    
    while (fast->next && fast->next->next) {
        fast = fast->next->next;
        slow = slow->next;
        
        if (fast->val == slow->val) {
            break;
        }
    }
    
    if (!fast->next || !fast->next->next) return NULL;
    slow = A;
    
    while (fast->val != slow->val) {
        fast = fast->next;
        slow = slow->next;
    }
    
    return slow;
    
    
}


listnode* deleteDuplicates(listnode* head) {

    listnode *origin = head;
    while (head) {
        while(head->next && head->val == head->next->val) {
            head->next = head->next->next;
        }
        head = head->next;
    }
    return origin;
    
}

//unwrap array
+ (NSArray *)unwrapArray:(NSObject *)array {
    
    if ([array isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *result = [NSMutableArray new];
        
        for (int i = 0; i < ((NSArray *)array).count; i++) {
            [result addObjectsFromArray:[self unwrapArray:((NSArray *)array)[i]]];
        }
        
        return result;
    } else {
        return @[array];
    }
    
}

//calc nested array
+ (int)calcNestedSum:(NSArray *)array {
    
    return [self calcNestedSum:array forLevel:1];
    
}

+ (int)calcNestedSum:(NSArray *)array forLevel:(int)level {
    
    int sum = 0;
    for (NSObject *value in array) {
        if ([value isKindOfClass:[NSArray class]]) {
            sum += [self calcNestedSum:(NSArray *)value forLevel:level+1];
        } else if ([value isKindOfClass:[NSNumber class]]) {
            sum += [(NSNumber *)value intValue] * level;
        }
    }
    
    return sum;
}


#pragma mark Prime numbers

+ (NSArray *)primeNumbersFromSieveEratosthenes:(NSUInteger)firstNPrimesCount
{
    NSUInteger maxNumber =  ceilf(log(log(firstNPrimesCount) * firstNPrimesCount) * firstNPrimesCount);
    NSArray *result = [self primeNumbersFromSieveEratosthenesWithMaxNumber:maxNumber];
    return [result subarrayWithRange:NSMakeRange(0, firstNPrimesCount)];
}

+ (NSArray *)primeNumbersFromSieveEratosthenesWithMaxNumber:(NSUInteger)maxNumber
{
    NSMutableArray *resultArray = [@[] mutableCopy];
    
    for (NSUInteger i = 0; i < maxNumber; i++) {
        resultArray[i] = @(i);
    }
    
    resultArray[1] = @0;
    
    for (NSUInteger prime = 2; prime <= sqrt(maxNumber); prime++) {
        if (resultArray[prime] != 0) {
            for (NSUInteger j = prime * prime; j < maxNumber; j += prime) {
                resultArray[j] = @0;
            }
        }
    }
    [resultArray removeObject:@0];
    
    return [resultArray copy];
}

//    https://careercup.com/question?id=5643607445864448
//    Given an array and a number, add it in such a way where array is [0,0,1] and number is 4 output will be [0,0,5]
//
//    Example 2 :
//    array is [1] and number is 9 output will be [1,0]
+ (void)sumArray:(NSMutableArray<NSNumber *> *)array with:(int)num {
    NSUInteger index = array.count - 1;
    array[index] = @([array[index] intValue] + num);

    while (array[index] > @9) {
        int digit = [array[index] intValue];
        array[index] = @(digit % 10);

        if (index == 0) {
            [array insertObject:@(digit / 10) atIndex:0];
        } else {
            index--;
            array[index] = @([array[index] intValue] + digit / 10);
            
        }
    }
}

//    https://careercup.com/question?id=5751343965798400
//    Given a set of numbers {x1, x2, x3, x4, ..., xN} (N>=3) a set of its pairwise sums is {x1+x2, x1+x3, x1+x4, x2+x3,x2+x4,x3+x4, ...,}. (That is s_k = x_i + x_j where i != j)
//    Restore a set of numbers given a set of its pairwise sums.
//    Note: you don't know given some k, to which i and j it refers, (i.e. input is given in undefined order)
//
//    Example:
//
//    S = {1, 5, 10, 100} (n elements)
//    P = {6, 11, 101, 15, 105, 110} (n * (n - 1) / 2 elements)
//    P = {x1+x2, x1+x3, x1+x4, x2+x3, x2+x4, x3+x4}
//
//   EXPLANATION
//    original size is: x * (x-1) = 2 * size
//     x^2 - x - 2 *Size = 0
//    D = sqrt(bˆ2 -4ac) = sqrt(1 + 8*size)
//    x = (-b +- D)/2a == (1 + D)/2
//
//    S[0] = P0 + P1 - P(4-1)
+(NSArray *)reconstructFromSum:(NSArray *)sums {
    int size = [self getOriginalSize:sums.count];
    NSMutableArray *result = [NSMutableArray arrayWithCapacity:size];
    int firstValue = ([sums[0] intValue] + [sums[1] intValue] - [sums[size-1] intValue]) / 2;
    [result addObject:@(firstValue)];
    for (int index = 0; index < size-1; index++) {
        int value = [sums[index] intValue] - firstValue;
        [result addObject:@(value)];
    }
    
    NSLog(@"%@", [result componentsJoinedByString:@" "]);
    
    return result;
    
}
+ (int)getOriginalSize:(int)size {
    return (powf(1 + 8 * size, .5f) + 1)/2;
}

//    Given a decimal number, write a function that returns its negabinary (i.e. negative 2-base) representation as a string.
//    (-2)^0 = 1
//    (-2)^1 = -2
//    (-2)^2 = 4
//    (-2)^3 = -8
//    (-2)^4 = 16
//    (-2)^5 = -32 and so on
//
//    i. e. for 2 = 1 * 4 + 1 * (-2) + 0 * 1 => 110
//    -15 = 1 * -32 + 1 * 16 + 0 * -8 + 0 * 4 + 0 * -2 + 1 * 1 => 110001
//
//    https://careercup.com/question?id=5728108897370112
//
//    It is very similar to transforming into 2-base but tricky case is when reminder is negative.
//    we just have to convert negative reminder into non-negative:
//    a=b*c + r, so if r <0 then we can do a=b*c + r +b-b=b*(c+1) + (r-b)
//    in our case b=-2
//
//    private static String negaBinary(int x) {
//        StringBuilder sb = new StringBuilder();
//        while (x != 0) {
//            int rem = x % -2;
//            x = x / -2;
//            if (rem < 0) {
//                rem += 2;
//                x += 1;
//            }
//            sb.append(rem);
//        }
//        return sb.reverse().toString();
//    }

- (id)convertedNumberWithBase:(int)base from:(NSNumber *)number
{
    if (fabs(base) != 2 && fabs(base) != 8 && fabs(base) != 10 && fabs(base) != 12 && fabs(base) != 16) {
        NSLog(@"Bad base - base must be 2, 8, 10, 12 or 16 only");
        base = 10;
    }
    
    const char baseDigits[16] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    long int numberToConvert = [number longValue];
    int convertedNumber[64];
    int nextDigit = 0, index = 0;
    id resultOfConvertion = nil;
    NSMutableString *resultString = [@"" mutableCopy];
    
    
    do {
        convertedNumber[index] = numberToConvert % base;
        numberToConvert = numberToConvert / base;
        
        if (convertedNumber[index] < 0) {
            convertedNumber[index] -= base;
            numberToConvert += 1;
        }
        ++index;
    }
    while (numberToConvert != 0);
    
    for (--index; index >= 0; --index) {
        nextDigit = convertedNumber[index];
        [resultString appendString:[NSString stringWithFormat:@"%c", baseDigits[nextDigit]]];
    }
    
    if (fabs(base) == 2 || fabs(base) == 8 || fabs(base) == 10) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        NSNumber *myNumber = [f numberFromString:resultString];
        resultOfConvertion = myNumber;
    }
    else {
        resultOfConvertion = [resultString copy];
    }
    
    return resultOfConvertion;
}


#pragma mark string operations
+ (NSArray *)findAllSubstitutions:(NSString *)word {
    
    if (word.length == 0) {
        //for empty word return empty array
        return [NSArray new];
    } else if (word.length == 1) {
        
        //for single character return array of substitutions
        char character = [word characterAtIndex:0];
        return [self getSubstitutionsForChar:character];
    }
    
    NSMutableArray *result = [NSMutableArray new];
    
    //get first char
    char firstChar = [word characterAtIndex:0];
    // create list of replacements for first char
    NSArray *substitutionsOfFirstChar = [self getSubstitutionsForChar:firstChar];
    
    //recursively get substitutions for rest of the word
    NSString *restOfWord = [word substringFromIndex:1];
    NSArray *permutationsOfRestWord = [self findAllSubstitutions:restOfWord];
    
    //iterate for all first char substitutions
    for (int indexOfCharPerm = 0; indexOfCharPerm < substitutionsOfFirstChar.count; indexOfCharPerm++) {
        //iterate for all possible rest variants and concat them
        for (int indexOfRestWordPerm = 0; indexOfRestWordPerm < permutationsOfRestWord.count; indexOfRestWordPerm++) {
            
            NSString *newWord = [NSString stringWithFormat:@"%@%@", substitutionsOfFirstChar[indexOfCharPerm], permutationsOfRestWord[indexOfRestWordPerm]];
            [result addObject:newWord];
            
        }
    }
    
    return result;
    
}

+ (NSArray *)getSubstitutionsForChar:(char)character {
    NSArray *mappingChars = @[@[@"1"],
                              @[@"2", @"a", @"b", @"c"],
                              @[@"3", @"d", @"e", @"f"],
                              @[@"4", @"g", @"h", @"i"]
                              ];
    
    
    NSString *charStr = [NSString stringWithFormat:@"%c", character];
    
    //init with existing value -> if it's not found in substituations
    NSArray *substitutions = [NSArray arrayWithObject:charStr];
    
    //find array of substitutions in array of replacements
    for (int index = 0; index < mappingChars.count; index++) {
        if ([mappingChars[index] containsObject:charStr]) {
            substitutions = mappingChars[index];
        }
    }
    
    return substitutions;
}


+ (NSArray *)findAllPermutations:(NSString *)word {
    if (!word || word.length <= 1) {
        return @[word];
    }
    
    NSMutableArray *permutations = [NSMutableArray new];
    char firstChar = [word characterAtIndex:0];
    NSString *restOfWord = [word substringFromIndex:1];
    
    NSArray *permutationsOfRestWord = [self findAllPermutations:restOfWord];
    for (int permIndex = 0; permIndex < permutationsOfRestWord.count; permIndex++) {
        NSString *subPermutation = permutationsOfRestWord[permIndex];
        for (int subIndex = 0; subIndex <= subPermutation.length; subIndex++) {
            NSString *newPermutation = [self insertChar:firstChar to:subPermutation atIndex:subIndex];
            [permutations addObject:newPermutation];
        }
    }
    
    return permutations;
    
}

+ (NSString *)insertChar:(char)character to:(NSString *)word atIndex:(int)index {
    NSMutableString *result = [NSMutableString stringWithString:word];
    NSString *charStr = [NSString stringWithFormat:@"%c", character];
    [result insertString:charStr atIndex:index];
    
    return result;
}

+ (BOOL)isIsomorpthic:(NSString *)first with:(NSString *)second {
    char maxCharIndex = 'z'; //or 256 if all ASCII
    NSMutableArray *deltas = [NSMutableArray arrayWithCapacity:2 * maxCharIndex];
    
    for (int i = 0; i < 2 * maxCharIndex; i++) {
        [deltas addObject:@0];
    }
    
    if (first.length != second.length) {
        return NO;
    }
    
    for (int index = 0; index < first.length; index++) {
        char charA = [first characterAtIndex:index];
        char charB = [second characterAtIndex:index];
        
        int delta = charA - charB + maxCharIndex;
        int deltaValue = [deltas[charA] intValue];
        if (deltaValue == 0) {
            deltas[charA] = @(delta);
        } else if (deltaValue != delta) {
            return NO;
        }
    }
    
    return YES;
    
}


+ (NSMutableArray *)reversePossibilities:(NSString *)value {
    if (!value || value.length == 0) {
        return [NSMutableArray new];
    } else if (value.length == 1) {
        return [@[[@[value] mutableCopy]] mutableCopy];
    } else if (value.length == 2) {
        NSString *possibilityA = [value substringWithRange:NSMakeRange(0, 1)];
        NSString *possibilityB = [value substringWithRange:NSMakeRange(1, 1)];
        if ([self isValidString:value]) {
            return [NSMutableArray arrayWithObjects:[@[possibilityA, possibilityB] mutableCopy], [@[value] mutableCopy], nil];
        } else {
            return [NSMutableArray arrayWithObjects:[@[possibilityA, possibilityB] mutableCopy], nil];
        }
    }
    
    NSMutableArray *result = [NSMutableArray new];
    
    NSString *possibilityA = [value substringWithRange:NSMakeRange(0, 1)];
    NSMutableArray *restA = [self reversePossibilities:value length:1];
    for (NSMutableArray *possibilities in restA) {
        [possibilities insertObject:possibilityA atIndex:0];
        [result addObject:possibilities];
    }
    
    NSString *possibilityB = [value substringWithRange:NSMakeRange(0, 2)];
    if ([self isValidString:possibilityB]) {
        NSMutableArray *restB = [self reversePossibilities:value length:2];
        for (NSMutableArray *possibilities in restB) {
            [possibilities insertObject:possibilityB atIndex:0];
            [result addObject:possibilities];
        }
    }
    
    return result;
}

+ (NSMutableArray *)reversePossibilities:(NSString *)value length:(int)length {
    NSString *possibilitiesRestA = [value substringWithRange:NSMakeRange(length, value.length-length)];
    return [self reversePossibilities: possibilitiesRestA];
}

+ (BOOL)isValidString:(NSString *)value {
    int valueInt = [value intValue];
    return valueInt < 27;
}

// Given an array with non negative numbers, divide the array into two parts such that the average of both the parts is equal.
//Return both parts (If exist).
//If there is no solution. return an empty list.

//
//Example:
//
//
//Input:
//[1 7 15 29 11 9]
//
//Output:
//[9 15] [1 7 11 29]
//
//The average of part is (15+9)/2 = 12,
//average of second part elements is (1 + 7 + 11 + 29) / 4 = 12

//Sum_of_Set1 / size_of_set1 = total_sum / total_size

+(int)getSum:(NSArray *)input {
    int sum = 0;
    for (NSNumber *num in input) {
        sum += [num intValue];
    }
    return sum;
}

+ (NSArray *)getEqualAvg:(NSArray *)input {
    float avg = [self getSum:input]/(float)input.count;
    for (int i = 1; i <= input.count/2; i++) {
        NSArray *result = [self getAvg:input forCount:i forSum:avg*i startFrom:0];
        if (result) {
            NSLog(@"%@", result);
            return result;
        }
    }
    
    NSLog(@"not found");
    
    return nil;
}

+ (NSArray *)getAvg:(NSArray *)input forCount:(int)count forSum:(float)sum startFrom:(int)index {
    if (count == 1) {
        for (int i = index; i < input.count; i++) {
            if ([input[i]  isEqual: @(sum)]) {
                return @[input[i]];
            }
        }
        return nil;
    }
    if (index == input.count) {
        return nil;
    }
    
    NSArray *resultWithValue = [self getAvg:input forCount:count-1 forSum:sum-[input[index] intValue] startFrom:index+1];
    if (resultWithValue) {
        NSMutableArray *result = [resultWithValue mutableCopy];
        [result addObject:input[index]];
        return result;
    }
    
    NSArray *resultWithoutValue = [self getAvg:input forCount:count forSum:sum startFrom:index+1];
    if (resultWithoutValue) {
        NSMutableArray *result = [resultWithoutValue mutableCopy];
        return result;
    }
    
    return nil;
    
}

//sum of two
+(NSArray *)sumOfTwo:(NSArray *)input {
    NSMutableDictionary *hashSum = [NSMutableDictionary new];
    for (int i = 0; i < input.count; i++) {
        for (int j = i+1; j < input.count; j++) {
            int sum = [input[i] intValue] + [input[j] intValue];
            if (hashSum[@(sum)]) {
                NSLog(@"%@ -- %@ %@", hashSum[@(sum)], input[i], input[j]);
            } else {
                hashSum[@(sum)] = @[input[i], input[j]];
            }
        }
    }
    
    return nil;
}


//https://www.careercup.com/question?id=5689327699886080
+ (NSArray *)getPairs:(NSString *)string {
    if (!string) {
        return @[];
    }
    
    if (string.length == 1) {
        return @[string];
    }
    
    char firstChar = [string characterAtIndex:0];
    NSArray *pairs = [self getPairs:[string substringWithRange:NSMakeRange(1, string.length-1)]];
    NSMutableArray *result = [NSMutableArray new];
    
    for (int i = 0; i < pairs.count; i++) {
        NSString *value = pairs[i];
//        NSString *val1 = [NSString stringWithFormat:@"(%c%@)", firstChar, value];
//        NSString *val2 = [NSString stringWithFormat:@"(%c)(%@)", firstChar, value];
        NSString *val1 = [NSString stringWithFormat:@"%c%@", firstChar, value];
        NSString *val2 = [NSString stringWithFormat:@"%c)(%@", firstChar, value];
        [result addObject:val1];
        [result addObject:val2];
    }
    
    return result;
    
}

//https://www.careercup.com/question?id=5760148355153920
+ (int)minCostOfDistance:(int)start finish:(int)finish withIntervals:(NSArray *)intervals {
    
    NSMutableArray *suggestedIntervals = [[self getIntervalsFor:start from:(NSArray *)intervals] mutableCopy];
    
    
    for (int distance = start+1; distance <= finish; distance++) {
        NSMutableArray *suggestedIntervalsCopy = [suggestedIntervals mutableCopy];
        for (NSArray *interval in suggestedIntervals) {
            if (interval[1] < @(distance)) {
                [suggestedIntervalsCopy removeObject:interval];
                NSMutableArray *continuedIntervals = [[self getIntervalsFor:distance from:(NSArray *)intervals] mutableCopy];
                for (NSMutableArray *continuedInterval in continuedIntervals) {
                    continuedInterval[2] = @([continuedInterval[2] intValue] + [interval[2] intValue]);
                }
                [suggestedIntervalsCopy addObjectsFromArray:continuedIntervals];
            }
        }
        if (suggestedIntervalsCopy.count == 0) {
            return -1;
        }
        suggestedIntervals = suggestedIntervalsCopy;
    }
    
    float result = [self getMinCost:suggestedIntervals];
    return result;
}

+ (NSArray *)getIntervalsFor:(int)distance from:(NSArray *)intervals {
    NSMutableArray *result = [NSMutableArray new];
    for (NSArray *interval in intervals) {
        if (interval[0] <= @(distance) && interval[1] >= @(distance)) {
            [result addObject:[interval mutableCopy]];
        }
    }
    
    return result;
}

+ (float)getMinCost:(NSArray *)intervals {
    float cost = NSIntegerMax;
    for (NSArray *interval in intervals) {
        if ([interval[2] floatValue] <= cost) {
            cost = [interval[2] floatValue];
        }
    }
    
    return cost;
}


+ (NSString *) encodeString:(NSString *)string {
    NSMutableString *result = [NSMutableString new];
    if (string.length == 1) {
        return string;
    }
    int counter = 1;
    char prev = [string characterAtIndex:0];
    char current;
    for (int index = 1; index < string.length; index++) {
        current = [string characterAtIndex:index];
        if (current == prev) {
            counter++;
        } else {
            if (counter < 4) {
                for (int i = 0; i < counter; i++) {
                    [result appendFormat:@"%c", prev];
                }
            } else {
                [result appendFormat:@"%dx%c", counter, prev];
            }
            counter = 1;
            prev = current;
        }
    }
    if (counter != 0) {
        if (counter < 4) {
            for (int i = 0; i < counter; i++) {
                [result appendFormat:@"%c", prev];
            }
        } else {
            [result appendFormat:@"%dx%c", counter, prev];
        }
    }
    
    return [result copy];
}


//+ (int) partition:(NSMutableArray *)arr left:(int)l right:(int)r
//{
//    int x = arr[r] intv, i = l;
//    for (int j = l; j <= r - 1; j++)
//    {
//        if (arr[j] <= x)
//        {
//            swap(&arr[i], &arr[j]);
//            i++;
//        }
//    }
//    swap(&arr[i], &arr[r]);
//    return i;
//}

@end
