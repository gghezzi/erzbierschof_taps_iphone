//
//  Bar.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "Bar.h"

// Class used to keep information about an Erbierschof bar
@implementation Bar
@synthesize name = _name;
@synthesize url = _url;
@synthesize image = _image;
@synthesize phone = _phone;
@synthesize latitude = _latitude;
@synthesize longitude = _longitude;
@synthesize city = _city;
@synthesize address = _address;

-(id)initWithName:(NSString *)name url:(NSString *)url image:(UIImage *)image phone:(NSURL *)phone latitude:(double)latitude longitude:(double)longitude address:(NSString *)address city:(NSString *)city
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
        _image = image;
        _phone = phone;
        _longitude = longitude;
        _latitude = latitude;
        _city = city;
        _address = address;
        return self;
    }
    return nil;
}
@end
