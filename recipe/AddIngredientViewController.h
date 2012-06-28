//
//  AddIngredientViewController.h
//  recipe
//
//  Created by Trung on 28/06/2012.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface AddIngredientViewController : UIViewController <UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource, UIImagePickerControllerDelegate, UINavigationControllerDelegate>
{
    Recipe *_recipe;
    UIImagePickerController *imagePicker;
    NSMutableArray* _images;
}
@property (nonatomic) Recipe *recipe;
@property (strong, nonatomic) IBOutlet UITableViewCell *inputCell;

@property (nonatomic) UIImagePickerController *imagePicker;
- (IBAction)btnSelectImage:(id)sender;
@end
