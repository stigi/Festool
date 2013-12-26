//
//  USExampleViewController.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USExampleViewController.h"

@interface USExampleViewController ()

@end

@implementation USExampleViewController

- (instancetype)initWithRouterParameters:(NSDictionary *)parameters;
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        self.parameters = parameters;
    }
    return self;
}

@end
