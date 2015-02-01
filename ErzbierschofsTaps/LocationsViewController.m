//
//  LocationsViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "LocationsViewController.h"
#import "BarPageController.h"
#import "FindBarViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKMapItem.h>

@implementation LocationsViewController

@synthesize bars;
@synthesize winti_button;
@synthesize bern_button;
@synthesize zurich_button;
@synthesize liebefeld_button;
@synthesize barButtonsMap;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    self.title = @"Locations";
    self.barButtonsMap = [NSMutableDictionary dictionary];
    self.barButtonsMap[self.bern_button.restorationIdentifier] = self.bars[0];
    self.barButtonsMap[self.zurich_button.restorationIdentifier] = self.bars[1];
    self.barButtonsMap[self.liebefeld_button.restorationIdentifier] = self.bars[2];
    self.barButtonsMap[self.winti_button.restorationIdentifier] = self.bars[3];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BarPageController *barController = segue.destinationViewController;
    Bar *bar = self.barButtonsMap[((UIButton*) sender).restorationIdentifier];
    barController.detailItem = bar;
}

@end
