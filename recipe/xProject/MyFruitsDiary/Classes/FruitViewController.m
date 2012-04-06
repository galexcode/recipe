    //
//  FruitViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FruitViewController.h"


@implementation FruitViewController

-(id) initWithEntry:(Entry*)entry andFruitBag:(FruitBag*)fruitBag editMode:(BOOL)editMode
{
	if (self = [super initWithNibName:@"FruitView" bundle:nil]) {
		_entry = entry;
		if (_isEdit) {
			_fruitBag = fruitBag;
		} else {
			_fruitBag = [fruitBag retain];
		}
	}
	return self;
}

- (void)viewDidLoad {
    NSString* detail = [NSString stringWithFormat:@"Vitamins: %d \nType: %@", 
						_fruitBag.fruit.vitamins, 
						_fruitBag.fruit.type];
	_txtFruitDetail.text = detail;
	
	_txtAmount.text = [NSString stringWithFormat:@"%d", _fruitBag.count];
	_txtVitamins.text = [NSString stringWithFormat:@"%d", _fruitBag.fruit.vitamins*_fruitBag.count];
	
	_fruitImg.image = [UIImage imageWithData:_fruitBag.fruit.image];
	
	UIBarButtonItem* ubbi = 
		[[UIBarButtonItem alloc] initWithTitle:@"Save" 
										 style:UIBarButtonItemStyleDone 
										target:self 
										action:@selector(finishEdit:)];
	[self setRightBarButtonItem:ubbi];
	[ubbi release];
	
	[super viewDidLoad];
}

-(void) finishEdit: (id) sender
{
	_fruitBag.count = [_txtAmount.text intValue];
	
	APP_SERVICE(appSrv);
	[appSrv addOrEditFruitBag:_fruitBag toEntry:_entry];
	
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

-(IBAction) amountChanged: (UISlider*) sender
{
	int amt = (int)(sender.value * 100);
	_txtAmount.text = [NSString stringWithFormat:@"%d", amt];
	_txtVitamins.text = [NSString stringWithFormat:@"%d", _fruitBag.fruit.vitamins*amt];
}

-(void) finishReq:(NSNotification *)notif
{
	[super finishReq: notif];
	[self.navigationController popToRootViewControllerAnimated:YES];
}
@end
