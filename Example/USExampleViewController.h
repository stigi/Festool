//
//  USExampleViewController.h
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "USRouterViewController.h"

@interface USExampleViewController : UIViewController <USRouterViewController>

@property NSDictionary *parameters;

@end
