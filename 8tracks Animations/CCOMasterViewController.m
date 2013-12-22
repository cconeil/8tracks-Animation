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


- (void)loadView {
    self.view = [[CCOMainView alloc] initWithFrame:CGRectMake(0, 0, kWidth, kHeight)];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor greenColor];
    
    // add gesture recognizer for a tap.
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(backgroundTouched:)];
    [self.view addGestureRecognizer:tap];
}

-(IBAction)backgroundTouched:(id)sender {
    NSLog(@"Background touched");
    [self.view add8track];
}





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
