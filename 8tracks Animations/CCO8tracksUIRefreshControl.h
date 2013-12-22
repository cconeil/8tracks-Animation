//
//  CCO8tracksUIRefreshControl.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/22/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Constants.h"
#import "UIColor+_tracks.h"
#import "CCO8trackView.h"

typedef enum {
    CCO8tracksUIRefreshControlStateIdle = 0,
    CCO8tracksUIRefreshControlStateRefreshing =1,
    CCO8tracksUIRefreshControlStateResetting = 2
} CCO8tracksUIRefreshControlState;

@interface CCO8tracksUIRefreshControl : UIView <UIScrollViewDelegate>


@property (nonatomic, assign) CCO8tracksUIRefreshControlState state;
@property (weak, nonatomic) UITableView* tableView;
@property (weak, nonatomic) id target;
@property (nonatomic) SEL refreshAction;

@property (nonatomic, strong) NSDate *refreshBeginTime;
@property (nonatomic, strong) UILabel* releaseToRefreshLabel;
@property (nonatomic, strong) CCO8trackView *logo;

+(CCO8tracksUIRefreshControl *)attachToTableView:(UITableView *)tableView withTarget:(id)target andAction:(SEL)refreshAction;

- (void)finishedLoading;
- (void)tableViewScrolled;
- (void)userStoppedDragging;


@end
