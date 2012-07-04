//
//  RecipesTableViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/27/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "RecipesTableViewController.h"
#import "GlobalStore.h"
#import "RecipeViewController.h"
#import "RecipeLongCell.h"
#import "RecipeNavigationLabel.h"
#import "RecipesXMLHandler.h"
#import "AddRecipeViewController.h"
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"

@interface RecipesTableViewController ()

@end

@implementation RecipesTableViewController
@synthesize recipes = _recipes;
@synthesize user = _user;
@synthesize category = _category;
@synthesize keyword = _keyword;
@synthesize reusableCells = _reusableCells;
@synthesize navController;

- (void)awakeFromNib
{
    loaded = NO;
    _user = nil;
    _category = nil;
    _keyword = nil;
    editable = YES;
    isMyRecipe = YES;
}

- (void)viewWillAppear:(BOOL)animated
{
    if (!loaded && isMyRecipe) {
        _user = [[GlobalStore sharedStore] loggedUser];
        [self refresh];
        loaded = YES;
    }
    if (isNeedToReload  && isMyRecipe) {
        isNeedToReload = NO;
        [self refresh];
        loaded = YES;
    }
}

- (id)initWithEditableTable
{
    self = [super initWithNibName:@"ReciepsTableViewController" bundle:nil];
    if (self) {
        loaded = NO;
        _user = [[GlobalStore sharedStore] loggedUser];
        _category = nil;
        _keyword = nil;
        editable = YES;
        [self refresh];
    }
    return self;
}

- (id)initWithUser:(User *)currentUser
{
    self = [super initWithNibName:@"RecipesTableViewController" bundle:nil];
    if (self) {
        loaded = NO;
        _user = currentUser;
        _category = nil;
        _keyword = nil;
        [self refresh];
    }
    return self;
}

- (id)initWithCategory:(Category *)currentCategory
{
    self = [super initWithNibName:@"RecipesTableViewController" bundle:nil];
    if (self) {
        loaded = NO;
        _category = currentCategory;
        _user = nil;
        _keyword = nil;
    }
    return self;
}

- (id)initWithKeyword:(NSString *)keyword
{
    self = [super initWithNibName:@"RecipesTableViewController" bundle:nil];
    if (self) {
        loaded = NO;
        _keyword = keyword;
        _user = nil;
        _category = nil;
    }
    return self;
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        loaded = NO;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        loaded = NO;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    
    if (editable) {
        barButton = [[UIBarButtonItem alloc] 
         initWithTitle:@"Add"                                            
         style:UIBarButtonItemStyleBordered 
         target:self 
         action:@selector(addRecipe:)];
        self.navigationItem.rightBarButtonItem = barButton;
    }
    
    [self initResuableCells];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
}

-(IBAction)addRecipe:(id)sender{
    isNeedToReload = YES;
    AddRecipeViewController *viewControllerToPush = [[AddRecipeViewController alloc] initWithNibName:@"AddRecipeViewController" bundle:nil];
    [[viewControllerToPush navigationItem] setTitle:@"Add Recipe"];
    [[self navigationController] pushViewController:viewControllerToPush animated:YES];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)refresh
{
    _recipes = nil;
    _recipes = [[NSMutableArray alloc] init];
    
    NSURL *url;
    
    if (_keyword != nil) {
        url = [NSURL URLWithString:[GlobalStore searchLink]];
    } else {
        url = [NSURL URLWithString:[GlobalStore recipesLink]];
    }
    
    __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    
    if (_user != nil) {
        [request setPostValue:[_user userId] forKey:@"uid"];
    }
    if (_category != nil) {
        [request setPostValue:[_category categoryId] forKey:@"cid"];
    }
    if (_keyword != nil) {
        NSLog(@"the keyword: %@", _keyword);
        [request setPostValue:_keyword forKey:@"key"];
    }
    
    [request setCompletionBlock:^{
        NSLog(@"respone code: %d", request.responseStatusCode);
        if (request.responseStatusCode == 200) {
            RecipesXMLHandler* handler = [[RecipesXMLHandler alloc] initWithRecipeArray:_recipes];
            [handler setEndDocumentTarget:self andAction:@selector(didParsedRecipes)];
            NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
            parser.delegate = handler;
            [parser parse];
        }
        else {
            [self didParsedRecipes];
        }
    }];
    [request setFailedBlock:^{
        NSError *error = request.error;
        NSLog(@"Error downloading recipes xml: %@", error.localizedDescription);
    }];
    
    [request startAsynchronous];
    [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.5];
}

-(void) didParsedRecipes
{
    if (_recipes != nil && [_recipes count] > 0) {
        [self initResuableCells];
    }
}

-(void)initResuableCells{
    
    [self setReusableCells:nil];
     self.reusableCells = [NSMutableArray array];
    
    for (int i = 0; i < [[self recipes] count]; i++) {
        
        RecipeLongCell *cell;
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecipeLongCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[RecipeLongCell class]]) {
                cell = (RecipeLongCell*)currentObject;
                break;
            }
        }
        
        Recipe *currentRecipe = [self.recipes objectAtIndex:i];
        
        cell.recipeName.text = [currentRecipe name];
        
        if ([[currentRecipe imageList] count] > 0) {
            NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:120 andHeight:0]];
            
            __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
            [request setCompletionBlock:^{
                NSData *data = request.responseData;
                if (data != nil)
                    [cell.thumb setImage:[[UIImage alloc] initWithData:data]];
            }];
            [request setFailedBlock:^{
                NSError *error = request.error;
                NSLog(@"Error downloading image: %@", error.localizedDescription);
            }];
            [request startAsynchronous];
        }
        
        [[self reusableCells] addObject:cell];;
    }
    
    [[self tableView] reloadData];
}

#pragma mark - Table view data source

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
    RecipeLongCell *cell = [self.reusableCells objectAtIndex:indexPath.row];
    
    return cell;
//    static NSString *CellIdentifier = @"RecipeLongCell";
//    
//    RecipeLongCell *cell = (RecipeLongCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
//    
//    if (cell == nil) 
//    {
//        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecipeLongCell" owner:self options:nil];
//        
//        for (id currentObject in topLevelObjects) {
//            if ([currentObject isKindOfClass:[RecipeLongCell class]]) {
//                cell = (RecipeLongCell*)currentObject;
//                break;
//            }
//        }
//        
//        if ([[self recipes] count] > 0) {
//            Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
//            
//            cell.recipeName.text = [currentRecipe name];
//            
//            //cell.thumb.image = [UIImage imageNamed:@"default_recipe.jpg"];
//            
//            if ([[currentRecipe imageList] count] > 0) {
//                if (cell.thumb.image == nil) {
//                    NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:120 andHeight:0]];
//                    
//                    __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
//                    [request setCompletionBlock:^{
//                        NSData *data = request.responseData;
//                        if (data != nil) {
//                            [cell.thumb setImage:[[UIImage alloc] initWithData:data]];
//                        } else {
//                            cell.thumb.image = [UIImage imageNamed:@"default_recipe.jpg"];
//                        }
//                    }];
//                    [request setFailedBlock:^{
//                        NSError *error = request.error;
//                        NSLog(@"Error downloading image: %@", error.localizedDescription);
//                    }];
//                    [request startAsynchronous];
//                }
////                NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[[currentRecipe imageList] objectAtIndex:0] forWidth:120 andHeight:0]];
////                
////                __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
////                [request setCompletionBlock:^{
////                    NSData *data = request.responseData;
////                    [cell.thumb setImage:[[UIImage alloc] initWithData:data]];
////                }];
////                [request setFailedBlock:^{
////                    NSError *error = request.error;
////                    NSLog(@"Error downloading image: %@", error.localizedDescription);
////                }];
////                [request startAsynchronous];
//            }
//        }        
//    }
//    
//    return cell;
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self recipes] count] > 0) {
        Recipe *currentRecipe = (Recipe*)[[self recipes] objectAtIndex:indexPath.row];
        RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
        [viewControllerToPush setRecipe:currentRecipe];
        [[viewControllerToPush navigationItem] setTitle:[currentRecipe name]];
        if ([self navController] != nil) {
            UINavigationController *parentNav = (UINavigationController *)[self navController];
            [parentNav pushViewController:viewControllerToPush animated:YES];
        } else {
            [[self navigationController] pushViewController:viewControllerToPush animated:YES];
        }
    }
}

@end
