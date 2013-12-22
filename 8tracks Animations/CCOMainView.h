//
//  CCOMainView.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "CCO8trackView.h"
#import "UIColor+_tracks.h"
#import "Constants.h"

@protocol COOMainViewDelegate <NSObject>
-(void)finishedLoading;
@end


@interface CCOMainView : UIView {
    CCO8trackView *_trackView;
    UILabel *tracks, *slogan;
}

@property (nonatomic, weak) id delegate;

-(void)add8track;
-(void)drawLogo;

@end
