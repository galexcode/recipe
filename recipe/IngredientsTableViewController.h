//
//  IngredientsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface IngredientsTableViewController : UITableViewController<UITextFieldDelegate, UITextViewDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UIPickerViewDelegate, UIPickerViewDataSource, UIAlertViewDelegate, UIActionSheetDelegate>{
    Recipe* _recipe;
    NSArray* _ingredients;
    Boolean editable;
    UIBarButtonItem *barButton;
    __weak UITextField *activeTextField;
    __weak UITextView *activeTextView;
    UIImagePickerController *imagePicker;
    //UIPickerView *picker;
    NSMutableArray *unitArray;
    NSMutableArray *quantityArray;
    //UIImage *_image;
    NSData *imageData;
    NSMutableArray* _resuableCells;
    UIPickerView* quantityPicker;
    UIPickerView* unitPicker;
    NSIndexPath *indexToDelete;
}
@property (weak, nonatomic) IBOutlet UITextField *txtIngredientQuantity;
//@property (nonatomic, retain) UIPickerView *picker;
@property (weak, nonatomic) IBOutlet UITextField *txtIngredientUnit;
@property (nonatomic) NSMutableArray *reusableCells;
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
