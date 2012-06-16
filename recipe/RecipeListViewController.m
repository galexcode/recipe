//
//  RecipeListViewController.m
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "RecipeListViewController.h"
#import "RecipeViewController.h"
#import "Recipe.h"
#import "RecipeNavigationLabel.h"

@interface RecipeListViewController ()

@end

@implementation RecipeListViewController
@synthesize recipeTable;
@synthesize recipes = _recipes;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        Recipe *recipe = [[Recipe alloc] init];
//        [recipe setName:@"Test name"];
//        recipeList = [[NSMutableArray alloc] init];
//        for (NSInteger i = 0; i < 5; i++) {
//            [recipeList addObject:recipe];
//        }
        [self.navigationItem setTitle:@"Recipe List"];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
//    [[self navigationItem] setTitleView:label];
    
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
    
    [[self navigationItem] setTitleView:headerView];
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

#pragma mark - Table Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    //NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    //NSArray* sortedCategories = [self.articleDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    //NSString *categoryName = [sortedCategories objectAtIndex:indexPath.section];
    
    //NSArray *currentCategory = [self.articleDictionary objectForKey:categoryName];
    
    Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    
    //NSLog(@"%@", currentRecipe);
    
    cell.textLabel.text = [currentRecipe name];
    cell.imageView.image = [UIImage imageNamed:@"OrangeJuice"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
