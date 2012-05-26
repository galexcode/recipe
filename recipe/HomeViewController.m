//
//  HomeViewController.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "HomeViewController.h"
#import "RecipeListViewController.h"
#import "CategoryCell.h"
#import "CategoryXMLHandler.h"
#import "UserXMLHandler.h"
#import "CategoryListViewController.h"

@implementation HomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
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
    // Do any additional setup after loading the view from its nib.
    CategoryListViewController *categoryList = [[CategoryListViewController alloc] initWithStyle:UITableViewStylePlain];
    //categoryTable = (UITableView *)categoryList.view;
    //self.view = categoryList.view;
    
    
//    _categoryArray = [[NSMutableArray alloc] init];
//    
//    CategoryXMLHandler* chandler = [[CategoryXMLHandler alloc] initWithCategoryArray:_categoryArray];
//    NSString *cxmlFilePath = [[NSBundle mainBundle] pathForResource:@"xml" ofType:@"xml"];
//    NSData* cdata = [[NSData alloc] initWithContentsOfFile:cxmlFilePath];
//    NSLog(@"DATA: %s", cdata.bytes);
//    NSXMLParser* cparser = [[NSXMLParser alloc] initWithData:cdata];
//    cparser.delegate = chandler;
//    [cparser parse];
//    
//    User *user = [[User alloc] init];
//    UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:user];
//    NSString *xmlFilePath = [[NSBundle mainBundle] pathForResource:@"user" ofType:@"xml"];
//    NSData* data = [[NSData alloc] initWithContentsOfFile:xmlFilePath];
//    NSLog(@"DATA: %s", data.bytes);
//    NSXMLParser* parser = [[NSXMLParser alloc] initWithData:data];
//    [parser setDelegate:handler];
//    [parser parse];
//    
//    NSLog(@"Recipe count: %i", [user recipeCount]);
}

- (void)viewDidUnload
{
    //[self setCategoryTable:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Navigation Handle
- (void)showRecipeView{
    RecipeListViewController *recipeListViewController = [[RecipeListViewController alloc] initWithNibName:@"RecipeListViewController" bundle:nil];
    [self.navigationController pushViewController:recipeListViewController animated:YES];
}

//#pragma mark - UITableView delegate methods
//- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
//    //return 2;
//    return [_categoryArray count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
//    return 40;
//}
//
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
//    return 1;
//    //return [[[_categoryArray objectAtIndex:section] latestRecipes] count];
//}
//
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    return 100;
//}
//
//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
//    UIView *header = [[UIView alloc] init];
//    [header setBackgroundColor:[UIColor redColor]];
//    UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 20)];
//    [headerLabel setText:[[_categoryArray objectAtIndex:section] name]];
//    [headerLabel setBackgroundColor:[UIColor clearColor]];
//    [headerLabel setTextColor:[UIColor greenColor]];
//    [header addSubview:headerLabel];
//    return header;
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
//    static NSString *CellIdentifier = @"Cell";
//    CategoryCell *cell = (CategoryCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    if (cell == nil) {
//        cell = [[CategoryCell alloc] initWithImageList:nil reuseIdentifier:CellIdentifier refController:self];
//    }
//    return cell;
//}



@end
