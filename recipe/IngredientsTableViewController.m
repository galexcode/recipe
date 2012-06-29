//
//  IngredientsTableViewController.m
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "IngredientsTableViewController.h"
#import "Ingredient.h"
#import "GlobalStore.h"
#import "IngredientViewController.h"
#import "RecipeNavigationLabel.h"
#import "IngredientCell.h"
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController
@synthesize btnSelectImage;
@synthesize txtIngredientName;
@synthesize txtIngredientDescription;
@synthesize recipe = _recipe;
@synthesize ingredients = _ingredients;
@synthesize navController;
@synthesize ingredientForm;
@synthesize imagePicker;

- (IBAction)btnSelectImage:(id)sender {
    [self presentModalViewController:imagePicker animated:YES];
}

- (id)initWithEditableTable
{
    self = [super initWithNibName:@"IngredientsTableViewController" bundle:nil];
    if (self) {
        editable = YES;
    }
    return self;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
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
                     action:@selector(addIngredient:)];
        self.navigationItem.rightBarButtonItem = barButton;
        [self.view addSubview:ingredientForm];
        [ingredientForm setHidden:YES];
    }
    NSLog(@"new recipe Id: %@",[_recipe recipeId]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    imagePicker = [[UIImagePickerController alloc] init];
    
    //    [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    //[imagePicker setShowsCameraControls:YES];
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    
}

- (void)addIngredient:(id)sender
{
    [barButton setTitle:@"Cancel"];
    [barButton setAction:@selector(cancelAddIngredient:)];
    [ingredientForm setHidden:NO];
}

- (void)cancelAddIngredient:(id)sender
{
    [barButton setTitle:@"Add"];
    [barButton setAction:@selector(addIngredient:)];
    [ingredientForm setHidden:YES];
    [self dismissKeyboard:self];
}

- (IBAction)dismissKeyboard:(id)sender{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
    if (activeTextView != nil) {
        [activeTextView resignFirstResponder];
    }
}

- (IBAction)insertIngredient:(id)sender {
    NSLog(@"Insert Ingredient");
//    if ([self validateInputInformation]) {
//        
//        //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipe/add"];
//        NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/recipe_php/recipe/add"];
//        
//        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
//        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
//        [request setPostValue:[recipeName text] forKey:@"rn"];
//        [request setPostValue:[serving text] forKey:@"rs"];
//        for (NSInteger i = 0; i < [_images count]; i++) {
//            NSLog(@"post image: %d",i);
//            [request addData:[_images objectAtIndex:i] forKey:@"ri[]"];
//            
//        }
//        //multiple category
//        //[request setPostValue:@"2" forKey:@"cid[]"];
//        //[request setPostValue:@"1" forKey:@"cid[]"];
//        [request addPostValue:@"1" forKey:@"cid[]"];
//        [request addPostValue:@"2" forKey:@"cid[]"];
//        
//        //[request setPostValue:[password text] forKey:@"pw"];
//        
//        [request setCompletionBlock:^{
//            NSLog(@"Complete Post Recipe.");
//            if (request.responseStatusCode == 200) {
//                NSLog(@"%d", request.responseStatusCode);
//                [recipe setRecipeId:request.responseString];
//                //NSLog(@"recipe id: %s", [request.responseData bytes]);
//                NSLog(@"recipe id: %@", request.responseString);
//                NSLog(@"set recipe id : %@",[recipe recipeId]);
//                
//                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:recipe];
//                
//                [handler setEndDocumentTarget:self andAction:@selector(didParsedInsertRecipe)];
//                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
//                parser.delegate = handler;
//                [parser parse];
//                
//                [self reloadPage];
//                //}else if(request.responseStatusCode == 404){
//            } else {
//                //_user = nil;
//                [self didParsedInsertRecipe];
//            }
//        }];
//        [request setFailedBlock:^{
//            //            [self handleError:request.error];
//        }];
//        
//        [request startAsynchronous];
//    }
}

- (Boolean)validateInputInformation
{
    Boolean flag = YES;
    
    if ([trimSpaces([txtIngredientName text]) length] == 0){
        [txtIngredientName setText:@""];
        [txtIngredientName setPlaceholder:@"Recipe name is blank"];
        flag = NO;
    }
    if ([trimSpaces([txtIngredientDescription text]) length] == 0){
        flag = NO;
    }
    return flag;
}

- (void)viewDidUnload
{
    [self setIngredientForm:nil];
    [self setBtnSelectImage:nil];
    [self setTxtIngredientName:nil];
    [self setTxtIngredientDescription:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [btnSelectImage setImage:image forState:UIControlStateNormal];
    
    //NSData *imageData = UIImagePNGRepresentation(image);
    _image = image;
    //[_images addObject:imageData];
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    activeTextView = textView;
    return YES;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[self ingredients] count] > 0)
        return [self.ingredients count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[self ingredients] count] > 0) {
        static NSString *CellIdentifier = @"IngredientCell";
        
        IngredientCell *cell = (IngredientCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        
        Ingredient *currentIngredient = (Ingredient*)[[self ingredients] objectAtIndex:indexPath.row];
        
        
        if (cell == nil) 
        {
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:self options:nil];
            
            for (id currentObject in topLevelObjects) {
                if ([currentObject isKindOfClass:[IngredientCell class]]) {
                    cell = (IngredientCell*)currentObject;
                    break;
                }
            }
        }
        
        cell.unit.text = [currentIngredient unit];
        cell.quantity.text = [currentIngredient quantity];
        cell.name.text = [currentIngredient name];
        
        if (![[currentIngredient imagePath] isEqualToString:@"-1"]) {
            NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[currentIngredient imagePath] forWidth:60 andHeight:0]];
            
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
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [[cell textLabel] setText:@"No ingredients. Tap \"Add\" to add ingredient"];
        [[cell textLabel] setTextColor:[UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f]];
        [[cell textLabel] setFont:[UIFont systemFontOfSize:15.00f]];
        [[cell textLabel] setLineBreakMode:UILineBreakModeWordWrap];
        [[cell textLabel] setNumberOfLines:2];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        return cell;
    }
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
    if ([[self ingredients] count] > 0) {
        IngredientViewController *viewControllerToPush = [[IngredientViewController alloc] initWithNibName:@"IngredientViewController" bundle:nil];
        Ingredient *currentIngredient = (Ingredient*)[[self ingredients] objectAtIndex:indexPath.row];
        [[viewControllerToPush navigationItem] setTitle:[currentIngredient name]];
        [viewControllerToPush setIngredient:currentIngredient];
        if ([self navController] != nil) {
            UINavigationController *parentNav = (UINavigationController *)[self navController];
            [parentNav pushViewController:viewControllerToPush animated:YES];
        } else {
            [[self navigationController] pushViewController:viewControllerToPush animated:YES];
        }
    }
}

@end
