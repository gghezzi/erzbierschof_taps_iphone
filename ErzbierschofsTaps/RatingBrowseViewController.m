//
//  RatingBrowseViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/1/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "RatingBrowseViewController.h"


@implementation RatingBrowseViewController

@synthesize ratingUrl;

- (void)setDetailItem:(id)newDetailItem
{
    if (self.ratingDetailItem != newDetailItem) {
        self.ratingDetailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    self.ratingUrl = self.ratingDetailItem;
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
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.ratingUrl];
    [_webView loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
