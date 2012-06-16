//
//  MyRecipeViewController.m
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import "MyRecipeViewController.h"
#import "RecipeViewController.h"
#import "RecipesXMLHandler.h"
#import "GlobalStore.h"
#import "RecipeLongCell.h"

@implementation MyRecipeViewController
@synthesize recipes = _recipes;
@synthesize tableView = _tableView;

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

- (void)awakeFromNib
{
}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    NSDictionary* temp = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Articles" ofType:@"plist"]];
//    self.recipes = [temp objectForKey:@"1Headlines"];
    [self.tableView setBackgroundColor:[UIColor clearColor]];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewWillAppear:(BOOL)animated
{
    NSLog(@"%@", [[[GlobalStore sharedStore] loggedUser] name]);
    if (![[[[GlobalStore sharedStore] loggedUser] name] isEqualToString:@"-1"]) {
        NSLog(@"load recipes");
        [self reload];
    }
}

- (void)reload
{
    _recipes = nil;
    _recipes = [[NSMutableArray alloc] init];
    //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/xml/categories.xml"];
    NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipes"];
    
    __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
    
    [request setCompletionBlock:^{
        NSLog(@"Recipes xml loaded.");
        NSLog(@"status code: %d",request.responseStatusCode);
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
        NSLog(@"Error downloading image: %@", error.localizedDescription);
    }];
    
    [request startAsynchronous];
}

-(void) didParsedRecipes
{
    if (_recipes != nil) {
        [self.tableView reloadData];
    }
}

- (void)viewDidUnload
{
    [self setTableView:nil];
    [super viewDidUnload];
    self.recipes = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
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

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    RecipeLongCell *cell = (RecipeLongCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        //NSArray* topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:nil options:nil];
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"RecipeLongCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[RecipeLongCell class]]) {
                cell = (RecipeLongCell*)currentObject;
                break;
            }
        }
    }
    
//    if (cell == nil) 
//    {
//        cell = [[RecipeLongCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
//    }
    
    //NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES selector:@selector(localizedCompare:)];
    //NSArray* sortedCategories = [self.articleDictionary.allKeys sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    //NSString *categoryName = [sortedCategories objectAtIndex:indexPath.section];
    
    //NSArray *currentCategory = [self.articleDictionary objectForKey:categoryName];
    
//    NSDictionary *currentArticle = [self.recipes objectAtIndex:indexPath.row];
//    
//    cell.textLabel.text = [currentArticle objectForKey:@"Title"];
//    cell.imageView.image = [UIImage imageNamed:[currentArticle objectForKey:@"ImageName"]];
//    cell.textLabel.textColor = [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f];
//    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Recipe *currentRecipe = [self.recipes objectAtIndex:indexPath.row];
    
//    cell.textLabel.text = [currentRecipe name];
//    cell.imageView.image = [UIImage imageNamed:@"OrangeJuice"];
    cell.recipeName.text = [currentRecipe name];
    
    //need to remove
    cell.thumb.image = [UIImage imageNamed:@"OrangeJuice"];
 
    if ([[currentRecipe imageList] count] > 0) {
        NSString *link = [NSString stringWithFormat:@"http://www.perselab.com/recipe/image/%@", [[currentRecipe imageList] objectAtIndex:0]];
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [viewControllerToPush setRecipe:[self.recipes objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
