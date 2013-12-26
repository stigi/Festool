//
//  NSString+USRouter.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "NSString+USRouter.h"

@implementation NSString (USRouter)

- (NSString *)us_URLEncodedString;
{
    return CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                                     (__bridge CFStringRef)(self),
                                                                     NULL,
                                                                     CFSTR(":/?#[]@!$&'()*+,;="),
                                                                     kCFStringEncodingUTF8));
}

- (NSString *)us_URLDecodedString;
{
    return CFBridgingRelease(CFURLCreateStringByReplacingPercentEscapesUsingEncoding(kCFAllocatorDefault,
                                                                                     (__bridge CFStringRef)(self),
                                                                                     CFSTR(""),
                                                                                     kCFStringEncodingUTF8));
}

@end
