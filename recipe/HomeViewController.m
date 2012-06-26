//
//  HomeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/25/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "CategoryListViewController.h"
#import "RecipesXMLHandler.h"
#import "GlobalStore.h"
#import "recipeGlobal.h"
#import "RecipeListViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize mySearchBar;
@synthesize recipes = _recipes;
@synthesize navController;

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
//    
//    for (__strong UIView *subview in [[self mySearchBar] subviews]) {
//        if ([subview isKindOfClass:[UITextField class]])
//        {
//        }
//    }
    
    CategoryListViewController *tableViewController = [[CategoryListViewController alloc] initWithNibName:@"CategoryListViewController" bundle:nil];
    CGRect frame = CGRectMake(0, 44, 320, 446);
    [tableViewController.view setFrame:frame];
    tableViewController.navController = self.navigationController;
    [self.view addSubview:tableViewController.view];
}

- (void)viewDidUnload
{
    [self setMySearchBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    //NSLog(@"Button click search: %@", [[self mySearchBar] text]);
    if ([trimSpaces([searchBar text]) length] > 0) {
        _recipes = nil;
        _recipes = [[NSMutableArray alloc] init];
        
        NSURL *url = [NSURL URLWithString:[GlobalStore searchLink]];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:searchBar.text forKey:@"key"];
        
        [request setCompletionBlock:^{
            NSLog(@"Recipes xml loaded.");
            NSLog(@"status code: %d",request.responseStatusCode);
            if (request.responseStatusCode == 200) {
                RecipesXMLHandler* handler = [[RecipesXMLHandler alloc] initWithRecipeArray:_recipes];
                [handler setEndDocumentTarget:self andAction:@selector(didParsedSearchRecipes)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
            }
            else {
                //[self didParsedRecipes];
            }
        }];
        [request setFailedBlock:^{
            NSError *error = request.error;
            NSLog(@"Error downloading image: %@", error.localizedDescription);
        }];
        
        [request startAsynchronous];
    } else {
        [searchBar setText:@""];
    }
}

- (void)didParsedSearchRecipes
{
    if(_recipes != nil && [_recipes count] > 0)
    {
        NSLog(@"Load len cai view moi");
        RecipeListViewController* viewControllerToPush = [[RecipeListViewController alloc] initWithNibName:@"RecipeListViewController" bundle:nil];
        viewControllerToPush.recipes = _recipes;
        [[viewControllerToPush navigationItem] setTitle:[[self mySearchBar] text]];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    } else {
        [[self mySearchBar] resignFirstResponder];
        [[self mySearchBar] setShowsCancelButton:NO animated:YES];
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:[NSString stringWithFormat:@"No result for \"%@\"", [[self mySearchBar] text]] delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [[self mySearchBar] setText:@""];
        [alertView show];
    }
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:YES animated:NO];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [searchBar setShowsCancelButton:NO animated:YES];
    [searchBar resignFirstResponder];
}
@end
