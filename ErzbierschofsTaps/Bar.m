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

-(id)initWithName:(NSString *)name url:(NSString *)url image:(UIImage *)image
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
        _image = image;
        return self;
    }
    return nil;
}
@end
