//
//  LocationsViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 10/2/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "LocationsViewController.h"
#import "DetailViewController.h"
#import "FindBarViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKMapItem.h>

@implementation LocationsViewController

@synthesize liebefeldBar;
@synthesize winterthurBar;
@synthesize tap_button_1;
@synthesize tap_button_2;
@synthesize call_button_1;
@synthesize call_button_2;
@synthesize find_button_1;
@synthesize find_button_2;
@synthesize tapButtonsMap;
@synthesize callButtonsMap;
@synthesize findButtonsMap;

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
    self.tapButtonsMap = [NSMutableDictionary dictionary];
    self.callButtonsMap = [NSMutableDictionary dictionary];
    self.findButtonsMap = [NSMutableDictionary dictionary];
    self.tapButtonsMap[self.tap_button_1.restorationIdentifier] = self.liebefeldBar;
    self.tapButtonsMap[self.tap_button_2.restorationIdentifier] = self.winterthurBar;
    self.callButtonsMap[self.call_button_1.restorationIdentifier] = self.liebefeldBar.phone;
    self.callButtonsMap[self.call_button_2.restorationIdentifier] = self.winterthurBar.phone;
    self.findButtonsMap[self.find_button_1.restorationIdentifier] = self.liebefeldBar;
    self.findButtonsMap[self.find_button_2.restorationIdentifier] = self.winterthurBar;
    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImage_2 = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight_2 = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any states you plan to use
    [self.tap_button_1 setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.tap_button_1 setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.tap_button_2 setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.tap_button_2 setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    [self.find_button_1 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.find_button_1 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    [self.find_button_2 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.find_button_2 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    [self.call_button_1 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.call_button_1 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    [self.call_button_2 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.call_button_2 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    [self.find_button_1 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.find_button_1 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    [self.find_button_2 setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.find_button_2 setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
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

-(IBAction)callPhone:(id)sender {
    [[UIApplication sharedApplication] openURL:self.callButtonsMap[((UIButton*) sender).restorationIdentifier]];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (((UIButton*) sender).restorationIdentifier == self.tap_button_1.restorationIdentifier || ((UIButton*) sender).restorationIdentifier == self.tap_button_2.restorationIdentifier) {
        DetailViewController *detailController = segue.destinationViewController;
        Bar *bar = self.tapButtonsMap[((UIButton*) sender).restorationIdentifier];
        detailController.detailItem = bar;
    } else if (((UIButton*) sender).restorationIdentifier == self.find_button_1.restorationIdentifier || ((UIButton*) sender).restorationIdentifier == self.find_button_2.restorationIdentifier) {
        FindBarViewController *findController = segue.destinationViewController;
        Bar *bar = self.findButtonsMap[((UIButton*) sender).restorationIdentifier];
        findController.locationItem = bar;
    }
    
}

@end
