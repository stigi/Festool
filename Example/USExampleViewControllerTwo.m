//
//  USExampleViewControllerTwo.m
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import "USExampleViewControllerTwo.h"

#import "USRouter.h"


@interface USExampleViewControllerTwo ()
@property UITextField *textField;
@end

@implementation USExampleViewControllerTwo

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Two";
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    self.textField = [[UITextField alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds) - 40, 40)];
    self.textField.backgroundColor = [UIColor whiteColor];
    self.textField.placeholder = @"Enter name";
    self.textField.center = self.view.center;
    [self.view addSubview:self.textField];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button setTitle:@"Open Three" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(openThree:) forControlEvents:UIControlEventTouchUpInside];
    [button sizeToFit];
    button.center = CGPointMake(self.view.center.x, self.view.center.y + 50);
    [self.view addSubview:button];
}

- (IBAction)openThree:(id)sender
{
    [[USRouter sharedRouter] open:[NSString stringWithFormat:@"/three/%@", self.textField.text]];
}

@end
