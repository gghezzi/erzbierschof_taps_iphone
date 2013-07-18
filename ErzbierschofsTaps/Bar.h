//
//  Bar.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Bar : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;
@property (nonatomic) UIImage *image;
-(id)initWithName:(NSString *)name url:(NSString *)url image:(UIImage *)image;
@end
