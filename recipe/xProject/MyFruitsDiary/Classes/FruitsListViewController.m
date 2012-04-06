    //
//  FruitsListViewController.m
//  MyFruitsDiary
//
//  Created by Khoi Pham on 3/13/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FruitsListViewController.h"
#import "FruitViewController.h"

@implementation FruitsListViewController

-(id) initWithEntry:(Entry*)entry
{
	if (self = [super initWithNibName:@"FruitsListView" bundle:nil]) {
		_entry = entry;
	}
	return self;
}

- (void)viewDidLoad {
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

#pragma mark -
#pragma mark UITableViewDelegate
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	APP_SERVICE(app);
	
	return [[app fruitList] count];
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	APP_SERVICE(app);
	Fruit* fruit = [[app fruitList] objectAtIndex:indexPath.row];
	
	NSString *cellIdentifier = nil;
	cellIdentifier = @"FruitCell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
	if (cell == nil) {
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIdentifier]	autorelease];
		cell.indentationLevel = 1;		
	}
		
	cell.textLabel.text = fruit.name;
	NSString* detail = [NSString stringWithFormat:@"Vitamins: %d", [fruit vitamins]];
	cell.detailTextLabel.text = detail;
	if (fruit.image != nil) {
		cell.imageView.image = [UIImage imageWithData:fruit.image];
	}
	return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	APP_SERVICE(app);
	Fruit* fruit = [[app fruitList] objectAtIndex:indexPath.row];
	FruitBag* fb = [[FruitBag alloc] initWithCount:1 andFruit:fruit];
	//[[_entry fruitBags] addObject:fb];
		
	FruitViewController* fvc = [[FruitViewController alloc] initWithEntry:_entry 
															  andFruitBag:fb
																 editMode:NO];
	fvc.navigationItem.title = fb.fruit.name;
	[self.navigationController pushViewController:fvc animated:YES];
	[fvc release];
	[fb release];
}

-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

-(NSString *) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	return @"Please choose a fruit...";
}

-(void) reloadData:(NSNotification *)notif
{
	[_table reloadData];
}
@end
