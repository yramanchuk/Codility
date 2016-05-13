//
//  HRGraph.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/13/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//
#import <Foundation/Foundation.h>

#import "MainClass.m"
#import "HRQueue.m"
#import "HRVertexEdge.m"

@interface HRGraph : NSObject
@end

@implementation HRGraph

+ (NSMutableArray *)readGraph {
    int weight = 6;
    NSMutableArray *result = [NSMutableArray new];
    int vertexNum = [MainClass readLong];
    int edgeNum = [MainClass readLong];
    
    for (int i = 0; i < vertexNum; i++) {
        HRVertex *v = [HRVertex new];
        v.idx = [NSString stringWithFormat:@"%d", i];
        [result addObject:v];
    }
    
    for (int i = 0; i < edgeNum; i++) {
        int from = [MainClass readLong] - 1;
        int to = [MainClass readLong] - 1;
        
        HREdge *e = [[HREdge alloc] initWithAdjacentFrom:result[from] To:result[to] andWeight:@(weight)];
        //unidirected graph
        HREdge *e2 = [[HREdge alloc] initWithAdjacentFrom:result[to] To:result[from] andWeight:@(weight)];
    }
    
    return result;
}

+ (void)breadthFirstSearch:(HRVertex *)root
{
    //    NSAssert([self.vertices count] > 0, @"No any vertex in graph");
    
    root.label = @"-1";
    root.wasVisited = YES;
    //    [self displayVisitedVertex:self.firstVertex];
    
    HRQueue *queue = [[HRQueue alloc] init];
    [queue insertObject:root];
    
    while (![queue isEmpty]) {
        HRVertex *foo = [queue removeFirstObject];
        for (HREdge *adjacentEdge in foo.adjacentEdges) {
            if (!adjacentEdge.adjacentTo.wasVisited) {
                [queue insertObject:adjacentEdge.adjacentTo];
                adjacentEdge.adjacentTo.wasVisited = YES;
                
                int fromWeight = [foo.label intValue] < 0 ? 0 : [foo.label intValue];
                adjacentEdge.adjacentTo.label = [NSString stringWithFormat:@"%d", adjacentEdge.weight.intValue + fromWeight];
                //                [self displayVisitedVertex:adjacentEdge.adjacentTo];
            }
        }
    }
    
    //    [self clearVisitHistory];
}

+ (void)calculateBFS {
    int testCases = [MainClass readLong];
    for (int i = 0; i<testCases; i++) {
        NSMutableArray *graph = [self readGraph];
        int rootVertexIdx = [MainClass readLong] - 1;
        
        
//        for (HREdge *e in [graph[rootVertexIdx] adjacentEdges]) {
//            NSLog(@"e %ld", [graph indexOfObject:e.adjacentTo]);
//        }

        
        [self breadthFirstSearch:graph[rootVertexIdx]];
        
        NSMutableString *result = [NSMutableString new];
        for (int j = 0; j < graph.count; j++) {
            NSString *lbl = [graph[j] label];
            if (j != rootVertexIdx) {
                NSString *val = lbl.intValue != 0 ? lbl : @"-1";
                [result appendFormat:@"%@ ", val];
            }
        }
        [MainClass printString:result];
    }
}

@end
