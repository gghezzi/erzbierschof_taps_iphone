//
//  BeerDetailsViewController.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 9/16/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "TapInfo.h"
#import "TFHpple.h"
#import "BeerDetailsViewController.h"
#import "MBProgressHUD.h"
#import "RatingBrowseViewController.h"
#import "Reachability.h"

@implementation BeerDetailsViewController

@synthesize breweryLabel;
@synthesize nameLabel;
@synthesize alcoholLabel;
@synthesize styleLabel;
@synthesize ratingButton_1;
@synthesize ratingButton_2;
@synthesize ratingButton_3;
@synthesize tapNumberLabel;
@synthesize ratebeerRating;
@synthesize ratebeerUrl;
@synthesize untappdRating;
@synthesize untappdUrl;
@synthesize beeradvocateRating;
@synthesize beeradvocatedUrl;
@synthesize buttonUrls;
@synthesize loaded;


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
    if (self.beerDetailItem != newDetailItem) {
        self.beerDetailItem = newDetailItem;
        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.
    if (self.beerDetailItem) {
        self.beerInfo = self.beerDetailItem;
        self.tapNumberLabel.text = self.beerInfo.tapNum;
        self.nameLabel.text = self.beerInfo.name;
        self.breweryLabel.text = self.beerInfo.brewery;
        self.alcoholLabel.text = [NSString stringWithFormat:@"Alcohol: %@", self.beerInfo.abv];
        self.styleLabel.text = [NSString stringWithFormat:@"Style: %@", self.beerInfo.style];
    }
    self.ratingButton_1.hidden = TRUE;
    self.ratingButton_2.hidden = TRUE;
    self.ratingButton_3.hidden = TRUE;
}

- (void)becomeActive:(NSNotification *)note
{
    // If the view already loaded but then the app became inactive no date is refetched from the websites
    if (!self.loaded) {
        [self viewDidLoad];
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.buttonUrls = [NSMutableDictionary dictionary];
    // Register for an enterForeground notification
    // Necessary for the view to be notified when it comes back to the foreground (e.g. when I reopen the application)
    [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(becomeActive:)
                                                 name:UIApplicationWillEnterForegroundNotification
                                                   object:nil];
    // Do any additional setup after loading the view.
    [self configureView];
    // Check if there's connection
    Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
        UIAlertView *alert = [[UIAlertView alloc]
                              initWithTitle:@"Warning"
                              message:@"The application needs an internet connection to fetch the beer ratings"
                              delegate:nil
                              cancelButtonTitle:@"Ok"
                              otherButtonTitles:nil];
        [alert show];
    } else {
        // I got an internet connection I can work with
        // Proceeding to try to find ratings for the beer
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Looking for ratings";
        dispatch_async(dispatch_get_global_queue( DISPATCH_QUEUE_PRIORITY_LOW, 0), ^{
            BOOL found = false;
            if ([self loadRatebeerInfo]) {
                found = true;
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    [self.ratingButton_1 setTitle:[NSString stringWithFormat:@"Ratebeer rating: %@/100", self.ratebeerRating] forState:UIControlStateNormal];
                    
                    UIImage *buttonImage = [[UIImage imageNamed:@"blueButton.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
                    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"blueButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
                    // Set the background for any states you plan to use
                    [self.ratingButton_1 setBackgroundImage:buttonImage forState:UIControlStateNormal];
                    [self.ratingButton_1 setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
                    self.ratingButton_1.hidden = false;
                    self.buttonUrls[self.ratingButton_1.restorationIdentifier] = self.ratebeerUrl;
                    loaded = true;
                });
            }
            if ([self loadUntappdInfo]) {
                found = true;
                dispatch_async(dispatch_get_main_queue(), ^(void){
                    UIImage *buttonImage = [[UIImage imageNamed:@"tanButton"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
                    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"tanButtonHighlight.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
                    if (self.ratingButton_1.hidden) {
                        [self.ratingButton_1 setTitle:[NSString stringWithFormat:@"Untappd rating: %@/5", self.untappdRating] forState:UIControlStateNormal];
                        [self.ratingButton_1 setBackgroundImage:buttonImage forState:UIControlStateNormal];
                        [self.ratingButton_1 setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
                        self.ratingButton_1.hidden = false;
                        self.buttonUrls[self.ratingButton_1.restorationIdentifier] = self.untappdUrl;
                    } else {
                        [self.ratingButton_2 setTitle:[NSString stringWithFormat:@"Untappd rating: %@/5", self.untappdRating] forState:UIControlStateNormal];
                        [self.ratingButton_2 setBackgroundImage:buttonImage forState:UIControlStateNormal];
                        [self.ratingButton_2 setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
                        self.ratingButton_2.hidden = false;
                        self.buttonUrls[self.ratingButton_2.restorationIdentifier] = self.untappdUrl;
                    }
                    loaded = true;
                });
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [MBProgressHUD hideHUDForView:self.view animated:YES];
                if (!found) {
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Warning"
                                          message:@"Could not find any rating for the selected beer"
                                          delegate:nil
                                          cancelButtonTitle:@"Ok"
                                          otherButtonTitles:nil];
                    [alert show];
                }
            });
        });
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSDictionary*) getUntappdJson:(NSString*)subUrl additionalParams:(NSString *)additionalParams{
    NSString *clientId = @"0BAF01091B6ED6AE85A785CDC1E56989E0CE7D6E";
    NSString *clientSecret = @"B795AF721053EB3EBC7E1035A0B8BC7C46DD3CCE";
    NSString *apiAddress = @"http://api.untappd.com/v4";
    
    NSString *url = [NSString stringWithFormat: @"%@%@?client_id=%@&client_secret=%@&%@", apiAddress, subUrl, clientId, clientSecret, additionalParams];
    NSMutableURLRequest *detailsRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:[url stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]]];
    [detailsRequest setHTTPMethod:@"GET"];
    NSURLResponse* detailsRequestResponse;
    NSError* detailsRequestError = nil;
    NSData* detailsRequestResult = [NSURLConnection sendSynchronousRequest:detailsRequest  returningResponse:&detailsRequestResponse error:&detailsRequestError];
    if (detailsRequestError != nil) {
        NSLog(@"Call on Untappd API at %@ failed", url);
        return NULL;
    } else {
        NSError* jsonError;
        NSDictionary* json = [NSJSONSerialization
                              JSONObjectWithData:detailsRequestResult
                              options:kNilOptions
                              error:&jsonError];
        if (jsonError != nil) {
            NSLog(@"Could not parse JSON results returned by Untappd API at %@:%@", url, jsonError);
            return NULL;
        } else {
            return json;
        }
    }
}

// Tries to load the Untappd info for the beer
-(BOOL) loadUntappdInfo {
    BOOL success = false;
    NSDictionary* json = [self getUntappdJson:@"/search/beer" additionalParams: [NSString stringWithFormat: @"&q=%@ %@", self.beerInfo.name, self.beerInfo.brewery]];
    if (json != NULL) {
        // the Json parsing was successful, proceeding to see if beers were found
        NSArray* beerIds = [[[[[json objectForKey:@"response"]objectForKey:@"beers"]objectForKey:@"items"]valueForKey:@"beer"]valueForKey:@"bid"];
        // could add iterations to find beer when it has incorrect blank spaces
        if (beerIds.count > 0) {
            // Some beers found, proceeding to get the beer id of the most likely one
            NSDictionary* json_2 = [self getUntappdJson:[NSString stringWithFormat: @"/beer/info/%@", beerIds[0]] additionalParams: @""];
            if (json_2 != NULL) {
                self.untappdRating = [NSString stringWithFormat: @"%.2f", [[[[json_2 objectForKey:@"response"]objectForKey:@"beer"]valueForKey:@"rating_score"] doubleValue]];
                self.untappdUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://untappd.com/beer/%@", beerIds[0]]];
                success = true;
            }
        }
    }
    return success;
}

// Tries to load the Ratebeer info for the beer
-(BOOL) loadRatebeerInfo {
    BOOL success = false;
    
    // Note that the URL is the "action" URL parameter from the form.
    NSMutableURLRequest *beersListRequest = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: @"http://www.ratebeer.com/advbeersearch.php"]];
    [beersListRequest setHTTPMethod:@"POST"];
    [beersListRequest setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    NSString *postString = [NSString stringWithFormat: @"BeerName=%@+%@&BeerStyles=0&CountryID=+&StateID=+&SortBy=1&submit1=Search", [self.beerInfo.name stringByReplacingOccurrencesOfString:@" " withString:@"+"], [self.beerInfo.brewery stringByReplacingOccurrencesOfString:@" " withString:@"+"]];
    NSData *data = [postString dataUsingEncoding:NSUTF8StringEncoding];
    [beersListRequest setHTTPBody:data];
    [beersListRequest setValue:[NSString stringWithFormat:@"%u", [data length]] forHTTPHeaderField:@"Content-Length"];
    NSURLResponse* requestResponse;
    NSError* requestError = nil;
    //Capturing server response
    NSData* requestResult = [NSURLConnection sendSynchronousRequest:beersListRequest  returningResponse:&requestResponse error:&requestError];
    
    if(requestError != nil){
        NSLog(@"Failed to find for beer %@ by %@ on Ratebeer", self.beerInfo.name, self.beerInfo.brewery);
    } else {
        TFHpple *beersParser = [TFHpple hppleWithHTMLData:requestResult];
        NSString *xQueryString = @"//table[@align='center' and @class='results']/tr";
        NSArray *beerNodes = [beersParser searchWithXPathQuery:xQueryString];
        if ([beerNodes count] >= 5) {
            NSString *url;
            if ([[[UIDevice currentDevice] systemVersion] compare:@"7.0" options:NSNumericSearch] == NSOrderedAscending) {
                // less than iOS 7
                url = [NSString stringWithFormat: @"http://www.ratebeer.com%@", [[[[beerNodes[4] firstChild] children][3]children][1] objectForKey:@"href"]];
            } else {
                // iOS 7 or more
                url = [NSString stringWithFormat: @"http://www.ratebeer.com%@", [[[[beerNodes[4] firstChild] children][4]children][1] objectForKey:@"href"]];
            }
            NSMutableURLRequest *detailsRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            [detailsRequest setHTTPMethod:@"GET"];
            NSURLResponse* detailsRequestResponse;
            NSError* detailsRequestError = nil;
            NSData* detailsRequestResult = [NSURLConnection sendSynchronousRequest:detailsRequest  returningResponse:&detailsRequestResponse error:&detailsRequestError];
            if (detailsRequestError != nil) {
                NSLog(@"Failed to get detailed info for beer %@ by %@ on Ratebeer", self.beerInfo.name, self.beerInfo.brewery);
            } else {
                TFHpple *detailsParser = [TFHpple hppleWithHTMLData:detailsRequestResult];
                NSString *xQueryString = @"//title";
                NSArray *detailsNodes = [detailsParser searchWithXPathQuery:xQueryString];
                if ([detailsNodes count] > 0) {
                    NSRange startingRange = [[[detailsNodes[0] firstChild] content] rangeOfString:@"-" options:NSBackwardsSearch];
                    if (startingRange.length > 0) {
                        NSString *rating = [[[detailsNodes[0] firstChild] content] substringWithRange:NSMakeRange(startingRange.location + 2, 3)];
                        rating = [rating stringByReplacingOccurrencesOfString:@" " withString:@""];
                        success = true;
                        self.ratebeerRating = rating;
                        self.ratebeerUrl = [NSURL URLWithString:url];
                    } else {
                        NSLog(@"Beer %@ by %@ on Ratebeer exists but no correct rating could be found", self.beerInfo.name, self.beerInfo.brewery);
                    }
                } else {
                    NSLog(@"Failed to find the title for beer %@ by %@ on its Ratebeer page", self.beerInfo.name, self.beerInfo.brewery);
                }
            }
            
        } else {
            NSLog(@"Beer %@ by %@ could not be found on Ratebeer", self.beerInfo.name, self.beerInfo.brewery);
        }
    }
    return success;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    RatingBrowseViewController *ratingBrowser = segue.destinationViewController;
    ratingBrowser.ratingDetailItem = self.buttonUrls[((UIButton*) sender).restorationIdentifier];
}

@end
