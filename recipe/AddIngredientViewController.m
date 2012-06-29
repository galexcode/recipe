//
//  AddIngredientViewController.m
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddIngredientViewController.h"
#import "RecipeNavigationLabel.h"
#import "IngredientsTableViewController.h"

@interface AddIngredientViewController ()

@end

@implementation AddIngredientViewController
@synthesize imagePicker;
@synthesize ingredientForm;
@synthesize recipe=_recipe;
@synthesize inputCell;
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
    RecipeNavigationLabel *label = [[RecipeNavigationLabel alloc] initWithTitle:[[self navigationItem] title]];
    [[self navigationItem] setTitleView:label];
    barButton = [[UIBarButtonItem alloc] 
                                  initWithTitle:@"Add"                                            
                                  style:UIBarButtonItemStyleBordered 
                                  target:self 
                                  action:@selector(addIngredient:)];
    self.navigationItem.rightBarButtonItem = barButton;
    
    ingredientTable = [[IngredientsTableViewController alloc] initWithNibName:@"IngredientsTableViewController" bundle:nil];
    [ingredientTable setIngredients:[_recipe ingredientList]];
    [ingredientTable setNavController:[self navigationController]];
    //[[ingredientTable navigationItem] setTitle:@"Ingredients"];
    
    [self.view addSubview:ingredientTable.view];
    [self.view addSubview:ingredientForm];
    [ingredientForm setHidden:YES];
    
    NSLog(@"recipe id: %@", [[self recipe] recipeId]);
    
    imagePicker = [[UIImagePickerController alloc] init];
    
    //[imagePicker setSourceType:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
    //[imagePicker setShowsCameraControls:YES];
    imagePicker.allowsEditing = NO;
    imagePicker.delegate = self;
}

- (void)viewDidUnload
{
    [self setInputCell:nil];
    [self setIngredientForm:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
}

- (IBAction)btnSelectImage:(id)sender
{
    [self presentModalViewController:imagePicker animated:YES];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    NSLog(@"Nhay vao delegate set Image");
    //[btnAddImage setBackgroundImage:image forState:UIControlStateNormal];
    //[btnImagePicker setImage:image forState:UIControlStateNormal];
    
    NSData *imageData = UIImagePNGRepresentation(image);
    
    [_images addObject:imageData];
    
    [picker dismissModalViewControllerAnimated:YES];
}

@end
