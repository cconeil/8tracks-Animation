//
//  CCO8tracksUIRefreshControl.m
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/22/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CCO8tracksUIRefreshControl.h"

@implementation CCO8tracksUIRefreshControl




+(CCO8tracksUIRefreshControl *)attachToTableView:(UITableView *)tableView withTarget:(id)target andAction:(SEL)refreshAction {
    
    if (tableView.tableHeaderView != nil) {
        [NSException raise:@"Couldn't attach an CCO8tracksUIRefreshControl to the tableView because there is already a header view." format:@""];
        return nil;
    }
    
    CCO8tracksUIRefreshControl *refreshControl = [[CCO8tracksUIRefreshControl alloc]
                                                  initWithFrame:CGRectMake(tableView.frame.origin.x,
                                                                           tableView.frame.origin.y,
                                                                           tableView.frame.size.width,
                                                                           kRefreshControlFullHeight)];

    [tableView setTableHeaderView:refreshControl];
    refreshControl.tableView = tableView;
    refreshControl.target = target;
    refreshControl.refreshAction = refreshAction;
    
    UIEdgeInsets currentInsets = tableView.contentInset;
    currentInsets.top = -kRefreshControlFullHeight;
    tableView.contentInset = currentInsets;
    
    return refreshControl;
}


-(id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blueTrack];
        self.clipsToBounds = YES;
        
        self.state = CCO8tracksUIRefreshControlStateIdle;
        self.logo = [[CCO8trackView alloc] initWithFrame:CGRectMake(kWidth / 2 - kRefreshLogoSize / 2,
                                                                    self.frame.size.height - kRefreshLogoSize,
                                                                    kRefreshLogoSize,
                                                                    kRefreshLogoSize)];
        self.logo.graphColor = [UIColor clouds];
        self.logo.duration = .8;
        self.logo.numRepeats = 100;
        
        // release to refresh label.
        self.releaseToRefreshLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,
                                                                               self.frame.size.height - kRefreshLogoSize / 2,
                                                                               kWidth,
                                                                               kRefreshLogoSize / 2)];
        self.releaseToRefreshLabel.text = @"Pull down to refresh.";
        self.releaseToRefreshLabel.textColor = [UIColor whiteColor];
        self.releaseToRefreshLabel.textAlignment = NSTextAlignmentCenter;
        self.releaseToRefreshLabel.font = [UIFont fontWithName:@"Helvetica" size:20.0];
        
        [self addSubview:self.logo];
        [self addSubview:self.releaseToRefreshLabel];
    }
    return self;
}


-(void)userStoppedDragging {
    if (self.state == CCO8tracksUIRefreshControlStateIdle) {
        if(self.tableView.contentOffset.y < (kRefreshControlFullHeight - kRefreshControlStandardHeight)) {

            self.state = CCO8tracksUIRefreshControlStateRefreshing;
            self.refreshBeginTime = [NSDate date];

            // Put the view back into place.
            __weak CCO8tracksUIRefreshControl *weakSelf = self;
            UIEdgeInsets newInsets = self.tableView.contentInset;
            newInsets.top = -(kRefreshControlFullHeight - kRefreshControlStandardHeight);
            
            [UIView animateWithDuration:0.2f animations:^(void){
                weakSelf.tableView.contentInset = newInsets;
            }];
            
            [UIView animateWithDuration:.01 animations:^{
                [self.releaseToRefreshLabel setAlpha:0.0];
            }];
            
            [self.logo animate];
            
            //Let the target know
            [self.target performSelector:self.refreshAction];
        }
    }
}

#pragma mark - Resetting after loading finished

- (void)timerFireMethod:(NSTimer *)timer {
    [self finishedLoading];
}


- (void)finishedLoading
{
    if (self.state != CCO8tracksUIRefreshControlStateRefreshing) {
        return;
    }
    
    NSTimeInterval elapsed = -[self.refreshBeginTime timeIntervalSinceNow];
    if (elapsed < 1.0f) {
        [NSTimer scheduledTimerWithTimeInterval:1.01f - elapsed target:self selector:@selector(timerFireMethod:) userInfo:nil repeats:NO];
        return;
    }
    
    self.state = CCO8tracksUIRefreshControlStateResetting;
    __weak CCO8tracksUIRefreshControl *weakSelf = self;
    UIEdgeInsets newInsets = self.tableView.contentInset;
    newInsets.top = -kRefreshControlFullHeight;
    
    [UIView animateWithDuration:.2f animations:^{
        weakSelf.tableView.contentInset = newInsets;
    } completion:^(BOOL finished) {
        [self.logo stopAnimating];
        weakSelf.state = CCO8tracksUIRefreshControlStateIdle;
    }];
}


- (void)tableViewScrolled {
    if(self.state == CCO8tracksUIRefreshControlStateIdle) {
        //Moving and rotating the paddles and ball into place
        
        CGFloat rawOffset = kRefreshControlFullHeight - self.tableView.contentOffset.y;
        CGFloat offset = MIN(rawOffset / 2.0f, kRefreshControlHalfHeight);
        CGFloat proportionToMaxOffset = (offset / kRefreshControlHalfHeight);
        self.releaseToRefreshLabel.alpha = proportionToMaxOffset;
    }
}



@end
