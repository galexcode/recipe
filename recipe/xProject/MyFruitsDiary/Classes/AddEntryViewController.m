    //
//  AddEntryController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddEntryViewController.h"

@implementation AddEntryViewController

@synthesize delegate = _delegate;

- (void)viewDidLoad {
    [_datePicker setDate:[NSDate date]];
	[super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
    [super dealloc];
}

-(IBAction) ok:(UIButton*)sender
{
	[_delegate addView:self didPickADate:[_datePicker date]];
}

-(IBAction) cancel:(UIButton*)sender
{
	[_delegate addViewCancel:self];
}
@end
