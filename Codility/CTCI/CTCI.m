//
//  CTCI.m
//  Codility
//
//  Created by Yury Ramanchuk on 5/5/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//

#import "CTCI.h"

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


@end