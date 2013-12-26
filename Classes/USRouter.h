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
 Opens a view controller associated with the given path.
 
 \discussion A path can either be as simple as "/simple" or complex with parameters
 as "/complex/parameter1/foo/parameter2". \see `-map:toController:`.
 
 You need to pay attention to correctly URL-encode your values when using them as parameters
 
 \param path A path simple, or complex
 */
- (void)open:(NSString *)path;


/**
 Pops the current top view controller or dismisses a modaly presented controller
 */
- (void)pop;


/**
 Creates a mapping between a path and a controller class.
 
 \discussion A path can either be as simple as "/simple" or ccomplex with parameters
 as "/complex/:param/foo/:param2"
 */
- (void)map:(NSString *)path toController:(Class)viewControllerSubclass;

@end
