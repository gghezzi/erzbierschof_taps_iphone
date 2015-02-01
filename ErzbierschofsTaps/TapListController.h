//
//  DetailViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface TapListController : UITableViewController{
    IBOutlet UIButton *refreshButton;
}
@property (nonatomic, retain) UIButton *refreshButton;
@property (strong, nonatomic) id detailItem;
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong) Bar *bar;
@property (nonatomic) NSArray *taps;
- (void)configureView;
- (IBAction)refreshPressed:(id)sender;
@end
