//
//  RecipeViewController.m
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "RecipeViewController.h"
#import "IngredientListViewController.h"
#import "StepListViewController.h"
#import "RecipeNavigationLabel.h"

@implementation RecipeViewController
@synthesize recipeDetailsTable;
@synthesize recipe = _recipe;
@synthesize slideShowCell;
@synthesize recipeHeaderView;
@synthesize recipeInfoView;
@synthesize recipeNameLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        //[self.navigationItem setTitle:@"Missing Recipe Name"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:@"Recipe Details"];
    [[self navigationItem] setTitleView:label];
    [self.recipeDetailsTable setBackgroundColor:[UIColor clearColor]];
    [[self recipeNameLabel] setText:[[self recipe] name]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setRecipeDetailsTable:nil];
    [self setSlideShowCell:nil];
    [self setRecipeNameLabel:nil];
    [self setRecipeHeaderView:nil];
    [self setRecipeInfoView:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Table delegate methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (section == 1) {
        return @"Ingredients and Step";
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return 35.00f;
    }
    return 40.00f;
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if (section == 0) {
        return [self recipeHeaderView];
    }
    if (section == 1) {
        return [self recipeInfoView];
    }
    return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0) {
        return 1;
    }
    else if (section == 1){
        return 2;
    }
    else {
        return 0;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 201.0;
    }
    else {
        return 45;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *imageCell = @"Image";
    static NSString *listCell = @"List";
    if (indexPath.section == 0) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:imageCell];
        if (cell == nil) {
            //cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:imageCell];
            cell = slideShowCell;
        }
        //[cell.textLabel setText:@"images go here(slide show)"];
        return cell;
    }
    else{
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:listCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:listCell];
        }
        if (indexPath.row == 0) {
            [cell.textLabel setText:@"Ingredient List"];
        }
        else {
            [cell.textLabel setText:@"Step List"];
        }
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            IngredientListViewController *viewControllerToPush = [[IngredientListViewController alloc] initWithNibName:@"IngredientListViewController" bundle:nil];
            [self.navigationController pushViewController:viewControllerToPush animated:YES];
        } else if (indexPath.row == 1){
            StepListViewController *viewControllerToPush = [[StepListViewController alloc] initWithNibName:@"StepListViewController" bundle:nil];
            [self.navigationController pushViewController:viewControllerToPush animated:YES];
        }
    }
}

@end
