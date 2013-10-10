//
//  FindBarViewController.h
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Bar.h"
#import <MapKit/MKMapView.h>
#import <MapKit/MKMapItem.h>
#import <AddressBook/AddressBook.h>

@interface FindBarViewController : UIViewController

@property (strong, nonatomic) id locationItem;
@property (strong) Bar *bar;
@property (strong, nonatomic) IBOutlet MKMapView *mapView;
@property (nonatomic) MKCoordinateRegion location;

@end
