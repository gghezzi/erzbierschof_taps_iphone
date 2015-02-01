//
//  DetailViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "TapListController.h"
#import "BeerDetailsViewController.h"
#import "TFHpple.h"
#import "TapInfo.h"
#import "TapTableCell.h"
#import "Bar.h"
#import "Reachability.h"
#import "MBProgressHUD.h"

@implementation TapListController

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

- (void)viewDidUnload
{
    [super viewDidUnload];
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
    // Before even trying to fetch data from Erzbierschof I check that there's an active internet connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        if ([self loadCachedTaps]) {
            [self error:@"The application needs an internet connection to get an updated tap list.\nAn older version has been loaded instead"];
        } else {
            [self error:@"The application needs an internet connection to get an updated tap list."];
        }
    } else {
        //Load tap info from Erzbierschof
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            @try{
                BOOL success =  [self loadBeers];
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    if (!success) {
                        if ([self loadCachedTaps]) {
                            [self error:@"Could not update the tap list.\nAn older version has been loaded instead"];
                        } else {
                            [self error:@"Could not update the tap list and could not find any previously saved one."];
                        }
                    }
                });
            }
            @catch(NSException *e) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [MBProgressHUD hideHUDForView:self.view animated:YES];
                    [self error:@"Could not correctly get the tap list from the website, which seems to have changed. Please contact the app creator or Erbierschof"];
                });
            }
        
        });
    }
}

- (void)error:(NSString*) msg{
    UIAlertView *alert = [[UIAlertView alloc]
                          initWithTitle:@"Error"
                          message:msg
                          delegate:nil
                          cancelButtonTitle:@"Ok"
                          otherButtonTitles:nil];
    [alert show];
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
    NSInteger totBeers = [beerNodes count];
    [prefs setInteger:totBeers forKey:[NSString stringWithFormat:@"tot_beers"]];
    if ([beerNodes count] > 0) {
        for (int i = 1; i < [beerNodes count]; i++){
            TFHppleElement *element = beerNodes[i];
            TapInfo *tap = [[TapInfo alloc] init];
            [newTaps addObject:tap];
            if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
                // less than iOS 7
                tap.name = [self getContent:element.children[6]];
                if (tap.name != NULL) {
                    tap.brewery = [self getContent:element.children[2]];
                    tap.style = [self getContent:element.children[8]];
                    tap.abv = [self getContent:element.children[10]];
                    tap.quantity = [self getContent:element.children[12]];
                }
            } else {
                // iOS 7 or more
                tap.name = [self getContent:element.children[7]];
                if (tap.name != NULL) {
                    tap.brewery = [self getContent:element.children[3]];
                    tap.style = [self getContent:element.children[9]];
                    tap.abv = [self getContent:element.children[11]];
                    tap.quantity = [self getContent:element.children[13]];
                }
            }
            tap.tapNum = [NSString stringWithFormat:@"%i", i];
            // Saving the information for future use (e.g. If I can't load new info)
            NSString *prefix = [NSString stringWithFormat:@"%@_tap_%i_", self.bar.name, i];
            [prefs setObject:tap.brewery forKey:[NSString stringWithFormat:@"%@%@", prefix, @"brewery"]];
            [prefs setObject:tap.name forKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]];
            [prefs setObject:tap.abv forKey:[NSString stringWithFormat:@"%@%@", prefix, @"abv"]];
            [prefs setObject:tap.style forKey:[NSString stringWithFormat:@"%@%@", prefix, @"style"]];
            [prefs setObject:tap.quantity forKey:[NSString stringWithFormat:@"%@%@", prefix, @"quantity"]];
            [prefs setObject:tap.tapNum forKey:[NSString stringWithFormat:@"%@%@", prefix, @"tapNum"]];
        }
        success = true;
    } else {
        success = false;
    }
    self.taps = newTaps;
    [self.tableView reloadData];
    return success;
}

- (BOOL) loadCachedTaps {
    BOOL success = false;
    NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
    NSMutableArray *newTaps = [[NSMutableArray alloc] initWithCapacity:0];
    // In case I could not fetch the info from the webpage, I load the cached data (if there's any)
    NSInteger totBeers = [prefs integerForKey:[NSString stringWithFormat:@"tot_beers"]];
    if (totBeers > 0) {
        for (int i = 1; i <= 15; i++){
            TapInfo *tap = [[TapInfo alloc] init];
            [newTaps addObject:tap];
            NSString *prefix = [NSString stringWithFormat:@"%@_tap_%i_", self.bar.name, i];
            if ([prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]] != nil) {
//            NSUserDefaults *prefs = [NSUserDefaults standardUserDefaults];
                tap.name = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"name"]];
                tap.brewery = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"brewery"]];
                tap.abv  = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"abv"]];
                tap.style = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"style"]];
                tap.quantity = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"quantity"]];
                tap.tapNum = [prefs stringForKey:[NSString stringWithFormat:@"%@%@", prefix, @"tapNum"]];
            }
        }
    }
    if ([newTaps count] > 0) {
        success = true;
        self.taps = newTaps;
        [self.tableView reloadData];
    }
    return success;
}

- (NSString*) getContent:(TFHppleElement*) element{
    NSString *res = [[element firstChild] content];
    if (res == NULL) {
        if ([element.children count] > 0) {
            return [self getContent:element.children[0]];
        } else {
            return NULL;
        }
    }
    return res;
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
    } else {
        cell.nameLabel.text = @"No beer on tap";
        cell.tapNumLabel.text = [NSString stringWithFormat:@"%ld", (long) indexPath.row + 1];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Find the selected cell in the usual way
    TapTableCell *cell = (TapTableCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    if (![cell.nameLabel.text  isEqual: @"No beer on tap"]) {
        //Doing the segue only if there is a valid beer
        [self performSegueWithIdentifier:@"beerDetails" sender:cell];
    }
}
    
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    BeerDetailsViewController *beerDetailController = segue.destinationViewController;
    TapInfo *beerInfo = [self.taps objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    beerDetailController.beerDetailItem = beerInfo;
}


@end
