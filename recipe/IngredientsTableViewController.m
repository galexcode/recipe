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
#import "RecipeXMLHandler.h"

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController
@synthesize btnSelectImage;
@synthesize txtIngredientUnit;
@synthesize txtIngredientName;
@synthesize txtIngredientDescription;
@synthesize recipe = _recipe;
@synthesize ingredients = _ingredients;
@synthesize navController;
@synthesize ingredientForm;
@synthesize imagePicker;
@synthesize reusableCells = _resuableCells;

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
    
    [self initResuableCells];
    
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
    
    unitArray = [[NSMutableArray alloc] initWithObjects:@"cup",@"tablespoon",@"ounce",nil];
    UIPickerView *picker = [[UIPickerView alloc] init];
    [picker setDelegate:self];
    [picker setDataSource:self];
    txtIngredientUnit.inputView = picker;
    
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
    [self formReset];
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
    if ([self validateInputInformation]) {
        
        //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipe/add"];
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/recipe_php/ingredient/add"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[[self recipe] recipeId] forKey:@"rid"];
        [request setPostValue:[txtIngredientName text] forKey:@"in"];
        [request setPostValue:[txtIngredientDescription text] forKey:@"idesc"];
        
        if( imageData != nil ){
            [request addData:imageData forKey:@"ii"];
        }
        
        [request setPostValue:@"1/2" forKey:@"iqty"];
        [request setPostValue:[txtIngredientUnit text] forKey:@"iunit"];
        
        [request setCompletionBlock:^{
            NSLog(@"Complete Post Ingredient.");
            if (request.responseStatusCode == 200) {
                NSLog(@"%@", request.responseString);
                [[self recipe] setIngredientList:nil];
                [[self recipe] setIngredientList:[NSMutableArray array]];
                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:_recipe];
                
                [handler setEndDocumentTarget:self andAction:@selector(didParsedInsertIngredient)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
                
                [self cancelAddIngredient:self];
                //[self reloadPage];
                //}else if(request.responseStatusCode == 404){
            } else {
                //_user = nil;
                [self didParsedInsertIngredient];
            }
        }];
        [request setFailedBlock:^{
            //            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

- (void)didParsedInsertIngredient
{
    [self initResuableCells];
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
    if( [trimSpaces([txtIngredientUnit text]) length] == 0 ){
        [txtIngredientUnit setText:@""];
        [txtIngredientUnit setPlaceholder:@"Recipe unit is blank"];
        flag = NO;
    }
    return flag;
}

- (void)formReset
{
    txtIngredientName.text = @"";
    txtIngredientDescription.text = @"";
    txtIngredientUnit.text = @"";
    imageData = nil;
    [btnSelectImage setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
}
- (void)viewDidUnload
{
    [self setIngredientForm:nil];
    [self setBtnSelectImage:nil];
    [self setTxtIngredientName:nil];
    [self setTxtIngredientDescription:nil];
    [self setTxtIngredientUnit:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [btnSelectImage setImage:image forState:UIControlStateNormal];
    
    imageData = UIImagePNGRepresentation(image);
    
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

- (void)initResuableCells{
    [self setReusableCells:nil];
    self.reusableCells = [NSMutableArray array];
    
    for (int i = 0; i < [[[self recipe] ingredientList] count]; i++) {
        IngredientCell *cell = [[IngredientCell alloc] init];
        
        Ingredient *currentIngredient = (Ingredient*)[[[self recipe] ingredientList] objectAtIndex:i];
        
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects) {
            if ([currentObject isKindOfClass:[IngredientCell class]]) {
                cell = (IngredientCell*)currentObject;
                break;
            }
        }
        //}
        
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
        
        [[self reusableCells] addObject:cell];;
    }
    
    [[self tableView] reloadData];
}

   - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([[[self recipe] ingredientList] count] > 0)
        return [[[self recipe] ingredientList] count];
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([[[self recipe] ingredientList] count] > 0) {
        IngredientCell *cell = [[self reusableCells] objectAtIndex:indexPath.row];
        
//        Ingredient *currentIngredient = (Ingredient*)[[[self recipe] ingredientList] objectAtIndex:indexPath.row];
//        
//        if (cell == nil) 
//        {
//            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"IngredientCell" owner:self options:nil];
//            
//            for (id currentObject in topLevelObjects) {
//                if ([currentObject isKindOfClass:[IngredientCell class]]) {
//                    cell = (IngredientCell*)currentObject;
//                    break;
//                }
//            }
//        //}
//        
//            cell.unit.text = [currentIngredient unit];
//            cell.quantity.text = [currentIngredient quantity];
//            cell.name.text = [currentIngredient name];
//            
//            if (![[currentIngredient imagePath] isEqualToString:@"-1"]) {
//                NSURL *url = [[NSURL alloc] initWithString:[GlobalStore imageLinkWithImageId:[currentIngredient imagePath] forWidth:60 andHeight:0]];
//                
//                __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
//                [request setCompletionBlock:^{
//                    NSData *data = request.responseData;
//                    [cell.thumb setImage:[[UIImage alloc] initWithData:data]];
//                }];
//                [request setFailedBlock:^{
//                    NSError *error = request.error;
//                    NSLog(@"Error downloading image: %@", error.localizedDescription);
//                }];
//                [request startAsynchronous];
//            }
//        }
        
        return cell;
    } else {
        UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [[cell textLabel] setText:@"No ingredients. Tap here or \"Add\" to add ingredient"];
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
    if ([[[self recipe] ingredientList] count] > 0) {
        IngredientViewController *viewControllerToPush = [[IngredientViewController alloc] initWithNibName:@"IngredientViewController" bundle:nil];
        Ingredient *currentIngredient = (Ingredient*)[[[self recipe] ingredientList] objectAtIndex:indexPath.row];
        [[viewControllerToPush navigationItem] setTitle:[currentIngredient name]];
        [viewControllerToPush setIngredient:currentIngredient];
        if ([self navController] != nil) {
            UINavigationController *parentNav = (UINavigationController *)[self navController];
            [parentNav pushViewController:viewControllerToPush animated:YES];
        } else {
            [[self navigationController] pushViewController:viewControllerToPush animated:YES];
        }
    } else {
        [self addIngredient:nil];
    }
}

#pragma mark - UIpicker view delegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView;
{
    return 1;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    [txtIngredientUnit setText:[unitArray objectAtIndex:row]];
    [txtIngredientUnit resignFirstResponder];
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    return [unitArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    return [unitArray objectAtIndex:row];
}

@end
