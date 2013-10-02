//
//  BeerDetailsViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 9/16/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//
#import "TapInfo.h"
#import <UIKit/UIKit.h>

@interface BeerDetailsViewController : UIViewController
@property (nonatomic, weak) IBOutlet UILabel* nameLabel;
@property (nonatomic, weak) IBOutlet UILabel* breweryLabel;
@property (nonatomic, weak) IBOutlet UILabel* alcoholLabel;
@property (nonatomic, weak) IBOutlet UILabel* styleLabel;
@property (nonatomic, weak) IBOutlet UIButton* ratingButton_1;
@property (nonatomic, weak) IBOutlet UIButton* ratingButton_2;
@property (nonatomic, weak) IBOutlet UIButton* ratingButton_3;
@property (nonatomic, weak) IBOutlet UILabel* tapNumberLabel;
@property (strong, nonatomic) id beerDetailItem;
@property (strong) TapInfo *beerInfo;
@property (strong) NSString *ratebeerRating;
@property (strong) NSURL *ratebeerUrl;
@property (strong) NSString *untappdRating;
@property (strong) NSURL *untappdUrl;
@property (strong) NSString *beeradvocateRating;
@property (strong) NSURL *beeradvocatedUrl;
@property (strong) NSMutableDictionary *buttonUrls;
@property BOOL loaded;
@end
