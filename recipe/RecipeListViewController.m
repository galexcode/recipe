//
//  RecipeListViewController.m
//  recipe
//
//  Created by Vu Tran on on 4/3/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "RecipeListViewController.h"
#import "GlobalStore.h"
#import "RecipeViewController.h"
#import "Recipe.h"
#import "RecipeLongCell.h"
#import "RecipeNavigationLabel.h"
#import "ASI2HTTPRequest.h"

@interface RecipeListViewController ()

@end

@implementation RecipeListViewController
@synthesize recipeTable;
@synthesize pageTitle;
@synthesize recipes = _recipes;
@synthesize pageTitleText = _pageTitleText;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    [[self pageTitle] setText:[self pageTitleText]];
    
//    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
//    
//    [[self navigationItem] setTitleView:headerView];
}

- (void)viewDidUnload
{
    [self setRecipeTable:nil];
    [self setPageTitle:nil];
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

//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 60;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RecipeLongCell *cell = (RecipeLongCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecipeLongCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[RecipeLongCell class]]) {
                cell = (RecipeLongCell*)currentObject;
                break;
            }
        }
    }
    
    Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];

    cell.recipeName.text = [currentRecipe name];
    cell.thumb.image = [UIImage imageNamed:@"default_recipe.jpg"];
    
    if ([[currentRecipe imageList] count] > 0) {
        
        NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:120 andHeight:0]];
        
        __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
        [request setCompletionBlock:^{
            NSData *data = request.responseData;
            [cell.thumb setImage:[[UIImage alloc] initWithData:data]];
        }];
        [request setFailedBlock:^{
            NSError *error = request.error;
            NSLog(@"Error downloading image: %@", error.localizedDescription);
        }];
        [request startAsynchronous];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Recipe* currentRecipe = (Recipe*)[self.recipes objectAtIndex:indexPath.row];
    RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [[viewControllerToPush navigationItem] setTitle:[currentRecipe name]];
    [viewControllerToPush setRecipe:currentRecipe];
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
