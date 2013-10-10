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
    Bar *bar1 = [[Bar alloc] initWithName:@"Erzbierschof" url:@"http://bar.erzbierschof.ch/on-tap" image:[UIImage imageNamed:@"erz_liebefeld.png"] phone:[NSURL URLWithString:@"telprompt://+410319717275"] latitude:46.928198 longitude:7.416452 address:@"Könizstrasse 276" city:@"Liebefeld"];
    Bar *bar2 = [[Bar alloc] initWithName:@"Erzbierschof Punkt" url:@"http://punkt.erzbierschof.ch/on-tap" image:[UIImage imageNamed:@"erz_winti.png"] phone:[NSURL URLWithString:@"telprompt://+41522125252"] latitude:47.500489 longitude:8.730094 address:@"Stadthausstrasse 53" city:@"Winterthur" ];
//    NSMutableArray *bars = [NSMutableArray arrayWithObjects:bar1, bar2, nil];
    
    UINavigationController * navController = (UINavigationController *) self.window.rootViewController;
    LocationsViewController * locationsController = [navController.viewControllers objectAtIndex:0];
    locationsController.liebefeldBar = bar1;
    locationsController.winterthurBar = bar2;
    
//    UINavigationController * navController = (UINavigationController *) self.window.rootViewController;
//    MasterViewController * masterController = [navController.viewControllers objectAtIndex:0];
//    masterController.bars = bars;
    
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
