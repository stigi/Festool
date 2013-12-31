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

#define HC_SHORTHAND
#import <OCHamcrest/OCHamcrest.h>

#import "XCTestCase+AsyncTesting.h"

#import "USExampleViewControllerOne.h"
#import "USExampleViewControllerTwo.h"
#import "USExampleViewControllerThree.h"
#import "USExampleTransitioning.h"

@interface FestoolTestCase : XCTestCase

@end
