//
//  AppDelegate.m
//  ErzbierschofsTaps
//
//  Created by Giacomo Ghezzi on 6/21/13.
//  Copyright (c) 2013 Giacomo Ghezzi. All rights reserved.
//

#import "AppDelegate.h"
#import "Bar.h"
#import "LocationsViewController.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    //Loading the info about the different Erzbierschof locations
    NSMutableArray *bars = [NSMutableArray array];
    NSString *path = [[NSBundle mainBundle] pathForResource:@"bars" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    NSArray *names = [dict objectForKey:@"name"];
    NSArray *urls = [dict objectForKey:@"url"];
    NSArray *images = [dict objectForKey:@"image"];
    NSArray *latitudes = [dict objectForKey:@"latitude"];
    NSArray *longitudes = [dict objectForKey:@"longitude"];
    NSArray *addresses = [dict objectForKey:@"address"];
    NSArray *cities = [dict objectForKey:@"city"];
    NSArray *phones = [dict objectForKey:@"phones"];
    for (int i=0; i<4; i++){
        Bar *bar = [[Bar alloc] initWithName:names[i] url:urls[i] image:[UIImage imageNamed:images[i]] phone:[NSURL URLWithString:[NSString stringWithFormat:@"telprompt://%@", phones[i]]] latitude:[latitudes[i] doubleValue] longitude:[longitudes[i] doubleValue] address:addresses[i] city:cities[i]];
        [bars addObject:bar];
    }
    UINavigationController * navController = (UINavigationController *) self.window.rootViewController;
    LocationsViewController * locationsController = [navController.viewControllers objectAtIndex:0];
    locationsController.bars = bars;
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
