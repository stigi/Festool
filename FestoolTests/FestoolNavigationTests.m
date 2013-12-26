//
//  FestoolNavigationTests.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "FestoolTestCase.h"

#import "USRouter.h"


@interface FestoolNavigationTests : FestoolTestCase
@property USRouter *router;
@end


@implementation FestoolNavigationTests

- (void)setUp
{
    [super setUp];
    _router = [[USRouter alloc] init];
}

#pragma mark - Meta

- (void)testNavigationControllerDelegateIsSetUp
{
    expect(self.router.navigationController.delegate).to.equal(self.router);
}

- (void)testNavigationControllerIsCreatedEmpty
{
    expect(self.router.navigationController.viewControllers).to.haveCountOf(0);
}

#pragma mark - Navigation

- (void)testSimpleOpen
{
    [self.router map:@"/simple" toController:[UIViewController class]];

    [self.router open:@"/simple"];

    expect(self.router.navigationController.topViewController).to.beKindOf([UIViewController class]);
}

@end
