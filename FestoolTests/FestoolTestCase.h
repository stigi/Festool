//
//  FestoolTestCase.h
//  Festool
//
//  Created by Ullrich Schäfer on 25/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#define EXP_SHORTHAND
#import <Expecta/Expecta.h>

#define MOCKITO_SHORTHAND
#import <OCMockito/OCMockito.h>

#import "USTestViewControllerOne.h"
#import "USTestViewControllerTwo.h"
#import "USTestViewControllerThree.h"

@interface FestoolTestCase : XCTestCase

@end
