//
//  RatingBrowseView.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/1/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "RatingBrowseView.h"

@implementation RatingBrowseView

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

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *fullURL = @"http://conecode.com";
    NSURL *url = [NSURL URLWithString:fullURL];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_viewWeb loadRequest:requestObj];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
