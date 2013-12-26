//
//  USExampleViewControllerOne.h
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USExampleViewControllerOne.h"

#import "USRouter.h"

@interface USExampleViewControllerOne ()

@end

@implementation USExampleViewControllerOne

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"One";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Open Two" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openTwo:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = self.view.center;
    [self.view addSubview:button];
}

- (IBAction)openTwo:(id)sender
{
    [[USRouter sharedRouter] open:@"/two"];
}
@end
