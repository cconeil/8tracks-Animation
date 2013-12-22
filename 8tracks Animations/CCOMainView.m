//
//  CCOMainView.m
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CCOMainView.h"

@implementation CCOMainView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

-(void)setup {
    self.backgroundColor = [UIColor blueTrack];
    
    // add the logo
    float logoSize = 100.0, padding_x = kWidth * .05, padding_y = kHeight / 3;
    _trackView = [[CCO8trackView alloc] initWithFrame:CGRectMake(padding_x, padding_y, logoSize, logoSize)];
    _trackView.graphColor = [UIColor clouds];
    _trackView.duration = 2.0;
    [self addSubview:_trackView];
    
    // add the "tracks"
    tracks = [[UILabel alloc] initWithFrame:CGRectMake(logoSize , padding_y + 15.0, kWidth - padding_x * 2 - logoSize, logoSize)];
    tracks.text = @"tracks";
    tracks.font = [UIFont fontWithName:@"Helvetica" size:70.0];
    tracks.textColor = [UIColor clouds];
    [self addSubview:tracks];
    
    // add the "Radio, rediscovered."
    slogan = [[UILabel alloc] initWithFrame:CGRectMake(padding_x + 10.0, padding_y + logoSize - 20, kWidth - padding_x * 2, 60.0)];
    slogan.text = @"Radio, rediscovered.";
    slogan.font = [UIFont fontWithName:@"Helvetica" size:28.5];
    slogan.textColor = [UIColor clouds];
    [self addSubview:slogan];
}


-(void)drawLogo {
    [_trackView animate];
}


// Will be called after the 8tracks logo is drawn
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    [self.delegate finishedLoading];
}

BOOL isOn = NO;

-(void)add8track {
    
    if (!isOn) {
        isOn = YES;
        CCO8trackView *v = [[CCO8trackView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        v.numRepeats = 0;
        v.graphColor = [UIColor clouds];
        
        
        [self addSubview:v];
        [v animate];
    } else {
        isOn = NO;
        for (UIView *subview in [self subviews]) {
            if ([subview class] == [CCO8trackView class]) {
                [subview removeFromSuperview];
            }
        }
    }
}

-(void)addImage {
    UIImage *image = [UIImage imageNamed:@"8tracks.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(9, 12, 180, 180)];
    imageView.image = image;
    [self addSubview:imageView];
}


@end
