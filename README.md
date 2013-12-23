8tracks-Animation
=================

An animation for 8tracks


## Check it out.
##### 1. Open the app and watch the 8tracks animation in the MainView
##### 2. Swipe right to the tableView to read the my message
##### 3. Pull to refresh to see the CCO8tracksRefreshControl animation

## COO8trackView
### properties
    NSInteger numRepeats; // defaults to 0
    float duration; // defaults to 2.5
    UIColor *graphColor; // defaults to paleWhite
### methods
    -(void)animate; // starts drawing the 8tracks logo
    -(void)stopAnimating; // stops drawing the 8tracks logo & removes it
    -(BOOL)isAnimating; // returns YES if the logo is animating
### protocol
    -(void)startedAnimating; // fires when the logo starts animating
    -(void)stoppedAnimating; // fires when the logo stops animating

## COO8tracksUIRefreshControl
### properties
    UITableView* tableView; // weak instance of the tableView it's refreshing
    id target; // target for selector
    SEL refreshAction; // the action that is called for refresh
    NSDate *refreshBeginTime; // will be the time that the refresh begins
    UILabel* releaseToRefreshLabel; // label that indicates "Pull down to refresh"
    CCO8trackView *logo; // the 8tracks logo
### methods
    +(CCO8tracksUIRefreshControl *)attachToTableView:(UITableView *)tableView withTarget:(id)target andAction:(SEL)refreshAction; // creates a UIRefreshControl and addis it to the given tableView with the given target and given selector
    -(void)finishedLoading; // called when the Controller finishes loading data
    -(void)tableViewScrolled; // called when Controller receives delegate method for scrolling
    -(void)userStoppedDragging; // called when Controller recieves delegate method for stopped scrolling

