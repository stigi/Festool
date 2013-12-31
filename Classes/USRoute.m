//
//  USRoute.m
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <libkern/OSAtomic.h>

#import "USRoute.h"


@implementation USRoute

#pragma mark - Lifecycle

- (instancetype)initWithParameterPath:(NSString *)path
                  viewControllerClass:(Class)viewControllerClass;
{
    return [self initWithParameterPath:path viewControllerClass:viewControllerClass animatedTransitionings:nil];
}

- (instancetype)initWithParameterPath:(NSString *)path
                  viewControllerClass:(Class)viewControllerClass
               animatedTransitionings:(NSArray/*USRouterViewControllerAnimatedTransitioning*/*)animatedTransitionings;
{
    NSParameterAssert([viewControllerClass isSubclassOfClass:[UIViewController class]]);
    NSParameterAssert(path.length > 0);
    
    self = [super init];
    if (self) {
        _parameterPath = [path copy];
        _viewControllerClass = viewControllerClass;
        
        _parameters = [[self class] parametersFromPath:_parameterPath];
        _animatedTransitionings = [animatedTransitionings copy];
    }
    return self;
}


#pragma mark - Parsing Options

- (BOOL)matchesPath:(NSString *)path
{
    NSArray *parameterComponents = [self.parameterPath componentsSeparatedByString:@"/"];
    NSArray *pathComponents = [path componentsSeparatedByString:@"/"];

    if (pathComponents.count != parameterComponents.count) return NO;
    
    __block volatile uint32_t /*BOOL*/ matches = YES;
    [parameterComponents enumerateObjectsWithOptions:NSEnumerationConcurrent
                                          usingBlock:^(NSString *parameterSegment, NSUInteger idx, BOOL *stop)
     {
         NSString *pathSegment = [pathComponents objectAtIndex:idx];
         
         if ([parameterSegment hasPrefix:@":"] == NO) {
             BOOL segmentIsEqual = [pathSegment isEqualToString:parameterSegment];
             // thread safe version of matches &= segmentIsEqual
             *stop = !OSAtomicAnd32(segmentIsEqual, &matches);
         }
     }];
    return matches;
}

- (NSDictionary *)parameterValuesByParsingPath:(NSString *)path;
{
    NSArray *parameterComponents = [self.parameterPath componentsSeparatedByString:@"/"];
    NSArray *pathComponents = [path componentsSeparatedByString:@"/"];

    NSAssert2((pathComponents.count == parameterComponents.count),
              @"Path (%@) does not fit this routes parameter path (%@).", path, self.parameterPath);
    
    NSMutableDictionary *parameterValues = [NSMutableDictionary dictionary];
    
    // this would be a nice place for a map
    // NSDictionary *parameterToValue = [NSDictionary dictionaryWithObjects:pathComponents forKeys:parameterComponents];
    // parameterValues = [parameterToValue map:...];
    // but instead let's just do it like this
    [parameterComponents enumerateObjectsWithOptions:NSEnumerationConcurrent
                                          usingBlock:^(NSString *parameterSegment, NSUInteger idx, BOOL *stop)
     {
         NSString *pathSegment = [pathComponents objectAtIndex:idx];
         
         if ([parameterSegment hasPrefix:@":"]) {
             @synchronized(parameterValues) {
                 [parameterValues setValue:pathSegment forKey:[parameterSegment substringFromIndex:1]];
             }
         } else {
             NSAssert2([pathSegment isEqualToString:parameterSegment],
                       @"Path (%@) does not fit this routes parameter path (%@).", path, self.parameterPath);
         }
     }];
    
    return [parameterValues copy];
}


#pragma mark - Private

+ (NSSet *)parametersFromPath:(NSString *)path
{
    // The regex says:
    // There are three groups (?:)()(?:)
    // (?:) marks a group to not be captured
    // 1st group (?::) is the prefix ":"
    // 2nd group ((?:\\w|-)+) is the value to capture, consisting of multipe carachters or hyphens
    //     (note the non capturing group inside which only adds the hyphen to the set of characters)
    // 3rd group (?:/|$) is the end (either the next slash or EOL)
    // Again: only the 2nd group is captured
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"(?::)((?:\\w|-)+)(?:/|$)"
                                                                           options:NSRegularExpressionCaseInsensitive
                                                                             error:nil];
    NSArray *matches = [regex matchesInString:path options:0 range:NSMakeRange(0, path.length)];
    NSMutableSet *parameterSet = [NSMutableSet set];
    
    for (NSTextCheckingResult *match in matches) {
        NSString *parameter = [path substringWithRange:[match rangeAtIndex:1]]; // 1 is the index of the first captured group

        NSAssert2([parameterSet containsObject:parameter] == NO,
                  @"Parameter \"%@\" appeared more than once in the path \"%@\"", parameter, path);
        
        [parameterSet addObject:parameter];
    }
    return [parameterSet copy];
}

@end
