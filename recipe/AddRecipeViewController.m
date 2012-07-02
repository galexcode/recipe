//
//  AddRecipeViewController.m
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddRecipeViewController.h"
#import "SelectCategoresViewController.h"
#import "IngredientsTableViewController.h"
#import "StepsTableViewController.h"
//#import "AddIngredientViewController.h"
//#import "AddStepViewController.h"
#import "ASIForm2DataRequest.h"
#import "RecipeXMLHandler.h"
#import "MBProgressHUD.h"
#import "GlobalStore.h"

@interface AddRecipeViewController ()

@end

@implementation AddRecipeViewController
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
        recipe = [[Recipe alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    
    _images = [NSMutableArray array];
    
//    UIImageView *headerView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logo_header"]];
//    [[self navigationItem] setTitleView:headerView];
    
    selectedCategories = [[NSMutableArray alloc] init];
    
    imagePicker = [[UIImagePickerController alloc] init];
    
//    [imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    //[imagePicker setShowsCameraControls:YES];
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;

    [self reloadPage];
    //[self presentModalViewController:self.imagePicker animated:NO];
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
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark Add Recipe Logic
- (IBAction)selectCategories:(id)sender
{
    SelectCategoresViewController *viewControllerToPush = [[SelectCategoresViewController alloc] initWithNibName:@"SelectCategoresViewController" bundle:nil];
    NSLog(@"current recipe id: %@", [recipe recipeId]);
    [viewControllerToPush setRecipe:recipe];
    [[self navigationController] pushViewController:viewControllerToPush animated:YES];
}

- (IBAction)selectIngredient:(id)sender {
//    AddIngredientViewController *addIngredientViewController = [[AddIngredientViewController alloc] initWithNibName:@"AddIngredientViewController" bundle:nil];
//    [addIngredientViewController setTitle:@"Ingredients"];
//    [addIngredientViewController setRecipe:recipe];
//    [[self navigationController] pushViewController:addIngredientViewController animated:YES];

    if([recipe recipeId] == @"-1"){
        isCallFromAddIngredient = YES;
        [self insertNewRecipe];
    } else {
        IngredientsTableViewController *viewControllerToPush = [[IngredientsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Ingredients"];
        [viewControllerToPush setRecipe:recipe];
        //[viewControllerToPush setIngredients:[recipe ingredientList]];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

- (IBAction)selectSteps:(id)sender {
//    AddStepViewController *addStepViewController = [[AddStepViewController alloc] initWithNibName:@"AddStepViewController" bundle:nil];
//    [addStepViewController setTitle:@"Steps"];
//    [addStepViewController setRecipe:recipe];
//    [[self navigationController] pushViewController:addStepViewController animated:YES];
    if( [recipe recipeId] == @"-1" ){
        isCallFromAddStep = YES;
        [self insertNewRecipe];
    } else {
        StepsTableViewController *viewControllerToPush = [[StepsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Steps"];
        [viewControllerToPush setRecipe:recipe];
        //[viewControllerToPush setSteps:[recipe stepList]];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

- (IBAction)cancelAction:(id)sender
{
    [[self navigationController] popViewControllerAnimated:YES];
}

- (IBAction)saveAction:(id)sender
{
    if([recipe recipeId] == @"-1"){
        [self insertNewRecipe];
    } else {
        NSLog(@"Update Recipe");
        //[self updateRecipe];
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
    
    return flag;
}

#pragma mark - Text Fields Delegate Methods
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    //activeTextField = textField;
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

- (IBAction)backgroundTap:(id)sender
{
    [recipeName resignFirstResponder];
    [serving resignFirstResponder];
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
        cell.textLabel.text = [NSString stringWithString:@"Recipe Information"];
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
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"Nhay vao delegate set Image");
    //[btnAddImage setBackgroundImage:image forState:UIControlStateNormal];
    [btnImagePicker setImage:image forState:UIControlStateNormal];

    NSData *imageData = UIImagePNGRepresentation(image);
    
    [_images addObject:imageData];
    
    [picker dismissModalViewControllerAnimated:YES];
}

- (void)reloadPage
{
    NSLog(@"nhay vao ham reloadpage");
    if([recipe recipeId] == @"-1"){
        [btnSaveRecipe setTitle:@"Save" forState:UIControlStateNormal];
        //[btnAddIngredient setEnabled:NO];
        //[btnAddStep setEnabled:NO];
    } else {
        [btnSaveRecipe setTitle:@"Update" forState:UIControlStateNormal];
        //[btnSaveRecipe setEnabled:NO];
        //[btnAddIngredient setEnabled:YES];
        //[btnAddStep setEnabled:YES];
    }
}

- (void)insertNewRecipe
{
    if ([self validateInputInformation]) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [hud setLabelText:@"Saving Recipe..."];
        //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipe/add"];
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.100/recipe_php/recipe/add"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        [request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[recipeName text] forKey:@"rn"];
        [request setPostValue:[serving text] forKey:@"rs"];
        for (NSInteger i = 0; i < [_images count]; i++) {
            [request addData:[_images objectAtIndex:i] forKey:@"ri[]"];
            
        }
        //multiple category
        //[request setPostValue:@"2" forKey:@"cid[]"];
        //[request setPostValue:@"1" forKey:@"cid[]"];
        [request addPostValue:@"1" forKey:@"cid[]"];
        [request addPostValue:@"2" forKey:@"cid[]"];
        
        //[request setPostValue:[password text] forKey:@"pw"];
        
        [request setCompletionBlock:^{
            NSLog(@"Complete Post Recipe.");
            if (request.responseStatusCode == 200) {
                NSLog(@"%d", request.responseStatusCode);
                //[recipe setRecipeId:request.responseString];
                //NSLog(@"recipe id: %s", [request.responseData bytes]);
                NSLog(@"recipe id: %@", request.responseString);
                
                RecipeXMLHandler* handler = [[RecipeXMLHandler alloc] initWithRecipe:recipe];
                
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

- (void)didParsedInsertRecipe
{
    NSLog(@"after insert number of category is: %d", [[recipe categoryList] count]);
    [MBProgressHUD hideHUDForView:self.view animated:YES];
    
    if (isCallFromAddIngredient) {
        isCallFromAddIngredient = NO;
        IngredientsTableViewController *viewControllerToPush = [[IngredientsTableViewController alloc] initWithEditableTable];
        [viewControllerToPush setTitle:@"Ingredients"];
        [viewControllerToPush setRecipe:recipe];
        //[viewControllerToPush setIngredients:[recipe ingredientList]];
        [[self navigationController] pushViewController:viewControllerToPush animated:YES];
    }
}

- (void)updateRecipe
{
    if ([self validateInputInformation]) {
        
        //NSURL *url = [NSURL URLWithString:@"http://www.perselab.com/recipe/recipe/update"];
        NSURL *url = [NSURL URLWithString:@"http://192.168.0.102/recipe_php/recipe/update"];
        
        __block ASIForm2DataRequest *request = [ASIForm2DataRequest requestWithURL:url];
        //[request setPostValue:[[[GlobalStore sharedStore] loggedUser] userId] forKey:@"uid"];
        [request setPostValue:[recipeName text] forKey:@"rn"];
        [request setPostValue:[serving text] forKey:@"rs"];
        
        if([_images count] > 0){
            for (NSInteger i = 0; i < [_images count]; i++) {
                NSLog(@"post image: %d",i);
                [request addData:[_images objectAtIndex:i] forKey:@"ri[]"];
                
            }
        }
        
        //multiple category
        //[request setPostValue:@"2" forKey:@"cid[]"];
        //[request setPostValue:@"1" forKey:@"cid[]"];
        [request addPostValue:@"1" forKey:@"cid[]"];
        [request addPostValue:@"2" forKey:@"cid[]"];
        
        //[request setPostValue:[password text] forKey:@"pw"];
        
        [request setCompletionBlock:^{
            NSLog(@"Complete Post Recipe.");
            if (request.responseStatusCode == 200) {
                NSLog(@"%d", request.responseStatusCode);
                [recipe setRecipeId:request.responseString];
                //NSLog(@"recipe id: %s", [request.responseData bytes]);
                NSLog(@"recipe id: %@", request.responseString);
                NSLog(@"set recipe id : %@",[recipe recipeId]);
                //UserXMLHandler* handler = [[UserXMLHandler alloc] initWithUser:_user];
                //[handler setEndDocumentTarget:self andAction:@selector(didParsedLoggingUser)];
                //NSXMLParser* parser = [[NSXMLParser alloc] initWithData:request.responseData];
                //parser.delegate = handler;
                //[parser parse];
                //            }else if(request.responseStatusCode == 404){
                [self reloadPage];
            } else {
                //_user = nil;
                //[self didParsedLoggingUser];
            }
        }];
        [request setFailedBlock:^{
            //            [self handleError:request.error];
        }];
        
        [request startAsynchronous];
    }
}

@end
