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
        
        [self addImage];
    }
    return self;
}

BOOL isOn = NO;

-(void)add8track {
    
    if (!isOn) {
        isOn = YES;
        CCO8trackView *v = [[CCO8trackView alloc] initWithFrame:CGRectMake(0, 0, 300, 300)];
        v.numRepeats = 0;
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
