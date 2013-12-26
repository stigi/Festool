//
//  USRoute.h
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface USRoute : NSObject
@property (readonly, strong) Class viewControllerClass;
@property (readonly, copy) NSString *parameterPath;

- (instancetype)initWithParameterPath:(NSString *)path
                  viewControllerClass:(Class)viewControllerClass;


- (NSDictionary *)parameterValuesByParsingPath:(NSString *)path;

/**
 Find out if the path is matched by this route
 
 \returns YES when this route can be applied to path
 */
- (BOOL)matchesPath:(NSString *)path;


/**
 Purely for information purposes
 */
@property (readonly, strong) NSSet *parameters;

@end
