//
//  TapTableCell.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/24/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "TapTableCell.h"

@implementation TapTableCell
@synthesize nameLabel = _nameLabel;
@synthesize detailsLabel = _detailsLabel;
@synthesize amountLabel = _abvLabel;
@synthesize tapNumLabel = _tapNumLabel;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
