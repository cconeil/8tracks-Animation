//
//  CCO8trackView.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIColor+_tracks.h"


#define MIN_t 0.0000001
#define START_t 3 * M_PI_2
#define MAX_t 2.0 * M_PI
#define INCREMENT_t 0.01

@interface CCO8trackView : UIView {
    float offset, a, lineWidth, padding;
}

@property NSInteger numRepeats; // defaults to 0
@property float duration; // defaults to 2.5
@property (nonatomic, strong) UIColor *bgColor; // defaults to clear
@property (nonatomic, strong) UIColor *graphColor; // defaults to paleWhite

-(void)animate;

@end
