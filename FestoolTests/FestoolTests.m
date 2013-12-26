//
//  FestoolTests.m
//  FestoolTests
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "FestoolTestCase.h"

#import "USRouter.h"



@interface FestoolTests : FestoolTestCase

@end


@implementation FestoolTests

#pragma mark - Creation

- (void)testRouterCreation
{
    USRouter *router = [[USRouter alloc] init];
    expect(router).toNot.beNil();
}

- (void)testRouterSingletonCreation
{
    USRouter *router = [USRouter sharedRouter];
    expect(router).toNot.beNil();
}

- (void)testRouterIsCreatedWithNavigationController
{
    USRouter *router = [[USRouter alloc] init];
    expect(router.navigationController).toNot.beNil();
}

- (void)testSingletonIsActuallyASingleton
{
    USRouter *singleton = [USRouter sharedRouter];
    USRouter *sameSingleton = [USRouter sharedRouter];
    
    expect(sameSingleton).to.beIdenticalTo(singleton);
}

- (void)testSingletonWorksAlsoForNavigationController
{
    UINavigationController *navigationController = [[USRouter sharedRouter] navigationController];
    UINavigationController *sameNavigationController = [[USRouter sharedRouter] navigationController];
    
    expect(sameNavigationController).to.beIdenticalTo(navigationController);
}


@end
