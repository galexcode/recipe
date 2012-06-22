//
//  IngredientListViewController.m
//  recipe
//
//  Created by SaRy on 4/5/12.
//  Copyright (c) 2012 Perselab. All rights reserved.
//

#import "IngredientListViewController.h"
#import "IngredientViewController.h"
#import "RecipeNavigationLabel.h"
#import "IngredientCell.h"
#import "Ingredient.h"
#import "ASI2HTTPRequest.h"

@interface IngredientListViewController ()

@end

@implementation IngredientListViewController
@synthesize pageTitle;
@synthesize pageTitleText = _pageTitleText;
@synthesize ingredientListTable;
@synthesize ingredients = _ingredients;

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
//    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
//    [[self navigationItem] setTitleView:label];
    
    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
    
    [[self pageTitle] setText:[self pageTitleText]];
    
    [[self navigationItem] setTitleView:headerView];
    
    [[self ingredientListTable] setBackgroundColor:[UIColor clearColor]];
    //[self.view addSubview:ingredientListTable];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [self setIngredientListTable:nil];
    [self setPageTitle:nil];
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.ingredients count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"IngredientCell";
    
    IngredientCell *cell = (IngredientCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Ingredient *currentIngredient = (Ingredient*)[[self ingredients] objectAtIndex:indexPath.row];
    
    
    if (cell == nil) 
    {
        //NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:nil options:nil];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[IngredientCell class]]) {
                cell = (IngredientCell*)currentObject;
                break;
            }
        }
    }
    
//    cell.textLabel.text = @"ingredient";
//    cell.imageView.image = [UIImage imageNamed:@"Aviation"];
    cell.unit.text = @"cup";
    cell.quantity.text = @"1/2";
    cell.name.text = [currentIngredient name];
    
    //need to remove
    cell.thumb.image = [UIImage imageNamed:@"Aviation"];
    
    
    if (![[currentIngredient imagePath] isEqualToString:@"-1"]) {
        NSString *link = [NSString stringWithFormat:@"http://www.perselab.com/recipe/image/%@", [currentIngredient imagePath]];
        NSURL *url = [[NSURL alloc] initWithString:link];
        
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    IngredientViewController *viewControllerToPush = [[IngredientViewController alloc] initWithNibName:@"IngredientViewController" bundle:nil];
    Ingredient *currentIngredient = (Ingredient*)[[self ingredients] objectAtIndex:indexPath.row];
    [viewControllerToPush setIngredient:currentIngredient];
    [viewControllerToPush setPageTitleText:[currentIngredient name]];
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
