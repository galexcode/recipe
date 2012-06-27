//
//  CategoryListViewController.h
//  recipe
//
//  Created by Vu Tran Dao Vuong on 5/21/12.
//  Copyright (c) 2012 OngSoft. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "recipeGlobal.h"
#import "PullRefreshTableViewController.h"

@interface CategoryListViewController : PullRefreshTableViewController
{
    NSMutableDictionary *_categoryDictionary;
    NSMutableArray *_reusableCells;
}

@property (nonatomic) NSMutableDictionary *categoryDictionary;
@property (nonatomic) NSMutableArray *reusableCells;
@property (nonatomic, weak) UIViewController* navController;

-(void)tapOnHeader:(id)sender;
-(void) didParsedCategories;

@end
