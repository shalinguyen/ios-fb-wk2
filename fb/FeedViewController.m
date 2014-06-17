//
//  FeedViewController.m
//  fb
//
//  Created by Shali Nguyen on 6/16/14.
//  Copyright (c) 2014 shali. All rights reserved.
//

#import "FeedViewController.h"


@interface FeedViewController ()
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UITabBarItem *newsFeedBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (void)activityLoader;

@end

@implementation FeedViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)activityLoader {
    [self.activityIndicator stopAnimating];
    [self.scrollView setHidden:NO];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self performSelector:@selector(activityLoader) withObject:nil afterDelay:2];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
