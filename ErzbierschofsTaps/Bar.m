//
//  Bar.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "Bar.h"

@implementation Bar
@synthesize name = _name;
@synthesize url = _url;

-(id)initWithName:(NSString *)name url:(NSString *)url
{
    self = [super init];
    if (self) {
        _name = name;
        _url = url;
        return self;
    }
    return nil;
}
@end
