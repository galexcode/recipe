//
//  IngredientsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface IngredientsTableViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>{
    Recipe* _recipe;
    NSArray* _ingredients;
    Boolean editable;
    UIBarButtonItem *barButton;
    __weak UITextField *activeTextField;
    __weak UITextView *activeTextView;
    UIImagePickerController *imagePicker;
    UIImage *_image;
    //NSMutableArray* _images;
}

@property (weak, nonatomic) IBOutlet UITextField *txtIngredientName;
@property (weak, nonatomic) IBOutlet UITextView *txtIngredientDescription;
@property (nonatomic) Recipe *recipe;
@property (nonatomic) NSArray *ingredients;
@property (nonatomic, weak) UIViewController* navController;
@property (strong, nonatomic) IBOutlet UIView *ingredientForm;
@property (nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet UIButton *btnSelectImage;
- (IBAction)btnSelectImage:(id)sender;
- (id)initWithEditableTable;
- (IBAction)dismissKeyboard:(id)sender;
- (IBAction)insertIngredient:(id)sender;
@end
