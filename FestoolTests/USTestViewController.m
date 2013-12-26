//
//  USTestViewController.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USTestViewController.h"

@interface USTestViewController ()

@end

@implementation USTestViewController

- (instancetype)initWithRouterParameters:(NSDictionary *)parameters;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.parameters = parameters;
    }
    return self;
}

@end
