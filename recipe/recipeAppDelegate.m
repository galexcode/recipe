//
//  recipeAppDelegate.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "recipeAppDelegate.h"
#import "AuthViewController.h"
#import "CategoryXMLHandler.h"

@implementation recipeAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;

#pragma  mark Global Variable
- (User*) user
{
    return _user;
}

#pragma mark Services Accessor
- (ApplicationService*) appService
{
    return _appService;
}

// Change default appearance of UI Control Element
#pragma mark Customization UI
- (void)customizeAppearance
{
    //Testing
    //[[UINavigationBar appearance] setTintColor:[UIColor colorWithRed:44/255 green:14/255 blue:5/255 alpha:0]];
    
    // Create resizable images
    UIImage *gradientImage44 = [[UIImage imageNamed:@"topbar"] 
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
//    UIImage *gradientImage32 = [[UIImage imageNamed:@"surf_gradient_textured_32"] 
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 
                                       forBarMetrics:UIBarMetricsDefault];
//    [[UINavigationBar appearance] setBackgroundImage:gradientImage32 
//                                       forBarMetrics:UIBarMetricsLandscapePhone];
    
    // Customize UIBarButtonItems 
    UIImage *button30 = [[UIImage imageNamed:@"button_textured_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    // Customize back button items differently
    UIImage *buttonBack30 = [[UIImage imageNamed:@"back_button_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
//    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    // Customze UITabbar
    UIImage *tabBackground = [[UIImage imageNamed:@"tabbar_49"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    [[UITabBar appearance] setSelectedImageTintColor:[UIColor brownColor]];
    
    // Customize UISegment
    //[[UISegmentedControl appearance] setSelectedIma];
}

#pragma mark Application Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Call customize method to change UI look and feel
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self customizeAppearance];
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    authViewController = [[AuthViewController alloc] initWithNibName:@"AuthViewController" bundle:nil];
    //[authViewController.view setFrame:CGRectMake(0, 0, 320, 480)];
    self.window.rootViewController = self.tabBarController;
    [self.window addSubview:authViewController.view];
    
    _appService = [[ApplicationService alloc] init];
    _user = [[User alloc] init];
    
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
}
*/

/*
// Optional UITabBarControllerDelegate method.
- (void)tabBarController:(UITabBarController *)tabBarController didEndCustomizingViewControllers:(NSArray *)viewControllers changed:(BOOL)changed
{
}
*/

@end
