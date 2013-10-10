//
//  FindBarViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "FindBarViewController.h"
#import "BarLocation.h"
#define METERS_PER_MILE 1609.344

@implementation FindBarViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newLocationItem
{
    if (self.locationItem != newLocationItem) {
        self.locationItem = newLocationItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)becomeActive:(NSNotification *)note
{
    [self viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.locationItem) {
        self.bar = self.locationItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureView];
	// Do any additional setup after loading the view.
    CLLocationCoordinate2D barLocation;
    barLocation.latitude = self.bar.latitude;
    barLocation.longitude= self.bar.longitude;

    BarLocation *barAnnotation = [[BarLocation alloc] initWithName:self.bar.name barStreet:self.bar.address barCity:self.bar.city barCoordinate:barLocation] ;
    MKCoordinateRegion viewRegion = MKCoordinateRegionMakeWithDistance(barLocation, 1*METERS_PER_MILE, 1*METERS_PER_MILE);
    
    [self.mapView setRegion:viewRegion animated:YES];
    [self.mapView addAnnotation:barAnnotation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
