//
//  USExampleViewControllerThree.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USExampleViewControllerThree.h"

#import "USRouter.h"


@interface USExampleViewControllerThree ()

@end

@implementation USExampleViewControllerThree

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Three";
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.text = self.parameters[@"name"];
    [label sizeToFit];
    label.center = self.view.center;
    [self.view addSubview:label];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Pop" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(pop:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:button];
}

- (IBAction)pop:(id)sender
{
    [[USRouter sharedRouter] pop];
}

@end
