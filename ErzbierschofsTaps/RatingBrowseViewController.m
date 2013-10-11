//
//  RatingBrowseViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/1/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "RatingBrowseViewController.h"
#import "MBProgressHUD.h"
#import "Reachability.h"

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
    // Check if there's connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Warning"
                              message:@"The application needs an internet connection to load the official ratings page"
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading the official rating page";
        NSURLRequest *requestObj = [NSURLRequest requestWithURL:self.ratingUrl];
        [_webView loadRequest:requestObj];
        [_webView setSuppressesIncrementalRendering:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
}

- (void)didFailLoadWithError:(UIWebView *)webView {
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Warning"
                          message:@"The official ratings page cannot be loaded"
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
}

@end
