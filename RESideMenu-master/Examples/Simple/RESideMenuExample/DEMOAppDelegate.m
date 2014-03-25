//
//  DEMOAppDelegate.m
//  RESideMenuExample
//
//  Created by Roman Efimov on 10/10/13.
//  Copyright (c) 2013 Roman Efimov. All rights reserved.
//

#import "DEMOAppDelegate.h"
#import "UIImageView+LBBlurredImage.h"

#import "DEMOMenuViewController.h"
#import "DEMOFirstViewController.h"
//532ff7a456240bb92601093c
@implementation DEMOAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:[[DEMOFirstViewController alloc] init]];
    DEMOMenuViewController *menuViewController = [[DEMOMenuViewController alloc] init];
    
    RESideMenu *sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:navigationController menuViewController:menuViewController];
    
    
    sideMenuViewController.backgroundImage=nil;
    
    sideMenuViewController.delegate = self;
    self.window.rootViewController = sideMenuViewController;
    
    self.window.backgroundColor = [UIColor whiteColor];
    
    [MobClick startWithAppkey:@"532ff7a456240bb92601093c" reportPolicy:SEND_INTERVAL   channelId:@"Web"];

    
    
    [self.window makeKeyAndVisible];
    return YES;
}

#pragma mark -
#pragma mark RESideMenu Delegate

- (void)sideMenu:(RESideMenu *)sideMenu willShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didShowMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didShowMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu willHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"willHideMenuViewController");
}

- (void)sideMenu:(RESideMenu *)sideMenu didHideMenuViewController:(UIViewController *)menuViewController
{
    NSLog(@"didHideMenuViewController");
}

@end
