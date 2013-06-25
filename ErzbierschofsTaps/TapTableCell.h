//
//  TapTableCell.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/24/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TapTableCell : UITableViewCell
@property (nonatomic, weak) IBOutlet UILabel *nameLabel;
@property (nonatomic, weak) IBOutlet UILabel *detailsLabel;
@property (nonatomic, weak) IBOutlet UILabel *amountLabel;
@property (nonatomic, weak) IBOutlet UILabel *tapNumLabel;
@end
