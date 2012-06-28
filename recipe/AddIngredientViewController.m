//
//  AddIngredientViewController.m
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import "AddIngredientViewController.h"

@interface AddIngredientViewController ()

@end

@implementation AddIngredientViewController
@synthesize imagePicker;
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
    // Do any additional setup after loading the view from its nib.
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
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
