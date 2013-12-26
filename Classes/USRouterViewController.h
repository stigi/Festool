//
//  USRouterViewController.h
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol USRouterViewController <NSObject>

@optional
- (instancetype)initWithRouterParameters:(NSDictionary *)parameters;

@end
