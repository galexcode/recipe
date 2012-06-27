//
//  recipeAppDelegate.m
//  recipe
//
//  Created by Vu Tran on 3/26/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "recipeAppDelegate.h"
#import "AuthViewController.h"
#import "GlobalStore.h"

//static ApplicationService *shared = nil;
//static dispatch_queue_t serialQueue;

@implementation recipeAppDelegate
@synthesize navItem1;
@synthesize navItem2;
@synthesize navItem3;
@synthesize navItem4;
@synthesize homeBar;
@synthesize myRecipeBar;
@synthesize todoBar;
@synthesize feedBar;

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize tabBarItem1, tabBarItem2, tabBarItem3, tabBarItem4;

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
    // Create resizable images
    UIImage *gradientImage44 = [[UIImage imageNamed:@"topbar_44"] 
                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *plain_bar44 = [[UIImage imageNamed:@"plain_bar_bg_44"] 
                            resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    UIImage *searchIcon = [UIImage imageNamed:@"search"];
    UIImage *searchTextFieldBackbround = [[UIImage imageNamed:@"search_tf_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 20, 0, 20)];
//    UIImage *gradientImage32 = [[UIImage imageNamed:@"surf_gradient_textured_32"] 
//                                resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    // Set the background image for *all* UINavigationBars
    [[UINavigationBar appearance] setBackgroundImage:gradientImage44 forBarMetrics:UIBarMetricsDefault];
//    [UINavigationBar appearance] setBackgroundImage:gradientImage32 forBarMetrics:UIBarMetricsLandscapePhone];
    
    //[[UILabel appearanceWhenContainedIn:[UIToolbar class], nil] setColor:[UIColor redColor]];
    
    [[UISearchBar appearance] setBackgroundImage:plain_bar44];
    [[UISearchBar appearance] setImage:searchIcon forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
    [[UISearchBar appearance] setSearchFieldBackgroundImage:searchTextFieldBackbround forState:UIControlStateNormal];
    [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setTextColor:[UIColor colorWithRed:0.27f green:0.13f blue:0.05f alpha:1.00f]];
    
    // Customize UIBarButtonItems 
    UIImage *button30 = [[UIImage imageNamed:@"normal_button_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
//    UIImage *button24 = [[UIImage imageNamed:@"button_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 5, 0, 5)];
    [[UIBarButtonItem appearance] setBackgroundImage:button30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackgroundImage:button24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    //UINavigationBar customization
    
    // Customize back button items differently
    UIImage *buttonBack30 = [[UIImage imageNamed:@"back_button_30"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 13, 0, 5)];
//    UIImage *buttonBack24 = [[UIImage imageNamed:@"button_back_textured_24"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 12, 0, 5)];
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack30 forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f], UITextAttributeTextColor, 
                                                          [UIColor blackColor], UITextAttributeTextShadowColor, 
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil] 
                                                 forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                          [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f], UITextAttributeTextColor, 
                                                          [UIColor blackColor], UITextAttributeTextShadowColor, 
                                                          [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil] 
                                                forState:UIControlStateHighlighted];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:buttonBack24 forState:UIControlStateNormal barMetrics:UIBarMetricsLandscapePhone];
    
    // Customize UITabbar
    UIImage *tabBackground = [[UIImage imageNamed:@"tabbar_49"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    [[UITabBar appearance] setBackgroundImage:tabBackground];
    //[[UITabBar appearance] setSelectedImageTintColor:[UIColor yellowColor]];
    
    // Custommize UITextField
    //[[UITextField appearance] setValue:[UIColor redColor] forKey:@"insertionPointColor"];
    //[[UITextField appearance] setBackgroundColor:[UIColor brownColor]];
    //[[UITextField appearance] setValue:[UIColor darkGrayColor] forKeyPath:@"textField.placeholderLabel.textColor"];
    
    [[UITextField appearance] setBorderStyle:UITextBorderStyleNone];
    
    UIImage *textFieldBackground = [UIImage imageNamed:@"tf_bg"];// resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    [[UITextField appearance] setBackground:textFieldBackground];
    
    
    //UIImage *mainBackground = [[UIImage imageNamed:@"background"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    //[[UIView appearance] setBackgroundImage:mainBackground];
    
    //UITabbarItem Title
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f], UITextAttributeTextColor, 
                                                       [UIColor blackColor], UITextAttributeTextShadowColor, 
                                                       [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil] 
                                             forState:UIControlStateNormal];
    
    //UISegmentedControl appearance
    UIImage *segmentSelected = [[UIImage imageNamed:@"seg_s.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *segmentUnselected = [[UIImage imageNamed:@"seg_u.png"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 10, 0, 10)];
    UIImage *segmentSelectedUnselected = [UIImage imageNamed:@"seg_s_u.png"];
    UIImage *segUnselectedSelected = [UIImage imageNamed:@"seg_u_s.png"];
    UIImage *segmentUnselectedUnselected = [UIImage imageNamed:@"seg_u_u.png"];
    
    [[UISegmentedControl appearance] setBackgroundImage:segmentUnselected forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setBackgroundImage:segmentSelected forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    
    [[UISegmentedControl appearance] setDividerImage:segmentUnselectedUnselected forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segmentSelectedUnselected forLeftSegmentState:UIControlStateSelected rightSegmentState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setDividerImage:segUnselectedSelected forLeftSegmentState:UIControlStateNormal rightSegmentState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f], UITextAttributeTextColor, 
                                                       [UIColor blackColor], UITextAttributeTextShadowColor, 
                                                       [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil] 
                                             forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                             [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:0.75f], UITextAttributeTextColor, 
                                                       [UIColor blackColor], UITextAttributeTextShadowColor, 
                                                       [NSValue valueWithUIOffset:UIOffsetMake(0, 1)], UITextAttributeTextShadowOffset, nil] 
                                             forState:UIControlStateHighlighted];
}

#pragma mark Application Lifecycle
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Call customize method to change UI look and feel
    //[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [application setStatusBarHidden:YES withAnimation:UIStatusBarAnimationNone];
    [self customizeAppearance];
    
    //Customize Tabbar Item
    UIImage *homeTabIcon = [UIImage imageNamed:@"tbi_home"];
    UIImage *recipeTabIcon = [UIImage imageNamed:@"tbi_recipe"];
    UIImage *todoTabIcon = [UIImage imageNamed:@"tbi_todo"];
    UIImage *feedTabIcon = [UIImage imageNamed:@"tbi_feed"];
    UIImage *navLogo = [UIImage imageNamed:@"logo_header"];
    [[self tabBarItem1] setFinishedSelectedImage:homeTabIcon withFinishedUnselectedImage:homeTabIcon];
    [[self tabBarItem2] setFinishedSelectedImage:recipeTabIcon withFinishedUnselectedImage:recipeTabIcon];
    [[self tabBarItem3] setFinishedSelectedImage:todoTabIcon withFinishedUnselectedImage:todoTabIcon];
    [[self tabBarItem4] setFinishedSelectedImage:feedTabIcon withFinishedUnselectedImage:feedTabIcon];
    
    UIImageView *headerView1 = [[UIImageView alloc] initWithImage:navLogo];
    UIImageView *headerView2 = [[UIImageView alloc] initWithImage:navLogo];
    UIImageView *headerView3 = [[UIImageView alloc] initWithImage:navLogo];
    UIImageView *headerView4 = [[UIImageView alloc] initWithImage:navLogo];
    
    
    [[self navItem1] setTitleView:headerView1];
    [[self navItem2] setTitleView:headerView2];
    [[self navItem3] setTitleView:headerView3];
    [[self navItem4] setTitleView:headerView4];

    //_appService = [[ApplicationService alloc] init];
    GlobalStore *store = [GlobalStore sharedStore];
    NSLog(@"%@", store.loggedUser);
    
    //_user = [[User alloc] init];
    
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    authViewController = [[AuthViewController alloc] initWithNibName:@"AuthViewController" bundle:nil];
    self.window.rootViewController = self.tabBarController;
    
    [self.window addSubview:authViewController.view];
    
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
