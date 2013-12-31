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
@property UIWindow *window;
@end


@implementation FestoolNavigationTests

- (void)setUp
{
    [super setUp];
    _router = [[USRouter alloc] init];
    
    // put the routers navigationController in the view hierarchy
    _window = [[[UIApplication sharedApplication] delegate] window];
    self.window.rootViewController = self.router.navigationController;
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
    [self.router map:@"/simple" toController:[USExampleViewControllerOne class]];
    
    [self.router open:@"/simple"];
    
    expect(self.router.navigationController.topViewController).to.beKindOf([USExampleViewControllerOne class]);
}

- (void)testPickingOfCorrectPath
{
    [self.router map:@"/simple/one" toController:[USExampleViewControllerOne class]];
    [self.router map:@"/simple/two" toController:[USExampleViewControllerTwo class]];
    [self.router map:@"/simple/three" toController:[USExampleViewControllerThree class]];
    
    [self.router open:@"/simple/two"];
    
    expect(self.router.navigationController.topViewController).to.beKindOf([USExampleViewControllerTwo class]);
}

- (void)testComplexOpen
{
    [self.router map:@"/complex/one/:id" toController:[USExampleViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USExampleViewControllerTwo class]];
    [self.router map:@"/complex/three/:id" toController:[USExampleViewControllerThree class]];
    
    [self.router open:@"/complex/two/1"];
    
    expect(self.router.navigationController.topViewController).to.beKindOf([USExampleViewControllerTwo class]);
}

- (void)testMultipleOpen
{
    [self.router map:@"/complex/one/:id" toController:[USExampleViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USExampleViewControllerTwo class]];
    [self.router map:@"/complex/three/:id" toController:[USExampleViewControllerThree class]];
    
    [self.router open:@"/complex/one/1"];
    [self.router open:@"/complex/two/2"];
    [self.router open:@"/complex/three/3"];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(3);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USExampleViewControllerOne class]);
    expect(self.router.navigationController.viewControllers[1]).to.beKindOf([USExampleViewControllerTwo class]);
    expect(self.router.navigationController.viewControllers[2]).to.beKindOf([USExampleViewControllerThree class]);
}


#pragma mark - Parameters

- (void)testComplexOpenWithParameters
{
    [self.router map:@"/complex/:param1/:param2" toController:[USExampleViewControllerOne class]];
    
    [self.router open:@"/complex/1/5"];
    
    expect([self.router.navigationController.topViewController isKindOfClass:[USExampleViewControllerOne class]]);
    NSDictionary *parameters = [(USExampleViewControllerOne *)self.router.navigationController.topViewController parameters];
    
    expect(parameters[@"param1"]).to.equal(@"1");
    expect(parameters[@"param2"]).to.equal(@"5");
}

- (void)testComplexParametersWithDashesAndSpaces
{
    NSString *value = @"Hey, I got spaces and /dashes";
    [self.router map:@"/complex/:param" toController:[USExampleViewControllerOne class]];
    [self.router open:[NSString stringWithFormat:@"/complex/%@", [value us_URLEncodedString]]];
    
    expect([self.router.navigationController.topViewController isKindOfClass:[USExampleViewControllerOne class]]);
    
    NSDictionary *parameters = [(USExampleViewControllerOne *)self.router.navigationController.topViewController parameters];
    expect([parameters[@"param"] us_URLDecodedString]).to.equal(value);
}


#pragma mark - Poping

- (void)testPop
{
    [self.router map:@"/complex/one/:id" toController:[USExampleViewControllerOne class]];
    [self.router map:@"/complex/two/:id" toController:[USExampleViewControllerTwo class]];
    
    [self.router open:@"/complex/one/1"];
    [self.router open:@"/complex/two/2"];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(2);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USExampleViewControllerOne class]);
    expect(self.router.navigationController.viewControllers[1]).to.beKindOf([USExampleViewControllerTwo class]);
    
    [self.router pop];
    
    expect(self.router.navigationController.viewControllers).to.haveCountOf(1);
    expect(self.router.navigationController.viewControllers[0]).to.beKindOf([USExampleViewControllerOne class]);
}



#pragma mark - iOS7 Transitions, yesir

- (void)testMappingsWithTransitions
{
    // mock a transitioning
    id<USRouterViewControllerAnimatedTransitioning> transitioning = mockProtocol(@protocol(USRouterViewControllerAnimatedTransitioning));
    [given([transitioning us_canHandleAnimatedTransitioningFromViewController:anything()
                                                                 toController:anything()
                                                                    operation:UINavigationControllerOperationPush])
     willReturnBool:YES];
    
    // set up the routes
    [self.router map:@"/root" toController:[USExampleViewControllerOne class]];
    [self.router map:@"/simple" toController:[USExampleViewControllerTwo class] withTansitionings:@[transitioning]];

    [self.router open:@"/root"];
    
    // needs to call second -open: after delay, so that the UINavigationController actually performs an animated transition
    {
        double delayInSeconds = 0.0;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void) {
            [self.router open:@"/simple"];
        });
    }
    
    // wait 0.2 seconds for the push animation to happen, than verify the mocks
    {
        double delayInSeconds = 0.2;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            [verifyCount(transitioning, atLeastOnce()) animateTransition:anything()];
            [self notify:XCTAsyncTestCaseStatusSucceeded];
        });
    }
    
    // wait 2.0 seconds for the animation to run & the mock verification after 0.2 seconds
    [self waitForStatus:XCTAsyncTestCaseStatusSucceeded timeout:2.0];
}

@end
