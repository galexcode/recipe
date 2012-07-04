//
//  RecipesTableViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 6/27/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PullRefreshTableViewController.h"
#import "Recipe.h"
#import "User.h"
#import "Category.h"

@interface RecipesTableViewController : PullRefreshTableViewController{
    NSMutableArray* _recipes;
    User* _user;
    Category* _category;
    NSString* _keyword;
    Boolean loaded;
    NSMutableArray* _resuableCells;
    Boolean isMyRecipe;
    Boolean editable;
    UIBarButtonItem *barButton;
    Boolean isNeedToReload;
}

@property (nonatomic) NSMutableArray* recipes;
@property (nonatomic) User *user;
@property (nonatomic) Category *category;
@property (nonatomic) NSString *keyword;
@property (nonatomic) NSMutableArray* reusableCells;
@property (nonatomic, weak) UIViewController* navController;

- (id)initWithEditableTable;
- (id)initWithUser:(User *)currentUser;
- (id)initWithCategory:(Category *)currentCategory;
- (id)initWithKeyword:(NSString *)keyword;
- (void) didParsedRecipes;

@end
