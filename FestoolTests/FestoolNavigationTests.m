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
    [self.router map:@"/simple" toController:[USTestViewControllerOne class]];

    [self.router open:@"/simple"];

    expect(self.router.navigationController.topViewController).to.beKindOf([USTestViewControllerOne class]);
}

- (void)testPickingOfCorrectPath
{
    [self.router map:@"/simple/one" toController:[USTestViewControllerOne class]];
    [self.router map:@"/simple/two" toController:[USTestViewControllerTwo class]];
    [self.router map:@"/simple/three" toController:[USTestViewControllerThree class]];
    
    [self.router open:@"/simple/two"];
    
    expect(self.router.navigationController.topViewController).to.beKindOf([USTestViewControllerTwo class]);
}

- (void)testComplexOpen
{
    [self.router map:@"/complex/one/:id" toController:[USTestViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USTestViewControllerTwo class]];
    [self.router map:@"/complex/three/:id" toController:[USTestViewControllerThree class]];
    
    [self.router open:@"/complex/two/1"];
    
    expect(self.router.navigationController.topViewController).to.beKindOf([USTestViewControllerTwo class]);
}

- (void)testMultipleOpen
{
    [self.router map:@"/complex/one/:id" toController:[USTestViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USTestViewControllerTwo class]];
    [self.router map:@"/complex/three/:id" toController:[USTestViewControllerThree class]];
    
    [self.router open:@"/complex/one/1"];
    [self.router open:@"/complex/two/2"];
    [self.router open:@"/complex/three/3"];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(3);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USTestViewControllerOne class]);
    expect(self.router.navigationController.viewControllers[1]).to.beKindOf([USTestViewControllerTwo class]);
    expect(self.router.navigationController.viewControllers[2]).to.beKindOf([USTestViewControllerThree class]);
}


#pragma mark - Parameters

- (void)testComplexOpenWithParameters
{
    [self.router map:@"/complex/:param1/:param2" toController:[USTestViewControllerOne class]];
    
    [self.router open:@"/complex/1/5"];

    expect([self.router.navigationController.topViewController isKindOfClass:[USTestViewControllerOne class]]);
    NSDictionary *parameters = [(USTestViewControllerOne *)self.router.navigationController.topViewController parameters];
    
    expect(parameters[@"param1"]).to.equal(@"1");
    expect(parameters[@"param2"]).to.equal(@"5");
}


#pragma mark - Poping

- (void)testPop
{
    [self.router map:@"/complex/one/:id" toController:[USTestViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USTestViewControllerTwo class]];
    
    [self.router open:@"/complex/one/1"];
    [self.router open:@"/complex/two/2"];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(2);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USTestViewControllerOne class]);
    expect(self.router.navigationController.viewControllers[1]).to.beKindOf([USTestViewControllerTwo class]);
    
    [self.router pop];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(1);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USTestViewControllerOne class]);
    
}

@end
