//
//  ViewController.m
//  Codility
//
//  Created by Yury Ramanchuk on 4/27/16.
//  Copyright © 2016 Yury Ramanchuk. All rights reserved.
//


//        #ifndef DispatchAfterWithCancel_h
//        #define DispatchAfterWithCancel_h
//
//        typedef void(^dispatch_after_with_cancel_t)(BOOL shouldCancel);
//
//        /**
//         *  Provides a dispatch_after block that can be canceled before its execution.
//         *  The block will be called on the main thread.
//         *
//         *  To cancel the block before it executes, simply call `cancel_block` with
//         *  the block returned by this function.
//         *
//         *  This function will always return a non-null `dispatch_after_with_cancel_t`
//         *  block, even if the `block` provided is NULL.
//         *
//         *  @param delay the time to wait before execution
//         *  @param block the block to execute
//         *
//         *  @return a block that will execute after the set delay. Calling `cancel_block`
//         *  with this block will cancel the block before it executes.
//         */
//        NS_INLINE dispatch_after_with_cancel_t dispatch_after_with_cancel(NSTimeInterval delay, dispatch_block_t block) {
//            __block dispatch_block_t originalBlock = [block copy];
//            
//            __block dispatch_after_with_cancel_t cancelableBlock = ^(BOOL shouldCancel) {
//                if (shouldCancel == NO && originalBlock) {
//                    originalBlock();
//                }
//                
//                originalBlock = NULL;
//            };
//            
//            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, delay * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//                if (cancelableBlock) {
//                    cancelableBlock(NO);
//                    cancelableBlock = NULL;
//                }
//            });
//            
//            return cancelableBlock;
//        }
//
//        /**
//         *  Cancels the block before it executes. Does nothing when a NULL block is
//         *  provided.
//         *
//         *  @param block the block to cancel
//         */
//        NS_INLINE void cancel_block(dispatch_after_with_cancel_t block) {
//            if (block) {
//                block(YES);
//                block = NULL;
//            }
//        }
//
//        #endif

#import "ViewController.h"
#import <objc/runtime.h>

@interface ViewController ()

@end

@implementation ViewController

//typedef void(^dispatch_after_with_cancel_t)();

-(NSObject *)getAssosiation:(dispatch_block_t)block {
    return objc_getAssociatedObject(block, @selector(getAssosiation:));
}

-(void)setAssosiation:(dispatch_block_t)block {
    objc_setAssociatedObject(block, @selector(getAssosiation:), [NSObject new], OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cancelBlock:(dispatch_block_t)block {
    [self setAssosiation:block];
}

-(dispatch_block_t) dispatch_after_with_cancel:(NSTimeInterval) delay  for:(dispatch_block_t) block {
    
    dispatch_block_t cancellable = ^{
        if (![self getAssosiation:block]) {
            block();

        }
    };
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        cancellable();
    });
    
    return cancellable;
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    dispatch_block_t block = ^{
        NSLog(@"test");
    };
    
    [self dispatch_after_with_cancel:5 for:block];

//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self cancelBlock:block];
//    });

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
