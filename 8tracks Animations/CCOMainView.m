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


-(void)add8track {
    CCO8trackView *v = [[CCO8trackView alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
    [self addSubview:v];
    [v go];
}

-(void)addImage {
    
    UIImage *image = [UIImage imageNamed:@"8tracks.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(7, 12, 180, 180)];
    imageView.image = image;
    [self addSubview:imageView];
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
//- (void)drawRect:(CGRect)rect
//{
//    
//}


@end
