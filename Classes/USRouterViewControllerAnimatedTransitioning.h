//
//  USRouterViewControllerAnimatedTransitioning.h
//  Festool
//
//  Created by Ullrich Schäfer on 30/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol USRouterViewControllerAnimatedTransitioning <UIViewControllerAnimatedTransitioning>

- (BOOL)us_canHandleAnimatedTransitioningFromViewController:(UIViewController *)fromViewController
                                               toController:(UIViewController *)toViewController
                                                  operation:(UINavigationControllerOperation)operation;
@end
