//
//  IngredientsTableViewController.m
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import "IngredientsTableViewController.h"
#import "Ingredient.h"
#import "GlobalStore.h"
#import "IngredientViewController.h"
#import "IngredientCell.h"
#import "ASI2HTTPRequest.h"
#import "ASIForm2DataRequest.h"
#import "RecipeXMLHandler.h"
#import "MBProgressHUD.h"

@interface IngredientsTableViewController ()

@end

@implementation IngredientsTableViewController
@synthesize txtIngredientQuantity;
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
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:imagePicker animated:YES];
    }
    else
    {
        UIActionSheet *imagePickerActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Library", nil];
        [imagePickerActionSheet showInView:ingredientForm];
    }
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
    
    [self initResuableCells];
    
    if (editable || [[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[[self recipe] owner] userId]]) {
        barButton = [[UIBarButtonItem alloc] 
                     initWithTitle:@"Add"                                            
                     style:UIBarButtonItemStyleBordered 
                     target:self 
                     action:@selector(addIngredient:)];
        self.navigationItem.rightBarButtonItem = barButton;
        [self.view addSubview:ingredientForm];
        [ingredientForm setHidden:YES];
    }
    
    [[[self btnSelectImage] layer] setCornerRadius:4];
    [[[self btnSelectImage] layer] setMasksToBounds:YES];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
    
    unitArray = [[NSMutableArray alloc] initWithObjects:@"cup",@"tbls",@"tsp",@"ounce",nil];
    unitPicker = [[UIPickerView alloc] init];
    [unitPicker setDelegate:self];
    [unitPicker setDataSource:self];
    [unitPicker setShowsSelectionIndicator:YES];
    txtIngredientUnit.inputView = unitPicker;
    
    quantityArray = [[NSMutableArray alloc] initWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10",nil];
    quantityPicker = [[UIPickerView alloc] init];
    [quantityPicker setDelegate:self];
    [quantityPicker setDataSource:self];
    [quantityPicker setShowsSelectionIndicator:YES];
    txtIngredientQuantity.inputView = quantityPicker;
}

- (void)addIngredient:(id)sender
{
    [barButton setTitle:@"Cancel"];
    [barButton setAction:@selector(cancelAddIngredient:)];
    [ingredientForm setHidden:NO];
    [[self tableView] setScrollEnabled:NO];
}

- (void)cancelAddIngredient:(id)sender
{
    [barButton setTitle:@"Add"];
    [barButton setAction:@selector(addIngredient:)];
    [ingredientForm setHidden:YES];
    [self dismissKeyboard:self];
    [self formReset];
    [[self tableView] setScrollEnabled:YES];
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
    if ([self validateInputInformation]) {
        NSURL *url = [NSURL URLWithString:[GlobalStore addIngredientLink]];
        __weak __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[[self recipe] recipeId] forKey:@"rid"];
        [request setPostValue:[txtIngredientName text] forKey:@"in"];
        [request setPostValue:[txtIngredientDescription text] forKey:@"idesc"];
        
        if( imageData != nil ){
            [request addData:imageData forKey:@"ii"];
        }
        
        [request setPostValue:[txtIngredientQuantity text] forKey:@"iqty"];
        [request setPostValue:[txtIngredientUnit text] forKey:@"iunit"];
        
        [request setCompletionBlock:^{
            if (request.responseStatusCode == 200) {
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
    if ([[[self recipe] ingredientList] count] == 1 || [[[self recipe] ingredientList] count] == 0)
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Ingredient", [[[self recipe] ingredientList] count]]];
    else
        [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Ingredients", [[[self recipe] ingredientList] count]]];
    [self initResuableCells];
}

- (Boolean)validateInputInformation
{
    Boolean flag = YES;
    
    if ([trimSpaces([txtIngredientName text]) length] == 0){
        [txtIngredientName setText:@""];
        [txtIngredientName setPlaceholder:@"Name is blank"];
        flag = NO;
    }
    if( [trimSpaces([txtIngredientUnit text]) length] == 0 ){
        [txtIngredientUnit setText:@""];
        [txtIngredientUnit setPlaceholder:@"Unit is blank"];
        flag = NO;
    }
    if( [trimSpaces([txtIngredientQuantity text]) length] == 0 ){
        [txtIngredientQuantity setText:@""];
        [txtIngredientQuantity setPlaceholder:@"Quantity is blank"];
        flag = NO;
    }
    return flag;
}

- (void)formReset
{
    txtIngredientName.text = @"";
    txtIngredientDescription.text = @"Simple description";
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
    [self setTxtIngredientQuantity:nil];
    [super viewDidUnload];
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

#pragma mark UI Action Sheet Delegate Methods
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    if (buttonIndex == 1) {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    if (buttonIndex != 2) {
        [self presentModalViewController:imagePicker animated:YES];
    }
}

#pragma mark UI Alert View Delegate Methods
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        [self deleteIngredientAtIndexPath:indexToDelete];
    }
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
            
            __weak __block ASI2HTTPRequest *request = [ASI2HTTPRequest requestWithURL:url];
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

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editable || [[[[GlobalStore sharedStore] loggedUser] userId] isEqualToString:[[[self recipe] owner] userId]])
        return YES;
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        UIAlertView *deleteConfirmAlert = [[UIAlertView alloc] initWithTitle:@"Delete Ingredient" message:@"Do you really want to delete ingredient. Delete ingredient could not be reversed." delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Delete", nil];
        [deleteConfirmAlert show];
        indexToDelete = indexPath;
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}

- (void)deleteIngredientAtIndexPath:(NSIndexPath*)indexPath
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setLabelText:@"Deleting Ingredient..."];
    
    Ingredient *currentIngredient = (Ingredient*)[[[self recipe] ingredientList] objectAtIndex:indexPath.row];
    
    NSURL *url = [NSURL URLWithString:[GlobalStore deleteIngredientLink]];
    __weak __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
    [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
    [request setPostValue:[[self recipe] recipeId] forKey:@"rid"];
    [request setPostValue:[currentIngredient ingredientId] forKey:@"iid"];
    
    [request setCompletionBlock:^{
        if (request.responseStatusCode == 200) {
            if ([request.responseString isEqualToString:@"1"]) {
                [self didDeleteIngredientAtIndex:indexPath];
            } else {
                [self didDeleteIngredientAtIndex:nil];
            }
        } else {
            [self didDeleteIngredientAtIndex:nil];
        }
    }];
    [request setFailedBlock:^{
        //            [self handleError:request.error];
    }];
    
    [request startAsynchronous];
}

- (void)didDeleteIngredientAtIndex:(NSIndexPath*)indexPath
{
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    if (indexPath != nil) {
        if ([[[self recipe] ingredientList] count] == 1) {
            [[[self recipe] ingredientList] removeObjectAtIndex:indexPath.row];
            [[self navigationItem] setTitle:@"0 Ingredient"];
            [[self tableView] reloadData];
        } else {
            [[[self recipe] ingredientList] removeObjectAtIndex:indexPath.row];
            [[self reusableCells] removeObjectAtIndex:indexPath.row];
            [[self tableView] deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            if ([[[self recipe] ingredientList] count] > 1)
                [[self navigationItem] setTitle:[NSString stringWithFormat:@"%d Ingredients", [[[self recipe] ingredientList] count]]];
            else
                [[self navigationItem] setTitle:@"1 Ingredient"];
        }
    } else {
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Could not delete ingredient, please try again" delegate:nil cancelButtonTitle:@"Close" otherButtonTitles:nil];
        [alertView show];
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
    if(pickerView == unitPicker){
        [txtIngredientUnit setText:[unitArray objectAtIndex:row]];
    }
    if(pickerView == quantityPicker){
        [txtIngredientQuantity setText:[quantityArray objectAtIndex:row]];
    }
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component;
{
    if (pickerView == unitPicker){
        return [unitArray count];
    }
    if(pickerView == quantityPicker){
        return [quantityArray count];
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component;
{
    if (pickerView == unitPicker) {
        return [unitArray objectAtIndex:row];
    }
    if (pickerView == quantityPicker) {
        return [quantityArray objectAtIndex:row];
    }
    return @"";
}

@end
