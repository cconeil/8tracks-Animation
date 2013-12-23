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
    _trackView.delegate = self;
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


// draws the logo on the screen
-(void)drawLogo {
    [_trackView animate];
}


// removes the logo for the view -- this should only be called when the view
// is moved off of the screen.
-(void)removeLogo {
    [_trackView stopAnimating];
}


// Will be called after the 8tracks logo is drawn
-(void)stoppedAnimating {
    [self.delegate finishedLoading];
}


@end
