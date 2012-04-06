    //
//  EntryTitleViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "EntryTitleViewController.h"


@implementation EntryTitleViewController


-(id) initWithTitle:(NSString*)title andDetaill:(NSString*)detail
{
	if (self = [super initWithNibName:@"EntryTitleView" bundle:nil]) {
		_sTitle = title;
		_sTitleDetail = detail;
	}
	return self;
}

-(void) updateTitle:(NSString*)title andDetaill:(NSString*)detail
{
	_entryTitle.text = title;
	_entryTitleDetail.text = detail;
}

- (void)viewDidLoad {
    [self updateTitle:_sTitle andDetaill:_sTitleDetail];
	[super viewDidLoad];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

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


@end
