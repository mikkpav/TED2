//
//  AppDelegate.m
//  TED
//
//  Created by Mikk Pavelson on 12/03/15.
//  Copyright (c) 2015 mp. All rights reserved.
//

#import "AppDelegate.h"
#import "MasterViewController.h"
#import "AFNetworking.h"

@interface AppDelegate () <UISplitViewControllerDelegate>

@property (nonatomic, strong) MasterViewController *masterViewController;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
  self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
  MasterViewController *masterController = [[MasterViewController alloc] init];
  [self setMasterViewController:masterController];
  UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:masterController];
  [self.window setRootViewController:navigationController];
  [self.window makeKeyAndVisible];
  
  
  
  return YES;
}

- (MasterViewController *)masterController {
  return self.masterViewController;
}

- (void)applicationWillResignActive:(UIApplication *)application {
  // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
  // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
  // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
  // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager stopMonitoring];
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
  // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
  // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager startMonitoring];
}

- (void)applicationWillTerminate:(UIApplication *)application {
  // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
  [manager stopMonitoring];
}

@end
