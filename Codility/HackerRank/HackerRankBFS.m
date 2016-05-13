//
//  HackerRankBFS.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/14/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

//#import <Foundation/Foundation.h>
//
//#pragma mark Vertex Wrapper
//@interface HRVertex : NSObject
//@property (nonatomic, copy) NSString *label;
//@property (nonatomic, copy) NSString *idx;
//@property (nonatomic, assign) BOOL wasVisited;
//@property (nonatomic, strong) NSMutableSet *adjacentEdges;
//@end
//
//@implementation HRVertex
//-(instancetype)init{
//    if (self = [super init]) {
//        self.adjacentEdges = [NSMutableSet new];
//    }
//    return self;
//}
//- (NSUInteger)hash {
//    return [self.idx hash];
//}
//@end
//
//#pragma mark Edge Wrapper
//@interface HREdge : NSObject
//@property (nonatomic, strong) HRVertex *adjacentFrom;
//@property (nonatomic, strong) HRVertex *adjacentTo;
//@property (nonatomic, strong) NSNumber *weight;
//@property (nonatomic, assign) BOOL used;
//- (instancetype)initWithAdjacentFrom:(HRVertex *)vertexFrom
//                                  To:(HRVertex *)vertexTo
//                           andWeight:(NSNumber *)weight;
//
//@end
//
//@implementation HREdge
//- (instancetype)initWithAdjacentFrom:(HRVertex *)vertexFrom
//                                  To:(HRVertex *)vertexTo
//                           andWeight:(NSNumber *)weight {
//    self = [super init];
//    if (self) {
//        self.adjacentFrom = vertexFrom;
//        self.adjacentTo = vertexTo;
//        self.weight = weight;
//        self.used = NO;
//        
//        [vertexFrom.adjacentEdges addObject:self];
//    }
//    return self;
//}
//
//- (BOOL)isEqual:(HREdge *)object {
//    return [self.adjacentFrom isEqual:object.adjacentFrom] && [self.adjacentTo isEqual:object.adjacentTo];
//}
//
//- (NSUInteger)hash {
//    return 7 * [self.adjacentFrom hash] + 13 * [self.adjacentTo hash];
//}
//@end
//
//@interface HRGraph : NSObject
//@end
//
//
///////
//@interface HRQueue : NSObject
//- (void)insertObject:(id)object;
//- (id)removeFirstObject;
//- (id)peek;
//- (BOOL)isEmpty;
//- (void)clear;
//- (NSArray *)allObjectsFromQueue;
//
//@property (nonatomic, strong) NSMutableArray *queueArray;
//
//@end
//
//@implementation HRQueue
//
//#pragma mark - init
//
//- (id)init
//{
//    self = [super init];
//    if (self) {
//        self.queueArray = [@[] mutableCopy];
//    }
//    return self;
//}
//
//#pragma mark - Public API
//
//- (void)insertObject:(id)object
//{
//    if (object != nil) {
//        [self.queueArray addObject:object];
//    }
//    else {
//        NSAssert(object != nil, @"You can't push nil object to deque");
//    }
//}
//
//- (id)removeFirstObject
//{
//    if ([self.queueArray count] > 0) {
//        id object = [self peek];
//        [self.queueArray removeObjectAtIndex:0];
//        return object;
//    }
//    
//    return nil;
//}
//
//- (id)peek
//{
//    if ([self.queueArray count] > 0) {
//        return [self.queueArray objectAtIndex:0];
//    }
//    
//    return nil;
//}
//
//- (BOOL)isEmpty
//{
//    return [self.queueArray count] == 0;
//}
//
//- (void)clear
//{
//    [self.queueArray removeAllObjects];
//}
//
//- (NSArray *)allObjectsFromQueue
//{
//    NSMutableArray *buffer = [@[] mutableCopy];
//    
//    for (id object in self.queueArray) {
//        [buffer addObject:object];
//    }
//    
//    return [buffer copy];
//}
//
//@end
//
//
//////////
//
//@interface MainClass : NSObject
//+ (BOOL)startMain;
//@end
//
//@implementation MainClass
//
//+ (BOOL)startMain {
//    NSInteger n = [self readLong];
//    
//    [self printLong:n];
//    NSArray *numbers = [self readLongArrayOfLength:n];
//    [self printLongNumberArray:numbers];
//    return YES;
//}
//
//+ (NSString *)readString {
//    char c[1024];
//    //    scanf("%s", c);
//    scanf("%[^\n]", c);
//    return [NSString stringWithCString:c encoding:NSUTF8StringEncoding];
//}
//
//+ (long)readLong {
//    long n;
//    scanf("%ld",&n);
//    return n;
//}
//
//+ (NSArray *)readLong2DimArrayOfLength:(NSInteger)len {
//    NSMutableArray *result = [NSMutableArray array];
//    for (int i =0; i < len; i++) {
//        [result addObject:[NSMutableArray array]];
//        for (int j =0; j < len; j++) {
//            [result[i] addObject:@([self readLong])];
//        }
//    }
//    return [result copy];
//}
//
//+ (NSArray *)readLongArrayOfLength:(NSInteger)len {
//    NSMutableArray *result = [NSMutableArray array];
//    for (int i =0; i < len; i++) {
//        [result addObject:@([self readLong])];
//    }
//    return [result copy];
//}
//
////Helpers
//+ (void)printLong:(long)i {
//    printf("%ld\n",(long)i);
//}
//
//+ (void)printFloat:(float)i {
//    printf("%f\n", i);
//}
//
//+ (void)printString:(NSString *)s {
//    printf("%s\n", [s UTF8String]);
//}
//
//+ (void)printLongNumberArray:(NSArray *)array {
//    printf("[");
//    [array enumerateObjectsUsingBlock:^(NSNumber *n, NSUInteger idx, BOOL * _Nonnull stop) {
//        printf("%ld",(long)[n longValue]);
//        if (idx < array.count-1) {
//            printf(",");
//        }
//    }];
//    printf("]\n");
//}
//
//@end
//
//
////////
//@implementation HRGraph
//
//+ (NSMutableArray *)readGraph {
//    int weight = 6;
//    NSMutableArray *result = [NSMutableArray new];
//    int vertexNum = [MainClass readLong];
//    int edgeNum = [MainClass readLong];
//    
//    for (int i = 0; i < vertexNum; i++) {
//        HRVertex *v = [HRVertex new];
//        v.idx = [NSString stringWithFormat:@"%d", i];
//        [result addObject:v];
//    }
//    
//    for (int i = 0; i < edgeNum; i++) {
//        int from = [MainClass readLong] - 1;
//        int to = [MainClass readLong] - 1;
//        
//        HREdge *e = [[HREdge alloc] initWithAdjacentFrom:result[from] To:result[to] andWeight:@(weight)];
//        HREdge *e2 = [[HREdge alloc] initWithAdjacentFrom:result[to] To:result[from] andWeight:@(weight)];
//        //        [vertexFrom.adjacentEdges addObject:self];
//    }
//    
//    return result;
//}
//
//+ (void)breadthFirstSearch:(HRVertex *)root
//{
//    //    NSAssert([self.vertices count] > 0, @"No any vertex in graph");
//    
//    root.label = @"0";
//    root.wasVisited = YES;
//    //    [self displayVisitedVertex:self.firstVertex];
//    
//    HRQueue *queue = [[HRQueue alloc] init];
//    [queue insertObject:root];
//    
//    while (![queue isEmpty]) {
//        HRVertex *foo = [queue removeFirstObject];
//        for (HREdge *adjacentEdge in foo.adjacentEdges) {
//            if (!adjacentEdge.adjacentTo.wasVisited) {
//                [queue insertObject:adjacentEdge.adjacentTo];
//                adjacentEdge.adjacentTo.wasVisited = YES;
//                int fromWeight = [foo.label intValue] < 0 ? 0 : [foo.label intValue];
//                adjacentEdge.adjacentTo.label = [NSString stringWithFormat:@"%d", adjacentEdge.weight.intValue + fromWeight];
//                //                [self displayVisitedVertex:adjacentEdge.adjacentTo];
//            }
//        }
//    }
//    
//    //    [self clearVisitHistory];
//}
//
//+ (void)calculateBFS {
//    int testCases = [MainClass readLong];
//    for (int i = 0; i<testCases; i++) {
//        NSMutableArray *graph = [self readGraph];
//        int rootVertexIdx = [MainClass readLong]-1;
//        NSLog(@"adj %ld", [graph[rootVertexIdx] adjacentEdges].count);
//        for (HREdge *e in [graph[rootVertexIdx] adjacentEdges]) {
//            NSLog(@"e %ld - idx %@", [graph indexOfObject:e.adjacentTo], e.adjacentTo.idx);
//        }
//        
//        
//        [self breadthFirstSearch:graph[rootVertexIdx]];
//        
//        NSMutableString *result = [NSMutableString new];
//        for (int j = 0; j < graph.count; j++) {
//            NSString *lbl = [graph[j] label];
//            if (j != rootVertexIdx) {
//                NSString *val = lbl.intValue != 0 ? lbl : @"-1";
//                [result appendFormat:@"%@ ", val];
//            }
//        }
//        [MainClass printString:result];
//    }
//}
//
//@end
//
//
//int main(int argc, char * argv[]) {
//    @autoreleasepool {
//        [HRGraph calculateBFS];
//        return 1;
//    }
//}