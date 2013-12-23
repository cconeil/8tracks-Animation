//
//  CCOMasterViewController.m
//  8tracks Animations
//
//  Created by Chris O'Neil on 12/21/13.
//  Copyright (c) 2013 Chris O'Neil. All rights reserved.
//

#import "CCOMasterViewController.h"



@interface CCOMasterViewController ()

@end

@implementation CCOMasterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // handle startView
    self.view.backgroundColor = [UIColor blueTrack];
    self.startView = [[CCOMainView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.startView.backgroundColor = [UIColor blueTrack];
    self.startView.delegate = self;
    [self.view addSubview:self.startView];
    
    // handle tableView
    self.tableViewData = [NSMutableArray arrayWithArray:@[@"Hey!", @"You", @"should", @"pull", @"to", @"refresh!", @":)"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(kWidth, 0, kWidth, kHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
    [self.view addSubview:self.tableView];
    
    // add refresh
    self.refreshControl = [CCO8tracksUIRefreshControl attachToTableView:self.tableView withTarget:self andAction:@selector(mockRefresh)];
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.startView drawLogo];
}


#pragma mark COOMainViewDelegate
// Protocol from the startView that is called when the startView finishes
// loading the logo -- here we add a tap gesture recognizer that will load the
// the tableView if it hasn't loaded.
-(void)finishedLoading {
    if (swipe == nil) {
        swipe = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(goToTableView)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [self.view addGestureRecognizer:swipe];
    }
}


// Takes us to the tableView
-(void)goToTableView {
    __weak CCOMasterViewController *weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        [weakSelf.startView setFrame:CGRectMake(-kWidth, 0, kWidth, kHeight)];
        [weakSelf.tableView setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    } completion:^(BOOL finished) {
        // change swipe gesutre
        [self.startView removeLogo];
        [swipe removeTarget:weakSelf action:@selector(goToTableView)];
        [swipe addTarget:weakSelf action:@selector(goToMainView)];
        swipe.direction = UISwipeGestureRecognizerDirectionRight;
    }];
}

-(void)goToMainView {
    __weak CCOMasterViewController *weakSelf = self;
    [UIView animateWithDuration:.2 animations:^{
        [weakSelf.tableView setFrame:CGRectMake(kWidth, 0, kWidth, kHeight)];
        [weakSelf.startView setFrame:CGRectMake(0, 0, kWidth, kHeight)];
    } completion:^(BOOL finished) {
        // change swipe gesutre
        [swipe removeTarget:weakSelf action:@selector(goToMainView)];
        [swipe addTarget:weakSelf action:@selector(goToTableView)];
        swipe.direction = UISwipeGestureRecognizerDirectionLeft;
        [weakSelf.startView drawLogo];
    }];
}


#pragma mark Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [self.tableViewData count];
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *text = [self.tableViewData objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

#pragma mark Memory Warnings
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Scrolling + UIRefresh
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    [self.refreshControl tableViewScrolled];
}


- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    [self.refreshControl userStoppedDragging];
}


// This is a fake refresh, It will pause for 1 second and then finish refreshing.
-(void)mockRefresh {
    [NSTimer scheduledTimerWithTimeInterval:1.01f target:self selector:@selector(mockFinish) userInfo:nil repeats:NO];
}


-(void)mockFinish {
    [self.refreshControl finishedLoading];
}


@end
