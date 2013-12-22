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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

//- (void)loadView {
//    self.view = [[CCOMainView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
//    self.view.delegate = self;
//}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // handle startView
    self.view.backgroundColor = [UIColor blueTrack];
    self.startView = [[CCOMainView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
    self.startView.backgroundColor = [UIColor blueTrack];
    self.startView.delegate = self;
    [self.view addSubview:self.startView];
    
    // handle tableView
    self.tableViewData = [NSMutableArray arrayWithArray:@[@"Hey!", @"You", @"should", @"pull", @"to", @"refresh!", @":)"]];
    self.tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"Cell"];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [self.startView drawLogo];
}


// Protocol from the startView that is called when the startView finishes
// loading the
-(void)finishedLoading {
    
    NSLog(@"FINISHED LOADING");
    // Switch to our tableView
    [UIView animateWithDuration:.1 animations:^{
        self.startView.hidden = YES;
    } completion:^(BOOL finished) {
        [self.startView removeFromSuperview];
        [self.view addSubview:self.tableView];
    }];
}

#pragma mark Table View
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.tableViewData count];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    NSString *text = [self.tableViewData objectAtIndex:indexPath.row];
    cell.textLabel.text = text;
    
    return cell;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
