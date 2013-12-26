//
//  NSString+USRouter.h
//  Festool
//
//  Created by Ullrich Schäfer on 26/12/13.
//  Copyright (c) 2013 Ullrich Schäfer. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (USRouter)

- (NSString *)us_URLEncodedString;

- (NSString *)us_URLDecodedString;

@end
