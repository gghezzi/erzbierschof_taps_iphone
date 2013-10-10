//
//  Bar.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface Bar : NSObject
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *url;
@property (nonatomic) UIImage *image;
@property (nonatomic) NSURL *phone;
@property (nonatomic) double latitude;
@property (nonatomic) double longitude;
@property (nonatomic) NSString *address;
@property (nonatomic) NSString *city;

-(id)initWithName:(NSString *)name url:(NSString *)url image:(UIImage *)image phone:(NSURL *)phone latitude:(double)latitude longitude:(double)longitude address:(NSString *)address city:(NSString *)city;
@end
