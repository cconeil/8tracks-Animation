//
//  CCOMasterViewController.h
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CCOMainView.h"
#import "UIColor+_tracks.h"
#import "Constants.h"

@interface CCOMasterViewController : UIViewController <COOMainViewDelegate, UITableViewDataSource, UITableViewDelegate>

@property (strong, nonatomic) CCOMainView *startView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *tableViewData;
@end
