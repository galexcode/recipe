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
    NSLog(@"%d", [[self recipes] count]);
    return [self.recipes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) 
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
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
    
    cell.textLabel.text = [currentRecipe name];
    cell.imageView.image = [UIImage imageNamed:@"OrangeJuice"];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RecipeViewController *viewControllerToPush = [[RecipeViewController alloc] initWithNibName:@"RecipeViewController" bundle:nil];
    [viewControllerToPush setRecipe:[self.recipes objectAtIndex:indexPath.row]];
    [self.navigationController pushViewController:viewControllerToPush animated:YES];
}

@end
