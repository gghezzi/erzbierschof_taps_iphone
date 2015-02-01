#import "BarPageController.h"
#import "TapListController.h"
#import "FindBarViewController.h"
#import <MapKit/MapKit.h>
#import <MapKit/MKMapItem.h>

@implementation BarPageController

@synthesize bar;
@synthesize call_button;
@synthesize find_button;
@synthesize bar_logo_view;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.bar = self.detailItem;
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = self.bar.name;
    self.bar_logo_view.image = bar.image;

    UIImage *buttonImage = [[UIImage imageNamed:@"orangeButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"orangeButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImage_2 = [[UIImage imageNamed:@"greyButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight_2 = [[UIImage imageNamed:@"greyButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    // Set the background for any state we plan to use
    [self.tap_button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [self.tap_button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [self.find_button setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.find_button setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    
    [self.call_button setBackgroundImage:buttonImage_2 forState:UIControlStateNormal];
    [self.call_button setBackgroundImage:buttonImageHighlight_2 forState:UIControlStateHighlighted];
    
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
    [[UIApplication sharedApplication] openURL:self.bar.phone];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (((UIButton*) sender).restorationIdentifier == self.tap_button.restorationIdentifier) {
        TapListController *detailController = segue.destinationViewController;
        detailController.detailItem = self.bar;
    } else if (((UIButton*) sender).restorationIdentifier == self.find_button.restorationIdentifier) {
        FindBarViewController *findController = segue.destinationViewController;
        findController.locationItem = self.bar;
    }
    
}

@end