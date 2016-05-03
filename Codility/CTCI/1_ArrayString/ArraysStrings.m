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

@end
