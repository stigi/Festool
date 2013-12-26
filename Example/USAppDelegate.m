//
//  USAppDelegate.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USAppDelegate.h"

#import "USRouter.h"

#import "USExampleViewControllerOne.h"
#import "USExampleViewControllerTwo.h"
#import "USExampleViewControllerThree.h"

@implementation USAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    USRouter *router = [USRouter sharedRouter];
    
    [router map:@"/one" toController:[USExampleViewControllerOne class]];
    [router map:@"/two" toController:[USExampleViewControllerTwo class]];
    [router map:@"/three/:name" toController:[USExampleViewControllerThree class]];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.rootViewController = router.navigationController;
    [self.window makeKeyAndVisible];
    
    [router open:@"/one"];
    return YES;
}


@end
