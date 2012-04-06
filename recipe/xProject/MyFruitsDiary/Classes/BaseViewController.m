    //
//  BaseViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "BaseViewController.h"
#import "MyFruitsDiaryGlobal.h"

@implementation BaseViewController

-(id) initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
	if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		[[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(startReq:) 
													 name: HTTP_REQUEST_STARTING_NOTIFICATION 
												   object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(finishReq:) 
													 name: HTTP_REQUEST_FINISHING_NOTIFICATION 
												   object: nil];
		[[NSNotificationCenter defaultCenter] addObserver: self 
												 selector: @selector(reloadData:) 
													 name: RELOAD_DATA_NOTIFICATION 
												   object: nil];
		_backupRightButtonItem = nil;
	}
	return self;
}

- (void)viewDidLoad {
    
	[super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver: self 
													name: HTTP_REQUEST_STARTING_NOTIFICATION 
												  object: nil];
	[[NSNotificationCenter defaultCenter] removeObserver: self 
													name: HTTP_REQUEST_FINISHING_NOTIFICATION 
												  object: nil];
	[[NSNotificationCenter defaultCenter] removeObserver: self 
													name: RELOAD_DATA_NOTIFICATION 
												  object: nil];
	[super dealloc];
}

-(void) startReq:(NSNotification*)notif
{
	UIActivityIndicatorView* spinner = 
		[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleWhite];
	UIBarButtonItem* ubbi = [[UIBarButtonItem alloc] initWithCustomView:spinner];
	[spinner startAnimating];
	
	_backupRightButtonItem = [self.navigationItem.rightBarButtonItem retain];
	[self.navigationItem setRightBarButtonItem:ubbi animated:YES];
	
	[ubbi release];
	[spinner release];
	
}
-(void) finishReq:(NSNotification*)notif
{
	[self.navigationItem setRightBarButtonItem:_backupRightButtonItem animated:YES];
	[_backupRightButtonItem release];
	_backupRightButtonItem = nil;
	
}
-(void) setRightBarButtonItem:(id)bbi
{
	if (self.navigationItem.rightBarButtonItem == nil) {
		[self.navigationItem setRightBarButtonItem:bbi animated:YES];
	} else {
		// Spinner on, move to backupRightButtonItem instead
		_backupRightButtonItem = [bbi retain];
	}
}
-(void) reloadData:(NSNotification*)notif
{
	
}
@end
