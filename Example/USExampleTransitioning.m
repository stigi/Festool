//
//  USExampleTransitioning.m
//  Festool
//
//  Created by Ullrich Schäfer on 30/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USExampleTransitioning.h"

@implementation USExampleTransitioning

- (BOOL)us_canHandleAnimatedTransitioningFromViewController:(UIViewController *)fromViewController
                                               toController:(UIViewController *)toViewController
                                                  operation:(UINavigationControllerOperation)operation
{
    return YES;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    // no-op
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    return 0.2;
}

@end
