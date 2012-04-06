//
//  MyFruitsDiaryViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyFruitsDiaryViewController.h"
#import "MyDiaryViewController.h"
#import "AboutViewController.h"

@implementation MyFruitsDiaryViewController

#pragma mark -
#pragma mark private
-(UINavigationController *) buildTabOnController: (UIViewController *)controller 
									   withTitle: (NSString*)title andImage: (NSString*)imageName {
	UINavigationController* nav = [[[UINavigationController alloc] initWithRootViewController:controller] autorelease];
	nav.navigationBar.tintColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:1];
	controller.navigationItem.title = title;
	
	UIImage* img = [UIImage imageNamed:imageName];	
	
	UITabBarItem* it = [[UITabBarItem alloc] initWithTitle:title image:img tag:0];		
	nav.tabBarItem = it;		
	[it release];
	
	return nav;	
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	MyDiaryViewController* diaryView = [[[MyDiaryViewController alloc] initWithNibName:@"MyDiaryView" bundle:nil] autorelease];
	UINavigationController* diaryTab = [self buildTabOnController:diaryView withTitle:@"My Diary" andImage:@"notebook-icon.png"];
	
	AboutViewController* aboutView = [[[AboutViewController alloc] initWithNibName:@"AboutView" bundle:nil] autorelease];
	UINavigationController* aboutTab = [self buildTabOnController:aboutView withTitle:@"About" andImage:@"about-icon.png"];
	
	_tabBarController = [[UITabBarController alloc] init];	
	NSArray* controllers = [NSArray arrayWithObjects:diaryTab, aboutTab, nil];
	_tabBarController.viewControllers = controllers;
	CGRect fr = self.view.frame;
	fr.origin.y = 0;
	_tabBarController.view.frame = fr;
	//_tabBarController.delegate = self;
	[self.view addSubview:_tabBarController.view];	
	
	// Load data here to make sure the notifications work well
	APP_SERVICE(appSrv);
	[appSrv loadAllData];
}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [_tabBarController release];
	[super dealloc];
}

@end
