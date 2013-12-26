//
//  FestoolNSStringTests.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "FestoolTestCase.h"

#import "NSString+USRouter.h"

@interface FestoolNSStringTests : FestoolTestCase
@end

@implementation FestoolNSStringTests

- (void)testURLEncode
{
    NSString *string =
    @"Hello, I am a NSString that needs character encoding. "
    @"Especially for my /dashes, (paratheses) and \"quotes\"";
    
    NSString *encoded =
    @"Hello%2C%20I%20am%20a%20NSString%20that%20needs%20character%20encoding.%20"
    @"Especially%20for%20my%20%2Fdashes%2C%20%28paratheses%29%20and%20%22quotes%22";
    
    expect([string us_URLEncodedString]).to.equal(encoded);
}

- (void)testURLDecode
{
    NSString *string =
    @"Hello%2C%20I%20am%20a%20NSString%20that%20needs%20character%20encoding.%20"
    @"Especially%20for%20my%20%2Fdashes%2C%20%28paratheses%29%20and%20%22quotes%22";
    
    NSString *decoded =
    @"Hello, I am a NSString that needs character encoding. "
    @"Especially for my /dashes, (paratheses) and \"quotes\"";
    
    expect([string us_URLDecodedString]).to.equal(decoded);
}

@end
