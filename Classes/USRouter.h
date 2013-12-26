//
//  USRouter.h
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface USRouter : NSObject

/**
 Singleton Accessor
 
 \return A singleton instance of USRouter
 */
+ (instancetype)sharedRouter;

/**
 A router is responsible for a navigation controller. It manages pushing and poping content
 
 \return the navigationController in effect
 */
@property (readonly, strong) UINavigationController *navigationController;


/**
 Opens a view controller associated with the given path
 */
- (void)open:(NSString *)path;


/**
 Creates a mapping between a path and a controller class
 */
- (void)map:(NSString *)path toController:(Class)viewControllerSubclass;

@end
