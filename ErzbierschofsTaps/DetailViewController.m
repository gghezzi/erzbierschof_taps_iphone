//
//  DetailViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "DetailViewController.h"
#import "TFHpple.h"
#import "TapInfo.h"
#import "TapTableCell.h"
#import "Bar.h"
#import <MBProgressHUD/MBProgressHUD.h>

@interface DetailViewController () {}
@property (strong, nonatomic) UIPopoverController *masterPopoverController;
@property (strong) Bar *bar;
@property (nonatomic) NSArray *taps;
- (void)configureView;
@end

@implementation DetailViewController

@synthesize refreshButton;

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
        
        // Update the view.
        [self configureView];
    }

    if (self.masterPopoverController != nil) {
        [self.masterPopoverController dismissPopoverAnimated:YES];
    }        
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.detailItem) {
        self.bar = self.detailItem;
    }
}

//Refreshes the list of beers on tap
- (IBAction)refreshPressed:(id)sender{
    [self viewDidLoad];
}

- (void)becomeActive:(NSNotification *)note 
{
    [self viewDidLoad];
}

// Called when the view successfully loaded, it takes care of populating
// the tableView with the beers currently on tap at the selected Erzbierschof location.
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Register for an enterForeground notification
    // Necessary for the view to be notified when it comes back to the foreground (e.g. when I reopen the application)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(becomeActive:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                               object:nil];
    [self configureView];
    self.title = self.bar.name;
    //Load tap info from Erzbierschof
    [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
        BOOL success =  [self loadBeers];
        dispatch_async(dispatch_get_main_queue(), ^{
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            if (!success) {
                UIAlertView *alert = [[UIAlertView alloc]
                initWithTitle:@"Error"
                message:@"Could not update the tap list. Check that you have a connection."
                delegate:nil
                cancelButtonTitle:@"Ok"
                otherButtonTitles:nil];
                [alert show];
            }
        });
    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// Loads the tap info from the Erzbierschof website
-(BOOL) loadBeers {
    BOOL success = false;
    NSURL *beersUrl = [NSURL URLWithString:self.bar.url];
    NSMutableArray *newTaps = [[NSMutableArray alloc] initWithCapacity:0];
    NSData *beersHtmlData = [NSData dataWithContentsOfURL:beersUrl];
    // Setting up an HTML parser to get the tap info from the HTML page
    TFHpple *beersParser = [TFHpple hppleWithHTMLData:beersHtmlData];
    // The XQuery used to get to the 'currently on tap' HTML table
    NSString *xQueryString = @"//table[@class='tabtable-gr_alterora_elemental_1_grey_2s2']/tbody/tr";
    NSArray *beerNodes = [beersParser searchWithXPathQuery:xQueryString];        
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    if ([beerNodes count] > 0) {
        for (int i = 1; i < [beerNodes count]; i++){
            TFHppleElement *element = beerNodes[i];
            TapInfo *tap = [[TapInfo alloc] init];
            [newTaps addObject:tap];
            tap.brewery = [[element.children[2]  firstChild] content];
            tap.name = [[element.children[6]  firstChild] content];
            tap.abv = [[element.children[8]  firstChild] content];
            tap.style = [[element.children[10]  firstChild] content];
            tap.quantity = [[element.children[12]  firstChild] content];
            // Saving the information for future use (e.g. If I can't load new info)
            NSString *prefix = [NSString stringWithFormat:@"%@_tap_%i_", self.bar.name, i];
            [prefs setObject:tap.brewery forKey:[NSString stringWithFormat:@"%@%@", prefix, @"brewery"]];
            [prefs setObject:tap.name forKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]];
            [prefs setObject:tap.abv forKey:[NSString stringWithFormat:@"%@%@", prefix, @"abv"]];
            [prefs setObject:tap.style forKey:[NSString stringWithFormat:@"%@%@", prefix, @"style"]];
            [prefs setObject:tap.quantity forKey:[NSString stringWithFormat:@"%@%@", prefix, @"quantity"]];
        }
        // If I get to this point I loaded the tap info from the website
        // This is necessary so that methods calling this one know when they need to warn that the info
        // has not been loaded.
        success = true;
    } else {
        // In case I could not fetch the info from the webpage, I load the cached data (if there's any)
        for (int i = 1; i <= 15; i++){
            TapInfo *tap = [[TapInfo alloc] init];
            [newTaps addObject:tap];
            NSString *prefix = [NSString stringWithFormat:@"%@_tap_%i_", self.bar.name, i];
            if ([prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]] != nil) {
                NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                tap.name = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]];
                tap.brewery = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"brewery"]];
                tap.abv  = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"abv"]];
                tap.style = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"style"]];
                tap.quantity = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"quantity"]];
            }
        }
    }
    self.taps = newTaps;
    [self.tableView reloadData];
    return success;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_taps count];
}

// Updates the tableView with the tap info fetched
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TapTableCell";
    
    TapTableCell *cell = (TapTableCell *)[tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"TapTableCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    
    TapInfo *thisBeer = [self.taps objectAtIndex:indexPath.row];
    if (thisBeer.name != nil) {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@ by %@", thisBeer.name, thisBeer.brewery];
        cell.detailsLabel.text = [NSString stringWithFormat:@"%@, %@", thisBeer.style, thisBeer.abv];
        cell.tapNumLabel.text = [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1];
        cell.amountLabel.text = thisBeer.quantity;
    }
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)splitViewController:(UISplitViewController *)splitController willHideViewController:(UIViewController *)viewController withBarButtonItem:(UIBarButtonItem *)barButtonItem forPopoverController:(UIPopoverController *)popoverController
{
    barButtonItem.title = NSLocalizedString(@"Master", @"Master");
    [self.navigationItem setLeftBarButtonItem:barButtonItem animated:YES];
    self.masterPopoverController = popoverController;
}

- (void)splitViewController:(UISplitViewController *)splitController willShowViewController:(UIViewController *)viewController invalidatingBarButtonItem:(UIBarButtonItem *)barButtonItem
{
    // Called when the view is shown again in the split view, invalidating the button and popover controller.
    [self.navigationItem setLeftBarButtonItem:nil animated:YES];
    self.masterPopoverController = nil;
}

@end
