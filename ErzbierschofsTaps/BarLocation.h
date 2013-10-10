//
//  BarLocation.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/3/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface BarLocation : NSObject <MKAnnotation>
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *street;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, assign) CLLocationCoordinate2D theCoordinate;
- (id)initWithName:(NSString*)name barStreet:(NSString*)barStreet barCity:(NSString*)barCity barCoordinate:(CLLocationCoordinate2D)barCoordinate;
- (MKMapItem*)mapItem;
@end
