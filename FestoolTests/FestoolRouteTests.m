//
//  FestoolRouteTests.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "FestoolTestCase.h"

#import "USRoute.h"

@interface FestoolRouteTests : FestoolTestCase

@end

@implementation FestoolRouteTests

#pragma mark - Creation

- (void)testInitWithPath
{
    NSString *path = @"/users";
    USRoute *route = [[USRoute alloc] initWithParameterPath:path viewControllerClass:[UIViewController class]];
    
    expect(route).toNot.beNil();
    expect(route.parameterPath).to.equal(path);
}


#pragma mark - Creation with wrong parameters

- (void)testInitRaisesOnWrongControllerClass
{
    expect(^{
        USRoute *route = [[USRoute alloc] initWithParameterPath:@"/users" viewControllerClass:[NSObject class]];
        route = route; // silence unused variable warning the lazy way
    }).to.raiseAny();
}

- (void)testInitRaisesOnNilControllerClass
{
    expect(^{
        USRoute *route = [[USRoute alloc] initWithParameterPath:@"/users" viewControllerClass:nil];
        route = route; // silence
    }).to.raiseAny();
}

- (void)testInitRaisesOnEmptyPath
{
    expect(^{
        USRoute *route = [[USRoute alloc] initWithParameterPath:@"" viewControllerClass:[UIViewController class]];
        route = route; // silence
    }).to.raiseAny();
}

- (void)testInitRaisesOnNilPath
{
    expect(^{
        USRoute *route = [[USRoute alloc] initWithParameterPath:nil viewControllerClass:[UIViewController class]];
        route = route; // silence
    }).to.raiseAny();
}


#pragma mark - Parameter parsing

- (void)testFindingOfParameters
{
    NSString *routePath = @"/users/:id/tracks/:track-id";
    
    USRoute *route = [[USRoute alloc] initWithParameterPath:routePath viewControllerClass:[UIViewController class]];
    
    expect(route.parameters).to.contain(@"id");
    expect(route.parameters).to.contain(@"track-id");
    expect(route.parameters).to.haveCountOf(2);
}

- (void)testDoubleParametersRaisesException
{
    NSString *badRoutePath = @"/users/:id/again/:id";
    
    expect(^{
        USRoute *route = [[USRoute alloc] initWithParameterPath:badRoutePath viewControllerClass:[UIViewController class]];
        route = route; // silence
    }).to.raiseAny();
}


#pragma mark - Option parsing

- (void)testParsingOfOptions
{
    NSString *path = @"/users/3/tracks/4";
    NSString *routePath = @"/users/:id/tracks/:track-id";
    
    USRoute *route = [[USRoute alloc] initWithParameterPath:routePath viewControllerClass:[UIViewController class]];

    NSDictionary *options = [route parameterValuesByParsingPath:path];

    expect(options).to.haveCountOf(2);
    expect(options[@"id"]).to.equal(@"3");
    expect(options[@"track-id"]).to.equal(@"4");
}


@end
