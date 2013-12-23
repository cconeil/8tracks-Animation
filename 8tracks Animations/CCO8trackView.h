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
#import "Constants.h"

@protocol CCO8trackViewDelegate <NSObject>

-(void)startedAnimating;
-(void)stoppedAnimating;

@end


@interface CCO8trackView : UIView {
    float offset, a, lineWidth, padding;
    CAShapeLayer *logo;
    BOOL animating;
}

@property (nonatomic, weak) id delegate;
@property NSInteger numRepeats; // defaults to 0
@property float duration; // defaults to 2.5
@property (nonatomic, strong) UIColor *graphColor; // defaults to paleWhite

-(void)animate;
-(void)stopAnimating;
-(BOOL)isAnimating;

@end
