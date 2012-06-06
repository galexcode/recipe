//
//  CategoryListViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/21/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "CategoryListViewController.h"
#import "ASIForm2DataRequest.h"
#import "HorizontalTableCell.h"
#import "ControlVariables.h"
#import "HeaderButton.h"
#import "RecipeListViewController.h"

#define kHeadlineSectionHeight  26
#define kRegularSectionHeight   18

@interface CategoryListViewController ()

@end

@implementation CategoryListViewController
@synthesize categoryDictionary = _categoryDictionary;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
//        APP_SERVICE(appSrv);
//        NSLog(@"%@", appSrv);
//        _applicationService = appSrv;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
//        APP_SERVICE(appSrv);
//        NSLog(@"%@", appSrv);
//        _applicationService = appSrv;
    }
    return self;
}

- (void)awakeFromNib
{
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] 
                                  initWithBarButtonSystemItem:UIBarButtonSystemItemAdd 
                                  target:self 
                                  action:@selector(reload)];
    [[self navigationItem] setRightBarButtonItem:addButton];
    //[self.tableView setBackgroundColor:kVerticalTableBackgroundColor];
    [self setCategoryDictionary:[[NSMutableDictionary alloc] init]];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    self.tableView.rowHeight = kCellHeight + (kRowVerticalPadding * 0.5) + ((kRowVerticalPadding * 0.5) * 0.5);
    
    [self reload];
}

- (void)viewWillAppear:(BOOL)animated
{
    //[self reload];
}

- (void)reload
{
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/categories.xml"];
    
    ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    //    [request setPostValue:@"1" forKey:@"rw_app_id"];
    //    [request setPostValue:@"test" forKey:@"code"];
    //    [request setPostValue:@"test" forKey:@"device_id"];
    
    [request setCompletionBlock:^{
        NSLog(@"Categories xml loaded.");
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
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    
    [request startAsynchronous];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //self.categoryDictionary = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Articles" ofType:@"plist"]];
    

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.categoryDictionary = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)tapOnHeader:(id)sender
{
    __weak HeaderButton* tempButton = (HeaderButton*)sender;
    RecipeListViewController* viewControllerToPush = [[RecipeListViewController alloc] initWithNibName:@"RecipeListViewController" bundle:nil];
    viewControllerToPush.recipes = tempButton.array;
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kRegularSectionHeight;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self.categoryDictionary.allKeys count];
    NSLog(@"section: %d", [self.categoryDictionary.allKeys count]);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *customSectionHeaderView;
    UILabel *titleLabel;
    HeaderButton *headerButton;
    
    //Custom Section Header
    customSectionHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)];
        
    titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, tableView.frame.size.width, kRegularSectionHeight)];

    //customSectionHeaderView.backgroundColor = [UIColor colorWithRed:0 green:0.40784314 blue:0.21568627 alpha:0.95];
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
    
    //titleLabel.text = [categoryName substringFromIndex:1];
    [titleLabel setText:categoryName];
    [titleLabel setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
    
    [customSectionHeaderView addSubview:titleLabel];
    
    //Add button for header
    headerButton = [[HeaderButton alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, kRegularSectionHeight)];
    [headerButton setArray:[thisCategory latestRecipes]];
    [headerButton setBackgroundColor:[UIColor clearColor]];
    [headerButton addTarget:self action:@selector(tapOnHeader:) forControlEvents:UIControlEventTouchUpInside];
    
    [customSectionHeaderView addSubview:headerButton];
    
    return customSectionHeaderView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{    
    static NSString *CellIdentifier = @"HorizontalCell";
    
    HorizontalTableCell *cell = (HorizontalTableCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil)
    {
        cell = [[HorizontalTableCell alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, tableView.frame.size.height)];
        cell.navController = self.navigationController;
    }
    
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    NSArray* sortedCategories = [self.categoryDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    NSString *categoryName = [sortedCategories objectAtIndex:indexPath.section];
    
    //NSLog(@"%@", categoryName);
    
    NSMutableArray *currentCategory = [self.categoryDictionary objectForKey:categoryName];
    
    Category* thisCategory = (Category *)currentCategory;
    
    cell.recipes = thisCategory.latestRecipes;
    
    return cell;
}

#pragma mark Application Service Delegate Methods
-(void) didParsedCategories
{
    if (_categoryDictionary != nil) {
        [self.tableView reloadData];
    }
}

//-(void) didFinishParsedCategories:(NSMutableDictionary *__weak)categoryDictionary
//{
//    if (categoryDictionary != nil) {
////        _categoryDictionary = categoryDictionary;
//        [self.tableView reloadData];
//        //APP_SERVICE(appSrv);
////        NSLog(@"%@", _applicationService);
////        [_applicationService setDelegate:nil];
//    }
//}

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
