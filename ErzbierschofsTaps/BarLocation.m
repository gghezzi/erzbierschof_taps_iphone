//
//  BarLocation.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/3/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "BarLocation.h"
#import <AddressBook/AddressBook.h>

@implementation BarLocation

@synthesize name;
@synthesize street;
@synthesize theCoordinate;

- (id)initWithName:(NSString*)barName barStreet:(NSString*)barStreet barCity:(NSString*)barCity barCoordinate:(CLLocationCoordinate2D)barCoordinate {
    if ((self = [super init])) {
        self.name = barName;
        self.street = barStreet;
        self.city = barCity;
        self.theCoordinate = barCoordinate;
    }
    return self;
}

- (NSString *)title {
    return self.name;
}

- (NSString *)subtitle {
    return [NSString stringWithFormat:@"%@, %@", self.street, self.city];
}

- (CLLocationCoordinate2D)coordinate {
    return self.theCoordinate;
}

- (MKMapItem*)mapItem {
    NSDictionary *addressDict = @{(NSString*)kABPersonAddressStreetKey : self.street, (NSString*)kABPersonAddressCityKey : self.city};
    
    MKPlacemark *placemark = [[MKPlacemark alloc]
                              initWithCoordinate:self.coordinate
                              addressDictionary:addressDict];
    
    MKMapItem *mapItem = [[MKMapItem alloc] initWithPlacemark:placemark];
    mapItem.name = self.title;
    
    return mapItem;
}

@end