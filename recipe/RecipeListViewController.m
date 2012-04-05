//
//  RecipeListViewController.m
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "RecipeListViewController.h"
#import "RecipeViewController.h"
#import "Recipe.h"

@interface RecipeListViewController ()

@end

@implementation RecipeListViewController
@synthesize recipeTable;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        Recipe *recipe = [[Recipe alloc] init];
        [recipe setName:@"Test name"];
        recipeList = [[NSMutableArray alloc] init];
        for (NSInteger i = 0; i < 5; i++) {
            [recipeList addObject:recipe];
        }
        [self.navigationItem setTitle:@"Recipe List"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setRecipeTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table Delegate Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"need to be change";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return recipeList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setText:[[recipeList objectAtIndex:indexPath.row] name]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    RecipeViewController *recipeViewController = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [self.navigationController pushViewController:recipeViewController animated:YES];
}
@end
