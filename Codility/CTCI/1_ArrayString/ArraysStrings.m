//
//  ArraysStrings.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "ArraysStrings.h"



@implementation EKNode (Additions)

- (NSNumber *)data {
    return (NSNumber *)self.value;
}
@end

@implementation EKTreeNode (Additions)

- (NSArray *)children {
    return @[self.child, self.sibling];
}

//only to mock. use dynamic assosiation
- (BOOL)visited {
    return YES;
}

@end

@implementation ArraysStrings

+ (BOOL)hasDuplicates:(NSString *)string {
    NSMutableDictionary *strChars = [NSMutableDictionary dictionaryWithCapacity: string.length];
    BOOL result = NO;
    
    for (int i = 0; i < string.length; i++) {
        char c = [string characterAtIndex:i];
        int count = [strChars[@(c)] intValue];
        if (count > 0) {
            result = YES;
            break;
        } else {
            strChars[@(c)] = @1;
        }
        
    }
    
    return result;
    
}

+ (void)rotate:(NSMutableArray<NSMutableArray<NSNumber *> *> *)array {
    //validate that it's not empty
    //validate that is nxn
    //retunt if length = 1;
    
    for (int i = 0; i < array.count - 1; i++) {
        NSMutableArray *row = array[i];
        for (int j = i + 1; j < row.count; j++) {
            NSNumber *valJ = row[j];
            NSNumber *valI = array[j][i];
            row[j] = valI;
            array[j][i] = valJ;
        }
    }
}

# pragma mark Linked Lists tasks

+ (void)removeDuplicates:(NSMutableArray *)a {
    NSMutableSet *existing = [NSMutableSet new];
    int lastEl = 0;
    while (lastEl < a.count - 1)
        for (int i = lastEl; i < a.count; i++) {
            id value = a[i];
            lastEl = i;
            if ([existing containsObject:value]) {
                [a removeObjectAtIndex:i]; //bad practise to iterate and change
                break;
            } else {
                [existing addObject:value];
            }
        }
}

////Implement an algorithm to find the kth to last element of a singly linked list.
//// use 2 pointer one after another!
//- (id)findKthLast: (LinkedListNode *)head postion:(int)position {
//    int count = 0;
//    id node = head;
//    while (!(id next = node.next)) {
//        count++;
//        node = next;
//        
//        if (k > count) {
//            retutn nil;
//        }
//    }
//    
//    id result = head;
//    for (int = 0; i < count - k; i++) {
//        result = result.next;
//    }
//    
//    return result;
//    
//}

//// Implement an algorithm to delete a node in the middle of a singly linked list, given only access to that node.
//// a->b->c->d->e
//- (void)removeNode:(Node **)node {
//    node = node.next;
//    
//}
//- (void)removeNode:(Node *)node {
//    node.data = node.next.data;
//    node.next = node.next.next;
//}

+ (EKNode *)partition:(EKNode *)head around:(int)n {
//    EKNode *tail = nil;
//    EKNode *node = head;
//    EKNode *result = nil;
//    
//    //need to track beginning
//    
//    if ([self getData:head] >= n) {
//        tail = head;
//    } else {
//        result = head;
//    }
//    
//    EKNode *restList = tail;
//    
//    while ((node = node.next)) {
//        if ([self getData:node] >= n) {
//            //change next
//            if (tail) {
//                tail.next = node;
//            } else {
//                restList = node;
//            }
//            tail = node;
//        } else if (!result) {
//            result = node;
//        }
//    }
//    
//    if (restList) {
//        node.next = restList;
//    }
//    if (!result) {
//        result = head;
//    }
//    
//    
//    return result;
 
    EKNode *beforeStart = nil;
    EKNode *afterStart = nil;
    EKNode *node = head;
    
    while (node) {
        EKNode *next = node.next;
        
        if ([self getData:node] < n) {
//            beforeStart.next = node;
//            beforeStart = node;
            node.next = beforeStart;
            beforeStart = node;
        } else {
//            beforeEnd.next = node;
//            beforeEnd = node;
            node.next = afterStart;
            afterStart = node;
        }
        
        node = next;
    }
    
    if (!beforeStart) {
        return afterStart;
    }
    
    head = beforeStart;
    
    while (beforeStart.next) {
        beforeStart = beforeStart.next;
    }
    beforeStart.next = afterStart;
    
    
    return head;
    
    
}

+ (EKNode *)sum:(EKNode *)left with:(EKNode *)right {
    EKNode *result = nil;
    EKNode *tail = nil;
    int extra = 0;
    
    while (left || right) {
        EKNode *lnext = left.next;
        EKNode *rnext = right.next;
        
        int ldata = [self getData:left];
        int rdata = [self getData:right];
        if (!left) {
            ldata = 0;
        }
        if (!right) {
            rdata = 0;
        }
        
        int sum = ldata + rdata + extra;
        extra = 0;
        if (sum > 9) {
            sum -= 10;
            extra++;
        }
        
        EKNode *sumNode = [[EKNode alloc] initWithObject:@(sum)];
        tail.next = sumNode;
        tail = sumNode;
        
        if (!result) {
            result = sumNode;
        }
        
        left = lnext;
        right = rnext;
    }
    
    if (extra > 0) {
        EKNode *sumNode = [[EKNode alloc] initWithObject:@(extra)];
        tail.next = sumNode;
    }
    
    return result;
}


+ (int)getData:(EKNode *)node {
    return [(NSNumber *)node.value intValue];
}


/// DFS
- (void)treeDFS:(EKTreeNode *)node {
    if (!node) {
        return;
    }
    
    [self visit:node];
    
    for (EKTreeNode *n in node.children) {
        if (!n.visited) {
            [self treeDFS:n];
        }
    }
}

// BFS search
- (void)treeBFS:(EKTreeNode *)node {
    if (!node) {
        return;
    }
    
    NSMutableArray *queue = [NSMutableArray new];
    [queue addObject:node];
    [self visit:node];
    
    while (queue.count > 0) {
        EKTreeNode *n = queue.lastObject;
        [queue removeLastObject];
        
        for (EKTreeNode *child in n.children) {
            if (!child.visited) {
                [self visit:child];
                [queue addObject:child];
            }
        }
        
    }
}



- (void)visit:(EKTreeNode *)node {
//    node.visited = YES;
    //validate
}


# pragma mark binary operations
const int MAX_ITERATIONS = 32;

+ (NSString *)toBinary:(double)value {
    
    assert(value > 0);
    assert(value < 1);
    
    NSMutableString *result = [NSMutableString stringWithString:@"0."];
    double sum = 0;
    int counter = 1;
    
    while (sum != value && counter <= MAX_ITERATIONS) {
        double delta = 1.f / (1 << counter);
        if (sum + delta <= value) {
            sum += delta;
            [result appendString:@"1"];
        } else {
            [result appendString:@"0"];
        }
        counter++;
    }
    
    
    return sum == value ? result : [NSString stringWithFormat:@"ERROR %@", result];
}


+ (void)printSmallestAndLargest:(int)value {
    assert(value > 0);
    
    int countBits = 0; //helper and not used
    int counter = 0;
    NSString *smallest = [NSMutableString new];
    NSString *biggest = [NSMutableString new];
    int smallestInt = 0;
    int biggestInt = 0;
    
    while (1 << counter <= value) {
        int max = 1 << counter;
        if ((value & max) > 0) {
            biggest = [NSString stringWithFormat:@"1%@", biggest];
            smallest = [NSString stringWithFormat:@"%@1", smallest];
            
            smallestInt += 1 << countBits;
            
            countBits++;
        } else {
            biggest = [NSString stringWithFormat:@"%@0", biggest];
            smallest = [NSString stringWithFormat:@"0%@", smallest];
        }
        counter++;
    }
    
    biggestInt = smallestInt << (counter - countBits);
    
    NSLog(@"biggest %d - %@, smallest %d - %@", biggestInt, biggest, smallestInt, smallest);
    
}
@end
