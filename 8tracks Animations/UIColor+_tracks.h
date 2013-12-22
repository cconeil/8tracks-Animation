//
//  UIColor+_tracks.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/22/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (_tracks)

+ (UIColor *) colorFromHexCode:(NSString *)hexString;

// custom colors
+(UIColor *)paleWhite;
+(UIColor *)paleGray;
+(UIColor *)blueTrack;
+(UIColor *)clouds;


@end
