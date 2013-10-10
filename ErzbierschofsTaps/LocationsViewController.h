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

@property (nonatomic, weak) IBOutlet UIButton* tap_button_1;
@property (nonatomic, weak) IBOutlet UIButton* tap_button_2;
@property (nonatomic, weak) IBOutlet UIButton* call_button_1;
@property (nonatomic, weak) IBOutlet UIButton* call_button_2;
@property (nonatomic, weak) IBOutlet UIButton* find_button_1;
@property (nonatomic, weak) IBOutlet UIButton* find_button_2;
@property (strong) Bar *liebefeldBar;
@property (strong) Bar *winterthurBar;
@property (strong) NSMutableDictionary *tapButtonsMap;
@property (strong) NSMutableDictionary *callButtonsMap;
@property (strong) NSMutableDictionary *findButtonsMap;
@end
