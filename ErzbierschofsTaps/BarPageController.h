//
//  BarPageController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface BarPageController : UIViewController

@property (nonatomic, weak) IBOutlet UIImageView *bar_logo_view;
@property (nonatomic, weak) IBOutlet UIButton* tap_button;
@property (nonatomic, weak) IBOutlet UIButton* call_button;
@property (nonatomic, weak) IBOutlet UIButton* find_button;
@property (strong, nonatomic) id detailItem;
@property (strong) Bar *bar;
//@property (strong, nonatomic) UIPopoverController *masterPopoverController;


@end
