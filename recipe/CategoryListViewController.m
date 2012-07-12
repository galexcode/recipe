//
//  CategoryListViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/21/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "CategoryListViewController.h"
#import "RecipesTableViewController.h"
#import "ASIForm2DataRequest.h"
#import "ASI2HTTPRequest.h"
#import "HorizontalTableCell.h"
#import "ControlVariables.h"
#import "HeaderButton.h"
#import "GlobalStore.h"
#import "CategoriesXMLHandler.h"

#define kHeadlineSectionHeight  26
#define kRegularSectionHeight   18

@interface CategoryListViewController ()

@end

@implementation CategoryListViewController
@synthesize categoryDictionary = _categoryDictionary;
@synthesize reusableCells = _reusableCells;
@synthesize navController;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [self.tableView setBackgroundColor:[UIColor clearColor]];
        self.tableView.rowHeight = kCellHeight + (kRowVerticalPadding * 0.5) + ((kRowVerticalPadding * 0.5) * 0.5);
        [self refresh];
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}

- (void)awakeFromNib
{
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.rowHeight = kCellHeight + (kRowVerticalPadding * 0.5) + ((kRowVerticalPadding * 0.5) * 0.5);
    [self refresh];
}

- (void)viewWillAppear:(BOOL)animated
{
}

- (void)refresh
{
    [self setCategoryDictionary:nil];
    [self setCategoryDictionary:[[NSMutableDictionary alloc] init]];
    
    NSURL *url = [NSURL URLWithString:[GlobalStore categoriesLink]];
    
    __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    
    [request setCompletionBlock:^{
        if (request.responseStatusCode == 200) {
            CategoriesXMLHandler* handler = [[CategoriesXMLHandler alloc] initWithCategoryDictionary:_categoryDictionary];
            [handler setEndDocumentTarget:self andAction:@selector(didParsedCategories)];
            NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
            parser.delegate = handler;
            [parser parse];
        }
        else {
            _categoryDictionary = nil;
            [self didParsedCategories];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = request.error;
        NSLog(@"Error downloading categories: %@", error.localizedDescription);
    }];
    
    [request startAsynchronous];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.5];
}

-(void) didParsedCategories
{
    if (_categoryDictionary != nil && [[_categoryDictionary allKeys] count] > 0) {
        [[GlobalStore sharedStore] setCategories:_categoryDictionary];
        [self initResuableCells];
        //[self.tableView reloadData];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)initResuableCells
{
    [self setReusableCells:nil];
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    NSArray* sortedCategories = [self.categoryDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
//    categoryIndex = nil;
//    categoryIndex = [[NSMutableArray alloc] init];
//    
//    for (int i = 0; i < [[[self categoryDictionary] allKeys] count]; i++) {
//        char alphabet = [[sortedCategories objectAtIndex:i] characterAtIndex:0];
//        NSString *uniChar = [NSString stringWithFormat:@"%C", alphabet];
//        if (![categoryIndex containsObject:uniChar])
//            [categoryIndex addObject:uniChar];
//    }
    
    self.reusableCells = [NSMutableArray array];
    
    for (int i = 0; i < [self.categoryDictionary.allKeys count]; i++)
    {                        
        HorizontalTableCell *cell = [[HorizontalTableCell alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
        cell.navController = self.navController;
        
        NSString *categoryName = [sortedCategories objectAtIndex:i];
        
        NSMutableArray *currentCategory = [self.categoryDictionary objectForKey:categoryName];
        
        Category* thisCategory = (Category *)currentCategory;
        
        cell.recipes = thisCategory.latestRecipes;
        
        [self.reusableCells addObject:cell];
    }
    
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.categoryDictionary = nil;
    self.reusableCells = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tapOnHeader:(id)sender
{
    __weak HeaderButton* tempButton = (HeaderButton*)sender;
    RecipesTableViewController *viewControllerToPush = [[RecipesTableViewController alloc] initWithCategory:[tempButton category]];
    [viewControllerToPush setRecipes:[[tempButton category] latestRecipes]];
    [[viewControllerToPush navigationItem] setTitle:tempButton.titleText];
    UINavigationController *nav = (UINavigationController*)self.navController;
    [nav pushViewController:viewControllerToPush animated:YES];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kRegularSectionHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.categoryDictionary.allKeys count];    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[self categoryDictionary] allKeys] count] > 0) {
        return 1;
    }
    return 0;
}

//- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView {
//    if (categoryIndex != nil)
//        return categoryIndex;
//    else
//        return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    if ([self.categoryDictionary.allKeys count] > 0) {
        UIView *customSectionHeaderView;
        UILabel *titleLabel;
        HeaderButton *headerButton;
        
        //Custom Section Header
        customSectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)];
        
        titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, kRegularSectionHeight)];
        
        customSectionHeaderView.backgroundColor = [UIColor colorWithRed:0.44f green:0.11f blue:0.05f alpha:1.00f];;
        
        titleLabel.textAlignment = UITextAlignmentLeft;
        [titleLabel setTextColor:[UIColor whiteColor]];
        [titleLabel setBackgroundColor:[UIColor clearColor]];   
        titleLabel.font = [UIFont boldSystemFontOfSize:13];
        
        NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
        NSArray* sortedCategories = [self.categoryDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        
        NSString *categoryName = [sortedCategories objectAtIndex:section];
        
        NSArray *currentCategory = [self.categoryDictionary objectForKey:categoryName];
        
        Category *thisCategory = (Category*)currentCategory;
        
        [titleLabel setText:categoryName];
        [titleLabel setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        
        [customSectionHeaderView addSubview:titleLabel];
        
        //Add button for header
        headerButton = [[HeaderButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)];
        [headerButton setCategory:thisCategory];
        [headerButton setArray:[thisCategory latestRecipes]];
        [headerButton setTitleText:categoryName];
        [headerButton setBackgroundColor:[UIColor clearColor]];
        [headerButton addTarget:self action:@selector(tapOnHeader:) forControlEvents:UIControlEventTouchUpInside];
        
        [customSectionHeaderView addSubview:headerButton];
        
        return customSectionHeaderView;
    }
    return nil;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HorizontalTableCell *cell = [self.reusableCells objectAtIndex:indexPath.section];
    
    return cell;
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

@end
