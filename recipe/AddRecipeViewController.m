//
//  AddRecipeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "AddRecipeViewController.h"
#import "SelectCategoresViewController.h"
#import "IngredientsTableViewController.h"
#import "StepsTableViewController.h"
#import "ASIForm2DataRequest.h"
#import "RecipeXMLHandler.h"
#import "MBProgressHUD.h"
#import "GlobalStore.h"

@interface AddRecipeViewController ()

@end

@implementation AddRecipeViewController
@synthesize recipe = _recipe;
@synthesize imagePicker;
@synthesize btnImagePicker;
@synthesize recipeName;
@synthesize serving;
@synthesize btnSaveRecipe;
@synthesize btnAddIngredient;
@synthesize btnAddStep;
@synthesize inputCell;
@synthesize itemCell;
@synthesize actionCell;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        //_recipe = [[Recipe alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([self recipe] == nil) {
        _recipe = [[Recipe alloc] init];
    } else {
        [recipeName setText:[_recipe name]];
        [serving setText:[NSString stringWithFormat:@"%d", [_recipe serving]]];
        [self reloadPage];
    }
    
    [[[self btnImagePicker] layer] setCornerRadius:4];
    [[[self btnImagePicker] layer] setMasksToBounds:YES];
    
    _images = [NSMutableArray array];
    
    selectedCategories = [[NSMutableArray alloc] init];
    
    imagePicker = [[UIImagePickerController alloc] init];
    
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;

    [self reloadPage];
}

- (void)viewDidUnload
{
    [self setInputCell:nil];
    [self setItemCell:nil];
    [self setActionCell:nil];
    [self setRecipeName:nil];
    [self setServing:nil];
    [self setBtnImagePicker:nil];
    [self setImagePicker:nil];
    [self setBtnSaveRecipe:nil];
    [self setBtnAddIngredient:nil];
    [self setBtnAddStep:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Add Recipe Logic
- (IBAction)selectCategories:(id)sender
{
    [self dismissKeyboard];
    SelectCategoresViewController *viewControllerToPush = [[SelectCategoresViewController alloc] initWithNibName:@"SelectCategoresViewController" bundle:nil];
    [viewControllerToPush setRecipe:_recipe];
    [viewControllerToPush setTitle:@"Select Categories"];
    [[self navigationController] pushViewController:viewControllerToPush animated:YES];
}

- (IBAction)selectIngredient:(id)sender {
    if([_recipe recipeId] == @"-1"){
        isCallFromAddIngredient = YES;
        isCallFromAddStep = NO;
        [self insertNewRecipe];
    } else {
        IngredientsTableViewController *viewControllerToPush = [[IngredientsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Ingredients"];
        [viewControllerToPush setRecipe:_recipe];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

- (IBAction)selectSteps:(id)sender {
    if( [_recipe recipeId] == @"-1" ){
        isCallFromAddStep = YES;
        isCallFromAddIngredient = NO;
        [self insertNewRecipe];
    } else {
        StepsTableViewController *viewControllerToPush = [[StepsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Steps"];
        [viewControllerToPush setRecipe:_recipe];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

- (IBAction)cancelAction:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender
{
    if([_recipe recipeId] == @"-1"){
        [self insertNewRecipe];
    } else {
        [self updateRecipe];
    }
}

- (Boolean)validateInputInformation
{
    Boolean flag = YES;
    
    if ([trimSpaces([recipeName text]) length] == 0){
        [recipeName setText:@""];
        [recipeName setPlaceholder:@"Recipe name is blank"];
        flag = NO;
    }
    if ([[serving text] length] == 0){
        [serving setText:@""];
        [serving setPlaceholder:@"Serving is blank"];
        flag = NO;
    }
    if ([trimSpaces([recipeName text]) length] == 0 && [[serving text] length] == 0){
        [recipeName setText:@""];
        [recipeName setPlaceholder:@"Recipe name is blank"];
        [serving setText:@""];
        [serving setPlaceholder:@"Serving is blank"];
        flag = NO;
    }
    if ( flag == YES && [[_recipe categoryList] count] == 0 ){
        UIAlertView *errorAlertView = [[UIAlertView alloc] initWithTitle:@"Message"
                                                                 message:[NSString stringWithFormat:@"No category selected"]
                                                                delegate:self
                                                       cancelButtonTitle:@"Close"
                                                       otherButtonTitles:@"Categories", nil];
        [errorAlertView show];
        [self dismissKeyboard];
        flag = NO;
    }
    
    return flag;
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    activeTextField = textField;
    if ([textField tag] == 1) {
        [textField setKeyboardType:UIKeyboardTypeDefault];
    }
    if ([textField tag] == 2) {
        [textField setKeyboardType:UIKeyboardTypeNumberPad];
    }
    return YES;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}

- (void)dismissKeyboard{
    if (activeTextField != nil) {
        [activeTextField resignFirstResponder];
    }
}

- (IBAction)backgroundTap:(id)sender
{
    [recipeName resignFirstResponder];
    [serving resignFirstResponder];
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
        [self selectCategories:nil];
    }
}

#pragma mark UI Table Deletage Methods
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 4;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return 135;
    }
    if (indexPath.row == 2) {
        return 100;
    }
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *normalCell = @"Normal";
    static NSString *inputCellIndentifier = @"Input";
    static NSString *itemCellIndentifier = @"Item";
    static NSString *actionCellIndentifier = @"Action";
    
    if (indexPath.row == 1) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:inputCellIndentifier];
        if (cell == nil) {
            cell = inputCell;
        }
        return cell;
    } else if (indexPath.row == 2) {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:itemCellIndentifier];
        if (cell == nil) {
            cell = itemCell;
        }
        return cell;
    } else if (indexPath.row == 3){
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:actionCellIndentifier];
        if (cell == nil) {
            cell = actionCell;
        }
        return cell;
    }else {
        UITableViewCell *cell = (UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:normalCell];
        if (cell == nil) {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:normalCell];
        }
        
        cell.backgroundColor = [UIColor clearColor];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.text = @"Recipe Information";
        cell.textLabel.textColor = [UIColor colorWithRed:0.76f green:0.54f blue:0.29f alpha:1.00f];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        [self backgroundTap:nil];
    }
}

- (IBAction)btnSelectImage:(id)sender
{
    if(![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        [imagePicker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
        [self presentModalViewController:imagePicker animated:YES];
    }
    else
    {
        UIActionSheet *imagePickerActionSheet = [[UIActionSheet alloc] initWithTitle:@"Select Image Source" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Camera", @"Library", nil];
        [imagePickerActionSheet showInView:[self.view window]];
    }
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    [btnImagePicker setImage:image forState:UIControlStateNormal];

    NSData *imageData = UIImagePNGRepresentation(image);
    
    [_images addObject:imageData];
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)reloadPage
{
    if([_recipe recipeId] == @"-1"){
        [btnSaveRecipe setTitle:@"Save" forState:UIControlStateNormal];
    } else {
        [btnSaveRecipe setTitle:@"Update" forState:UIControlStateNormal];
    }
}

- (void)insertNewRecipe
{
    if ([self validateInputInformation]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Saving Recipe..."];
        NSURL *url = [NSURL URLWithString:[GlobalStore addRecipeLink]];
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[recipeName text] forKey:@"rn"];
        [request setPostValue:[serving text] forKey:@"rs"];
        for (NSInteger i = 0; i < [_images count]; i++) {
            [request addData:[_images objectAtIndex:i] forKey:@"ri[]"];
            
        }
        
        //multiple category
        for ( NSInteger i = 0; i < [[_recipe categoryList] count]; i++ ){
            [request addPostValue:[[_recipe categoryList] objectAtIndex:i]  forKey:@"cid[]"];
        }
        
        [request setCompletionBlock:^{
            if (request.responseStatusCode == 200) {
                
                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:_recipe];
                
                [handler setEndDocumentTarget:self andAction:@selector(didParsedInsertRecipe)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
                
                [self reloadPage];
                //}else if(request.responseStatusCode == 404){
            } else {
                //_user = nil;
                [self didParsedInsertRecipe];
            }
        }];
        [request setFailedBlock:^{
            //            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

- (void)updateRecipe
{
    if ([self validateInputInformation]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Saving Recipe..."];
        NSURL *url = [NSURL URLWithString:[GlobalStore updateRecipeLink]];
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[_recipe recipeId] forKey:@"rid"];
        [request setPostValue:[recipeName text] forKey:@"rn"];
        [request setPostValue:[serving text] forKey:@"rs"];
        
        //multiple category
        for ( NSInteger i = 0; i < [[_recipe categoryList] count]; i++ ){
            [request addPostValue:[[_recipe categoryList] objectAtIndex:i]  forKey:@"cid[]"];
        }
        
        [request setCompletionBlock:^{
            if (request.responseStatusCode == 200) {
                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:_recipe];
                
                [handler setEndDocumentTarget:self andAction:@selector(didParsedInsertRecipe)];
                NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                parser.delegate = handler;
                [parser parse];
                
                [self reloadPage];
            } else {
            }
        }];
        [request setFailedBlock:^{
            //[self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

- (void)didParsedInsertRecipe
{
    [[self navigationItem] setTitle:@"Edit Recipe"];
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isCallFromAddIngredient) {
        isCallFromAddIngredient = NO;
        IngredientsTableViewController *viewControllerToPush = [[IngredientsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Ingredients"];
        [viewControllerToPush setRecipe:_recipe];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    } else if (isCallFromAddStep){
        isCallFromAddStep = NO;
        StepsTableViewController *viewControllerToPush = [[StepsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Steps"];
        [viewControllerToPush setRecipe:_recipe];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

@end
