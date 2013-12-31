//
//  USRouter.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USRouter.h"

#import "USRoute.h"
#import "USRouterViewController.h"
#import "USRouterViewControllerAnimatedTransitioning.h"


@interface USRouter () <UINavigationControllerDelegate>
@property (readonly) NSMutableDictionary *routes;
@property USRoute *currentRoute;
@end


@implementation USRouter

#pragma mark - Singleton & Lifecycle

+ (instancetype)sharedRouter;
{
    static dispatch_once_t onceToken;
    static USRouter *singleton;
    dispatch_once(&onceToken, ^{
        singleton = [[USRouter alloc] init];
    });
    return singleton;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        _navigationController = [[UINavigationController alloc] initWithNibName:nil bundle:nil];
        _navigationController.delegate = self;
        
        _routes = [NSMutableDictionary dictionary];
    }
    return self;
}



#pragma mark - Mapping

- (void)map:(NSString *)path toController:(Class)viewControllerSubclass;
{
    [self map:path toController:viewControllerSubclass withTansitionings:nil];
}

- (void)       map:(NSString *)path
      toController:(Class)viewControllerSubclass
 withTansitionings:(NSArray *)transitionings;
{
    NSParameterAssert([viewControllerSubclass isSubclassOfClass:[UIViewController class]]);
    
    @synchronized(self.routes) {
        USRoute *route = [[USRoute alloc] initWithParameterPath:path
                                            viewControllerClass:viewControllerSubclass
                                         animatedTransitionings:transitionings];
        
        [self.routes setObject:route forKey:path];
    }
}


#pragma mark - Open and Close

- (void)open:(NSString *)path;
{
    @synchronized(self.routes) {
        NSMutableSet *routes = [NSMutableSet set];
        [self.routes enumerateKeysAndObjectsWithOptions:NSEnumerationConcurrent
                                             usingBlock:^(NSString *routePath, USRoute *route, BOOL *stop) {
                                                 if ([route matchesPath:path]) {
                                                     [routes addObject:route];
                                                 }
                                             }];
        
        // TODO: Should we turn these asserts into warnings?
        NSAssert1(routes.count <= 1, @"There was more than one route found matching the path %@", path);
        NSAssert1(routes.count > 0, @"There was no route found matching the path %@", path);
        
        USRoute *route = [routes anyObject];
        if (route) {
            Class viewControllerClass = route.viewControllerClass;
            UIViewController *viewController = nil;
            if ([viewControllerClass instancesRespondToSelector:@selector(initWithRouterParameters:)]) {
                NSDictionary *parameters = [route parameterValuesByParsingPath:path];
                viewController = [[viewControllerClass alloc] initWithRouterParameters:parameters];
            } else {
                viewController = [[viewControllerClass alloc] initWithNibName:nil bundle:nil];
            }
            
            self.currentRoute = route;
            [self.navigationController pushViewController:viewController animated:YES];
        }
    }
}

- (void)pop;
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - UINavigationControllerDelegate

- (id <UIViewControllerAnimatedTransitioning>)navigationController:(UINavigationController *)navigationController
                                   animationControllerForOperation:(UINavigationControllerOperation)operation
                                                fromViewController:(UIViewController *)fromVC
                                                  toViewController:(UIViewController *)toVC  NS_AVAILABLE_IOS(7_0);
{
    __block id<USRouterViewControllerAnimatedTransitioning> transitioning = nil;
    [self.currentRoute.animatedTransitionings enumerateObjectsWithOptions:NSEnumerationConcurrent
                                                               usingBlock:
     ^(id<USRouterViewControllerAnimatedTransitioning> aTransitioning, NSUInteger idx, BOOL *stop) {
         if ([aTransitioning us_canHandleAnimatedTransitioningFromViewController:fromVC
                                                                    toController:toVC
                                                                       operation:operation])
         {
             transitioning = aTransitioning;
             *stop = YES;
         }
     }];
    return transitioning;
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated;
{
    self.currentRoute = nil;
}

@end
