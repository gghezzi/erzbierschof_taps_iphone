//
//  RatingBrowseViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/1/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RatingBrowseViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIWebView *webView;

@property (strong) NSURL *ratingUrl;
@property (strong, nonatomic) id ratingDetailItem;

@end
