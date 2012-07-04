//
//  AddRecipeViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/16/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"
#import "RecipeTextField.h"

@interface AddRecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIAlertViewDelegate>{
    Recipe *recipe;
    NSMutableArray *selectedCategories;
    UIImagePickerController *imagePicker;
    NSMutableArray* _images;
    Boolean isCallFromAddIngredient;
    Boolean isCallFromAddStep;
}

@property (strong, nonatomic) IBOutlet UITableViewCell *inputCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *itemCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *actionCell;

- (IBAction)selectCategories:(id)sender;
- (IBAction)selectIngredient:(id)sender;
- (IBAction)selectSteps:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)backgroundTap:(id)sender;
- (IBAction)btnSelectImage:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnImagePicker;
@property (nonatomic) UIImagePickerController *imagePicker;
@property (weak, nonatomic) IBOutlet RecipeTextField *recipeName;
@property (weak, nonatomic) IBOutlet RecipeTextField *serving;
@property (weak, nonatomic) IBOutlet UIButton *btnSaveRecipe;
@property (weak, nonatomic) IBOutlet UIButton *btnAddIngredient;
@property (weak, nonatomic) IBOutlet UIButton *btnAddStep;

@end
