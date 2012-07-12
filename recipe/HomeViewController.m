//
//  HomeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/25/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "HomeViewController.h"
#import "RecipesXMLHandler.h"
#import "GlobalStore.h"
#import "recipeGlobal.h"
#import "RecipesTableViewController.h"
#import "ASIForm2DataRequest.h"

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
    
    UIBarButtonItem *barButton = [[UIBarButtonItem alloc] 
                 initWithTitle:@"Switch Style"                                            
                 style:UIBarButtonItemStyleBordered 
                 target:self 
                 action:@selector(switchView)];
    self.navigationItem.rightBarButtonItem = barButton;

    
    bigBgView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 64, 300, 285)];
    
    UIImage *bigBg = [[UIImage imageNamed:@"form_bg"] resizableImageWithCapInsets:UIEdgeInsetsMake(11, 0, 11, 0)];
    
    [bigBgView setImage:bigBg];
    
    [self.view addSubview:bigBgView];
    
    UIImage *smallBg = [[UIImage imageNamed:@"glass"] resizableImageWithCapInsets:UIEdgeInsetsMake(15, 15, 15, 15)];
    
    upperSmallBgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 75, 290, 132)];
    
    [upperSmallBgView setImage:smallBg];
    
    [self.view addSubview:upperSmallBgView];
    
    lowerSmallBgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 207, 290, 132)];
    
    [lowerSmallBgView setImage:smallBg];
    
    [self.view addSubview:lowerSmallBgView];
    
    
    tableViewController = [[CategoryListViewController alloc] initWithNibName:@"CategoryListViewController" bundle:nil];
    CGRect frame = CGRectMake(0, 44, 320, 446);
    [tableViewController.view setFrame:frame];
    tableViewController.navController = self.navigationController;
    [self.view addSubview:tableViewController.view];
    [tableViewController.view setHidden:YES];
    isSwitch = YES;
    
    tableView2Controller = [[CategoryList2ViewController alloc] initWithNibName:@"CategoryList2ViewController" bundle:nil];
    CGRect frame2 = CGRectMake(15, 64, 290, 357);
    [tableView2Controller.view setFrame:frame2];
    tableView2Controller.navController = self.navigationController;
    [self.view addSubview:tableView2Controller.view];
}

- (void)switchView
{
    [bigBgView setHidden:isSwitch];
    [upperSmallBgView setHidden:isSwitch];
    [lowerSmallBgView setHidden:isSwitch];
    [tableView2Controller.view setHidden:isSwitch];
    [tableViewController.view setHidden:!isSwitch];
    isSwitch = !isSwitch;
}

- (void)viewDidUnload
{
    [self setMySearchBar:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    if ([trimSpaces([searchBar text]) length] > 0) {
        _recipes = nil;
        _recipes = [[NSMutableArray alloc] init];
        
        NSURL *url = [NSURL URLWithString:[GlobalStore searchLink]];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:searchBar.text forKey:@"key"];
        
        [request setCompletionBlock:^{
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
        RecipesTableViewController *viewControllerToPush = [[RecipesTableViewController alloc] initWithKeyword:[[self mySearchBar] text]];
        [viewControllerToPush setRecipes:_recipes];
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
