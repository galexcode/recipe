//
//  IngredientsTableViewController.h
//  recipe
//
//  Created by Vu Tran on 6/29/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface IngredientsTableViewController : UITableViewController{
    Recipe* _recipe;
    NSArray* _ingredients;
    Boolean editable;
    UIBarButtonItem *barButton;
}

@property (nonatomic) Recipe *recipe;
@property (nonatomic) NSArray *ingredients;
@property (nonatomic, weak) UIViewController* navController;
@property (strong, nonatomic) IBOutlet UIView *ingredientForm;

- (id)initWithEditableTable;

@end
