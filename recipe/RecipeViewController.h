//
//  RecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/28/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Recipe.h"

@interface RecipeViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
{
    Recipe* _recipe;
}

@property (weak, nonatomic) IBOutlet UITableView *recipeDetailsTable;
@property (nonatomic) Recipe *recipe;

@end
