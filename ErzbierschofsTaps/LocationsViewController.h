//
//  LocationsViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"

@interface LocationsViewController : UIViewController

@property (nonatomic, weak) IBOutlet UIButton* zurich_button;
@property (nonatomic, weak) IBOutlet UIButton* bern_button;
@property (nonatomic, weak) IBOutlet UIButton* liebefeld_button;
@property (nonatomic, weak) IBOutlet UIButton* winti_button;
@property (strong) NSArray *bars;
@property (strong) NSMutableDictionary *barButtonsMap;
@end
