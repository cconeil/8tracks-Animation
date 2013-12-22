//
//  CCO8trackView.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


#define MIN_t 0.0000001
#define START_t 3 * M_PI_2
#define MAX_t 2.0 * M_PI
#define INCREMENT_t 0.01

@interface CCO8trackView : UIView {
    float offset, a, lineWidth;
}

@property NSInteger numRepeats;

-(void)animate;

@end
