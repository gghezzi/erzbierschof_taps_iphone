//
//  DetailViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UITableViewController{
    IBOutlet UIButton *refreshButton;
}
@property (nonatomic, retain) UIButton *refreshButton;
@property (strong, nonatomic) id detailItem;

-(IBAction)refreshPressed:(id)sender;
@end
