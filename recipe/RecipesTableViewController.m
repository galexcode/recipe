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
#import "MBProgressHUD.h"

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
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editable)
        return YES;
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editable) {
        if (editingStyle == UITableViewCellEditingStyleDelete) {
            deleteConfirmAlert = [[UIAlertView alloc] initWithTitle:@"Delete Recipe" message:@"Do you really want to delete recipe. Delete recipe could not be reversed." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Delete", nil];
            [deleteConfirmAlert show];
            indexToDelete = indexPath;
        }   
        else if (editingStyle == UITableViewCellEditingStyleInsert) {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
}

- (void)deleteRecipeAtIndexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Deleting Recipe..."];
    
    Recipe *currentRecipe = (Recipe*)[[self recipes] objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[GlobalStore deleteRecipeLink]];
    __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
    [request setPostValue:[currentRecipe recipeId]  forKey:@"rid"];
    
    [request setCompletionBlock:^{
        if (request.responseStatusCode == 200) {
            if ([request.responseString isEqualToString:@"1"]) {
                [self didDeleteRecipeAtIndex:indexPath];
            } else {
                [self didDeleteRecipeAtIndex:nil];
            }
        } else {
            [self didDeleteRecipeAtIndex:nil];
        }
    }];
    [request setFailedBlock:^{
        //            [self handleError:request.error];
    }];
    
    [request startAsynchronous];
}

- (void)didDeleteRecipeAtIndex:(NSIndexPath*)indexPath
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (indexPath != nil) {
        [[self recipes] removeObjectAtIndex:indexPath.row];
        [[self reusableCells] removeObjectAtIndex:indexPath.row];
        [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Could not delete recipe, please try again" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alertView show];
    }
}

#pragma mark - UI Alert View Deletgate Method
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleteRecipeAtIndexPath:indexToDelete];
    }
}

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
        RecipeViewController *viewControllerToPush;// = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
        if (editable || [[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[currentRecipe owner] userId]]) {
            viewControllerToPush = [[RecipeViewController alloc] initWithEditableRecipe];
        } else {
            viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
        }
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
