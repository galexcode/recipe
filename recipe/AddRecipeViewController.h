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

@interface AddRecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate>{
    Recipe *recipe;
    NSMutableArray *selectedCategories;
}

@property (strong, nonatomic) IBOutlet UITableViewCell *inputCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *itemCell;
@property (strong, nonatomic) IBOutlet UITableViewCell *actionCell;

- (IBAction)selectCategories:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
- (IBAction)backgroundTap:(id)sender;

@property (weak, nonatomic) IBOutlet RecipeTextField *recipeName;
@property (weak, nonatomic) IBOutlet RecipeTextField *serving;

@end
