//
//  ArraysStrings.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/3/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "ArraysStrings.h"

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

@end
