    //
//  MyDiaryViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MyDiaryViewController.h"
#import "EntryTitleViewController.h"
#import "FruitsListViewController.h"
#import "FruitViewController.h"


@implementation MyDiaryViewController

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    self.navigationItem.title = @"My Diary";
	
	NSArray *itemsArray = [NSArray arrayWithObjects: @"Edit", @" +  ", nil];
	_rightBarButtonItems = [[UISegmentedControl alloc] initWithItems:itemsArray];
	_rightBarButtonItems.segmentedControlStyle = UISegmentedControlStyleBar;
	[_rightBarButtonItems addTarget:self 
							 action:@selector(handleRightBarButtonEvent:) 
				   forControlEvents:UIControlEventValueChanged];
	_rightBarButtonItems.momentary = YES;
	for (int i = 0; i < _rightBarButtonItems.numberOfSegments; ++i) {
		// TODO [_rightBarButtonItems setWidth:70 forSegmentAtIndex:i];
	}
	UIBarButtonItem* ubbi = [[UIBarButtonItem alloc] initWithCustomView:_rightBarButtonItems];
	[self setRightBarButtonItem:ubbi];
	[ubbi release];
	
	_isEditMode = NO;
	
	[super viewDidLoad];
}

-(void) handleRightBarButtonEvent : (id) sender
{
	switch([(UISegmentedControl *)sender selectedSegmentIndex]) {
		case 0:
			[self toggleEditingMode];
			break;
		case 1:
			[self displayAddEntryView: YES];
			break;    
	}
}

- (void) displayAddEntryView:(BOOL)toShow
{
	if (toShow) {
		_addEntryViewController = [[AddEntryViewController alloc] initWithNibName:@"AddEntryView" bundle:nil];
		_addEntryViewController.delegate = self;
		
		APP_DELEGATE(app);
		UIViewController* container = (UIViewController*)[app viewController];
		[container.view addSubview:_addEntryViewController.view];
		_addEntryViewController.view.alpha = 0;
		
		[UIView beginAnimations:nil context:NULL];
		_addEntryViewController.view.alpha = 1;
		[UIView commitAnimations];
	} else {
		[_addEntryViewController.view removeFromSuperview];
		[_addEntryViewController release];
	}
}

-(void) toggleEditingMode
{
	_isEditMode = !_isEditMode;
	
	if (_isEditMode) {
		[_rightBarButtonItems setTitle:@"Done" forSegmentAtIndex: 0];
	} else {
		[_rightBarButtonItems setTitle:@"Edit" forSegmentAtIndex:0];
	}
	
	[_table setEditing:_isEditMode];
	
	[_table reloadData];
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
	[_rightBarButtonItems release];
    [super dealloc];
}

-(void) reloadData:(NSNotification*)notif
{
	[_table reloadData];
}
#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	APP_SERVICE(appService);
	return [[appService entries] count];
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	APP_SERVICE(app);
	Entry* entry = [[app entries] objectAtIndex:section];
	return [[entry fruitBags] count] + 1;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	APP_SERVICE(app);
	Entry* entry = [[app entries] objectAtIndex:indexPath.section];
	
	NSString *cellIdentifier = nil;
	cellIdentifier = @"EntryCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (indexPath.row < [entry.fruitBags count]) {
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]	autorelease];
			cell.indentationLevel = 1;		
		} 
		
		FruitBag* fruitBag = [[entry fruitBags] objectAtIndex:indexPath.row];
		cell.textLabel.text = fruitBag.fruit.name;
		NSString* detail = [NSString stringWithFormat:@"Amount: %d - Vitamins: %d", fruitBag.count, [fruitBag totalVitamins]];
		cell.detailTextLabel.text = detail;
		cell.imageView.image = nil;
		if (fruitBag.fruit.image != nil) {
			cell.imageView.image = [UIImage imageWithData:fruitBag.fruit.image];
		}
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	} else {
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]	autorelease];
			cell.indentationLevel = 1;		
		}
		cell.textLabel.text = @"Add more fruit...";
		cell.detailTextLabel.text = @"";
		cell.imageView.image = nil;
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	APP_SERVICE(app);
	Entry* entry = [[app entries] objectAtIndex:indexPath.section];
		
	if (indexPath.row < [entry.fruitBags count]) {
		FruitBag* fruitBag = [[entry fruitBags] objectAtIndex:indexPath.row];
	
		FruitViewController* fvc = [[FruitViewController alloc] initWithEntry:entry andFruitBag:fruitBag editMode:YES];
		fvc.navigationItem.title = fruitBag.fruit.name;
		[self.navigationController pushViewController:fvc animated:YES];
		[fvc release];
									
	} else {
		FruitsListViewController* flvc = [[FruitsListViewController alloc] initWithEntry:entry];
		flvc.navigationItem.title = @"Fruits";
		[self.navigationController pushViewController:flvc animated:YES];
		[flvc release];
		
	}
}

-(UIView *) tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
	APP_SERVICE(app);
	Entry* entry = [[app entries] objectAtIndex:section];
	
	EntryTitleViewController* etvc = 
		[[[EntryTitleViewController alloc] initWithTitle:[entry dateByStringWithFormat:@"yyyy-MM-dd"] 
											  andDetaill:[entry detailByString]] autorelease];

	return etvc.view;
}

-(CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
	return 48;
}

-(UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.row == 0) {
		return UITableViewCellEditingStyleDelete;
		
	}
	return UITableViewCellEditingStyleNone;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    int idx = indexPath.section;
	
	APP_SERVICE(appSrv);
	Entry* e = [[appSrv entries] objectAtIndex: idx];
	[appSrv removeEntry: e];
	
}
#pragma mark -
#pragma mark AddEntryViewDelegate
-(void) addViewCancel: (UIViewController*)viewController
{
	[self displayAddEntryView:NO];
}

-(void) addView: (UIViewController*)viewController didPickADate: (NSDate*)date
{
	[self displayAddEntryView:NO];
	Entry* entry = [[Entry alloc] initWithDate:date];
	APP_SERVICE(appSrv);	
	[appSrv addEntry:entry];
	[entry release];
}
@end
