//
//  MyRecipeViewController.h
//  recipe
//
//  Created by Vu Tran on 3/27/12.
//  Copyright 2012 Perselab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"

@interface MyRecipeViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
{
    NSMutableArray* _recipes;
    Boolean loaded;
}

@property (nonatomic) NSMutableArray* recipes;
@property (weak, nonatomic) IBOutlet UITableView *tableView;

-(void) reload;
-(void) didParsedRecipes;
-(IBAction)addRecipe:(id)sender;

@end
