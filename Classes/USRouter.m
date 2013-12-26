//
//  USRouter.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USRouter.h"

#import "USRoute.h"


@interface USRouter () <UINavigationControllerDelegate>
@property (readonly) NSMutableDictionary *routes;
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
    NSParameterAssert([viewControllerSubclass isSubclassOfClass:[UIViewController class]]);
    
    @synchronized(self.routes) {
        USRoute *route = [[USRoute alloc] initWithParameterPath:path viewControllerClass:viewControllerSubclass];
        
        [self.routes setObject:route forKey:path];
    }
}


#pragma mark - Open

- (void)open:(NSString *)path;
{
    @synchronized(self.routes) {
        USRoute *route = [self.routes objectForKey:path];
        [self.navigationController pushViewController:[[route.viewControllerClass alloc] init] animated:YES];
    }
}


@end
