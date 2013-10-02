//
//  TapInfo.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TapInfo : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *brewery;
@property (nonatomic, copy) NSString *quantity;
@property (nonatomic, copy) NSString *style;
@property (nonatomic, copy) NSString *abv;
@property (nonatomic, copy) NSString *country;
@property (nonatomic, copy) NSString *tapNum;

@end
