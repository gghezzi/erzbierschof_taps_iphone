//
//  RatingBrowseViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/1/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "RatingBrowseViewController.h"
#import "MBProgressHUD.h"

@implementation RatingBrowseViewController

@synthesize ratingUrl;

- (void)setDetailItems:(id)newDetailItem
{
    if (self.ratingUrlItem != newDetailItem) {
        self.ratingUrlItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.ratingUrl = self.ratingUrlItem;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)becomeActive:(NSNotification *)note
{
    [self viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];

    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    hud.labelText = @"Loading the rating page";
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.ratingUrl];
    [_webView loadRequest:requestObj];
    BOOL loading = _webView.loading;
    while(loading) {
        loading = _webView.loading;
    }
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
